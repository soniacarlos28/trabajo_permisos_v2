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
if(request.getParameter("ID_INFORME") != null){ PERMI__V_ID_CAMPO = (String)request.getParameter("ID_INFORME");}



String PERMI__V_ID_USUARIO = "0";
if (session.getValue("MM_ID_USUARIO")    !=null) {PERMI__V_ID_USUARIO = (String)session.getValue("MM_ID_USUARIO")   ;}


%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call finger_genera_informe(?,?)}");

PERMI.setString(1,PERMI__V_ID_USUARIO);
PERMI.setString(2,PERMI__V_ID_CAMPO);

Object PERMI_data;


%>
<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>EJECUTANDO INFORME.....</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


</head>
<body onLoad="window.opener.close();self.close()">
<table>
<tr>
<td>
<img	src="../../imagen/gear.gif" alt="Eliminar" width="100" height="100" border="0">
</td>
</tr>
</table>



</body>
</html>


<%  PERMI.execute(); %>
<%
ConnPERMI.close();
%>
