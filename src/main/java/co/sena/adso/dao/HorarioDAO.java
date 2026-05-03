package co.sena.adso.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import co.sena.adso.dto.Horario;
import co.sena.adso.model.Conexion;

public class HorarioDAO {

    public List<Horario> listarTodos() {
        List<Horario> lista = new ArrayList<>();
        String sql = "SELECT h.id, h.id_medico, u.nombres, u.apellidos, h.dia_semana, h.hora_inicio, h.hora_fin, h.max_citas "
                   + "FROM horarios h "
                   + "JOIN usuarios u ON h.id_medico = u.id "
                   + "ORDER BY h.dia_semana, h.hora_inicio";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                Horario h = new Horario();
                h.setId(rs.getInt("id"));
                h.setIdMedico(rs.getInt("id_medico"));
                h.setMedicoNombre(rs.getString("nombres") + " " + rs.getString("apellidos"));
                h.setDiaSemana(rs.getInt("dia_semana"));
                h.setHoraInicio(rs.getTime("hora_inicio"));
                h.setHoraFin(rs.getTime("hora_fin"));
                h.setMaxCitas(rs.getInt("max_citas"));
                lista.add(h);
            }
        } catch (SQLException e) {
            System.err.println("Error listando horarios: " + e.getMessage());
        }
        return lista;
    }

    public List<Horario> listarPorMedico(int idMedico) {
        List<Horario> lista = new ArrayList<>();
        String sql = "SELECT h.id, h.id_medico, u.nombres, u.apellidos, h.dia_semana, h.hora_inicio, h.hora_fin, h.max_citas "
                   + "FROM horarios h "
                   + "JOIN usuarios u ON h.id_medico = u.id "
                   + "WHERE h.id_medico = ? "
                   + "ORDER BY h.dia_semana, h.hora_inicio";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idMedico);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Horario h = new Horario();
                    h.setId(rs.getInt("id"));
                    h.setIdMedico(rs.getInt("id_medico"));
                    h.setMedicoNombre(rs.getString("nombres") + " " + rs.getString("apellidos"));
                    h.setDiaSemana(rs.getInt("dia_semana"));
                    h.setHoraInicio(rs.getTime("hora_inicio"));
                    h.setHoraFin(rs.getTime("hora_fin"));
                    h.setMaxCitas(rs.getInt("max_citas"));
                    lista.add(h);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error listando horarios por médico: " + e.getMessage());
        }
        return lista;
    }

    public boolean insertar(Horario h) {
        String sql = "INSERT INTO horarios (id_medico, dia_semana, hora_inicio, hora_fin, max_citas) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, h.getIdMedico());
            ps.setInt(2, h.getDiaSemana());
            ps.setTime(3, h.getHoraInicio());
            ps.setTime(4, h.getHoraFin());
            ps.setInt(5, h.getMaxCitas());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error insertando horario: " + e.getMessage());
            return false;
        }
    }

    public Horario buscarPorId(int id) {
        Horario h = null;
        String sql = "SELECT h.id, h.id_medico, u.nombres, u.apellidos, h.dia_semana, h.hora_inicio, h.hora_fin, h.max_citas "
                   + "FROM horarios h "
                   + "JOIN usuarios u ON h.id_medico = u.id "
                   + "WHERE h.id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    h = new Horario();
                    h.setId(rs.getInt("id"));
                    h.setIdMedico(rs.getInt("id_medico"));
                    h.setMedicoNombre(rs.getString("nombres") + " " + rs.getString("apellidos"));
                    h.setDiaSemana(rs.getInt("dia_semana"));
                    h.setHoraInicio(rs.getTime("hora_inicio"));
                    h.setHoraFin(rs.getTime("hora_fin"));
                    h.setMaxCitas(rs.getInt("max_citas"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error buscando horario por ID: " + e.getMessage());
        }
        return h;
    }

    public boolean actualizar(Horario h) {
        String sql = "UPDATE horarios SET id_medico = ?, dia_semana = ?, hora_inicio = ?, hora_fin = ?, max_citas = ? WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, h.getIdMedico());
            ps.setInt(2, h.getDiaSemana());
            ps.setTime(3, h.getHoraInicio());
            ps.setTime(4, h.getHoraFin());
            ps.setInt(5, h.getMaxCitas());
            ps.setInt(6, h.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error actualizando horario: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM horarios WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error eliminando horario: " + e.getMessage());
            return false;
        }
    }

    // MÉTODO CORREGIDO: Lógica inteligente de distribución de citas y validación de tiempo
    public List<String> horasDisponibles(int idMedico, Date fechaCita) {
        List<String> horasDisponibles = new ArrayList<>();
        LocalDate localDate = fechaCita.toLocalDate();
        int diaSemana = localDate.getDayOfWeek().getValue();
        
        // CORRECCIÓN: Ahora solicitamos explícitamente el max_citas
        String sqlHorario = "SELECT hora_inicio, hora_fin, max_citas FROM horarios WHERE id_medico = ? AND dia_semana = ?";
        String sqlCitas = "SELECT hora_cita FROM citas WHERE id_medico = ? AND fecha_cita = ? AND estado != 'CANCELADA'";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement psHorario = conn.prepareStatement(sqlHorario);
             PreparedStatement psCitas = conn.prepareStatement(sqlCitas)) {
             
            psHorario.setInt(1, idMedico);
            psHorario.setInt(2, diaSemana);
            
            LocalTime horaInicio = null;
            LocalTime horaFin = null;
            int maxCitas = 0;
            
            try (ResultSet rsHorario = psHorario.executeQuery()) {
                if (rsHorario.next()) {
                    horaInicio = rsHorario.getTime("hora_inicio").toLocalTime();
                    horaFin = rsHorario.getTime("hora_fin").toLocalTime();
                    maxCitas = rsHorario.getInt("max_citas");
                }
            }
            
            // Si el médico no trabaja ese día, devolvemos la lista vacía inmediatamente
            if (horaInicio == null || horaFin == null) {
                return horasDisponibles;
            }
            
            // Calculamos todas las horas posibles del turno
            List<LocalTime> horasPosibles = new ArrayList<>();
            LocalTime horaActual = horaInicio;
            while (horaActual.isBefore(horaFin)) {
                horasPosibles.add(horaActual);
                horaActual = horaActual.plusHours(1); 
            }
            
            // Obtenemos todas las citas que ya tiene agendadas para ese día
            psCitas.setInt(1, idMedico);
            psCitas.setDate(2, fechaCita);
            
            List<LocalTime> horasOcupadas = new ArrayList<>();
            try (ResultSet rsCitas = psCitas.executeQuery()) {
                while (rsCitas.next()) {
                    horasOcupadas.add(rsCitas.getTime("hora_cita").toLocalTime());
                }
            }
            
            // REGLA 1: Si ya alcanzó el límite máximo de citas en el día, cerramos la agenda
            if (horasOcupadas.size() >= maxCitas) {
                return horasDisponibles; 
            }
            
            // REGLA 2: Calculamos cuántos pacientes puede atender en UNA MISMA HORA
            int maxPorHora = (int) Math.ceil((double) maxCitas / horasPosibles.size());
            if (maxPorHora < 1) maxPorHora = 1;

            boolean esHoy = localDate.equals(LocalDate.now());
            LocalTime horaActualDelReloj = LocalTime.now();

            for (LocalTime hp : horasPosibles) {
                // REGLA 3: Si la cita es para hoy, ocultar las horas que ya pasaron
                if (esHoy && hp.isBefore(horaActualDelReloj)) {
                    continue; 
                }

                // Contamos cuántos pacientes ya están agendados en esta hora específica
                int pacientesEnEstaHora = 0;
                for (LocalTime ocupada : horasOcupadas) {
                    if (ocupada.equals(hp)) pacientesEnEstaHora++;
                }
                
                // Si en esta hora aún hay cupo, la habilitamos en el formulario
                if (pacientesEnEstaHora < maxPorHora) {
                    horasDisponibles.add(hp.toString());
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error consultando horas disponibles: " + e.getMessage());
        }
        
        return horasDisponibles;
    }
}