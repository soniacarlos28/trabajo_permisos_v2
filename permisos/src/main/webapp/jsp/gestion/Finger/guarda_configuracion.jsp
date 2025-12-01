<%@page language="java" import="java.util.Date,java.sql.*" errorPage="error.jsp"%>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**fd
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>

          
<%
   

String PERMI__V_ID_FUNCIONARIO = "0";
if(session.getAttribute("MM_ID_FUNCIONARIO") != null){ PERMI__V_ID_FUNCIONARIO = (String)session.getAttribute("MM_ID_FUNCIONARIO");}

String PERMI__V_RELOJ_FICHAJE = "0";
if(request.getParameter("RELOJES") != null){ PERMI__V_RELOJ_FICHAJE = (String)request.getParameter("RELOJES");}

String PERMI__V_CAMPO_ALERT = "";
if(request.getParameter("CAMPO_ALERT") != null){ PERMI__V_CAMPO_ALERT = (String)request.getParameter("CAMPO_ALERT");}

String PERMI__V_CAMPO_JORNADA = "0";
if(request.getParameter("CAMPO_JORNADA") != null){ PERMI__V_CAMPO_JORNADA = (String)request.getParameter("CAMPO_JORNADA");}

String PERMI__V_CAMPO_PTO_FICHAJE = "0";
if(request.getParameter("CAMPO_PTO_FICHAJE") != null){ PERMI__V_CAMPO_PTO_FICHAJE = (String)request.getParameter("CAMPO_PTO_FICHAJE");}

String PERMI__V_CAMPO_CALENDARIO = "0";
if(request.getParameter("CAMPO_CALENDARIO") != null){ PERMI__V_CAMPO_CALENDARIO = (String)request.getParameter("CAMPO_CALENDARIO");}

String PERMI__V_AUDIT_USUARIO = "";
if(request.getParameter("V_AUDIT_USUARIO") != null){ PERMI__V_AUDIT_USUARIO = (String)request.getParameter("V_AUDIT_USUARIO");}


%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call FICHAJE_GUARDA_CONFIGURACION(?,?,?,?,?,?,?,?,?)}");
PERMI.setString(1,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(2,PERMI__V_RELOJ_FICHAJE);
PERMI.setString(3,PERMI__V_CAMPO_ALERT);
PERMI.setString(4,PERMI__V_CAMPO_JORNADA);
PERMI.setString(5,PERMI__V_CAMPO_PTO_FICHAJE);
PERMI.setString(6,PERMI__V_CAMPO_CALENDARIO);
PERMI.setString(7,PERMI__V_AUDIT_USUARIO);
PERMI.registerOutParameter(8,Types.LONGVARCHAR);
PERMI.registerOutParameter(9,Types.LONGVARCHAR);

Object PERMI_data;
PERMI.execute();
%>
<%
String RSTIPO_PERMISO__MMColParam1 = "0";
if (request.getParameter("ID_ANO") !=null) {RSTIPO_PERMISO__MMColParam1 = (String)request.getParameter("ID_ANO");}
%>
<%
String RSTIPO_PERMISO__MMColParam2 = "0";
if (request.getParameter("ID_TIPO_PERMISO") !=null) {RSTIPO_PERMISO__MMColParam2 = (String)request.getParameter("ID_TIPO_PERMISO");}
%>
<%
String RSTIPO_PERMISO__MMColParam3 = "0";
if (request.getParameter("NUM_DIAS")  !=null) {RSTIPO_PERMISO__MMColParam3 = (String)request.getParameter("NUM_DIAS") ;}
%>
<%
Driver DriverRSTIPO_PERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPO_PERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPO_PERMISO = ConnRSTIPO_PERMISO.prepareStatement("SELECT DESC_TIPO_PERMISO  FROM tr_tipo_permiso  WHERE ID_ANO=" + RSTIPO_PERMISO__MMColParam1 + " and ID_TIPO_PERMISO=" + RSTIPO_PERMISO__MMColParam2 + " and (  1=1 OR '" + RSTIPO_PERMISO__MMColParam3 + "'='1')");
ResultSet RSTIPO_PERMISO = StatementRSTIPO_PERMISO.executeQuery();
boolean RSTIPO_PERMISO_isEmpty = !RSTIPO_PERMISO.next();
boolean RSTIPO_PERMISO_hasData = !RSTIPO_PERMISO_isEmpty;
Object RSTIPO_PERMISO_data;
int RSTIPO_PERMISO_numRows = 0;
%>
<%
String RSTIPODIAS__MMColParam1 = "N";
if (request.getParameter("TIPO_DIAS") !=null) {RSTIPODIAS__MMColParam1 = (String)request.getParameter("TIPO_DIAS");}
%>
<%
Driver DriverRSTIPODIAS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPODIAS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPODIAS = ConnRSTIPODIAS.prepareStatement("SELECT DESC_TIPO_DIAS  FROM tr_tipo_dias  WHERE id_tipo_dias='" + RSTIPODIAS__MMColParam1 + "'");
ResultSet RSTIPODIAS = StatementRSTIPODIAS.executeQuery();
boolean RSTIPODIAS_isEmpty = !RSTIPODIAS.next();
boolean RSTIPODIAS_hasData = !RSTIPODIAS_isEmpty;
Object RSTIPODIAS_data;
int RSTIPODIAS_numRows = 0;
%>
<%
String RSGRADO__MMColParam1 = "0";
if (request.getParameter("ID_GRADO") !=null) {RSGRADO__MMColParam1 = (String)request.getParameter("ID_GRADO");}
%>
<%
Driver DriverRSGRADO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSGRADO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSGRADO = ConnRSGRADO.prepareStatement("SELECT desc_grado  FROM tr_grado  WHERE id_grado='" + RSGRADO__MMColParam1 + "'");
ResultSet RSGRADO = StatementRSGRADO.executeQuery();
boolean RSGRADO_isEmpty = !RSGRADO.next();
boolean RSGRADO_hasData = !RSGRADO_isEmpty;
Object RSGRADO_data;
int RSGRADO_numRows = 0;
%>
<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body><%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
      <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>  
       <li><a href="../../gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
       <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
        <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
 </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger" id="current">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
	</div>
<table width="760" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td valign="middle" scope="row"><img src="../../imagen/ok.jpg" width="25" height="25"></td>
    <td colspan="2" valign="middle"><span class="Estilo9">
    <%= PERMI__V_ID_FUNCIONARIO %> <br>
    <%=  PERMI__V_RELOJ_FICHAJE %> <br>
  <%= PERMI__V_CAMPO_ALERT %><br>
  <%=  PERMI__V_CAMPO_JORNADA %><br>
  <%= PERMI__V_CAMPO_PTO_FICHAJE %><br>
  <%=  PERMI__V_CAMPO_CALENDARIO %><br>
  <%= PERMI__V_AUDIT_USUARIO %><br>
    
    <%= (((PERMI_data = PERMI.getObject(8))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
    <td>
    <input type="button" value="Volver" name="Volver" onClick="window.location='index_configuracion.jsp'">
    </td>
    </tr>
</table>

</body>
</html>
<%
RSTIPO_PERMISO.close();
StatementRSTIPO_PERMISO.close();
ConnRSTIPO_PERMISO.close();
%>
<%
RSTIPODIAS.close();
StatementRSTIPODIAS.close();
ConnRSTIPODIAS.close();
%>
<%
RSGRADO.close();
StatementRSGRADO.close();
ConnRSGRADO.close();
%>
<%
ConnPERMI.close();
%>

