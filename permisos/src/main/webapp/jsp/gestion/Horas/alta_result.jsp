<%@page language="java" import="java.util.Date,java.sql.*" %>
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
if(request.getParameter("ID_FUNCIONARIO") != null){ PERMI__V_ID_FUNCIONARIO = (String)request.getParameter("ID_FUNCIONARIO");}

String PERMI__V_ID_ANO = "0";
if(request.getParameter("ID_ANO") != null){ PERMI__V_ID_ANO = (String)request.getParameter("ID_ANO");}

String PERMI__V_ID_TIPO_OPERACION= "0"; /* ALTA*/
if(request.getParameter("ID_TIPO_OPERACION") != null){ PERMI__V_ID_TIPO_OPERACION = (String)request.getParameter("ID_TIPO_OPERACION");}

String PERMI__V_ID_TIPO_HORAS = "0";
if(request.getParameter("ID_TIPO_HORAS") != null){ PERMI__V_ID_TIPO_HORAS = (String)request.getParameter("ID_TIPO_HORAS");}

String PERMI__V_ID_TRP_NOMINA = "0";
if(request.getParameter("TRP_NOMINA") != null){ PERMI__V_ID_TRP_NOMINA = (String)request.getParameter("TRP_NOMINA");}

String PERMI__V_FECHA_HORAS = "";
if(request.getParameter("FECHA_HORAS") != null){ PERMI__V_FECHA_HORAS = (String)request.getParameter("FECHA_HORAS");}

String PERMI__V_HORA_INICIO  = "";
if(request.getParameter("HORA_INICIO") != null){ PERMI__V_HORA_INICIO = (String)request.getParameter("HORA_INICIO");}

String PERMI__V_HORA_FIN  = "";
if(request.getParameter("HORA_FIN") != null){ PERMI__V_HORA_FIN  = (String)request.getParameter("HORA_FIN");}

String PERMI__V_PHE  = "0";
if(request.getParameter("PHE") != null){ PERMI__V_PHE = (String)request.getParameter("PHE");}

String PERMI__V_DESCRIPCION  = "";
if(request.getParameter("DESCRIPCION") != null){ PERMI__V_DESCRIPCION   = (String)request.getParameter("DESCRIPCION");}

String PERMI__V_ANULADO  = "NO";
if(request.getParameter("ANULADO") != null){ PERMI__V_ANULADO   = (String)request.getParameter("ANULADO");}

String PERMI__V_ID_USUARIO = "";
if(request.getParameter("ID_USUARIO") != null){ PERMI__V_ID_USUARIO = (String)request.getParameter("ID_USUARIO");}


%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call FICHAJE_INSERTA_HEXTRAS(?,?,?,?,?,?,?,?,?,?,?,?)}");

PERMI.setString(1,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(2,PERMI__V_ID_ANO);
PERMI.setString(3,PERMI__V_ID_TIPO_OPERACION);
PERMI.setString(4,PERMI__V_ID_TIPO_HORAS);
PERMI.setString(5,PERMI__V_ID_TRP_NOMINA);
PERMI.setString(6,PERMI__V_FECHA_HORAS);
PERMI.setString(7,PERMI__V_HORA_INICIO);
PERMI.setString(8,PERMI__V_HORA_FIN);
PERMI.setString(9,PERMI__V_PHE);
PERMI.setString(10,PERMI__V_DESCRIPCION);
PERMI.setString(11,PERMI__V_ANULADO);
PERMI.setString(12,PERMI__V_ID_USUARIO);
Object PERMI_data;
PERMI.execute();
%>

<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Actualizando....</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<meta http-equiv="refresh" content="0;URL=index.jsp">
</head>
<body>
<p>Añadiendo...</p>
<%= PERMI__V_ID_FUNCIONARIO %>
<%= PERMI__V_ID_ANO %>
<%= PERMI__V_ID_TIPO_OPERACION%>
<%= PERMI__V_ID_TIPO_HORAS%>
<%= PERMI__V_ID_TRP_NOMINA%>
<%= PERMI__V_FECHA_HORAS%>
<%= PERMI__V_HORA_INICIO%>
<%= PERMI__V_HORA_FIN%>
<%= PERMI__V_PHE%>
<%= PERMI__V_DESCRIPCION%>
<%= PERMI__V_ANULADO%>
<%=  PERMI__V_ID_USUARIO %>
</body>
</html>

<%
ConnPERMI.close();
%>
