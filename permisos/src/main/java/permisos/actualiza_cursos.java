package permisos;

import java.net.URI;
import java.sql.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.apache.hc.client5.http.classic.HttpClient;
import org.apache.oltu.oauth2.client.OAuthClient;
import org.apache.oltu.oauth2.client.URLConnectionClient;
import org.apache.oltu.oauth2.client.request.OAuthClientRequest;
import org.apache.oltu.oauth2.client.response.OAuthJSONAccessTokenResponse;
import org.apache.oltu.oauth2.client.response.OAuthResourceResponse;
import org.apache.oltu.oauth2.common.OAuth;
import org.apache.oltu.oauth2.common.message.types.GrantType;
import org.json.*;

public class actualiza_cursos {
	  private static final String API_URL = "https://api.saviacloud.net/ginpix7/V2/Entidades/1/PlanCod/2025/search/(AnioPlan=2025)";
	    private static final String OAUTH_TOKEN = "TU_TOKEN_OAUTH"; // Reemplazar con el token v�lido
	    private static final String DB_URL = "CADENA";
	    private static final String DB_USER = "USUARIO";
	    private static final String DB_PASSWORD = "CALVE";
		
	    public static final String TOKEN_REQUEST_URL = "A";
	    public static final String CLIENT_ID = "B";
	    public static final String CLIENT_SECRET = "C";
	    public static final String SCOPE = "H";
	    public static final String RESOURCE_URL_TPL =   "I";

	    
    
    public static void main(String[] args) {
        try {
            JSONArray formaciones = obtenerFormaciones(1, 2025); // Reemplazar con valores reales
            guardarEnBD(formaciones);
        } catch (Exception e) {
            e.printStackTrace();
        }
       }

    private static JSONArray obtenerFormaciones(int entidadCod, int planCod) throws Exception {
        // 1) Obtenci�n de token
    	   OAuthClient client2 = new OAuthClient(new URLConnectionClient());

           OAuthClientRequest request2 =
                   OAuthClientRequest.tokenLocation(TOKEN_REQUEST_URL)
                   .setGrantType(GrantType.CLIENT_CREDENTIALS)                    
                   .setScope(SCOPE)                    
                   .buildBodyMessage();
          
           request2.addHeader("Content-Type", "application/x-www-form-urlencoded");
           request2.addHeader("Authorization", "Basic XX");
           request2.addHeader("cache-control", "no-cache");
      
           OAuthResourceResponse resourceResponse = client2.resource(request2, OAuth.HttpMethod.POST, OAuthResourceResponse.class);
        
          String token = client2.accessToken(request2,
                   				OAuth.HttpMethod.POST,
                                  OAuthJSONAccessTokenResponse.class).getAccessToken();

        // 2) Iterar paginando
        JSONArray todasFormaciones = new JSONArray();
        int start = 0;
        final int limit = 30;
        boolean hasMore = true;

        while (hasMore) {
            // Construir URL con par�metros Start/Limit
            String apiUrl = String.format(
                "https://api.saviacloud.net/api/V2/Entidades/%d/PlanCod/%d/search/(AnioPlan=%d)?Start=%d&Limit=%d",
                entidadCod, planCod, planCod, start, limit
            );
            apiUrl="https://api.saviacloud.net/ginpix7/V2/Entidades/1/PlanCod/2025/search/(AnioPlan=2025)?start=" + start;
            System.out.println("Llamando a la API: " + apiUrl);

            // Abrir conexi�n
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + token);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Ocp-Apim-Subscription-Key", "4f9e137d0ac64a61b215a8ae888a00c9");

            int code = conn.getResponseCode();
            System.out.println("C�digo de respuesta: " + code);

            if (code == 200) {
                // Leer y parsear JSON usando "UTF-8"
                BufferedReader reader = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8")
                );
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
                reader.close();

                JSONObject root = new JSONObject(sb.toString());
                JSONArray data = root.getJSONArray("Data");

                // Acumular resultados
                for (int i = 0; i < data.length(); i++) {
                    todasFormaciones.put(data.getJSONObject(i));
                }

                // Controlar paginado
                JSONObject pagination = root
                    .getJSONObject("Metadata")
                    .getJSONObject("Pagination");
                hasMore = pagination.getBoolean("HasMore");
                System.out.println("HasMore = " + hasMore);

                start += limit;
            } else {
                throw new RuntimeException("Error al llamar API: HTTP " + code);
            }

