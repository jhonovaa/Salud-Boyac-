package co.sena.adso.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import co.sena.adso.dto.Paciente;
import co.sena.adso.model.Conexion;

public class PacienteDAO {

    // Método principal de búsqueda utilizando el documento (cédula) en lugar del ID
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
}