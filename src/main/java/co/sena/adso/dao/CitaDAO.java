package co.sena.adso.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import co.sena.adso.dto.Cita;
import co.sena.adso.model.Conexion;

public class CitaDAO {

    public boolean insertar(Cita cita) {
        String sql = "INSERT INTO citas (id_paciente, id_medico, id_especialidad, fecha_cita, hora_cita, motivo, estado) "
                   + "VALUES (?, ?, ?, ?, ?, ?, 'PROGRAMADA')";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cita.getIdPaciente());
            ps.setInt(2, cita.getIdMedico());
            ps.setInt(3, cita.getIdEspecialidad());
            ps.setDate(4, cita.getFechaCita());
            ps.setTime(5, cita.getHoraCita());
            ps.setString(6, cita.getMotivo());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error insertando cita: " + e.getMessage());
            return false;
        }
    }

    public List<Cita> listarTodas() {
        List<Cita> lista = new ArrayList<>();
        // INNER JOIN para traer los nombres legibles y no solo los IDs
        String sql = "SELECT c.id, c.fecha_cita, c.hora_cita, c.estado, c.motivo, "
                   + "p.nombres AS pac_nom, p.apellidos AS pac_ape, p.documento, "
                   + "u.nombres AS med_nom, u.apellidos AS med_ape, e.nombre AS esp_nom "
                   + "FROM citas c "
                   + "JOIN pacientes p ON c.id_paciente = p.id "
                   + "JOIN usuarios u ON c.id_medico = u.id "
                   + "JOIN especialidades e ON c.id_especialidad = e.id "
                   + "ORDER BY c.fecha_cita DESC, c.hora_cita DESC";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Cita c = new Cita();
                c.setId(rs.getInt("id"));
                c.setFechaCita(rs.getDate("fecha_cita"));
                c.setHoraCita(rs.getTime("hora_cita"));
                c.setEstado(rs.getString("estado"));
                c.setMotivo(rs.getString("motivo"));
                c.setPacienteNombre(rs.getString("pac_nom") + " " + rs.getString("pac_ape"));
                c.setPacienteDocumento(rs.getString("documento"));
                c.setMedicoNombre(rs.getString("med_nom") + " " + rs.getString("med_ape"));
                c.setEspecialidadNombre(rs.getString("esp_nom"));
                lista.add(c);
            }
        } catch (SQLException e) {
            System.err.println("Error listando citas: " + e.getMessage());
        }
        return lista;
    }

    // NUEVO MÉTODO: Trae solo las citas de un médico específico (Para el filtro de seguridad)
    public List<Cita> listarPorMedico(int idMedico) {
        List<Cita> lista = new ArrayList<>();
        String sql = "SELECT c.id, c.fecha_cita, c.hora_cita, c.estado, c.motivo, "
                   + "p.nombres AS pac_nom, p.apellidos AS pac_ape, p.documento, "
                   + "u.nombres AS med_nom, u.apellidos AS med_ape, e.nombre AS esp_nom "
                   + "FROM citas c "
                   + "JOIN pacientes p ON c.id_paciente = p.id "
                   + "JOIN usuarios u ON c.id_medico = u.id "
                   + "JOIN especialidades e ON c.id_especialidad = e.id "
                   + "WHERE c.id_medico = ? "
                   + "ORDER BY c.fecha_cita DESC, c.hora_cita DESC";
                   
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, idMedico);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cita c = new Cita();
                    c.setId(rs.getInt("id"));
                    c.setFechaCita(rs.getDate("fecha_cita"));
                    c.setHoraCita(rs.getTime("hora_cita"));
                    c.setEstado(rs.getString("estado"));
                    c.setMotivo(rs.getString("motivo"));
                    
                    c.setPacienteNombre(rs.getString("pac_nom") + " " + rs.getString("pac_ape"));
                    c.setPacienteDocumento(rs.getString("documento"));
                    c.setMedicoNombre(rs.getString("med_nom") + " " + rs.getString("med_ape"));
                    c.setEspecialidadNombre(rs.getString("esp_nom"));
                    
                    lista.add(c);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error listando citas por médico: " + e.getMessage());
        }
        return lista;
    }

    public boolean cambiarEstado(int idCita, String nuevoEstado) {
        String sql = "UPDATE citas SET estado = ? WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, idCita);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error cambiando estado de cita: " + e.getMessage());
            return false;
        }
    }

    public Cita buscarPorId(int id) {
        Cita cita = null;
        // Hacemos JOIN para traer los nombres y no solo los IDs numéricos
        String sql = "SELECT c.*, "
                   + "p.nombres || ' ' || p.apellidos AS paciente_nombre, "
                   + "p.documento AS paciente_documento, "
                   + "u.nombres || ' ' || u.apellidos AS medico_nombre, "
                   + "e.nombre AS especialidad_nombre "
                   + "FROM citas c "
                   + "INNER JOIN pacientes p ON c.id_paciente = p.id "
                   + "INNER JOIN usuarios u ON c.id_medico = u.id "
                   + "INNER JOIN especialidades e ON c.id_especialidad = e.id "
                   + "WHERE c.id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cita = new Cita();
                    cita.setId(rs.getInt("id"));
                    cita.setIdPaciente(rs.getInt("id_paciente"));
                    cita.setIdMedico(rs.getInt("id_medico"));
                    cita.setIdEspecialidad(rs.getInt("id_especialidad"));
                    cita.setFechaCita(rs.getDate("fecha_cita"));
                    cita.setHoraCita(rs.getTime("hora_cita"));
                    cita.setMotivo(rs.getString("motivo"));
                    cita.setEstado(rs.getString("estado"));
                    
                    // Seteamos los nombres que necesita el PDF Generator
                    cita.setPacienteNombre(rs.getString("paciente_nombre"));
                    cita.setPacienteDocumento(rs.getString("paciente_documento"));
                    cita.setMedicoNombre(rs.getString("medico_nombre"));
                    cita.setEspecialidadNombre(rs.getString("especialidad_nombre"));
                }
            }
        } catch (Exception e) {
            System.err.println("Error buscando cita por ID: " + e.getMessage());
        }
        return cita;
    }

    // ==============================================================================
    // NUEVOS MÉTODOS PARA EL DASHBOARD
    // ==============================================================================
    
    // Cuenta cuántas citas hay programadas para el día de hoy (fecha actual)
    public int contarCitasHoy() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM citas WHERE fecha_cita = CURRENT_DATE";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error contando citas de hoy: " + e.getMessage());
        }
        return total;
    }

    // Cuenta cuántas citas están en estado 'PROGRAMADA' (Pendientes)
    public int contarCitasPendientes() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM citas WHERE estado = 'PROGRAMADA'";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error contando citas pendientes: " + e.getMessage());
        }
        return total;
    }

    // Cuenta el total de citas del mes y año actual
    public int contarCitasMes() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM citas WHERE EXTRACT(MONTH FROM fecha_cita) = EXTRACT(MONTH FROM CURRENT_DATE) AND EXTRACT(YEAR FROM fecha_cita) = EXTRACT(YEAR FROM CURRENT_DATE)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql); // <-- CORRECCIÓN APLICADA AQUÍ
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error contando citas del mes: " + e.getMessage());
        }
        return total;
    }
}