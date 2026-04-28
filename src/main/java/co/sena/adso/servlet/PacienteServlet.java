package co.sena.adso.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

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
                // CORRECCIÓN: Descomentado para que envíe los datos a la tabla
                List<Paciente> lista = dao.listarTodos();
                request.setAttribute("pacientes", lista);
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
            p.setEps(request.getParameter("eps"));
            
            // Validamos campos que tu formulario no tiene obligatorios para evitar valores "null" en la DB
            String email = request.getParameter("email");
            p.setEmail(email != null ? email : "");
            
            String veredaBarrio = request.getParameter("veredaBarrio");
            p.setVeredaBarrio(veredaBarrio != null ? veredaBarrio : "");
            
            // CORRECCIÓN: Descomentado para guardar realmente en la base de datos
            dao.insertar(p); 
            
            // Enviamos mensaje=ok para que dispare la alerta de éxito en la lista
            response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=ok");
        }
    }
}