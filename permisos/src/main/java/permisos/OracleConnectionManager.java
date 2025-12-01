package permisos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class OracleConnectionManager {

    private static final String URL = "CADEBA";
    private static final String USER = "USUARIO";
    private static final String PASSWORD = "CLAVE";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
