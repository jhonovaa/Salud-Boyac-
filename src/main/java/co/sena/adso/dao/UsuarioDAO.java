package co.sena.adso.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import co.sena.adso.dto.Usuario;
import co.sena.adso.model.Conexion;

public class UsuarioDAO {
    
    public Usuario validarLogin(String username, String password) {
        Usuario usuario = null;
        String sql = "SELECT id, nombres, apellidos, documento, email, rol, lang_preferido FROM usuarios WHERE username = ? AND password = ? AND activo = true";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNombres(rs.getString("nombres"));
                    usuario.setApellidos(rs.getString("apellidos"));
                    usuario.setDocumento(rs.getString("documento"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setRol(rs.getString("rol"));
                    usuario.setLangPreferido(rs.getString("lang_preferido"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en validarLogin: " + e.getMessage());
        }
        return usuario;
    }

    public List<Usuario> listarTodos() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT id, nombres, apellidos, documento, email, username, rol, especialidad FROM usuarios WHERE activo = true";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidos(rs.getString("apellidos"));
                u.setDocumento(rs.getString("documento"));
                u.setEmail(rs.getString("email"));
                u.setUsername(rs.getString("username"));
                u.setRol(rs.getString("rol"));
                u.setEspecialidad(rs.getString("especialidad"));
                lista.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Error listando usuarios: " + e.getMessage());
        }
        return lista;
    }
}