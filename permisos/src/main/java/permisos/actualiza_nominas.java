package permisos;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.ServletContext;

public class actualiza_nominas  {

	 public void procesarPdf(File pdfFile, String periodo, ServletContext context) {
	        List<File> paginas = null;
	        try {
	            paginas = PDFsepara.separarPaginas(pdfFile);
	            for (File pagina : paginas) {
	                try {
	                    // Ajuste: pasar ServletContext a OCRutilis
	                    String texto = OCRutilis.extraerTexto(pagina, context);
	                    String dni = OCRutilis.extraerDni(texto);
	                    guardarEnOracle(dni, periodo, pagina);
	                } catch (Exception e) {
	                    e.printStackTrace();
	                } finally {
	                    pagina.delete();
	                }
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (paginas != null) {
	                for (File pagina : paginas) {
	                    if (pagina.exists()) pagina.delete();
	                }
	            }
	            pdfFile.delete();
	        }
	    }

    private void guardarEnOracle(String dni, String periodo, File pdf) throws Exception {
        try (Connection conn = OracleConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO temp_nomina (nif, periodo, nomina) VALUES (?, ?, ?)")) {
            try (InputStream fis = new BufferedInputStream(new FileInputStream(pdf))) {
                ps.setString(1, dni);
                ps.setString(2, periodo);
                ps.setBinaryStream(3, fis);
                ps.executeUpdate();
            }
        }
    }
}