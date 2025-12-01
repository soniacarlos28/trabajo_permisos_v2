<%@page language="java" import="java.util.Date,java.sql.*" errorPage=""%>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
String RS1__MMColParam1 = "000000";
if (session.getAttribute("MM_ID_USUARIO")   !=null) {RS1__MMColParam1 = (String)session.getAttribute("MM_ID_USUARIO")  ;}
%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call CREA_FICHERO_BAJA(?,?,?)}");
PERMI.registerOutParameter(1,Types.LONGVARCHAR);
PERMI.registerOutParameter(2,Types.LONGVARCHAR);
PERMI.setString(3,RS1__MMColParam1);
Object PERMI_data;
PERMI.execute();
%>

<html>
<head>
<title>Mis Gestiones - Resultado de la Solicitud</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
      <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
      
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp">Proceso Bolsa</a></li>    
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>  
    <li><a href="../../gestion/Bajas/index.jsp" id="current" >Bajas Fichero</a></li>
     <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
    </ul>
   <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
     <div>
	  <ul id="subtabh">		
		<li><a href="index.jsp" >Bajas A�o</a></li>
		<li><a href="index_fichero_bajas.jsp" id="current">Historico Ficheros de Bajas</a></li>					
	  </ul>
	</div>   
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bordercolor="#FFFFFF">
  <tr>
    <td colspan="3" class="destacado" align="center">Creaci�n Fichero</td>
  </tr>
  
<div class="contenido" id="VACION">&nbsp;</div>
 <% String v_id_todook  = (String)  (((PERMI_data = PERMI.getObject(1))==null || PERMI.wasNull())?"":PERMI_data);%>    
 <% if ( v_id_todook.equals("0") ){ %>
<table width="100%">
  <tr>
    <td colspan="2" class="subdestacado">Resultado de la operaci&oacute;n:</td>
  </tr>
  <tr>
    <th width="5%" valign="middle" scope="row"><img src="../../imagen/ok.jpg" alt="Bien" width="25" height="25"></th>
    <td valign="middle"><div align="left"><%= (((PERMI_data = PERMI.getObject(2))==null || PERMI.wasNull())?"":PERMI_data)%></div></td>
  </tr>
</table>
<div class="contenido" style="clear:both"><a href="index_fichero_bajas.jsp" class="volver" title="VOLVER">VOLVER</a></div>
<%  } else { %>
<table width="100%">
  <tr>
    <td colspan="2" class="subdestacado">Resultado de la operaci&oacute;n:</td>
  </tr>
  <tr>
    <th width="5%" valign="middle" scope="row"><img src="../../imagen/mal_rojo_2.jpg" alt="Mal" width="25" height="25"></th>
    <td><div align="left"><%= (((PERMI_data = PERMI.getObject(2))==null || PERMI.wasNull())?"":PERMI_data)%></div></td>
  </tr>
</table>
<div class="contenido" style="clear:both"><a href="index_fichero_bajas.jsp" class="volver" title="VOLVER">VOLVER</a></div>
<% } %>
</div> 
</body>
</html>

<%
ConnPERMI.close();
%>

