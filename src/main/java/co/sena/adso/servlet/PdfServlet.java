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

// Esta anotacion mapea la ruta /pdf que se activa desde los botones en lista.jsp
@WebServlet(name = "PdfServlet", urlPatterns = {"/pdf"})
public class PdfServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtenemos el ID de la cita desde el parametro de la URL
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int idCita = Integer.parseInt(idParam);
                CitaDAO dao = new CitaDAO();
                
                // Buscamos la informacion detallada de la cita
                Cita cita = dao.buscarPorId(idCita);

                if (cita != null) {
                    // Definimos el tipo de contenido como PDF
                    response.setContentType("application/pdf");
                    
                    // "attachment" fuerza la descarga. Si prefieres abrir en una pestana, usa "inline"
                    // El nombre del archivo se genera dinamicamente sin tildes ni caracteres especiales
                    response.setHeader("Content-Disposition", "attachment; filename=Comprobante_Cita_" + idCita + ".pdf");

                    // Enviamos los datos al flujo de salida (OutputStream) del navegador
                    PDFGenerator.generarComprobanteCita(cita, response.getOutputStream());
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "La cita solicitada no existe en el sistema");
                }
            } catch (Exception e) {
                System.err.println("Error procesando PDF en el Servlet: " + e.getMessage());
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno al procesar el documento");
            }
        } else {
            // Si no hay ID, regresamos a la lista general
            response.sendRedirect(request.getContextPath() + "/citas");
        }
    }
}