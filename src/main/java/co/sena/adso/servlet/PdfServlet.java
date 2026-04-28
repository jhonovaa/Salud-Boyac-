package co.sena.adso.servlet;

import java.io.IOException;

import co.sena.adso.dao.CitaDAO;
import co.sena.adso.dto.Cita;
import co.sena.adso.util.PDFGenerator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Esta anotación mapea la ruta /pdf que está en los botones de tu lista.jsp
@WebServlet(name = "PdfServlet", urlPatterns = {"/pdf"})
public class PdfServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int idCita = Integer.parseInt(idParam);
                CitaDAO dao = new CitaDAO();
                
                // Buscamos la cita completa en la base de datos
                Cita cita = dao.buscarPorId(idCita);

                if (cita != null) {
                    // Configuramos la respuesta para que el navegador sepa que es un PDF
                    response.setContentType("application/pdf");
                    // "inline" hace que se abra en una nueva pestaña. Si quieres que se descargue directo, cambia "inline" por "attachment"
                    response.setHeader("Content-Disposition", "inline; filename=Comprobante_Cita_" + cita.getId() + ".pdf");

                    // Llamamos a tu clase utilitaria para generar el PDF directamente en el navegador
                    PDFGenerator.generarComprobanteCita(cita, response.getOutputStream());
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "La cita no existe");
                }
            } catch (Exception e) {
                System.err.println("Error generando PDF en el Servlet: " + e.getMessage());
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno generando el PDF");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/citas");
        }
    }
}