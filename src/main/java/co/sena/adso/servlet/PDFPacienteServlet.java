package co.sena.adso.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import co.sena.adso.dao.PacienteDAO;
import co.sena.adso.dto.Paciente;
import co.sena.adso.dto.Cita;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/generar-pdf")
public class PDFPacienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String documento = request.getParameter("documento");
        
        if (documento == null || documento.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Documento requerido");
            return;
        }

        PacienteDAO dao = new PacienteDAO();
        // El metodo buscarPorDocumento ya debe traer la lista de citas cargada
        Paciente p = dao.buscarPorDocumento(documento);

        if (p == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Paciente no encontrado");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Perfil_Paciente_" + documento + ".pdf");

        try {
            Document document = new Document(PageSize.A4, 30, 30, 40, 40);
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // DEFINICION DE COLORES
            BaseColor azulOscuro = new BaseColor(30, 84, 118); 
            BaseColor azulClaro = new BaseColor(41, 128, 185); 
            BaseColor grisFondo = new BaseColor(245, 245, 245);
            BaseColor grisLinea = new BaseColor(230, 230, 230);

            // DEFINICION DE FUENTES
            Font fTituloBlanco = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, BaseColor.WHITE);
            Font fSubBlanco = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.WHITE);
            Font fSeccionAzul = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, azulClaro);
            Font fLabelGris = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, BaseColor.GRAY);
            Font fValorNegro = FontFactory.getFont(FontFactory.HELVETICA, 11, BaseColor.BLACK);
            Font fTablaEncabezado = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);

            // ==========================================
            // BLOQUE 1: ENCABEZADO AZUL (PERFIL)
            // ==========================================
            PdfPTable headerTable = new PdfPTable(1);
            headerTable.setWidthPercentage(100);
            PdfPCell hCell = new PdfPCell();
            hCell.setBackgroundColor(azulOscuro);
            hCell.setPadding(25f);
            hCell.setBorder(Rectangle.NO_BORDER);
            
            hCell.addElement(new Paragraph("HISTORIA CLINICA DIGITAL", fTituloBlanco));
            hCell.addElement(new Paragraph("Paciente: " + p.getNombres() + " " + p.getApellidos(), fSubBlanco));
            headerTable.addCell(hCell);
            document.add(headerTable);

            document.add(new Paragraph(" "));

            // ==========================================
            // BLOQUE 2: DATOS PERSONALES (ESTILO TARJETA)
            // ==========================================
            crearTituloSeccion(document, "Informacion Personal", fSeccionAzul, azulClaro);
            
            PdfPTable tablaDatos = new PdfPTable(2);
            tablaDatos.setWidthPercentage(100);
            
            agregarDato(tablaDatos, "DOCUMENTO", p.getDocumento(), fLabelGris, fValorNegro, grisLinea);
            agregarDato(tablaDatos, "EPS", p.getEps(), fLabelGris, fValorNegro, grisLinea);
            agregarDato(tablaDatos, "TELEFONO", p.getTelefono(), fLabelGris, fValorNegro, grisLinea);
            agregarDato(tablaDatos, "CORREO", p.getEmail(), fLabelGris, fValorNegro, grisLinea);
            agregarDato(tablaDatos, "UBICACION", p.getVeredaBarrio(), fLabelGris, fValorNegro, grisLinea);
            agregarDato(tablaDatos, "FECHA NACIMIENTO", p.getFechaNacimiento().toString(), fLabelGris, fValorNegro, grisLinea);
            
            document.add(tablaDatos);
            document.add(new Paragraph(" "));
            document.add(new Paragraph(" "));

            // ==========================================
            // BLOQUE 3: TABLA DE CITAS (HISTORIAL DE LA IMAGEN)
            // ==========================================
            crearTituloSeccion(document, "Historial de Citas Medicas", fSeccionAzul, azulClaro);

            if (p.getCitas() != null && !p.getCitas().isEmpty()) {
                // Tabla de 4 columnas: Fecha, Hora, Motivo, Estado
                PdfPTable tablaCitas = new PdfPTable(4);
                tablaCitas.setWidthPercentage(100);
                tablaCitas.setSpacingBefore(10f);
                tablaCitas.setWidths(new float[]{15f, 15f, 50f, 20f});

                // Encabezados de la tabla
                String[] encabezados = {"FECHA", "HORA", "MOTIVO", "ESTADO"};
                for (String texto : encabezados) {
                    PdfPCell cell = new PdfPCell(new Phrase(texto, fTablaEncabezado));
                    cell.setBackgroundColor(azulClaro);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cell.setPadding(8f);
                    cell.setBorderColor(BaseColor.WHITE);
                    tablaCitas.addCell(cell);
                }

                // Llenado de filas con los datos de las citas
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                for (Cita cita : p.getCitas()) {
                    tablaCitas.addCell(crearCeldaTabla(sdf.format(cita.getFechaCita()), fValorNegro));
                    tablaCitas.addCell(crearCeldaTabla(cita.getHoraCita().toString(), fValorNegro));
                    tablaCitas.addCell(crearCeldaTabla(cita.getMotivo(), fValorNegro));
                    tablaCitas.addCell(crearCeldaTabla(cita.getEstado(), fValorNegro));
                }
                document.add(tablaCitas);
            } else {
                document.add(new Paragraph("No se registran citas previas para este paciente.", fValorNegro));
            }

            document.close();
        } catch (DocumentException e) {
            throw new IOException("Error iText: " + e.getMessage());
        }
    }

    // --- METODOS AUXILIARES ---

    private void crearTituloSeccion(Document doc, String texto, Font font, BaseColor color) throws DocumentException {
        PdfPTable t = new PdfPTable(1);
        t.setWidthPercentage(100);
        PdfPCell c = new PdfPCell(new Phrase(texto, font));
        c.setBorder(Rectangle.LEFT);
        c.setBorderWidthLeft(4f);
        c.setBorderColorLeft(color);
        c.setPaddingLeft(10f);
        c.setBorderWidthBottom(0); c.setBorderWidthRight(0); c.setBorderWidthTop(0);
        t.addCell(c);
        doc.add(t);
    }

    private void agregarDato(PdfPTable table, String label, String valor, Font fL, Font fV, BaseColor linea) {
        PdfPCell cell = new PdfPCell();
        cell.setBorder(Rectangle.BOTTOM);
        cell.setBorderColorBottom(linea);
        cell.setPaddingBottom(10f);
        cell.setPaddingTop(10f);
        cell.addElement(new Paragraph(label, fL));
        cell.addElement(new Paragraph(valor != null ? valor : "N/A", fV));
        table.addCell(cell);
    }

    private PdfPCell crearCeldaTabla(String contenido, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(contenido != null ? contenido : "-", font));
        cell.setPadding(8f);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setBorderColor(new BaseColor(230, 230, 230));
        return cell;
    }
}