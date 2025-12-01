package permisos;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

@WebServlet("/upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize       = 1024 * 1024 * 100,
    maxRequestSize    = 1024 * 1024 * 300
)
public class SubirNomina extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        String mes     = request.getParameter("mes");
        String anio    = request.getParameter("anio");
        String periodo = mes + anio;

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Progreso</title>");
        // Estilos simples para barra
        out.println("<style>#progress-container{width:80%;background:#eee;border:1px solid #ccc;padding:3px;}#bar{width:0%;height:20px;background:green;}#status{text-align:center;margin-top:5px;}</style>");
        out.println("</head><body>");
        out.println("<h2>Procesando nóminas...</h2>");
        out.println("<div id='progress-container'><div id='bar'></div></div>");
        out.println("<div id='status'>0 de 0</div>");
        out.println("<script>function updateProgress(done, total){var pct=Math.round(done/total*100);document.getElementById('bar').style.width=pct+'%';document.getElementById('status').textContent=done+' de '+total+' ('+pct+'%)'}</script>");
        out.flush();

        Part pdfPart = request.getParts().stream()
            .filter(p -> "nominasPDF".equals(p.getName()) && p.getSize() > 0)
            .findFirst().orElse(null);
        if (pdfPart == null) {
            out.println("<p>Error: no se subió ningún PDF.</p>");
            finalizar(out);
            return;
        }

        File tempPdf = File.createTempFile("nominas_", ".pdf");
        try (InputStream in = pdfPart.getInputStream();
             FileOutputStream fos = new FileOutputStream(tempPdf)) {
            byte[] buf = new byte[8192];
            int r;
            while ((r = in.read(buf)) != -1) {
                fos.write(buf, 0, r);
            }
        }

        List<File> paginas = PDFsepara.separarPaginas(tempPdf);
        int total = paginas.size();
        String nif_anterior = "";
        int id_carga = 0;
        try {
            id_carga = obtenerSiguienteIdCarga();
        } catch (SQLException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }

        // ==== CORRECCIÓN DE CONEXIONES: UNA SOLA CONEXIÓN PARA TODO Y BIEN CERRADA ====
        Connection conn = null;
        try {
            conn = OracleConnectionManager.getConnection();

            for (int i = 0; i < paginas.size(); i++) {
                File pagina = paginas.get(i);
                int done = i + 1;
                // Actualizar barra en cliente
                out.println("<script>updateProgress(" + done + "," + total + ");</script>");
                out.flush();
                try {
                    String texto = OCRutilis.extraerTexto(pagina, getServletContext());
                    String dni   = OCRutilis.extraerDni(texto);
                    
                    Integer id_nomina = 1;  
                   
                    nif_anterior = dni;

                    String selectSql = "SELECT NVL(MAX(ID_NOMINA), 0) + 1 " +
                                       "FROM RRHH.NOMINA_FUNCIONARIO " +
                                       "WHERE NIF = ? AND PERIODO = ?";
                    try (PreparedStatement psSelect = conn.prepareStatement(selectSql)) {
                        psSelect.setString(1, dni);
                        psSelect.setString(2, periodo);
                        try (ResultSet rs = psSelect.executeQuery()) {
                            id_nomina = 1;
                            if (rs.next()) {
                                id_nomina = rs.getInt(1);
                            }
                        }
                    }

                    String sql = "INSERT INTO RRHH.NOMINA_FUNCIONARIO " +
                            "(NIF, PERIODO, ID_NOMINA, ID_CARGA, CANTIDAD, NOMINA) " +
                            "VALUES (?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement ps = conn.prepareStatement(sql);
                         InputStream fis = new BufferedInputStream(new FileInputStream(pagina))) {
                        ps.setString(1, dni);
                        ps.setString(2, periodo);
                        
                        // 3 y 4: identificadores numéricos (ajusta a tu tipo real)
                        ps.setInt(3, id_nomina);
                        ps.setInt(4, id_carga); // Sacar el Id nomina
                        
                        // 5: cantidad
                        ps.setInt(5, 0);
                        
                        // 6: el BLOB / archivo
                        ps.setBinaryStream(6, fis, fis.available());
                        
                        ps.executeUpdate();
                    }
                } catch (Exception e) {
                    out.println("<p>Error procesando página " + done + ": " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    pagina.delete();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error de base de datos: " + e.getMessage() + "</p>");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        // ==== FIN CORRECCIÓN CONEXIONES ====

        tempPdf.delete();
        out.println("<p>¡Terminado!</p>");
        finalizar(out);
    }

    public int obtenerSiguienteIdCarga() throws SQLException {
        String sql = "SELECT NVL(MAX(ID_CARGA), 0) + 1 FROM RRHH.NOMINA_FUNCIONARIO";
        try (
            Connection conn = OracleConnectionManager.getConnection();
            Statement stmt  = conn.createStatement();
            ResultSet rs    = stmt.executeQuery(sql)
        ) {
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                // por si acaso no devolviera nada, damos 1
                return 1;
            }
        }
    }

    private void finalizar(PrintWriter out) {
        out.println("</body></html>");
        out.flush();
    }
}
