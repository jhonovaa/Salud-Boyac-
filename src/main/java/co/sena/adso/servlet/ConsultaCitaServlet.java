package co.sena.adso.servlet;

import java.io.IOException;

import co.sena.adso.util.CaptchaGenerator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ConsultaCitaServlet", urlPatterns = {"/consulta-cita"})
public class ConsultaCitaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Generar CAPTCHA nuevo
        String textoCaptcha = CaptchaGenerator.generarTextoCaptcha();
        session.setAttribute("captchaText", textoCaptcha);
        
        String imagenBase64 = CaptchaGenerator.generarImagenBase64(textoCaptcha);
        request.setAttribute("captchaImage", imagenBase64);
        
        request.getRequestDispatcher("/views/consulta_cita.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String captchaIngresado = request.getParameter("captcha");
        String captchaGuardado = (String) session.getAttribute("captchaText");

        if (captchaGuardado != null && captchaGuardado.equalsIgnoreCase(captchaIngresado)) {
            // CAPTCHA Válido: Proceder a buscar por documento
            String documento = request.getParameter("documento");
            
            // Aquí llamarías al CitaDAO para buscar las citas de este documento
            // request.setAttribute("citasEncontradas", dao.buscarPorDocumento(documento));
            
            request.setAttribute("mensajeExito", "Búsqueda realizada para: " + documento);
        } else {
            // CAPTCHA Inválido
            request.setAttribute("error", "El código CAPTCHA ingresado es incorrecto.");
        }
        
        // Regenerar CAPTCHA tras un intento (exitoso o fallido)
        String textoCaptcha = CaptchaGenerator.generarTextoCaptcha();
        session.setAttribute("captchaText", textoCaptcha);
        request.setAttribute("captchaImage", CaptchaGenerator.generarImagenBase64(textoCaptcha));
        
        request.getRequestDispatcher("/views/consulta_cita.jsp").forward(request, response);
    }
}