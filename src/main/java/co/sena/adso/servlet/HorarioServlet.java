package co.sena.adso.servlet;

import java.io.IOException;
import java.util.List;

import co.sena.adso.dao.HorarioDAO;
import co.sena.adso.dto.Horario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HorarioServlet", urlPatterns = {"/horarios"})
public class HorarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HorarioDAO dao = new HorarioDAO();
        List<Horario> horarios = dao.listarTodos();
        
        request.setAttribute("horarios", horarios);
        request.getRequestDispatcher("/views/horarios/lista.jsp").forward(request, response);
    }
}