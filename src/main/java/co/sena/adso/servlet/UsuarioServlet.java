package co.sena.adso.servlet;

import co.sena.adso.dao.UsuarioDAO;
import co.sena.adso.dto.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/usuarios"})
public class UsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        UsuarioDAO dao = new UsuarioDAO();

        switch (accion) {
            case "listar":
                List<Usuario> lista = dao.listarTodos();
                request.setAttribute("usuarios", lista);
                request.getRequestDispatcher("/views/usuarios/lista.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/usuarios");
        }
    }
}