package co.sena.adso.servlet;

import java.io.IOException;

// Importamos los DAOs necesarios
import co.sena.adso.dao.CitaDAO;
import co.sena.adso.dao.PacienteDAO;
// Si tienes un DAO para los logs, descomenta la siguiente línea:
// import co.sena.adso.dao.LogAccesoDAO; 

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Instanciamos los DAOs
        CitaDAO citaDao = new CitaDAO();
        PacienteDAO pacienteDao = new PacienteDAO();
        
        // 2. Extraemos los datos de la base de datos
        // Nota: Estos métodos (contarCitasHoy, etc.) deben existir en tus clases DAO
        try {
            int totalCitasHoy = citaDao.contarCitasHoy();
            int citasPendientes = citaDao.contarCitasPendientes();
            int citasMes = citaDao.contarCitasMes();
            int totalPacientes = pacienteDao.contarTotalPacientes();
            
            // 3. Enviamos las variables al JSP
            request.setAttribute("totalCitasHoy", totalCitasHoy);
            request.setAttribute("citasPendientes", citasPendientes);
            request.setAttribute("citasMes", citasMes);
            request.setAttribute("totalPacientes", totalPacientes);
            
            /* Si tienes creado el DAO para el log de accesos, usa esto para llenar la tabla inferior:
            LogAccesoDAO logDao = new LogAccesoDAO();
            request.setAttribute("logAccesos", logDao.obtenerUltimosAccesos());
            */
            
        } catch (Exception e) {
            System.err.println("Error cargando datos del dashboard: " + e.getMessage());
        }

        // 4. Redirigimos a la vista con los datos ya cargados
        request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
    }
}