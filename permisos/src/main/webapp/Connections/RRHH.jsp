<%
// Load DB connection settings from /WEB-INF/config.properties
java.util.Properties _cfg = new java.util.Properties();
try (java.io.InputStream _in = application.getResourceAsStream("/WEB-INF/config.properties")) {
	if (_in != null) _cfg.load(_in);
} catch (Exception _e) {
	// ignore and use defaults below
}

String MM_RRHH_DRIVER = _cfg.getProperty("MM_RRHH_DRIVER", "oracle.jdbc.driver.OracleDriver");
String MM_RRHH_USERNAME = _cfg.getProperty("MM_RRHH_USERNAME", "USUARIO");
String MM_RRHH_PASSWORD = _cfg.getProperty("MM_RRHH_PASSWORD", "CLAVE");
String MM_RRHH_STRING = _cfg.getProperty("MM_RRHH_STRING", "CADENA");
%>
