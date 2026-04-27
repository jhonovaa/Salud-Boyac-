package co.sena.adso.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    // Supabase usa postgresql://
    private static final String URL = System.getenv("DB_URL") != null
        ? System.getenv("DB_URL")
        : "jdbc:postgresql://aws-0-sa-east-1.pooler.supabase.com:5432/postgres"; // Cambia por tu URL local/de prueba
    
    private static final String USER = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "postgres.tu_id";
    private static final String PASS = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : "tu_password";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException ex) {
            throw new SQLException("Error al cargar el driver de PostgreSQL", ex);
        }
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