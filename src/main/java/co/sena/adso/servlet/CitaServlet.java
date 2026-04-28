package co.sena.adso.servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import co.sena.adso.dao.CitaDAO;
import co.sena.adso.dto.Cita;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CitaServlet", urlPatterns = {"/citas"})
public class CitaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        CitaDAO dao = new CitaDAO();

        switch (accion) {
            case "listar":
                List<Cita> lista = dao.listarTodas();
                request.setAttribute("citas", lista);
                request.getRequestDispatcher("/views/citas/lista.jsp").forward(request, response);
                break;
            case "nuevo":
                // Cargamos las listas base para el formulario
                co.sena.adso.dao.PacienteDAO pacDao = new co.sena.adso.dao.PacienteDAO();
                co.sena.adso.dao.EspecialidadDAO espDao = new co.sena.adso.dao.EspecialidadDAO();
                request.setAttribute("pacientes", pacDao.listarTodos());
                request.setAttribute("especialidades", espDao.listarTodas());
                request.getRequestDispatcher("/views/citas/formulario.jsp").forward(request, response);
                break;
            case "cargarMedicos":
                // CORRECCIÓN: Capturamos la especialidad y usamos el método filtrado
                int idEsp = 0;
                try {
                    idEsp = Integer.parseInt(request.getParameter("idEspecialidad"));
                } catch (NumberFormatException e) {
                    System.err.println("Error parseando idEspecialidad: " + e.getMessage());
                }

                co.sena.adso.dao.UsuarioDAO usuDao = new co.sena.adso.dao.UsuarioDAO();
                // Ahora sí usamos el método correcto que creamos en el DAO
                List<co.sena.adso.dto.Usuario> medicos = usuDao.listarMedicosPorEspecialidad(idEsp);
                
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                StringBuilder jsonMed = new StringBuilder("[");
                for (int i = 0; i < medicos.size(); i++) {
                    co.sena.adso.dto.Usuario m = medicos.get(i);
                    jsonMed.append("{\"id\":").append(m.getId())
                           .append(", \"nombre\":\"").append(m.getNombres()).append(" ").append(m.getApellidos()).append("\"}");
                    if (i < medicos.size() - 1) jsonMed.append(",");
                }
                jsonMed.append("]");
                response.getWriter().write(jsonMed.toString());
                break;
            case "cargarHorarios":
                // Respuesta AJAX con horas disponibles
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String jsonHoras = "[\"08:00\", \"09:00\", \"10:00\", \"11:00\", \"14:00\", \"15:00\", \"16:00\"]";
                response.getWriter().write(jsonHoras);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/citas");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        CitaDAO dao = new CitaDAO();

        if ("insertar".equals(accion)) {
            Cita cita = new Cita();
            cita.setIdPaciente(Integer.parseInt(request.getParameter("idPaciente")));
            cita.setIdMedico(Integer.parseInt(request.getParameter("idMedico")));
            cita.setIdEspecialidad(Integer.parseInt(request.getParameter("idEspecialidad")));
            cita.setFechaCita(Date.valueOf(request.getParameter("fechaCita")));
            cita.setHoraCita(Time.valueOf(request.getParameter("horaCita") + ":00"));
            cita.setMotivo(request.getParameter("motivo"));

            dao.insertar(cita);
            response.sendRedirect(request.getContextPath() + "/citas?mensaje=ok");
        } else if ("cambiarEstado".equals(accion)) {
            int idCita = Integer.parseInt(request.getParameter("id"));
            String estado = request.getParameter("estado");
            dao.cambiarEstado(idCita, estado);
            response.sendRedirect(request.getContextPath() + "/citas?mensaje=estado_actualizado");
        }
    }
}