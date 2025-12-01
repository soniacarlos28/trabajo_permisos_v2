package permisos;

import org.apache.pdfbox.pdmodel.PDDocument;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PDFsepara {
    public static List<File> separarPaginas(File original) throws IOException {
        List<File> paginas = new ArrayList<>();
        PDDocument doc = null;
        try {
            doc = PDDocument.load(original);
            int totalPages = doc.getNumberOfPages();

            for (int i = 0; i < totalPages; i++) {
                PDDocument pagina = new PDDocument();
                try {
                    pagina.addPage(doc.getPage(i));
                    File temp = File.createTempFile("pagina_", ".pdf");
                    pagina.save(temp);
                    paginas.add(temp);
                } finally {
                    pagina.close();
                }
            }
        } finally {
            if (doc != null) {
                doc.close();
            }
        }
        return paginas;
    }
}