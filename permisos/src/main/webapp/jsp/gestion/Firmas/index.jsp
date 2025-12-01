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

String I_ID_FUNCIONARIO = "101216";
if(session.getValue("MM_ID_FUNCIONARIO") != null){ I_ID_FUNCIONARIO = (String)session.getValue("MM_ID_FUNCIONARIO");}

%>
<%
String RSQUERYJS__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")   !=null) {RSQUERYJS__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")  ;}
%>
<%
Driver DriverRSQUERYJS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERYJS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERYJS = ConnRSQUERYJS.prepareStatement("SELECT f.id_funcionario,lpad(id_js,6,' ') as id_js  ,lpad(pe.nombre || ' ' || pe.ape1|| ' ' || pe.ape2,60,' ') as nombre  FROM personal_new pe, funcionario_firma f  WHERE f.id_funcionario='" + RSQUERYJS__MMColParam1 + "' and         pe.id_funcionario=id_js");
ResultSet RSQUERYJS = StatementRSQUERYJS.executeQuery();
boolean RSQUERYJS_isEmpty = !RSQUERYJS.next();
boolean RSQUERYJS_hasData = !RSQUERYJS_isEmpty;
Object RSQUERYJS_data;
int RSQUERYJS_numRows = 0;
%>
<%
String RSQUERYJA__MMColParam1 = "00000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSQUERYJA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
Driver DriverRSQUERYJA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERYJA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERYJA = ConnRSQUERYJA.prepareStatement("SELECT f.id_funcionario,lpad(id_ja,6,' ') as id_ja  ,lpad(pe.nombre || ' ' || pe.ape1 || ' ' || pe.ape2 ,60,' ' ) as nombre  FROM personal_new pe, funcionario_firma f  WHERE f.id_funcionario='" + RSQUERYJA__MMColParam1 + "' and         pe.id_funcionario=id_ja");
ResultSet RSQUERYJA = StatementRSQUERYJA.executeQuery();
boolean RSQUERYJA_isEmpty = !RSQUERYJA.next();
boolean RSQUERYJA_hasData = !RSQUERYJA_isEmpty;
Object RSQUERYJA_data;
int RSQUERYJA_numRows = 0;
%>
<%
String RSQUERYVER_PLA1__MMColParam1 = "00000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSQUERYVER_PLA1__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
Driver DriverRSQUERYVER_PLA1 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERYVER_PLA1 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERYVER_PLA1 = ConnRSQUERYVER_PLA1.prepareStatement("SELECT f.id_funcionario,lpad(id_ver_plani_1,6,' ') as id_ver_plani  ,lpad(pe.nombre || ' ' || pe.ape1 || ' ' || pe.ape2 ,60,' ') as nombre  FROM personal_new pe, funcionario_firma f  WHERE f.id_funcionario='" + RSQUERYVER_PLA1__MMColParam1 + "' and         pe.id_funcionario=id_ver_plani_1");
ResultSet RSQUERYVER_PLA1 = StatementRSQUERYVER_PLA1.executeQuery();
boolean RSQUERYVER_PLA1_isEmpty = !RSQUERYVER_PLA1.next();
boolean RSQUERYVER_PLA1_hasData = !RSQUERYVER_PLA1_isEmpty;
Object RSQUERYVER_PLA1_data;
int RSQUERYVER_PLA1_numRows = 0;
%>

<%
String RSQUERYVER_PLA2__MMColParam2 = "00000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSQUERYVER_PLA2__MMColParam2 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
Driver DriverRSQUERYVER_PLA2 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERYVER_PLA2 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERYVER_PLA2 = ConnRSQUERYVER_PLA2.prepareStatement("SELECT f.id_funcionario,lpad(id_ver_plani_2,6,' ') as id_ver_plani  ,lpad(pe.nombre || ' ' || pe.ape1|| ' ' || pe.ape2,60,' ') as nombre  FROM personal_new pe, funcionario_firma f  WHERE f.id_funcionario='" + RSQUERYVER_PLA2__MMColParam2 + "' and         pe.id_funcionario=id_ver_plani_2");
ResultSet RSQUERYVER_PLA2 = StatementRSQUERYVER_PLA2.executeQuery();
boolean RSQUERYVER_PLA2_isEmpty = !RSQUERYVER_PLA2.next();
boolean RSQUERYVER_PLA2_hasData = !RSQUERYVER_PLA2_isEmpty;
Object RSQUERYVER_PLA2_data;
int RSQUERYVER_PLA2_numRows = 0;
%>

