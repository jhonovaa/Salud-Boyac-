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
}