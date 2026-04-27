package co.sena.adso.servlet;

import java.io.IOException;
import java.sql.Date;

import co.sena.adso.dao.PacienteDAO;
import co.sena.adso.dto.Paciente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PacienteServlet", urlPatterns = {"/pacientes"})
public class PacienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        PacienteDAO dao = new PacienteDAO();

        switch (accion) {
            case "listar":
                // Asumiendo que creaste un método listarTodos() en PacienteDAO
                // List<Paciente> lista = dao.listarTodos();
                // request.setAttribute("pacientes", lista);
                request.getRequestDispatcher("/views/pacientes/lista.jsp").forward(request, response);
                break;
            case "nuevo":
                request.getRequestDispatcher("/views/pacientes/formulario.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/pacientes");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        PacienteDAO dao = new PacienteDAO();

        if ("insertar".equals(accion)) {
            Paciente p = new Paciente();
            p.setNombres(request.getParameter("nombres"));
            p.setApellidos(request.getParameter("apellidos"));
            p.setDocumento(request.getParameter("documento"));
            p.setFechaNacimiento(Date.valueOf(request.getParameter("fechaNacimiento")));
            p.setTelefono(request.getParameter("telefono"));
            p.setEmail(request.getParameter("email"));
            p.setEps(request.getParameter("eps"));
            
            // Asumiendo método insertar en PacienteDAO
            // dao.insertar(p); 
            response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=creado");
        }
    }
}