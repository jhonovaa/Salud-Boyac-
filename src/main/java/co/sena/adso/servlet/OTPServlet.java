package co.sena.adso.servlet;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import co.sena.adso.dao.OTPTokenDAO;
import co.sena.adso.dto.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "OTPServlet", urlPatterns = {"/otp"})
public class OTPServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String email = (String) session.getAttribute("otpEmail");
        request.setAttribute("emailMasked", enmascararEmail(email));
        request.getRequestDispatcher("/views/otp_verificacion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String codigoIngresado = request.getParameter("otpCodigo");
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        OTPTokenDAO otpDAO = new OTPTokenDAO();
        if (otpDAO.validar(usuario.getId(), codigoIngresado)) {
            session.setAttribute("otpVerificado", true);
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            String lang = (String) session.getAttribute("lang");
            if (lang == null) lang = "es";
            ResourceBundle rb = ResourceBundle.getBundle("messages", new Locale(lang));
            
            request.setAttribute("error", rb.getString("otp.error"));
            String email = (String) session.getAttribute("otpEmail");
            request.setAttribute("emailMasked", enmascararEmail(email));
            request.getRequestDispatcher("/views/otp_verificacion.jsp").forward(request, response);
        }
    }

    private String enmascararEmail(String email) {
        if (email == null || !email.contains("@")) return "***";
        String[] partes = email.split("@");
        String local = partes[0];
        if (local.length() <= 3) return local + "***@" + partes[1];
        return local.substring(0, 3) + "***@" + partes[1];
    }
}