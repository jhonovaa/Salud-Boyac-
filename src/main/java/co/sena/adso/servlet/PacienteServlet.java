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
                List<Paciente> lista = dao.listarTodos();
                request.setAttribute("pacientes", lista);
                request.getRequestDispatcher("/views/pacientes/lista.jsp").forward(request, response);
                break;
            case "nuevo":
                request.getRequestDispatcher("/views/pacientes/formulario.jsp").forward(request, response);
                break;
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Paciente paciente = dao.buscarPorId(idEditar); 
                request.setAttribute("paciente", paciente);
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
            
            String email = request.getParameter("email");
            p.setEmail(email != null ? email : "");
            
            String veredaBarrio = request.getParameter("veredaBarrio");
            p.setVeredaBarrio(veredaBarrio != null ? veredaBarrio : "");
            
            dao.insertar(p); 
            response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=ok");
            
        } else if ("actualizar".equals(accion)) {
            Paciente p = new Paciente();
            p.setId(Integer.parseInt(request.getParameter("id"))); 
            p.setNombres(request.getParameter("nombres"));
            p.setApellidos(request.getParameter("apellidos"));
            p.setDocumento(request.getParameter("documento"));
            p.setFechaNacimiento(Date.valueOf(request.getParameter("fechaNacimiento")));
            p.setTelefono(request.getParameter("telefono"));
            p.setEps(request.getParameter("eps"));
            
            String email = request.getParameter("email");
            p.setEmail(email != null ? email : "");
            
            String veredaBarrio = request.getParameter("veredaBarrio");
            p.setVeredaBarrio(veredaBarrio != null ? veredaBarrio : "");
            
            dao.actualizar(p); 
            response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=ok");
            
        } else if ("eliminar".equals(accion)) {
            // CORRECCIÓN AQUÍ: Validamos si dio error de Base de Datos para no redirigir con un "ok" falso
            int idEliminar = Integer.parseInt(request.getParameter("id"));
            boolean exito = dao.eliminar(idEliminar);
            
            if (exito) {
                response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=ok");
            } else {
                response.sendRedirect(request.getContextPath() + "/pacientes?mensaje=error_citas");
            }
        }
    }
}