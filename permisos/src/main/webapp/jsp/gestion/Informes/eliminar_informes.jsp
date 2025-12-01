<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@ include file="../../../Connections/RRHH.jsp" %>
<%

String PSBORRAR__MMColParam1 = null;
if(request.getParameter("ID_INFORME") != null){ PSBORRAR__MMColParam1 = (String)request.getParameter("ID_INFORME");}

%>
<%

String PSBORRAR_EJE_MMColParam1 = "0";
if(request.getParameter("ID_EJECUCION") != null){ PSBORRAR_EJE_MMColParam1  = (String)request.getParameter("ID_EJECUCION");}

%>
<%
Driver DriverPSBORRAR = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPSBORRAR = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement PSBORRAR = ConnPSBORRAR.prepareStatement("DELETE FROM FICHAJE_INFORME WHERE ID_SECUENCIA_INFORME = '"+ PSBORRAR__MMColParam1 + "' ");
PSBORRAR.executeUpdate();
%>
<%
Driver DriverPSBORRAR_H = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPSBORRAR_H = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement PSBORRAR_H = ConnPSBORRAR_H.prepareStatement("DELETE FROM FICHAJE_INFORME_CAMPO WHERE ID_SECUENCIA_INFORME = '"+ PSBORRAR__MMColParam1 + "' OR ID_EJECUCION='"+PSBORRAR_EJE_MMColParam1  + "' ");
PSBORRAR_H.executeUpdate();
%>


<html>
<head>
<title>Eliminando Informe...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="refresh" content="0;URL=index_informes.jsp">
</head>
<body>
<p>Eliminando Informe...</p>
</body>
</html>
<%
ConnPSBORRAR.close();
%>

