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
String PERMI__V_ID_CAMBIA_FIRMA = "-1";
if(request.getParameter("P_C_FIRMA_D") != null){ PERMI__V_ID_CAMBIA_FIRMA = (String)request.getParameter("P_C_FIRMA_D");}

String PERMI__V_FIRMA_ANT = "-1";
if(request.getParameter("P_ID_FUNCIONARIO_FIRMA") != null){ PERMI__V_FIRMA_ANT = (String)request.getParameter("P_ID_FUNCIONARIO_FIRMA");}

String PERMI__V_FIRMA_NEW = "-1";
if(request.getParameter("ID_JS") != null){ PERMI__V_FIRMA_NEW = (String)request.getParameter("ID_JS");}

String PERMI__V_ID_FUNCIONARIO = "-1";
if(request.getParameter("P_ID_FUNCIONARIO_C") != null){ PERMI__V_ID_FUNCIONARIO = (String)request.getParameter("P_ID_FUNCIONARIO_C");}

String PERMI__V_UNICO = "-1";
if(request.getParameter("TIPO") != null){ PERMI__V_UNICO = (String)request.getParameter("TIPO");}

String PERMI__V_DELEGA = "-1";
if(request.getParameter("ID_DELEGADO_FIRMA") != null){ PERMI__V_DELEGA = (String)request.getParameter("ID_DELEGADO_FIRMA");}

%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call cambia_firma(?,?,?,?,?,?,?,?)}");
PERMI.setString(1,PERMI__V_ID_CAMBIA_FIRMA);
PERMI.setString(2,PERMI__V_FIRMA_ANT);
PERMI.setString(3,PERMI__V_FIRMA_NEW);
PERMI.setString(4,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(5,PERMI__V_UNICO);
PERMI.setString(6,PERMI__V_DELEGA);
PERMI.registerOutParameter(7,Types.LONGVARCHAR);
PERMI.registerOutParameter(8,Types.LONGVARCHAR);

Object PERMI_data;
PERMI.execute();
%>

<html>
<head>
<title>Gesti&oacute;n de RRHH - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="refresh" content="0;URL=index.jsp">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
  <li><a href="gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
  </ul>
</div>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas" id="current">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
	</div>
	<div id="subform">
	<table width="760" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td valign="middle" scope="row"><img src="../../imagen/ok.jpg" width="25" height="25"></td>
    <td colspan="2" valign="middle"><span class="Estilo9">  
    <%= (((PERMI_data = PERMI.getObject(8))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
    <td>
    <input type="button" value="Volver" name="Volver" onClick="window.location='index.jsp'">
    </td>
    </tr>
</table>
	</div>
	</div>
  