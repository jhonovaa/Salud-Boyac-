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
                // Aquí deberías cargar las listas de pacientes, médicos y especialidades para el select
                request.getRequestDispatcher("/views/citas/formulario.jsp").forward(request, response);
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
            // Se asume formato HH:mm del formulario web, agregamos los segundos para SQL Time
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