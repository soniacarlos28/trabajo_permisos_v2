<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@ include file="../../../Connections/RRHH.jsp" %>
<%

String PSBORRAR__MMColParam1 = null;
if(request.getParameter("ID_PERMISO") != null){ PSBORRAR__MMColParam1 = (String)request.getParameter("ID_PERMISO");}

%>
<%

String PS_MMColParam2 = "index.jsp";
if(request.getParameter("ID_TIPO") != null){ PS_MMColParam2 = "index_ausencias.jsp";}

%>
<%
Driver DriverPSBORRAR = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPSBORRAR = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement PSBORRAR = ConnPSBORRAR.prepareStatement("update PERMISOS_AVISOS_SINJUSTI set valido=0 where id_PERMISO = '"+ PSBORRAR__MMColParam1 + "' ");
PSBORRAR.executeUpdate();
%>


<html>
<head>
<title>Eliminando ...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="refresh" content="0;URL=<%= PS_MMColParam2 %>">
</head>
<body>
<p>Eliminando </p>
</body>
</html>
<%
ConnPSBORRAR.close();
%>

