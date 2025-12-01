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


String PERMI__V_ID_CAMPO = "0";
if(request.getParameter("CAMPO_TODO") != null){ PERMI__V_ID_CAMPO = (String)request.getParameter("CAMPO_TODO");}



String PERMI__V_ID_USUARIO = "0";
if (session.getValue("MM_ID_USUARIO")    !=null) {PERMI__V_ID_USUARIO = (String)session.getValue("MM_ID_USUARIO")   ;}


%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call FINGER_PLANIFICA_INFORME(?,?)}");

PERMI.setString(1,PERMI__V_ID_USUARIO);
PERMI.setString(2,PERMI__V_ID_CAMPO);

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


</head>
<body onLoad="window.opener.location.reload();self.close()">


<p><%= PERMI__V_ID_CAMPO  %></p>
<p><%= PERMI__V_ID_USUARIO %></p>
</body>
</html>

<%
ConnPERMI.close();
%>
