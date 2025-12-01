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
if(request.getParameter("ID_FUNCIONARIO") != null){ PERMI__V_ID_FUNCIONARIO = (String)request.getParameter("ID_FUNCIONARIO");}

String PERMI__V_ID_FUNCIONARIO_NOMBRE = "0";
if(request.getParameter("ID_FUNCIONARIO_NOMBRE") != null){ PERMI__V_ID_FUNCIONARIO_NOMBRE = (String)request.getParameter("ID_FUNCIONARIO_NOMBRE");}

String PERMI__V_ID_TIPO_AUSENCIA = "0";
if(request.getParameter("V_ID_AUSENCIA") != null){ PERMI__V_ID_TIPO_AUSENCIA = (String)request.getParameter("V_ID_AUSENCIA");}

String PERMI__V_ID_SINDICATO = "0";
if(request.getParameter("ID_SINDICATO") != null){ PERMI__V_ID_SINDICATO = (String)request.getParameter("ID_SINDICATO");}

String PERMI__TODO_T = "0";
if(request.getParameter("TODO_T") != null){ PERMI__TODO_T  = (String)request.getParameter("TODO_T");}

String PERMI__AÑO = "2018";
if(request.getParameter("PERIODO") != null){ PERMI__AÑO  = (String)request.getParameter("PERIODO");}

String PERMI__V_ID_USUARIO = "";
if(request.getParameter("ID_USUARIO") != null){ PERMI__V_ID_USUARIO = (String)request.getParameter("ID_USUARIO");}


%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call HORAS_SINDICALES(?,?,?,?,?,?,?,?)}");

PERMI.setString(1,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(2,PERMI__V_ID_FUNCIONARIO_NOMBRE);
PERMI.setString(3,PERMI__V_ID_TIPO_AUSENCIA);
PERMI.setString(4,PERMI__V_ID_SINDICATO);
PERMI.setString(5,PERMI__TODO_T);
PERMI.setString(6,PERMI__AÑO);
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
<meta http-equiv="refresh" content="0;URL=index.jsp">
</head>
<body>
<p>Añadiendo...<%= PERMI__TODO_T %>    </p>
<p>A...<%= PERMI__V_ID_TIPO_AUSENCIA %>    </p>
<p>Ad...<%= PERMI__V_ID_SINDICATO %>    </p>
<p>Añ...<%= PERMI__V_ID_FUNCIONARIO %>    </p>
<p>Añ...<%= PERMI__AÑO %>    </p>
 <p>.<%=(((PERMI_data = PERMI.getObject(7))==null || PERMI.wasNull())?"":PERMI_data) %>    </p>


</body>
</html>

<%
ConnPERMI.close();
%>
