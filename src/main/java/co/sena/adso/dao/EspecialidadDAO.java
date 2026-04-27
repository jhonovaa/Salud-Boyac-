package co.sena.adso.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import co.sena.adso.dto.Especialidad;
import co.sena.adso.model.Conexion;

public class EspecialidadDAO {
    public List<Especialidad> listarTodas() {
        List<Especialidad> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, descripcion FROM especialidades ORDER BY nombre";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Especialidad e = new Especialidad();
                e.setId(rs.getInt("id"));
                e.setNombre(rs.getString("nombre"));
                e.setDescripcion(rs.getString("descripcion"));
                lista.add(e);
            }
        } catch (SQLException ex) {
            System.err.println("Error listando especialidades: " + ex.getMessage());
        }
        return lista;
    }
}