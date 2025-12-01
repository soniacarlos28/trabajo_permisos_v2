package permisos;


import net.sourceforge.tess4j.Tesseract;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletContext;
public class OCRutilis {
    /**
     * Extrae texto de la primera página de un PDF usando Tesseract en español.
     * Asegúrate de tener 'spa.traineddata' en tu carpeta tessdata.
     */
	public static String extraerTexto(File pdfFile, ServletContext context) throws Exception {
        // Carga el PDF y renderiza la primera página a BufferedImage
        PDDocument doc = PDDocument.load(pdfFile);
        PDFRenderer renderer = new PDFRenderer(doc);
        BufferedImage image = renderer.renderImageWithDPI(0, 300);
        doc.close();

        // Configura Tesseract para español y ruta bajo WEB-INF
        Tesseract tesseract = new Tesseract();
        // Resuelve la ruta absoluta de WEB-INF/tessdata
        String tessDataPath = context.getRealPath("/WEB-INF/tessdata");
        if (tessDataPath == null) {
            throw new IllegalStateException("No se ha encontrado WEB-INF/tessdata en el contexto de la aplicación");
        }
        tesseract.setDatapath(tessDataPath);
        tesseract.setLanguage("spa");                // Código ISO para español

        // Realiza OCR sobre la imagen renderizada
        return tesseract.doOCR(image);
    }

	public static String extraerDni(String texto) {
        // Pasa a mayúsculas para unificar
        String mayus = texto.toUpperCase();
        
        // Regex con grupo: opcional 'NIF:' o 'DNI:' seguido de espacios opcionales, luego captura 8 dígitos + letra o NIE
        //Pattern p = Pattern.compile("(?:[XYZ]\\d{7}|\\d{8})\\s?[A-Z]");
        Pattern p = Pattern.compile("NIF[:\\s]+([0-9]{8})\\s*([A-Z])");  
        Matcher m = p.matcher(mayus);
        if (m.find()) {
            // m.group(1) incluye los 8 dígitos o NIE inicial + letra => total 9 caracteres
            String nif = m.group(1);
            // Si el regex capturó sólo los primeros 8 dígitos o NIE, añadimos la letra final de m.group(0)
            if (nif.length() == 8) {
                // letra al final
                nif += m.group(0).substring(m.group(0).length() - 1);
            }
            System.out.println("nif" + nif);
            
            return nif;
        }
        return "DESCON";
    }
      
    public static String extraerPeriodo(String texto) {
        Pattern p = Pattern.compile("(\\d{2}/\\d{4})");
        Matcher m = p.matcher(texto);
        return m.find() ? m.group() : "00/0000";
    }
}
