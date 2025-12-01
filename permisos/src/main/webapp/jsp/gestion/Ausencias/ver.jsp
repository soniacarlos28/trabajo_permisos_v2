<%@page language="java" import="java.util.Date,java.sql.*"  %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%
String RS_TipoAusencia__MMColParam1 = "1";
if (session.getValue("MM_ID_FUNCIONARIO")         !=null) {RS_TipoAusencia__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")        ;}
%>
<%
Driver DriverRS_TipoAusencia = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_TipoAusencia = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_TipoAusencia = ConnRS_TipoAusencia.prepareStatement("SELECT DISTINCT ID_TIPO_AUSENCIA, ID_TIPO_AUSENCIA || ' -- ' || DESC_TIPO_AUSENCIA as DESC_TIPO_AUSENCIA  FROM TR_TIPO_AUSENCIA where   id_tipo_ausencia <500   or id_tipo_ausencia in(select id_tipo_ausencia  FROM hora_sindical  WHERE id_ano=2008 and id_funcionario='" + RS_TipoAusencia__MMColParam1 + "')  ORDER BY DESC_TIPO_AUSENCIA");
ResultSet RS_TipoAusencia = StatementRS_TipoAusencia.executeQuery();
boolean RS_TipoAusencia_isEmpty = !RS_TipoAusencia.next();
boolean RS_TipoAusencia_hasData = !RS_TipoAusencia_isEmpty;
Object RS_TipoAusencia_data;
int RS_TipoAusencia_numRows = 0;
%>
<%
String RS_DatosAusencia__MMColParam1 = "0";
if (request.getParameter("ID_AUSENCIA")   !=null) {RS_DatosAusencia__MMColParam1 = (String)request.getParameter("ID_AUSENCIA")  ;}
%>
<%
Driver DriverRS_DatosAusencia = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_DatosAusencia = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_DatosAusencia = ConnRS_DatosAusencia.prepareStatement("SELECT a.id_EStado, a.id_ausencia,  desc_tipo_ausencia,  id_ano,  id_funcionario,  a.id_tipo_ausencia,  id_estado,  firmado_js,  fecha_js,  firmado_ja,  fecha_ja,  firmado_rrhh,  fecha_rrhh,      to_Char(fecha_inicio,'DD/MM/YYYY') as FECHA_INICIO,    to_Char(fecha_Fin,'DD/MM/YYYY') as FECHA_FIN,    to_Char(fecha_inicio,'HH24') as HORA_INICIO,    to_Char(fecha_inicio,'MI') as MINUTO_INICIO,    to_Char(fecha_fin,'HH24') as HORA_FIN,    to_Char(fecha_fin,'MI') as MINUTO_FIN,        total_horas,  motivo_denega,  observaciones,  a.anulado,  fecha_anulacion,  a.id_usuario,  a.fecha_modi,  a.justificado  FROM AUSENCIA A,        TR_TIPO_AUSENCIA TR  WHERE a.ID_TIPO_AUSENCIA = TR.ID_TIPO_AUSENCIA   AND ID_AUSENCIA = " + RS_DatosAusencia__MMColParam1 + "");
ResultSet RS_DatosAusencia = StatementRS_DatosAusencia.executeQuery();
boolean RS_DatosAusencia_isEmpty = !RS_DatosAusencia.next();
boolean RS_DatosAusencia_hasData = !RS_DatosAusencia_isEmpty;
Object RS_DatosAusencia_data;
int RS_DatosAusencia_numRows = 0;
%>
<%
Driver DriverRSESTADO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSESTADO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSESTADO = ConnRSESTADO.prepareStatement("SELECT id_estado_permiso,         desc_estado_permiso  FROM tr_estado_permiso");
ResultSet RSESTADO = StatementRSESTADO.executeQuery();
boolean RSESTADO_isEmpty = !RSESTADO.next();
boolean RSESTADO_hasData = !RSESTADO_isEmpty;
Object RSESTADO_data;
int RSESTADO_numRows = 0;
%>
<%
String RSQUERY__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")  !=null) {RSQUERY__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO") ;}
%>
<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<script language="Javascript">
<!--
function envia_unavez()
{

 if (document.formAusencia.Guardar.disabled==false) 
  {
   document.formAusencia.Guardar.disabled=true;
   document.formAusencia.submit();
  }
}
</script>
</head>
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
   
    <li><a href="" onClick="show_finger()"  class="ah12b">Finger</a></li>
    <li><a href="gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>  
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
      <li><a href="../../gestion/Bajas/index.jsp"  >Bajas Fichero</a></li> 
       <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>      
 </ul>
