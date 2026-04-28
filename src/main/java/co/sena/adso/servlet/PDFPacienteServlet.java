package co.sena.adso.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import co.sena.adso.dao.PacienteDAO;
import co.sena.adso.dto.Paciente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/generar-pdf")
public class PDFPacienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String documento = request.getParameter("documento");
        PacienteDAO dao = new PacienteDAO();
        Paciente p = dao.buscarPorDocumento(documento);

        if (p == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Paciente no encontrado");
            return;
        }

        // Configuracion para que el navegador descargue el archivo
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Perfil_" + documento + ".pdf");

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Colores y fuentes de SaludBoyaca
            BaseColor azulSalud = new BaseColor(26, 82, 118);
            Font tituloFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, azulSalud);
            Font labelFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.DARK_GRAY);
            Font textoFont = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);

            Paragraph titulo = new Paragraph("SALUDBOYACA - PERFIL DE PACIENTE", tituloFont);
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);
            document.add(new Paragraph(" ")); 

            document.add(new Paragraph("DOCUMENTO: " + p.getDocumento(), labelFont));
            document.add(new Paragraph("NOMBRES: " + p.getNombres() + " " + p.getApellidos(), textoFont));
            document.add(new Paragraph("EPS: " + p.getEps(), textoFont));
            document.add(new Paragraph("TELEFONO: " + p.getTelefono(), textoFont));
            document.add(new Paragraph("CORREO: " + p.getEmail(), textoFont));
            document.add(new Paragraph("UBICACION: " + p.getVeredaBarrio(), textoFont));

            document.close();
        } catch (DocumentException e) {
            throw new IOException("Error al generar el PDF: " + e.getMessage());
        }
    }
}