<%@page language="java" import="java.util.Date,java.sql.*" errorPage="error.jsp"%>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%> 
<%


String PERMI__V_ID_INCIDENCIA = "0";
if(request.getParameter("ID_INCIDENCIA") != null){ PERMI__V_ID_INCIDENCIA = (String)request.getParameter("ID_INCIDENCIA");}

String PERMI__V_ID_TODOS = "0";
if(request.getParameter("ID_TODOS") != null){ PERMI__V_ID_TODOS = (String)request.getParameter("ID_TODOS");}



%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call FINGER_REGENERA_INCIDENCIAS(?,?)}");

PERMI.setString(1,PERMI__V_ID_INCIDENCIA);
PERMI.setString(2,PERMI__V_ID_TODOS);

Object PERMI_data;
PERMI.execute();
%>

<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Añadiendo...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<meta http-equiv="refresh" content="0;URL=index.jsp">
</head>
<body>
<p>Añadiendo...</p>
</body>
</html>

<%
ConnPERMI.close();
%>
