package co.sena.adso.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import co.sena.adso.dao.PacienteDAO;
import co.sena.adso.dto.Cita;
import co.sena.adso.dto.Paciente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PacienteServlet", urlPatterns = {"/pacientes"})
public class PacienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        PacienteDAO dao = new PacienteDAO();

        switch (accion) {
            case "listar":
                List<Paciente> lista = dao.listarTodos();
                request.setAttribute("pacientes", lista);
                request.getRequestDispatcher("/views/pacientes/lista.jsp").forward(request, response);
                break;
                
            case "nuevo":
                request.getRequestDispatcher("/views/pacientes/formulario.jsp").forward(request, response);
                break;
                
            case "editar":
                String idParamEditar = request.getParameter("id");
                if (idParamEditar != null) {
                    int idEditar = Integer.parseInt(idParamEditar);
                    Paciente paciente = dao.buscarPorId(idEditar); 
                    request.setAttribute("paciente", paciente);
                    request.getRequestDispatcher("/views/pacientes/formulario.jsp").forward(request, response);
                }
                break;

            case "ver":
                Paciente pVer = null;
                String doc = request.getParameter("documento");
                
                if (doc != null && !doc.isEmpty()) {
                    pVer = dao.buscarPorDocumento(doc);
                } else {
                    String idParamVer = request.getParameter("id");
                    if (idParamVer != null) {
                        pVer = dao.buscarPorId(Integer.parseInt(idParamVer));
                    }
                }

                if (pVer != null) {
                    // Aqui esta la clave: extraemos la lista de citas del objeto paciente
                    List<Cita> historialCitas = pVer.getCitas();
                    
                    // Pasamos tanto el paciente como su historial al JSP
                    request.setAttribute("paciente", pVer);
                    request.setAttribute("historial", historialCitas);
                    
                    request.getRequestDispatcher("/views/pacientes/perfil_paciente.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=no_encontrado");
                }
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/pacientes");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        PacienteDAO dao = new PacienteDAO();

        if ("insertar".equals(accion)) {
            Paciente p = new Paciente();
            extraerDatos(request, p);
            dao.insertar(p); 
            response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=ok");
            
        } else if ("actualizar".equals(accion)) {
            String idParamActualizar = request.getParameter("id");
            if (idParamActualizar != null) {
                Paciente p = new Paciente();
                p.setId(Integer.parseInt(idParamActualizar)); 
                extraerDatos(request, p);
                dao.actualizar(p); 
                response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=ok");
            }
            
        } else if ("eliminar".equals(accion)) {
            String idParamEliminar = request.getParameter("id");
            if (idParamEliminar != null) {
                int idEliminar = Integer.parseInt(idParamEliminar);
                boolean exito = dao.eliminar(idEliminar);
                
                if (exito) {
                    response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=ok");
                } else {
                    response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=error_citas");
                }
            }
        }
    }

    private void extraerDatos(HttpServletRequest request, Paciente p) {
        p.setNombres(request.getParameter("nombres"));
        p.setApellidos(request.getParameter("apellidos"));
        p.setDocumento(request.getParameter("documento"));
        
        String fechaStr = request.getParameter("fechaNacimiento");
        if (fechaStr != null && !fechaStr.isEmpty()) {
            p.setFechaNacimiento(Date.valueOf(fechaStr));
        }
        
        p.setTelefono(request.getParameter("telefono"));
        p.setEps(request.getParameter("eps"));
        
        String email = request.getParameter("email");
        p.setEmail(email != null ? email : "");
        
        String veredaBarrio = request.getParameter("veredaBarrio");
        p.setVeredaBarrio(veredaBarrio != null ? veredaBarrio : "");
    }
}