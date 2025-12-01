package permisos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class OracleConnectionManager {

    private static final String URL = Config.get("DB_URL", "CADEBA");
    private static final String USER = Config.get("DB_USER", "USUARIO");
    private static final String PASSWORD = Config.get("DB_PASSWORD", "CLAVE");

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
