package permisos;

import java.io.InputStream;
import java.util.Properties;

public class Config {
    private static final Properties props = new Properties();

    static {
        try (InputStream in = Config.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (in != null) props.load(in);
        } catch (Exception e) {
            // ignore and allow fallback to env
        }
    }

    public static String get(String key, String def) {
        String v = props.getProperty(key);
        if (v != null) return v;
        v = System.getenv(key);
        if (v != null) return v;
        v = System.getProperty(key);
        return v != null ? v : def;
    }

    public static String get(String key) {
        return get(key, null);
    }
}
