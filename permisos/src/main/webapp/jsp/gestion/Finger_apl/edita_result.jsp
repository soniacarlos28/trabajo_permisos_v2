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

String PERMI__V_ID_CALENDARIO = "0";
if(request.getParameter("ID_CALENDARIO") != null){ PERMI__V_ID_CALENDARIO = (String)request.getParameter("ID_CALENDARIO");}

String PERMI__V_HORAS_SEMANALES = "0";
if(request.getParameter("HORAS_SEMANALES") != null){ PERMI__V_HORAS_SEMANALES = (String)request.getParameter("HORAS_SEMANALES");}

String PERMI__V_DESC_CALENDARIO = "";
if(request.getParameter("NOMBRE_CALENDARIO") != null){ PERMI__V_DESC_CALENDARIO = (String)request.getParameter("NOMBRE_CALENDARIO");}

String PERMI__V_TURNO = "0";
if(request.getParameter("TURNO") != null){ PERMI__V_TURNO  = (String)request.getParameter("TURNO");}

String PERMI__TODO_T = "0";
if(request.getParameter("TODO_T") != null){ PERMI__TODO_T  = (String)request.getParameter("TODO_T");}

String PERMI__V_ID_USUARIO = "";
if(request.getParameter("ID_USUARIO") != null){ PERMI__V_ID_USUARIO = (String)request.getParameter("ID_USUARIO");}


%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call FICHAJE_GUARDA_CALENDARIO(?,?,?,?,?,?,?,?)}");

PERMI.setString(1,PERMI__V_ID_CALENDARIO);
PERMI.setString(2,PERMI__V_DESC_CALENDARIO);
PERMI.setString(3,PERMI__V_ID_USUARIO);
PERMI.setString(4,PERMI__V_TURNO);
PERMI.setString(5,PERMI__V_HORAS_SEMANALES);
PERMI.setString(6,PERMI__TODO_T);
PERMI.registerOutParameter(7,Types.LONGVARCHAR);
PERMI.registerOutParameter(8,Types.LONGVARCHAR);
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
<meta http-equiv="refresh" content="0;URL=index_calendario.jsp">


</head>
<body>
<p>Guardando....</p>


</body>
</html>