<%
String RSQUERYVER_PLA3__MMColParam3 = "00000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSQUERYVER_PLA3__MMColParam3 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
Driver DriverRSQUERYVER_PLA3 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERYVER_PLA3 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERYVER_PLA3 = ConnRSQUERYVER_PLA3.prepareStatement("SELECT f.id_funcionario,lpad(id_ver_plani_3,6,' ') as id_ver_plani  ,lpad(pe.nombre || ' ' || pe.ape1|| ' ' || pe.ape2,60,' ') as nombre  FROM personal_new pe, funcionario_firma f  WHERE f.id_funcionario='" + RSQUERYVER_PLA3__MMColParam3 + "' and         pe.id_funcionario=id_ver_plani_3");
ResultSet RSQUERYVER_PLA3 = StatementRSQUERYVER_PLA3.executeQuery();
boolean RSQUERYVER_PLA3_isEmpty = !RSQUERYVER_PLA3.next();
boolean RSQUERYVER_PLA3_hasData = !RSQUERYVER_PLA3_isEmpty;
Object RSQUERYVER_PLA3_data;
int RSQUERYVER_PLA3_numRows = 0;
%>

<%
String RSDELEGADOJS__MMColParam1 = "00000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSDELEGADOJS__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
Driver DriverRSDELEGADOJS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSDELEGADOJS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSDELEGADOJS = ConnRSDELEGADOJS.prepareStatement("SELECT f.id_funcionario,lpad(id_delegado_js,6,' ') as id_delegado_js  ,lpad(pe.nombre || ' ' || pe.ape1|| ' ' || pe.ape2,60,' ') as nombre,DECODE(ID_DELEGADO_FIRMA,1,'SI','NO') as ID_DELEGADO_FIRMA   FROM personal_new pe, funcionario_firma f  WHERE f.id_funcionario='" + RSDELEGADOJS__MMColParam1 + "' and         pe.id_funcionario=id_delegado_js");
ResultSet RSDELEGADOJS = StatementRSDELEGADOJS.executeQuery();
boolean RSDELEGADOJS_isEmpty = !RSDELEGADOJS.next();
boolean RSDELEGADOJS_hasData = !RSDELEGADOJS_isEmpty;
Object RSDELEGADOJS_data;
int RSDELEGADOJS_numRows = 0;
%>
<%
String RSFUNCIONARIO__MMColParam1 = "00000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSFUNCIONARIO__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
Driver DriverRSFUNCIONARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFUNCIONARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFUNCIONARIO = ConnRSFUNCIONARIO.prepareStatement("SELECT f.id_funcionario as id_funcionario  FROM funcionario_firma f  WHERE f.id_funcionario='" + RSFUNCIONARIO__MMColParam1 + "'");
ResultSet RSFUNCIONARIO = StatementRSFUNCIONARIO.executeQuery();
boolean RSFUNCIONARIO_isEmpty = !RSFUNCIONARIO.next();
boolean RSFUNCIONARIO_hasData = !RSFUNCIONARIO_isEmpty;
Object RSFUNCIONARIO_data;
int RSFUNCIONARIO_numRows = 0;
%>
<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de RRHH - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
  <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
   <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
   <li><a href="../Bolsa_concilia" >Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" >Incidencias  Fichajes</a></li>
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

  </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
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
	<table width="95%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#E0E0E0"><table width="100%" border="0" cellspacing="5" cellpadding="0">
                              <form name="formPermiso" method="post" action="alta_result.jsp">
                                <tr>
                                  <td bgcolor="#E0E0E0" valign="top">
                                    <table border="0" cellspacing="0" cellpadding="2">
                                      <tr>
                                        <td>&nbsp;                                        </td>
                                        <td>Funcionario:</td>
                                        <td>&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                      </tr>
                                  </table></td>
                                  <td bgcolor="#E0E0E0" valign="top" align="right"><b>                                    <%= "<input type='hidden' name='ID_FUNCIONARIO' value='" + session.getValue("MM_ID_FUNCIONARIO") + "'>" %>                                    <%= "<input type='hidden' name='ID_USUARIO' value='" + session.getValue("MM_ID_USUARIO") + "'>" %>
 Edita Firmas       </b></td>
                                </tr>
                                <tr>
                                  <td bgcolor="#E0E0E0" valign="top" colspan="2">                                    </td>
                                </tr>
                              </form>
                            </table></td>
                          </tr>
