package co.sena.adso.model;

import java.sql.Connection;
import java.sql.SQLException;

import co.sena.adso.config.ConexionDB;

public class Conexion {
    // Supabase usa postgresql://
    private static final String URL = System.getenv("DB_URL") != null
        ? System.getenv("DB_URL")
        : "jdbc:postgresql://aws-0-sa-east-1.pooler.supabase.com:5432/postgres"; // Cambia por tu URL local/de prueba
    
    private static final String USER = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "postgres.uiirgkypwrvgcbncursh";
    private static final String PASS = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : "holacomo3stas";

    public static Connection getConnection() throws SQLException {
        // CORRECCIÓN: Delegamos la conexión a ConexionDB para que utilice las credenciales reales de Supabase
        return ConexionDB.obtenerConexion();
    }

    public static void closeConnection(Connection connection) {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException ex) {
            System.err.println("Error al cerrar conexión: " + ex.getMessage());
        }
    }
}