            conn.disconnect();
        }

        return todasFormaciones;
    }
    private static void guardarEnBD(JSONArray formaciones) throws SQLException {
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); 
        String sql = "{ call ACTUALIZA_CURSOS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";  PreparedStatement pstmt = conn.prepareStatement(sql);

            for (int i = 0; i < formaciones.length(); i++) {
            	
            	Integer HorasDistancia=0;
            
                JSONObject curso = formaciones.getJSONObject(i);
               // HorasDistancia =curso.getInt("HorasDistancia");
              //  System.out.println("horas" + curso.get("HorasDistancia"));
                
                int    cursoCod     = curso.optInt("CursoCod", 0);
                String cursoDes     = curso.optString("CursoDes", "");
                String planDes      = curso.optString("PlanDes", "");
                String horasCursos  = curso.opt("HorasCursos") != JSONObject.NULL
                                      ? curso.get("HorasCursos").toString()
                                      : "0";
                String horasPres    = curso.opt("HorasPresenciales") != JSONObject.NULL
                                      ? curso.get("HorasPresenciales").toString()
                                      : "0";
                String horasDist    = curso.opt("HorasDistancia") != JSONObject.NULL
                                      ? curso.get("HorasDistancia").toString()
                                      : "0";
                String destinatarios= curso.optString("Destinatarios", "");
                String numConv      = String.valueOf(curso.optInt("NumeroConvocatorias", 0));
                String edicion      = String.valueOf(curso.optInt("Edicion", 0));
                String plazas       = String.valueOf(curso.optInt("NumeroPlazas", 0));
                String calendario   = curso.optString("HorarioCalendario", "");
                String estadoConv   = curso.optString("EstadoConvocatoria", "");
                
              
                
               
            	//	   ,  contenido, objetivo, requisitos, observaciones, solicitudes, num_convocatorias, version_convocatorias, plazas_curso, calendario, estado_convocatoria)
               /* pstmt.setInt(1, curso.getInt("CursoCod"));
                pstmt.setString(2, curso.getString("CursoDes"));
                pstmt.setString(3, curso.getString("PlanDes"));
                pstmt.setString(4, curso.get("HorasCursos").toString());
                pstmt.setString(5, curso.get("HorasPresenciales").toString());
                pstmt.setString(6,curso.get("HorasDistancia").toString());
                pstmt.setString(7, "");
                pstmt.setString(8, "");
                pstmt.setString(9, curso.get("Destinatarios").toString());
                pstmt.setString(10, "");
                pstmt.setString(11, "");
                pstmt.setString(12, curso.get("NumeroConvocatorias").toString());
                pstmt.setString(13, curso.get("Edicion").toString());
                pstmt.setString(14, curso.get("NumeroPlazas").toString());
                pstmt.setString(15, curso.get("HorarioCalendario").toString());
                pstmt.setString(16, curso.getString("EstadoConvocatoria"));*/
                
                
                pstmt.setInt(1,  cursoCod);
                pstmt.setString(2, cursoDes);
                pstmt.setString(3, planDes);
                pstmt.setString(4, horasCursos);
                pstmt.setString(5, horasPres);
                pstmt.setString(6, horasDist);
                pstmt.setString(7, "");  // contenido
                pstmt.setString(8, "");  // objetivo
                pstmt.setString(9, destinatarios);
                pstmt.setString(10, ""); // observaciones
                pstmt.setString(11, ""); // solicitudes
                pstmt.setString(12, numConv);
                pstmt.setString(13, edicion);
                pstmt.setString(14, plazas);
                pstmt.setString(15, calendario);
                pstmt.setString(16, estadoConv);

                
                pstmt.executeUpdate();
               
            }
            pstmt.close();
            System.out.println("Datos insertados correctamente.");
        
    }
    
    public String actualizarCursos() {
        try {
            JSONArray formaciones = obtenerFormaciones(1,2025);
            guardarEnBD(formaciones);
            return "Cursos actualizados correctamente.";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error al actualizar cursos: " + e.getMessage();
        }
    }
}