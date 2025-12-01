<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@ include file="../../../Connections/RRHH.jsp" %>
<%

String PSBORRAR__MMColParam1 = null;
if(request.getParameter("ID_INCIDENCIA") != null){ PSBORRAR__MMColParam1 = (String)request.getParameter("ID_INCIDENCIA");}

%>

<%
Driver DriverPSBORRAR = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPSBORRAR = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement PSBORRAR = ConnPSBORRAR.prepareStatement("UPDATE FICHAJE_INCIDENCIA SET  ID_ESTADO_INC =1 WHERE ID_INCIDENCIA = '"+ PSBORRAR__MMColParam1 + "' ");
PSBORRAR.executeUpdate();
%>



<html>
<head>
<title>Eliminando Incidencia...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="refresh" content="0;URL=index.jsp">
</head>
<body>
<p>Eliminando Incidencia...</p>
</body>
</html>
<%
ConnPSBORRAR.close();
%>