</div>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias" id="current">Ausencias</a></li>	
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
	</div>
	<div id="subform">
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formAusencia" method="get" action="editar_result.jsp">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table border="0" cellspacing="0" cellpadding="2">
                                  <tr> 
                                    <td> 
                                      <input type="button" disabled="yes" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp'">
                                    </td>
                                    <td>  <input type="button" value="volver atrás" name="volver atrás2" onClick="history.back()" />
                               </td>
                                    <td>&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                  </tr>
                                </table>
                              </td>
                              <td bgcolor="#E0E0E0" valign="top" align="right"><b><%= "<input type='hidden' name='ID_FUNCIONARIO' value='" + session.getValue("MM_ID_FUNCIONARIO") + "'>" %>
                                <input type="hidden" name="TOTAL_HORAS" size="4" maxlength="3" value="<%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("TOTAL_HORAS"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%>">
                                <input name="ID_USUARIO" type="hidden" value="<%=session.getValue("MM_ID_USUARIO")%>" size="32">
                                <input type="hidden" name="FECHA_MODI" value="" size="32">
                                Formulario de Modicaci&oacute;n</b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"><table align="center" cellpadding="2" cellspacing="1" border="0" width="100%">
                                <tr bgcolor="#f2f2f2">
                                  <td nowrap align="right" width="25%" valign="baseline">A&ntilde;o:</td>
                                  <td width="75%" colspan="3" valign="baseline">
                                    <input type="text" disabled="yes" name="ID_ANO" value="<%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("ID_ANO"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%>" size="6" maxlength="4">
                                  </td>
                                </tr>
                                <tr bgcolor="#f2f2f2">
                                  <td nowrap align="right" width="25%" valign="baseline">Tipo de Ausencia:</td>
                                  <td width="75%" colspan="3" valign="baseline">
                                    <input type="hidden" name="ID_TIPO_AUSENCIA" value="070" size="8" maxlength="8">
                                    <select disabled="yes" name="MENU_TIPO_AUSENCIA" onChange="document.formAusencia.ID_TIPO_AUSENCIA.value=document.formAusencia.MENU_TIPO_AUSENCIA.value;">
                                      <%
