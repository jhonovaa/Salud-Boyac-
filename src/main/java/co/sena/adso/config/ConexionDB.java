package co.sena.adso.config;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConexionDB {

    private static final Properties props = new Properties();

    static {
        // Cargamos la configuración desde el archivo de propiedades
        try (InputStream in = ConexionDB.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in == null) {
                throw new RuntimeException("Error: No se encontró el archivo db.properties");
            }
            props.load(in);
            
            // Registro del driver de PostgreSQL necesario para Supabase (Se hace una sola vez aquí)
            Class.forName("org.postgresql.Driver");
            
            System.out.println(">>> Conexión de Santa Rosa inicializada.");
        } catch (Exception e) {
            throw new RuntimeException("Error crítico al cargar configuración o driver", e);
        }
    }

    public static Connection obtenerConexion() throws SQLException {
        String url = props.getProperty("supabase.url");
        String user = props.getProperty("supabase.user");
        String pass = props.getProperty("supabase.password");

        return DriverManager.getConnection(url, user, pass);
    }

    // Método añadido para cerrar la conexión de forma segura y liberar recursos en Supabase
    public static void cerrarConexion(Connection conn) {
        if (conn != null) {
            try {
                if (!conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }
}