package co.sena.adso.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import co.sena.adso.dto.Paciente;
import co.sena.adso.dto.Cita; 
import co.sena.adso.model.Conexion;

public class PacienteDAO {

    public boolean insertar(Paciente p) {
        String sql = "INSERT INTO pacientes (nombres, apellidos, documento, fecha_nacimiento, telefono, email, eps, vereda_barrio) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getNombres());
            ps.setString(2, p.getApellidos());
            ps.setString(3, p.getDocumento());
            ps.setDate(4, p.getFechaNacimiento());
            ps.setString(5, p.getTelefono());
            ps.setString(6, p.getEmail());
            ps.setString(7, p.getEps());
            ps.setString(8, p.getVeredaBarrio());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error insertando paciente: " + e.getMessage());
            return false;
        }
    }

    public Paciente buscarPorDocumento(String documento) {
        Paciente paciente = null;
        String sql = "SELECT * FROM pacientes WHERE documento = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, documento);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    paciente = mappearPaciente(rs);
                    // Al encontrar al paciente, cargamos su historial de citas completo
                    paciente.setCitas(obtenerCitasPorPaciente(paciente.getId()));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error buscando paciente por documento: " + e.getMessage());
        }
        return paciente;
    }

    // Metodo fundamental para mostrar las citas del paciente en la vista
    public List<Cita> obtenerCitasPorPaciente(int idPaciente) {
        List<Cita> citas = new ArrayList<>();
        
        // Consulta validada en Supabase con ORDER BY para mostrar la cita mas nueva primero
        String sql = "SELECT c.id, c.fecha_cita, c.hora_cita, c.motivo, c.estado, c.observaciones, c.fecha_registro, " +
             "u.nombres AS medico_nombres, u.apellidos AS medico_apellidos, " +
             "e.nombre AS especialidad_nombre " +
             "FROM citas c " +
             "LEFT JOIN usuarios u ON c.id_medico = u.id " +
             "LEFT JOIN especialidades e ON c.id_especialidad = e.id " +
             "WHERE c.id_paciente = ? " +
             "ORDER BY c.fecha_cita DESC, c.hora_cita DESC";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idPaciente);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cita cita = new Cita();
                    cita.setId(rs.getInt("id"));
                    cita.setFechaCita(rs.getDate("fecha_cita"));
                    cita.setHoraCita(rs.getTime("hora_cita"));
                    cita.setMotivo(rs.getString("motivo"));
                    cita.setEstado(rs.getString("estado"));
                    cita.setObservaciones(rs.getString("observaciones"));
                    cita.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                    
                    // Mapeo de nombres del medico desde la tabla usuarios
                    String mNom = rs.getString("medico_nombres");
                    String mApe = rs.getString("medico_apellidos");
                    cita.setMedicoNombre((mNom != null ? mNom : "") + " " + (mApe != null ? mApe : ""));
                    
                    // Mapeo del nombre de la especialidad
                    cita.setEspecialidadNombre(rs.getString("especialidad_nombre"));
                    
                    citas.add(cita);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error obteniendo historial de citas: " + e.getMessage());
        }
        return citas;
    }

    public Paciente buscarPorId(int id) {
        Paciente paciente = null;
        String sql = "SELECT * FROM pacientes WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    paciente = mappearPaciente(rs);
                    paciente.setCitas(obtenerCitasPorPaciente(paciente.getId()));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error buscando paciente por ID: " + e.getMessage());
        }
        return paciente;
    }

    private Paciente mappearPaciente(ResultSet rs) throws SQLException {
        Paciente p = new Paciente();
        p.setId(rs.getInt("id"));
        p.setNombres(rs.getString("nombres"));
        p.setApellidos(rs.getString("apellidos"));
        p.setDocumento(rs.getString("documento"));
        p.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
        p.setTelefono(rs.getString("telefono"));
        p.setEmail(rs.getString("email"));
        p.setEps(rs.getString("eps"));
        p.setVeredaBarrio(rs.getString("vereda_barrio"));
        return p;
    }

    public List<Paciente> listarTodos() {
        List<Paciente> lista = new ArrayList<>();
        String sql = "SELECT * FROM pacientes ORDER BY nombres";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mappearPaciente(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error listando pacientes: " + e.getMessage());
        }
        return lista;
    }

    public boolean actualizar(Paciente p) {
        String sql = "UPDATE pacientes SET nombres = ?, apellidos = ?, documento = ?, fecha_nacimiento = ?, "
                   + "telefono = ?, email = ?, eps = ?, vereda_barrio = ? WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getNombres());
            ps.setString(2, p.getApellidos());
            ps.setString(3, p.getDocumento());
            ps.setDate(4, p.getFechaNacimiento());
            ps.setString(5, p.getTelefono());
            ps.setString(6, p.getEmail());
            ps.setString(7, p.getEps());
            ps.setString(8, p.getVeredaBarrio());
            ps.setInt(9, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error actualizando paciente: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM pacientes WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error eliminando paciente: " + e.getMessage());
            return false;
        }
    }

    public int contarTotalPacientes() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM pacientes";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) total = rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("Error contando pacientes: " + e.getMessage());
        }
        return total;
    }
}