while (RS_TipoAusencia_hasData) {
%>
<option value="<%=((RS_TipoAusencia.getObject("ID_TIPO_AUSENCIA")!=null)?RS_TipoAusencia.getObject("ID_TIPO_AUSENCIA"):"")%>" <%=(((RS_TipoAusencia.getObject("ID_TIPO_AUSENCIA")).toString().equals(((((RS_DatosAusencia_data = RS_DatosAusencia.getObject("ID_TIPO_AUSENCIA"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)).toString()))?"SELECTED":"")%> ><%=((RS_TipoAusencia.getObject("DESC_TIPO_AUSENCIA")!=null)?RS_TipoAusencia.getObject("DESC_TIPO_AUSENCIA"):"")%></option> <%
  RS_TipoAusencia_hasData = RS_TipoAusencia.next();
}
RS_TipoAusencia.close();
RS_TipoAusencia = StatementRS_TipoAusencia.executeQuery();
RS_TipoAusencia_hasData = RS_TipoAusencia.next();
RS_TipoAusencia_isEmpty = !RS_TipoAusencia_hasData;
%>
                                    </select>
                                    <input type="hidden" name="ID_AUSENCIA" value="<%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("ID_AUSENCIA"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%>" size="8" maxlength="8">
                                  </td>
                                </tr>
<tr bgcolor="#f2f2f2">
                                  <td nowrap align="right" width="25%" valign="baseline">Fecha Inicio:</td>
                                  <td width="75%" valign="baseline">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td>
                                          <input type="text" disabled="yes" name="FECHA_AUSENCIA" value="<%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("FECHA_INICIO"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%>"  onChange="document.formAusencia.FECHA_REPETICION.value=document.formAusencia.FECHA_AUSENCIA.value;" size="15" maxlength="12">
                                        </td>
                                        <td>&nbsp;</td>
                                      </tr>
                                  </table></td>
                                  <td nowrap align="right" width="35%" valign="baseline">Fecha Fin:</td>
                                  <td width="15%" valign="baseline">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td>
                                          <input type="text"  disabled="yes" name="FECHA_REPETICION" value="<%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("FECHA_FIN"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%>" size="15" maxlength="12">
                                        </td>
                                        <td>&nbsp;</td>
                                      </tr>
                                  </table></td>
                                </tr>
                                <tr bgcolor="#f2f2f2">
                                  <td nowrap align="right" width="25%" valign="baseline">Hora Inicio:</td>
                                  <td width="75%" colspan="3" valign="baseline">
                                    <input name="HORA_INICIO" disabled="yes"  type="text" id="HORA_INICIO2" size="2" maxlength="2" value="<%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("HORA_INICIO"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%>">
      :
      <input name="MINUTO_INICIO" type="text" disabled="yes" id="MINUTO_INICIO2" size="2" maxlength="2" value="<%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("MINUTO_INICIO"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%>">
      (Ej: 08:30) </td>
                                </tr>
                                <tr bgcolor="#f2f2f2">
                                  <td nowrap align="right" width="25%" valign="baseline">Hora Fin:</td>
                                  <td width="75%" colspan="3" valign="baseline">
                                    <input name="HORA_FIN" disabled="yes" type="text" id="HORA_FIN2" size="2" maxlength="2" value="<%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("HORA_FIN"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%>">
      :
      <input name="MINUTO_FIN" disabled="yes" type="text" id="MINUTO_FIN3" size="2" maxlength="2" value="<%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("MINUTO_FIN"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%>">
      (Ej: 13:25) </td>
                                </tr>
                                <tr bgcolor="#f2f2f2">
                                  <td nowrap align="right" width="25%" valign="baseline"><strong>Justificado:</strong></td>
                                  <td width="75%" colspan="3" valign="baseline">
                                    <select name="JUSTIFICACION">
                                      <option value="SI" <%=(("SI".toString().equals((((RS_DatosAusencia_data = RS_DatosAusencia.getObject("JUSTIFICADO"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)))?"SELECTED":"")%>>SI</option>
                                      <option value="NO"  <%=(("NO".toString().equals((((RS_DatosAusencia_data = RS_DatosAusencia.getObject("JUSTIFICADO"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)))?"SELECTED":"")%>>NO</option>
                                    </select></td>
                                </tr>
                                <tr bgcolor="#f2f2f2">
                                  <td nowrap align="right" valign="baseline"><strong>ESTADO:</strong></td>
                                  <td width="75%" colspan="3" valign="baseline"><select name="ID_ESTADO_AUSENCIA" id="ID_ESTADO_PERMISO">
                                      <%
while (RSESTADO_hasData) {
%>
                                      <option value="<%=((RSESTADO.getObject("ID_ESTADO_PERMISO")!=null)?RSESTADO.getObject("ID_ESTADO_PERMISO"):"")%>" <%=(((RSESTADO.getObject("ID_ESTADO_PERMISO")).toString().equals(((((RS_DatosAusencia_data = RS_DatosAusencia.getObject("ID_ESTADO"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)).toString()))?"SELECTED":"")%> ><%=((RSESTADO.getObject("DESC_ESTADO_PERMISO")!=null)?RSESTADO.getObject("DESC_ESTADO_PERMISO"):"")%></option>
                                        <%
  RSESTADO_hasData = RSESTADO.next();
}
RSESTADO.close();
RSESTADO = StatementRSESTADO.executeQuery();
RSESTADO_hasData = RSESTADO.next();
RSESTADO_isEmpty = !RSESTADO_hasData;
%>
                                    </select>&nbsp;</td>
                                </tr>
                                <tr bgcolor="#f2f2f2">
                                  <td nowrap align="right" width="25%" bgcolor="#f2f2f2" valign="middle"><strong>Observaciones:</strong></td>
                                  <td width="75%" colspan="3" valign="baseline">
                                    <textarea name="OBSERVACIONES"  cols="60" rows="3"><%=(((RS_DatosAusencia_data = RS_DatosAusencia.getObject("OBSERVACIONES"))==null || RS_DatosAusencia.wasNull())?"":RS_DatosAusencia_data)%></textarea>
                                  </td>
                                </tr>
                              </table></td>
                          </tr>
</form>
      </table>
	
	</div>
</div>

</body>
</html>
<%
RS_DatosAusencia.close();
ConnRS_DatosAusencia.close();
%>
<%
RSESTADO.close();
StatementRSESTADO.close();
ConnRSESTADO.close();
%>

<%
RS_TipoAusencia.close();
ConnRS_TipoAusencia.close();
%>