<tr><td><table width="100%"  border="1" cellspacing="2" cellpadding="4">
  <tr>
    <td colspan="3" bgcolor="#CCCCFF" scope="col"><div align="center">Personas que tienen que <strong>AUTORIZAR y VER</strong> los permisos y ausencias de este funcionario. </div></td>
    </tr>
  <tr>
    <th nowrap scope="row"><div align="right">Jefe de Servicio:</div></th>
    <td bgcolor="#FFFFFF"><% if (!RSQUERYJS_isEmpty ) { %>
        (<%=(((RSQUERYJS_data = RSQUERYJS.getObject("ID_JS"))==null || RSQUERYJS.wasNull())?"":RSQUERYJS_data)%>)&nbsp;<%=(((RSQUERYJS_data = RSQUERYJS.getObject("NOMBRE"))==null || RSQUERYJS.wasNull())?"":RSQUERYJS_data)%>
  <% } /* end !RSQUERYJS_isEmpty */ %></td>
    <td><div align="center">
      <% if ((!RSFUNCIONARIO_isEmpty ) && (!RSQUERYJS_isEmpty )) { %>
        <input type="button" name="Cambia2" value="Cambiar Firma" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=8&C_FIRMA=1&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>&ID_FUNCIONARIO_FIRMA=<%=(((RSQUERYJS_data = RSQUERYJS.getObject("ID_JS"))==null || RSQUERYJS.wasNull())?"":RSQUERYJS_data)%>'">  
        <% } else { %>
       <input type="button" name="INSERTA" value="Inserta Firma" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=1&C_FIRMA=1&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>'">
	       <% }  /* end !RSFUNCIONARIO_isEmpty */ %>
    </div></td>
  </tr>
  <tr>
    <th nowrap scope="row"><div align="right">Suplente Jefe de Servicio:</div></th>
    <td bgcolor="#FFFFFF"><% if (!RSDELEGADOJS_isEmpty ) { %>
        (<%=(((RSDELEGADOJS_data = RSDELEGADOJS.getObject("ID_DELEGADO_JS"))==null || RSDELEGADOJS.wasNull())?"":RSDELEGADOJS_data)%>) <%=(((RSDELEGADOJS_data = RSDELEGADOJS.getObject("NOMBRE"))==null || RSDELEGADOJS.wasNull())?"":RSDELEGADOJS_data)%>              
  . Delegaci�n: <%=(((RSDELEGADOJS_data = RSDELEGADOJS.getObject("ID_DELEGADO_FIRMA"))==null || RSDELEGADOJS.wasNull())?"":RSDELEGADOJS_data)%>
  <% } /* end !RSDELEGADOJS_isEmpty */ %> 
  </td>
    <td><div align="center">
      <% if ((!RSFUNCIONARIO_isEmpty )&& (!RSDELEGADOJS_isEmpty )) { %>
        <input type="button" name="Cambia2" value="Cambiar Firma" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=8&C_FIRMA=2&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>&ID_FUNCIONARIO_FIRMA=<%=(((RSDELEGADOJS_data = RSDELEGADOJS.getObject("ID_DELEGADO_JS"))==null || RSDELEGADOJS.wasNull())?"":RSDELEGADOJS_data)%>'">
        <% } else { %>
      <input type="button" name="INSERTA" value="Inserta Firma" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=1&C_FIRMA=2&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>'">
	       <% }  /* end !RSFUNCIONARIO_isEmpty */ %>
    </div></td>
  </tr>
  
  
  
  <tr>
    <th width="15%" scope="row"><div align="right">Jefe de Area:</div></th>
    <td bgcolor="#FFFFFF"><% if (!RSQUERYJA_isEmpty ) { %>
        (<%=(((RSQUERYJA_data = RSQUERYJA.getObject("ID_JA"))==null || RSQUERYJA.wasNull())?"":RSQUERYJA_data)%>)&nbsp;<%=(((RSQUERYJA_data = RSQUERYJA.getObject("NOMBRE"))==null || RSQUERYJA.wasNull())?"":RSQUERYJA_data)%>
  <% } /* end !RSQUERYJA_isEmpty */ %></td>
    <td><div align="center">
      <% if ((!RSFUNCIONARIO_isEmpty ) && (!RSQUERYJA_isEmpty )) { %>
        <input type="button" name="Cambia2" value="Cambiar Firma" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=8&C_FIRMA=3&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>&ID_FUNCIONARIO_FIRMA=<%=(((RSQUERYJA_data = RSQUERYJA.getObject("ID_JA"))==null || RSQUERYJA.wasNull())?"":RSQUERYJA_data)%>'">
        <% } else { %>
      <input type="button" name="INSERTA" value="Inserta Firma" onClick="window.location='inserta_firma.jsp?P_C_OPERA=1&C_FIRMA=3&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>'">
	       <% }  /* end !RSFUNCIONARIO_isEmpty */ %>
    </div></td>
    <tr>
    <td colspan="3" bgcolor="#CCCCFF" scope="col"><div align="center">Los Suplentes con Delegaci�n pueden autorizar permisos, aunque el Jefe no este de vacaciones o baja.</div></td>
    </tr>
  
