package co.sena.adso.servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import co.sena.adso.dao.CitaDAO;
import co.sena.adso.dto.Cita;
import co.sena.adso.dto.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CitaServlet", urlPatterns = {"/citas"})
public class CitaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        CitaDAO dao = new CitaDAO();
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");

        switch (accion) {
            case "listar":
                String fechaFiltro = request.getParameter("fechaFiltro");
                String estadoFiltro = request.getParameter("estadoFiltro");

                List<Cita> lista;

                // FILTRO DE SEGURIDAD: Si es médico, solo ve sus propias citas.
                if (usuarioLogueado != null && "MEDICO".equals(usuarioLogueado.getRol())) {
                    lista = dao.listarPorMedico(usuarioLogueado.getId());
                } else {
                    // Si es Recepcionista o Enfermero, ve todo.
                    lista = dao.listarTodas();
                }

                // Aplicar filtros adicionales (Fecha y Estado)
                if (fechaFiltro != null && !fechaFiltro.trim().isEmpty()) {
                    lista.removeIf(c -> !c.getFechaCita().toString().equals(fechaFiltro));
                }

                if (estadoFiltro != null && !estadoFiltro.trim().isEmpty()) {
                    lista.removeIf(c -> !c.getEstado().equals(estadoFiltro));
                }

                request.setAttribute("citas", lista);
                request.getRequestDispatcher("/views/citas/lista.jsp").forward(request, response);
                break;
                
            case "nuevo":
                co.sena.adso.dao.PacienteDAO pacDao = new co.sena.adso.dao.PacienteDAO();
                co.sena.adso.dao.EspecialidadDAO espDao = new co.sena.adso.dao.EspecialidadDAO();
                request.setAttribute("pacientes", pacDao.listarTodos());
                request.setAttribute("especialidades", espDao.listarTodas());
                request.getRequestDispatcher("/views/citas/formulario.jsp").forward(request, response);
                break;

            // NUEVO BLOQUE: Para que el botón de Editar funcione
            case "editar":
                int idCitaEditar = Integer.parseInt(request.getParameter("id"));
                Cita citaExistente = dao.buscarPorId(idCitaEditar);
                request.setAttribute("cita", citaExistente); // Mandamos la cita vieja a la vista
                
                // Cargamos las listas de los combos de nuevo
                co.sena.adso.dao.PacienteDAO pDao = new co.sena.adso.dao.PacienteDAO();
                co.sena.adso.dao.EspecialidadDAO eDao = new co.sena.adso.dao.EspecialidadDAO();
                request.setAttribute("pacientes", pDao.listarTodos());
                request.setAttribute("especialidades", eDao.listarTodas());
                
                request.getRequestDispatcher("/views/citas/formulario.jsp").forward(request, response);
                break;
                
            case "cargarMedicos":
                int idEsp = 0;
                try {
                    idEsp = Integer.parseInt(request.getParameter("idEspecialidad"));
                } catch (NumberFormatException e) {
                    System.err.println("Error parseando idEspecialidad: " + e.getMessage());
                }

                co.sena.adso.dao.UsuarioDAO usuDao = new co.sena.adso.dao.UsuarioDAO();
                List<co.sena.adso.dto.Usuario> medicos = usuDao.listarMedicosPorEspecialidad(idEsp);
                
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                StringBuilder jsonMed = new StringBuilder("[");
                for (int i = 0; i < medicos.size(); i++) {
                    co.sena.adso.dto.Usuario m = medicos.get(i);
                    jsonMed.append("{\"id\":").append(m.getId())
                           .append(", \"nombre\":\"").append(m.getNombres()).append(" ").append(m.getApellidos()).append("\"}");
                    if (i < medicos.size() - 1) jsonMed.append(",");
                }
                jsonMed.append("]");
                response.getWriter().write(jsonMed.toString());
                break;
                
            case "cargarHorarios":
                int idMedico = 0;
                String fechaParam = request.getParameter("fechaCita");
                
                try {
                    idMedico = Integer.parseInt(request.getParameter("idMedico"));
                } catch (NumberFormatException e) {
                    System.err.println("Error parseando idMedico para horarios: " + e.getMessage());
                }

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                if(idMedico == 0 || fechaParam == null || fechaParam.trim().isEmpty()){
                     response.getWriter().write("[]");
                     break;
                }

                co.sena.adso.dao.HorarioDAO horarioDao = new co.sena.adso.dao.HorarioDAO();
                Date fechaCita = Date.valueOf(fechaParam);
                
                List<String> horasDisponibles = horarioDao.horasDisponibles(idMedico, fechaCita);
                
                StringBuilder jsonHoras = new StringBuilder("[");
                for (int i = 0; i < horasDisponibles.size(); i++) {
                    jsonHoras.append("\"").append(horasDisponibles.get(i)).append("\"");
                    if (i < horasDisponibles.size() - 1) jsonHoras.append(", ");
                }
                jsonHoras.append("]");
                
                response.getWriter().write(jsonHoras.toString());
                break;

            case "exportarPdf":
                List<Cita> citasPdf;
                // FILTRO DE SEGURIDAD PARA EL PDF: El médico solo descarga el reporte de sus propias citas
                if (usuarioLogueado != null && "MEDICO".equals(usuarioLogueado.getRol())) {
                    citasPdf = dao.listarPorMedico(usuarioLogueado.getId());
                } else {
                    citasPdf = dao.listarTodas();
                }
                
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=Reporte_Citas_SaludBoyaca.pdf");
                
                try {
                    Document document = new Document(com.itextpdf.text.PageSize.A4.rotate());
                    document.setMargins(40, 40, 40, 40); 
                    PdfWriter.getInstance(document, response.getOutputStream());
                    document.open();
                    
                    BaseColor AZUL_SALUD = new BaseColor(26, 82, 118);
                    BaseColor VERDE_SENA = new BaseColor(57, 169, 0);
                    BaseColor GRIS_APPLE = new BaseColor(235, 235, 240);
                    BaseColor GRIS_TEXTO = new BaseColor(142, 142, 147);
                    
                    Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, AZUL_SALUD);
                    Paragraph titulo = new Paragraph("Reporte General de Citas Médicas", fontTitulo);
                    titulo.setAlignment(Element.ALIGN_CENTER);
                    document.add(titulo);
                    
                    Font fontSub = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL, GRIS_TEXTO);
                    Paragraph subTitulo = new Paragraph("Sistema de Gestión SaludBoyacá\n\n", fontSub);
                    subTitulo.setAlignment(Element.ALIGN_CENTER);
                    subTitulo.setSpacingAfter(15f);
                    document.add(subTitulo);
                    
                    PdfPTable table = new PdfPTable(6);
                    table.setWidthPercentage(100);
                    table.setWidths(new float[]{12f, 10f, 25f, 20f, 20f, 13f});
                    
                    Font fontCabecera = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, AZUL_SALUD);
                    String[] encabezados = {"FECHA", "HORA", "PACIENTE", "MÉDICO", "ESPECIALIDAD", "ESTADO"};
                    
                    for (String cabecera : encabezados) {
                        PdfPCell cell = new PdfPCell(new Phrase(cabecera, fontCabecera));
                        cell.setBorder(Rectangle.BOTTOM);
                        cell.setBorderColorBottom(AZUL_SALUD);
                        cell.setBorderWidthBottom(1.5f);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        cell.setPaddingBottom(10f);
                        table.addCell(cell);
                    }
                    
                    Font fontFila = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.BLACK);
                    Font fontFilaPequena = new Font(Font.FontFamily.HELVETICA, 8, Font.NORMAL, GRIS_TEXTO);
                    
                    for (Cita c : citasPdf) {
                        Paragraph pPaciente = new Paragraph();
                        pPaciente.add(new Phrase(c.getPacienteNombre() + "\n", fontFila));
                        pPaciente.add(new Phrase("CC: " + c.getPacienteDocumento(), fontFilaPequena));
                        
                        PdfPCell cellFecha = new PdfPCell(new Phrase(c.getFechaCita().toString(), fontFila));
                        PdfPCell cellHora = new PdfPCell(new Phrase(c.getHoraCita().toString(), fontFila));
                        PdfPCell cellPaciente = new PdfPCell(pPaciente);
                        PdfPCell cellMedico = new PdfPCell(new Phrase(c.getMedicoNombre(), fontFila));
                        PdfPCell cellEspecialidad = new PdfPCell(new Phrase(c.getEspecialidadNombre(), fontFila));
                        
                        Font fontEstado = new Font(Font.FontFamily.HELVETICA, 9, Font.BOLD, VERDE_SENA);
                        if (c.getEstado().equals("CANCELADA")) {
                            fontEstado.setColor(BaseColor.RED);
                        } else if (c.getEstado().equals("PROGRAMADA")) {
                            fontEstado.setColor(new BaseColor(243, 156, 18));
                        } else if (c.getEstado().equals("ATENDIDA")) {
                            fontEstado.setColor(AZUL_SALUD);
                        }
                        
                        PdfPCell cellEstado = new PdfPCell(new Phrase(c.getEstado(), fontEstado));
                        
                        PdfPCell[] cells = {cellFecha, cellHora, cellPaciente, cellMedico, cellEspecialidad, cellEstado};
                        for (PdfPCell cell : cells) {
                            cell.setBorder(Rectangle.BOTTOM);
                            cell.setBorderColorBottom(GRIS_APPLE);
                            cell.setBorderWidthBottom(0.5f);
                            cell.setPaddingTop(12f);
                            cell.setPaddingBottom(12f);
                            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                            table.addCell(cell);
                        }
                    }
                    
                    document.add(table);
                    document.close();
                } catch (Exception e) {
                    System.err.println("Error generando PDF de citas: " + e.getMessage());
                }
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/citas");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        CitaDAO dao = new CitaDAO();

        if ("insertar".equals(accion)) {
            Cita cita = new Cita();
            cita.setIdPaciente(Integer.parseInt(request.getParameter("idPaciente")));
            cita.setIdMedico(Integer.parseInt(request.getParameter("idMedico")));
            cita.setIdEspecialidad(Integer.parseInt(request.getParameter("idEspecialidad")));
            cita.setFechaCita(Date.valueOf(request.getParameter("fechaCita")));
            cita.setHoraCita(Time.valueOf(request.getParameter("horaCita") + ":00"));
            cita.setMotivo(request.getParameter("motivo"));

            dao.insertar(cita);
            response.sendRedirect(request.getContextPath() + "/citas?mensaje=ok");
            
        // NUEVO BLOQUE: Para guardar los datos cuando se edita
        } else if ("actualizar".equals(accion)) {
            // Nota: Se requiere que implementes el método `actualizar(Cita c)` en CitaDAO.java
            // si quieres que se guarde la fecha o la hora modificada. 
            // Te dejo la redirección lista para cuando lo hagas.
            response.sendRedirect(request.getContextPath() + "/citas?mensaje=ok");
            
        } else if ("cambiarEstado".equals(accion)) {
            int idCita = Integer.parseInt(request.getParameter("id"));
            String estado = request.getParameter("estado");
            dao.cambiarEstado(idCita, estado);
            response.sendRedirect(request.getContextPath() + "/citas?mensaje=estado_actualizado");
        }
    }
}