package permisos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;


public class Progreso {

	@WebServlet("/uploadProgress")
	public class UploadProgressServlet extends HttpServlet {
	    @Override
	    protected void doGet(HttpServletRequest req, HttpServletResponse res)
	            throws ServletException, IOException {
	        HttpSession session = req.getSession(false);
	        int total = session==null || session.getAttribute("totalPages")==null
	                    ? 0 : (int) session.getAttribute("totalPages");
	        int done  = session==null || session.getAttribute("processedPages")==null
	                    ? 0 : (int) session.getAttribute("processedPages");
	        res.setContentType("application/json");
	        res.getWriter().printf("{\"done\":%d,\"total\":%d}", done, total);
	    }
	}
	
}