</table>
</td></tr>
<tr>
  <td><table width="100%"  border="1" cellspacing="2" cellpadding="4">
  <tr>
    <td colspan="3" bgcolor="#FFCCCC" scope="col"><div align="center">Personas que tienen  permiso <strong>SOLO PARA VER</strong> los permisos y ausencias de este funcionario.  <strong>EN EL PLANIFICADOR</strong></div></td>
    </tr>
  <tr>
    <th nowrap scope="row"><div align="right">Persona 1 :</div></th>
    <td bgcolor="#FFFFFF"><% if (!RSQUERYVER_PLA1_isEmpty ) { %>
        (<%=(((RSQUERYVER_PLA1_data = RSQUERYVER_PLA1.getObject("ID_VER_PLANI"))==null || RSQUERYVER_PLA1.wasNull())?"":RSQUERYVER_PLA1_data)%>)&nbsp;<%=(((RSQUERYVER_PLA1_data = RSQUERYVER_PLA1.getObject("NOMBRE"))==null || RSQUERYVER_PLA1.wasNull())?"":RSQUERYVER_PLA1_data)%>

  <% } /* end !RSQUERYJS_isEmpty */ %></td>
    <td><div align="center">
    
    
     <% if (!RSQUERYVER_PLA1_isEmpty ) { %>
      
        <input type="button" name="Cambia2" value="Cambiar Funcionario" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=8&C_FIRMA=4&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>&ID_FUNCIONARIO_FIRMA=<%=(((RSQUERYVER_PLA1_data = RSQUERYVER_PLA1.getObject("ID_VER_PLANI"))==null || RSQUERYVER_PLA1.wasNull())?"":RSQUERYVER_PLA1_data)%>'">
     <% } else { %>
      <input type="button" name="INSERTA" value="Inserta Firma" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=1&C_FIRMA=4&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>'">
	    <% } %> 
    </div></td>
  </tr>
  <tr>
    <th nowrap scope="row"><div align="right">Persona 2 :</div></th>
    <td bgcolor="#FFFFFF"><% if (!RSQUERYVER_PLA2_isEmpty ) { %>
        (<%=(((RSQUERYVER_PLA2_data = RSQUERYVER_PLA2.getObject("ID_VER_PLANI"))==null || RSQUERYVER_PLA2.wasNull())?"":RSQUERYVER_PLA2_data)%>)&nbsp;<%=(((RSQUERYVER_PLA2_data = RSQUERYVER_PLA2.getObject("NOMBRE"))==null || RSQUERYVER_PLA2.wasNull())?"":RSQUERYVER_PLA2_data)%>

  <% } /* end !RSQUERYJS_isEmpty */ %>

            </td>
    <td><div align="center">
      <% if (!RSQUERYVER_PLA2_isEmpty ) { %>
      <input type="button" name="Cambia22" value="Cambiar Funcionario" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=8&C_FIRMA=5&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>&ID_FUNCIONARIO_FIRMA=<%=(((RSQUERYVER_PLA2_data = RSQUERYVER_PLA2.getObject("ID_VER_PLANI"))==null || RSQUERYVER_PLA2.wasNull())?"":RSQUERYVER_PLA2_data)%>'">
        <% } else { %>
      <input type="button" name="INSERTA" value="Inserta Firma" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=1&C_FIRMA=5&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>'">
        <% } %> 
    </div></td>
  </tr>
  
  
  
  <tr>
    <th width="15%" scope="row"><div align="right">Persona 3 :</div></th>
    <td bgcolor="#FFFFFF">
    <% if (!RSQUERYVER_PLA3_isEmpty ) { %>
        (<%=(((RSQUERYVER_PLA3_data = RSQUERYVER_PLA3.getObject("ID_VER_PLANI"))==null || RSQUERYVER_PLA3.wasNull())?"":RSQUERYVER_PLA3_data)%>)&nbsp;<%=(((RSQUERYVER_PLA3_data = RSQUERYVER_PLA3.getObject("NOMBRE"))==null || RSQUERYVER_PLA3.wasNull())?"":RSQUERYVER_PLA3_data)%>

  <% } /* end !RSQUERYJS_isEmpty */ %></td>
    <td><div align="center">
      <% if (!RSQUERYVER_PLA3_isEmpty ) { %>
      <input type="button" name="Cambia222" value="Cambiar Funcionario" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=8&C_FIRMA=6&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>&ID_FUNCIONARIO_FIRMA=<%=(((RSQUERYVER_PLA3_data = RSQUERYVER_PLA3.getObject("ID_VER_PLANI"))==null || RSQUERYVER_PLA3.wasNull())?"":RSQUERYVER_PLA3_data)%>'">
         <% } else { %>
      <input type="button" name="INSERTA" value="Inserta Firma" onClick="window.location='cambia_firma_n.jsp?P_C_OPERA=1&C_FIRMA=6&ID_FUNCIONARIO=<%=I_ID_FUNCIONARIO%>'">
      <% } %>
    </div></td>
  </tr>
</table></td>
</tr>
                      </table>
	
	</div>
	</div>
  <%
RSQUERYJS.close();
ConnRSQUERYJS.close();
%>
</body>
</html>
<%
RSQUERYJA.close();
StatementRSQUERYJA.close();
ConnRSQUERYJA.close();
%>
<%
RSDELEGADOJS.close();
StatementRSDELEGADOJS.close();
ConnRSDELEGADOJS.close();
%>
<%
RSFUNCIONARIO.close();
StatementRSFUNCIONARIO.close();
ConnRSFUNCIONARIO.close();
%>
<%
RSQUERYVER_PLA1.close();
StatementRSQUERYVER_PLA1.close();
ConnRSQUERYVER_PLA1.close();
%>
<%
RSQUERYVER_PLA2.close();
StatementRSQUERYVER_PLA2.close();
ConnRSQUERYVER_PLA2.close();
%>
<%
RSQUERYVER_PLA3.close();
StatementRSQUERYVER_PLA3.close();
ConnRSQUERYVER_PLA3.close();
%>
