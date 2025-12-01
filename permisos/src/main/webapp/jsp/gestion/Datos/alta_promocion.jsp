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

String PERMI__V_ID_FUNCIONARIO = "0";
if(session.getAttribute("MM_ID_USUARIO") != null){ PERMI__V_ID_FUNCIONARIO = (String) session.getAttribute("MM_ID_USUARIO");}

String PERMI__TODO_T = "0";
if(request.getParameter("TODO_T") != null){ PERMI__TODO_T  = (String)request.getParameter("TODO_T");}

String PERMI__TIPO_TITULA = "";
if(request.getParameter("TIPO_TITULACION") != null){ PERMI__TIPO_TITULA  = (String)request.getParameter("TIPO_TITULACION");}

String PERMI__TITULA = "";
if(request.getParameter("TITULA") != null){ PERMI__TITULA  = (String)request.getParameter("TITULA");}


%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call PROMOCION_FUNCIONARIOS_2018(?,?,?,?)}");

PERMI.setString(1,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(2,PERMI__TODO_T);
PERMI.setString(3,PERMI__TIPO_TITULA);
PERMI.setString(4,PERMI__TITULA);

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
