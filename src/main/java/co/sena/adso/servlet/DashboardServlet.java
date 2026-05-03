package co.sena.adso.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import co.sena.adso.dao.CitaDAO;
import co.sena.adso.dao.PacienteDAO;
import co.sena.adso.dto.Cita;
import co.sena.adso.dto.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");

        if (usuarioLogueado == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        CitaDAO citaDao = new CitaDAO();
        PacienteDAO pacienteDao = new PacienteDAO();
        
        try {
            int totalCitasHoy = 0;
            int citasPendientes = 0;
            int citasMes = 0;
            int totalPacientes = 0;
            List<Cita> listaBase;

            if ("MEDICO".equals(usuarioLogueado.getRol())) {
                listaBase = citaDao.listarPorMedico(usuarioLogueado.getId());
                LocalDate hoy = LocalDate.now();
                
                for (Cita c : listaBase) {
                    LocalDate fechaCita = c.getFechaCita().toLocalDate();
                    if (fechaCita.equals(hoy)) totalCitasHoy++;
                    if ("PROGRAMADA".equals(c.getEstado())) citasPendientes++;
                    if (fechaCita.getMonthValue() == hoy.getMonthValue() && fechaCita.getYear() == hoy.getYear()) citasMes++;
                }
                totalPacientes = (int) listaBase.stream().map(Cita::getIdPaciente).distinct().count();
                
            } else {
                listaBase = citaDao.listarTodas();
                totalCitasHoy = citaDao.contarCitasHoy();
                citasPendientes = citaDao.contarCitasPendientes();
                citasMes = citaDao.contarCitasMes();
                totalPacientes = pacienteDao.listarTodos().size(); 
            }
            
            // NUEVO: Extraemos las últimas 5 citas de la lista para usarlas como "Actividad Reciente"
            List<Cita> ultimasCitas = listaBase.size() > 5 ? listaBase.subList(0, 5) : listaBase;
            
            request.setAttribute("totalCitasHoy", totalCitasHoy);
            request.setAttribute("citasPendientes", citasPendientes);
            request.setAttribute("citasMes", citasMes);
            request.setAttribute("totalPacientes", totalPacientes);
            request.setAttribute("ultimasCitas", ultimasCitas); // Enviamos la actividad reciente
            
        } catch (Exception e) {
            System.err.println("Error cargando datos del dashboard: " + e.getMessage());
        }

        request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
    }
}