<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@ include file="../../../Connections/RRHH.jsp"  %>
<%

String PSBORRAR__MMColParam1 = null;
if(request.getParameter("ID_TIPO_AUSENCIA") != null){ PSBORRAR__MMColParam1 = (String)request.getParameter("ID_TIPO_AUSENCIA");}

%>
<%
Driver DriverPSBORRAR = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPSBORRAR = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement PSBORRAR = ConnPSBORRAR.prepareStatement("UPDATE TR_TIPO_AUSENCIA set TR_ANULADO='SI' where id_tipo_ausencia>500 and id_tipo_ausencia  = '"+ PSBORRAR__MMColParam1 + "' ");
PSBORRAR.executeUpdate();
%>
<html>
<head>
<title>Eliminando...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="refresh" content="0;URL=index.jsp">
</head>
<body>
<p>Eliminando...</p>
</body>
</html>
<%
ConnPSBORRAR.close();
%>
