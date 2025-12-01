<%@page language="java" import="java.util.Date,java.sql.*" %>
<%@ include file="../../../Connections/OMESA.jsp" %>
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

String PERMI__I_FECHA_P = "01/01/2000";
if(request.getParameter("ID_DIA") != null){ PERMI__I_FECHA_P = (String)request.getParameter("ID_DIA");}

String PERMI__I_CADENA_FICHAJE = "000000";
if (request.getParameter("campo_final")  !=null) {PERMI__I_CADENA_FICHAJE = (String)request.getParameter("campo_final") ;}

%>

<%
Driver DriverPERMI = (Driver)Class.forName(MM_OMESA_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_OMESA_STRING,MM_OMESA_USERNAME,MM_OMESA_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call REGENERA_FICHAJES_RRHH(?,?,?)}");
PERMI.setString(1,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(2,PERMI__I_FECHA_P);
PERMI.setString(3,PERMI__I_CADENA_FICHAJE);
Object PERMI_data;
PERMI.execute();

%>

<%
String RSCONSULTA__MMColParam13 = "000000";
if (request.getParameter("campo_final")  !=null) {RSCONSULTA__MMColParam13 = (String)request.getParameter("campo_final") ;}%>


<%
String valor_acumulado;
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger"  id="current">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
 </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
<div>
	 <ul id="subtabh">
		<li id="active"><a href="../Finger" id="current">Fichajes</a></li>
		<li><a href="../Permisos" >Configuracion</a></li>
		<li><a href="../Permisos" >Calendario</a></li>
		<li><a href="../Ausencias">Alertas</a></li>				
	  </ul>
  </div> 
	<div id="subform">
	<table width="20%" border="3" cellspacing="3" cellpadding="1">
      <tr>
        <td>Regenerando fichajes. <%= RSCONSULTA__MMColParam13 %> XXX <%=PERMI__I_FECHA_P %> XX <%= PERMI__V_ID_FUNCIONARIO%></td>
      </tr>
    </table>
  </div>
</div>
</body>
</html>
<%
ConnPERMI.close();
%>
