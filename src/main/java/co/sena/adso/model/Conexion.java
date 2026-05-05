package co.sena.adso.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    
    // Tus credenciales directas de Supabase
    private static final String URL = System.getenv("DB_URL") != null
        ? System.getenv("DB_URL")
        // IMPORTANTE: Use el puerto 5432 de tu db.properties original para evitar problemas
        : "jdbc:postgresql://aws-1-us-east-2.pooler.supabase.com:5432/postgres?sslmode=require"; 
    
    private static final String USER = System.getenv("DB_USER") != null 
        ? System.getenv("DB_USER") 
        : "postgres.uiirgkypwrvgcbncursh";
        
    private static final String PASS = System.getenv("DB_PASS") != null 
        ? System.getenv("DB_PASS") 
        : "holacomo3stas";

    public static Connection getConnection() throws SQLException {
        try {
            // 1. Cargamos el driver de PostgreSQL
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Error fatal: No se encontro el Driver de PostgreSQL");
            e.printStackTrace();
        }
        
        // 2. Nos conectamos DIRECTAMENTE usando las variables de arriba
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public static void closeConnection(Connection connection) {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException ex) {
            System.err.println("Error al cerrar conexion: " + ex.getMessage());
        }
    }
}