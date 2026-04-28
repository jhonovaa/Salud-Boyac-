package co.sena.adso.servlet;

import java.io.IOException;
import co.sena.adso.dao.PacienteDAO;
import co.sena.adso.dto.Paciente;
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
        
        // Generar CAPTCHA nuevo para la vista publica [cite: 503, 735]
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
        String documento = request.getParameter("documento");

        // 1. Validar CAPTCHA [cite: 853, 940]
        if (captchaGuardado != null && captchaGuardado.equalsIgnoreCase(captchaIngresado)) {
            
            // 2. Buscar al paciente usando tu DAO [cite: 703, 704]
            PacienteDAO dao = new PacienteDAO();
            Paciente paciente = dao.buscarPorDocumento(documento);
            
            if (paciente != null) {
                // EXITO: Enviar al perfil con los datos del objeto [cite: 674]
                request.setAttribute("paciente", paciente);
                request.getRequestDispatcher("/views/perfil_paciente.jsp").forward(request, response);
                return; // Finaliza para evitar regenerar captcha y volver a la consulta
            } else {
                // ERROR: Paciente no encontrado [cite: 856]
                request.setAttribute("error", "consulta.no.encontrado");
            }
        } else {
            // ERROR: CAPTCHA Incorrecto [cite: 853]
            request.setAttribute("error", "consulta.captcha.error");
        }
        
        // 3. Si hubo error, regenerar CAPTCHA y volver a la consulta [cite: 754]
        String textoCaptcha = CaptchaGenerator.generarTextoCaptcha();
        session.setAttribute("captchaText", textoCaptcha);
        request.setAttribute("captchaImage", CaptchaGenerator.generarImagenBase64(textoCaptcha));
        request.setAttribute("documentoDigitado", documento);
        
        request.getRequestDispatcher("/views/consulta_cita.jsp").forward(request, response);
    }
}