package co.sena.adso.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import co.sena.adso.dto.Horario;
import co.sena.adso.model.Conexion;

public class HorarioDAO {

    public List<Horario> listarTodos() {
        List<Horario> lista = new ArrayList<>();
        String sql = "SELECT id, id_medico, dia_semana, hora_inicio, hora_fin, max_citas FROM horarios ORDER BY dia_semana, hora_inicio";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                Horario h = new Horario();
                h.setId(rs.getInt("id"));
                h.setIdMedico(rs.getInt("id_medico"));
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
}