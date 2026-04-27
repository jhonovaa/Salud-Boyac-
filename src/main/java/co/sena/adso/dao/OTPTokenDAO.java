package co.sena.adso.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import co.sena.adso.model.Conexion;

public class OTPTokenDAO {
    
    public boolean insertar(int idUsuario, String codigo, Timestamp expiraEn) {
        // CORRECCIÓN: Agregamos 'fecha_gen' para forzar que guarde la hora de creación de Java (Colombia)
        String sql = "INSERT INTO otp_tokens (id_usuario, codigo, expira_en, fecha_gen) VALUES (?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setString(2, codigo);
            ps.setTimestamp(3, expiraEn);
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis())); // Hora local actual
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error insertando OTP: " + e.getMessage());
            return false;
        }
    }

    public boolean validar(int idUsuario, String codigoIngresado) {
        // CORRECCIÓN: Cambiamos 'CURRENT_TIMESTAMP' por un '?' para validar usando la hora local de Java
        String sql = "SELECT id FROM otp_tokens WHERE id_usuario = ? AND codigo = ? AND usado = false AND expira_en > ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setString(2, codigoIngresado);
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis())); // Hora local actual para validar
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    marcarUsado(rs.getInt("id"));
                    return true;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error validando OTP: " + e.getMessage());
        }
        return false;
    }

    private void marcarUsado(int idToken) {
        String sql = "UPDATE otp_tokens SET usado = true WHERE id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idToken);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error marcando OTP como usado: " + e.getMessage());
        }
    }
}