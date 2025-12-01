<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@page import = "java.sql.*,java.io. *, java.util. *, javax.servlet. *" %>
<%@ include file="../../../Connections/RRHH.jsp" %>

<%
String RS__MMColParam1 = "1";
if (request.getParameter("ID_ENLACE")    !=null) {RS__MMColParam1 = (String)request.getParameter("ID_ENLACE");}
%>

<%
Driver DriverPSBORRAR = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPSBORRAR = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement PSBORRAR = ConnPSBORRAR.prepareStatement("DELETE FROM FICHEROS_JUSTIFICANTES WHERE rownum<2 and ID = '"+ RS__MMColParam1 + "' ");
PSBORRAR.executeUpdate();
%>
<html>
<head>
<title>Eliminando justificante...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="refresh" content="0;URL=../index.jsp">
</head>
<body>
<p>Justificante Eliminado</p>
<input type=button name=boton value="Cerrar Ventana" onclick="window.close()">
</body>
</html>
<%
ConnPSBORRAR.close();
%>	 