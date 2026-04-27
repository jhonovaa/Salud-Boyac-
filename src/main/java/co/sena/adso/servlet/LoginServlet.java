package co.sena.adso.servlet;

import co.sena.adso.dao.OTPTokenDAO;
import co.sena.adso.dao.UsuarioDAO;
import co.sena.adso.dto.Usuario;
import co.sena.adso.util.OTPService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Locale;
import java.util.ResourceBundle;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.validarLogin(user, pass);

        if (usuario != null) {
            String otp = OTPService.generarOTP();
            Timestamp expiraEn = new Timestamp(System.currentTimeMillis() + (5 * 60 * 1000)); // 5 minutos
            
            OTPTokenDAO otpDAO = new OTPTokenDAO();
            otpDAO.insertar(usuario.getId(), otp, expiraEn);

            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setAttribute("otpEmail", usuario.getEmail());
            session.setAttribute("otpVerificado", false); 

            String lang = (String) session.getAttribute("lang");
            if (lang == null) lang = "es";
            ResourceBundle rb = ResourceBundle.getBundle("messages", new Locale(lang));
            String asunto = rb.getString("otp.email.asunto");
            String cuerpo = java.text.MessageFormat.format(rb.getString("otp.email.cuerpo"), otp);

            try {
                OTPService.enviarOTP(usuario.getEmail(), otp, asunto, cuerpo);
            } catch (Exception ex) {
                System.err.println("Error enviando correo OTP: " + ex.getMessage());
            }

            response.sendRedirect(request.getContextPath() + "/otp");
        } else {
            String lang = (String) request.getSession().getAttribute("lang");
            if (lang == null) lang = "es";
            ResourceBundle rb = ResourceBundle.getBundle("messages", new Locale(lang));
            request.setAttribute("error", rb.getString("login.error.credenciales"));
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}