<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@page import = "java.sql.*,java.io. *, java.util. *, javax.servlet. *" %>
<%@page import = "javax.servlet.http. *" %>
<%@page import = "org.apache.commons.fileupload. *" %>
<%@page import = "org.apache.commons.fileupload.disk. *" %>
<%@page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ include file="../../../Connections/RRHH.jsp" %>

<%
String RS__MMColParam1 = "1";
if (request.getParameter("ID_ENLACE")    !=null) {RS__MMColParam1 = (String)request.getParameter("ID_ENLACE");}
%>

<%
String RS__MMColParam2 = "P";
if (request.getParameter("PERMISO")    !=null) {RS__MMColParam2 = (String)request.getParameter("PERMISO");}
%>

<html>
<head>
<title>Justificante de Permiso/Ausencia</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="RRHH.css" rel="stylesheet" type="text/css">
</head>
<body>


<div id="form">
  <table>
  <tr>


<%
  
   int maxFileSize = 1024*1024*1;//Maximo 1 mb
   int maxMemSize = 500000 * 1024;
   String filePath = "C:/temp";
 
   String contentType = request.getContentType();
   
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
 
     
      try {
          // Apache Commons-Fileupload library classes
          DiskFileItemFactory factory = new DiskFileItemFactory();
          ServletFileUpload sfu  = new ServletFileUpload(factory);

          if (! ServletFileUpload.isMultipartContent(request)) {
              System.out.println("sorry. No file uploaded");
              return;
          }

          // parse request
          List items = sfu.parseRequest(request);
          //FileItem  id = (FileItem) items.get(0);
          //String photoid =  id.getString();
          String photoid =  "0";
          
         // FileItem title = (FileItem) items.get(1);
         // String   phototitle =  title.getString();
             String   phototitle =  "test";
          // get uploaded file
          FileItem file = (FileItem) items.get(0);
                      
          // Connect to Oracle
    

       
          Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
          Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);         
          CallableStatement PERMI = ConnPERMI.prepareCall(" insert into ficheros_justificantes values(?,?,?)");
          PERMI.setString(1,RS__MMColParam1);
          PERMI.setString(2,"");
          PERMI.setBinaryStream(3, file.getInputStream(), (int) file.getSize());
          Object PERMI_data;
          PERMI.execute();
          
          
          
          
          out.println("Añadido correctamente.");
       
      }
      catch(Exception ex) {
          out.println( "Error --> " + ex.getMessage());
      }
   }else{
	      out.println("<html>");
	      out.println("<body>");
	      out.println("<p>No file uploaded</p>"); 
	      out.println("</body>");
	      out.println("</html>");
	   }
  
%>
<input type=button name=boton value="Cerrar Ventana" onclick="window.close()">

 </tr>
   </table>
</body>
</html>