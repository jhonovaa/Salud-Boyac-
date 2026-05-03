package co.sena.adso.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import co.sena.adso.dto.Paciente;
import co.sena.adso.model.Conexion;

public class PacienteDAO {

    // MÉTODO ORIGINAL INTACTO
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

    // MÉTODO ORIGINAL INTACTO
    public List<Paciente> listarTodos() {
        List<Paciente> lista = new ArrayList<>();
        String sql = "SELECT id, nombres, apellidos, documento, fecha_nacimiento, telefono, email, eps, vereda_barrio FROM pacientes ORDER BY nombres";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
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
                
                lista.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error listando pacientes: " + e.getMessage());
        }
        return lista;
    }

    // MÉTODO ORIGINAL INTACTO
    public Paciente buscarPorDocumento(String documento) {
        Paciente paciente = null;
        String sql = "SELECT id, nombres, apellidos, documento, fecha_nacimiento, telefono, email, eps, vereda_barrio "
                   + "FROM pacientes WHERE documento = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, documento);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    paciente = new Paciente();
                    paciente.setId(rs.getInt("id"));
                    paciente.setNombres(rs.getString("nombres"));
                    paciente.setApellidos(rs.getString("apellidos"));
                    paciente.setDocumento(rs.getString("documento"));
                    paciente.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                    paciente.setTelefono(rs.getString("telefono"));
                    paciente.setEmail(rs.getString("email"));
                    paciente.setEps(rs.getString("eps"));
                    paciente.setVeredaBarrio(rs.getString("vereda_barrio"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error buscando paciente por documento: " + e.getMessage());
        }
        return paciente;
    }

    // MÉTODO ORIGINAL INTACTO
    public int contarTotalPacientes() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM pacientes";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error contando pacientes: " + e.getMessage());
        }
        return total;
    }

    // ==========================================
    // NUEVOS MÉTODOS PARA EL CRUD COMPLETO
    // ==========================================

    public Paciente buscarPorId(int id) {
        Paciente paciente = null;
        String sql = "SELECT id, nombres, apellidos, documento, fecha_nacimiento, telefono, email, eps, vereda_barrio "
                   + "FROM pacientes WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    paciente = new Paciente();
                    paciente.setId(rs.getInt("id"));
                    paciente.setNombres(rs.getString("nombres"));
                    paciente.setApellidos(rs.getString("apellidos"));
                    paciente.setDocumento(rs.getString("documento"));
                    paciente.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                    paciente.setTelefono(rs.getString("telefono"));
                    paciente.setEmail(rs.getString("email"));
                    paciente.setEps(rs.getString("eps"));
                    paciente.setVeredaBarrio(rs.getString("vereda_barrio"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error buscando paciente por ID: " + e.getMessage());
        }
        return paciente;
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
}