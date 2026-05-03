package co.sena.adso.servlet;

import java.io.IOException;
import java.sql.Time;
import java.util.List;

import co.sena.adso.dao.HorarioDAO;
import co.sena.adso.dto.Horario;
import co.sena.adso.dto.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "HorarioServlet", urlPatterns = {"/horarios"})
public class HorarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        HorarioDAO dao = new HorarioDAO();
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");

        switch (accion) {
            case "listar":
                List<Horario> horarios;
                // FILTRO DE SEGURIDAD: Si es médico, solo ve sus horarios
                if (usuarioLogueado != null && "MEDICO".equals(usuarioLogueado.getRol())) {
                    horarios = dao.listarPorMedico(usuarioLogueado.getId());
                } else {
                    horarios = dao.listarTodos();
                }
                request.setAttribute("horarios", horarios);
                request.getRequestDispatcher("/views/horarios/lista.jsp").forward(request, response);
                break;
                
            case "nuevo":
                // Cargamos todos los usuarios para filtrar a los médicos en la vista
                co.sena.adso.dao.UsuarioDAO usuDaoNuevo = new co.sena.adso.dao.UsuarioDAO();
                request.setAttribute("usuarios", usuDaoNuevo.listarTodos());
                request.getRequestDispatcher("/views/horarios/formulario.jsp").forward(request, response);
                break;
                
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Horario horario = dao.buscarPorId(idEditar);
                request.setAttribute("horario", horario);
                
                co.sena.adso.dao.UsuarioDAO usuDaoEditar = new co.sena.adso.dao.UsuarioDAO();
                request.setAttribute("usuarios", usuDaoEditar.listarTodos());
                
                request.getRequestDispatcher("/views/horarios/formulario.jsp").forward(request, response);
                break;
                
            default:
                response.sendRedirect(request.getContextPath() + "/horarios");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        HorarioDAO dao = new HorarioDAO();

        if ("insertar".equals(accion)) {
            Horario h = new Horario();
            h.setIdMedico(Integer.parseInt(request.getParameter("idMedico")));
            h.setDiaSemana(Integer.parseInt(request.getParameter("diaSemana")));
            
            // Validación inteligente para la Hora de Inicio
            String hIni = request.getParameter("horaInicio");
            if (hIni != null && hIni.length() == 5) hIni += ":00";
            h.setHoraInicio(Time.valueOf(hIni));
            
            // Validación inteligente para la Hora de Fin
            String hFin = request.getParameter("horaFin");
            if (hFin != null && hFin.length() == 5) hFin += ":00";
            h.setHoraFin(Time.valueOf(hFin));
            
            h.setMaxCitas(Integer.parseInt(request.getParameter("maxCitas")));
            
            dao.insertar(h);
            response.sendRedirect(request.getContextPath() + "/horarios?mensaje=ok");
            
        } else if ("actualizar".equals(accion)) {
            Horario h = new Horario();
            h.setId(Integer.parseInt(request.getParameter("id")));
            h.setIdMedico(Integer.parseInt(request.getParameter("idMedico")));
            h.setDiaSemana(Integer.parseInt(request.getParameter("diaSemana")));
            
            // Validación inteligente para la Hora de Inicio
            String hIni = request.getParameter("horaInicio");
            if (hIni != null && hIni.length() == 5) hIni += ":00";
            h.setHoraInicio(Time.valueOf(hIni));
            
            // Validación inteligente para la Hora de Fin
            String hFin = request.getParameter("horaFin");
            if (hFin != null && hFin.length() == 5) hFin += ":00";
            h.setHoraFin(Time.valueOf(hFin));
            
            h.setMaxCitas(Integer.parseInt(request.getParameter("maxCitas")));
            
            dao.actualizar(h);
            response.sendRedirect(request.getContextPath() + "/horarios?mensaje=ok");
            
        } else if ("eliminar".equals(accion)) {
            int idEliminar = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(idEliminar);
            response.sendRedirect(request.getContextPath() + "/horarios?mensaje=ok");
        }
    }
}