<%@page language="java" import="java.util.Date,java.sql.*"  errorPage="error.jsp"%>
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
if (session.getValue("MM_ID_FUNCIONARIO")        !=null) {RS_TipoAusencia__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")       ;}
%>
<%
Driver DriverRS_TipoAusencia = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_TipoAusencia = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_TipoAusencia = ConnRS_TipoAusencia.prepareStatement("select t.id_tipo_ausencia,      ID_TIPO_AUSENCIA || ' -- ' || DESC_TIPO_AUSENCIA || '. Horas Disponibles este a�o: ' ||  trunc((Total -utILIZADAs) / 60, 2) || ' h.' as desc_tipo_ausencia  FROM bolsa_concilia h, tr_tipo_ausencia t WHERE id_funcionario = '" + RS_TipoAusencia__MMColParam1 + "'   and '050' = t.id_tipo_ausencia   and  h.ID_ANO = '2022'   and tr_ANULADO = 'NO' union SELECT DISTINCT ID_TIPO_AUSENCIA,                ID_TIPO_AUSENCIA || ' -- ' || DESC_TIPO_AUSENCIA as DESC_TIPO_AUSENCIA  FROM TR_TIPO_AUSENCIA where id_tipo_ausencia < 500  and id_tipo_ausencia not in (50)    or id_tipo_ausencia in       (select id_tipo_ausencia          FROM hora_sindical         WHERE id_ano = to_char(sysdate, 'YYYY')           and id_funcionario = '" + RS_TipoAusencia__MMColParam1 + "') ORDER BY DESC_TIPO_AUSENCIA ");
ResultSet RS_TipoAusencia = StatementRS_TipoAusencia.executeQuery();
boolean RS_TipoAusencia_isEmpty = !RS_TipoAusencia.next();
boolean RS_TipoAusencia_hasData = !RS_TipoAusencia_isEmpty;
Object RS_TipoAusencia_data;
int RS_TipoAusencia_numRows = 0;
%>
<%
Driver DriverRS_FECHAHOY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_FECHAHOY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_FECHAHOY = ConnRS_FECHAHOY.prepareStatement("SELECT TO_CHAR(SYSDATE,'dd/MM/YYYY') AS fecha_hoy FROM DUAL");
ResultSet RS_FECHAHOY = StatementRS_FECHAHOY.executeQuery();
boolean RS_FECHAHOY_isEmpty = !RS_FECHAHOY.next();
boolean RS_FECHAHOY_hasData = !RS_FECHAHOY_isEmpty;
Object RS_FECHAHOY_data;
int RS_FECHAHOY_numRows = 0;
%>
<%
String RSHORAS__MMColParam1 = "101217";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSHORAS__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
Driver DriverRSHORAS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSHORAS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSHORAS = ConnRSHORAS.prepareStatement("SELECT lpad(  ( (total-utilizadas)  -  mod((total-utilizadas),60))/60,2,0)  || ':' || lpad(mod((total-utilizadas),60),2,0) as contador  FROM horas_extras_ausenciaS  WHERE id_funcionario='" + RSHORAS__MMColParam1 + "' and id_ano='2003'");
ResultSet RSHORAS = StatementRSHORAS.executeQuery();
boolean RSHORAS_isEmpty = !RSHORAS.next();
boolean RSHORAS_hasData = !RSHORAS_isEmpty;
Object RSHORAS_data;
int RSHORAS_numRows = 0;
%>
<%
String RSHORAS_SINDICALES__MMColParam1 = "0";
if (session.getValue("MM_ID_FUNCIONARIO")       !=null) {RSHORAS_SINDICALES__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")      ;}
%>
<%
Driver DriverRSHORAS_SINDICALES = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSHORAS_SINDICALES = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSHORAS_SINDICALES = ConnRSHORAS_SINDICALES.prepareStatement("SELECT ID_MES,       DECODE(ID_MES,              1,              '01--Enero',              2,              '02--Febrero',              3,              '03--Marzo',              4,              '04--Abril',              5,              '05--Mayo',              6,              '06--Junio',              7,              '07--Julio',              8,              '08--Agosto',              9,              '09--Septiembre',              10,              '10--Octubre',              11,              '11--Noviembre',              12,              '12--Diciembre',              '') || '--tipo: ' || h.id_tipo_ausencia || ' --Total :' ||       TRUNC(Total_horas / 60, 0) || '--Utilizadas :' ||       TRUNC(TOTAL_Utilizadas / 60, 0) as Registro,       lpad(ID_MES, 2, 0) || '-' ||       lpad(total_HORAS - TOTAL_utilizadas, 4, 0) as Total  FROM hora_sindical h,tr_tipo_ausencia tr WHERE id_funcionario = '" + RSHORAS_SINDICALES__MMColParam1 + "'   and id_ano=to_char(sysdate,'YYYY') and        tr.id_tipo_ausencia=h.id_tipo_ausencia   and TR_ANULADO = 'NO' ORDER BY 1");
ResultSet RSHORAS_SINDICALES = StatementRSHORAS_SINDICALES.executeQuery();
boolean RSHORAS_SINDICALES_isEmpty = !RSHORAS_SINDICALES.next();
boolean RSHORAS_SINDICALES_hasData = !RSHORAS_SINDICALES_isEmpty;
Object RSHORAS_SINDICALES_data;
int RSHORAS_SINDICALES_numRows = 0;
%><script language="Javascript">

function envia_unavez()
{

 if (document.formAusencia.Guardar.disabled==false) 
  {
   document.formAusencia.Guardar.disabled=true;
   document.formAusencia.submit();
  }
}
</script>
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
        <li><a href="../../gestion/Bajas/index.jsp"  >Bajas Fichero</a></li>
         <li ><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
 </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
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
		<li><a href="../Bolsa_concilia" >Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" >Incidencias  Fichajes</a></li>
	  </ul>
	</div>
	<div id="subform">
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formAusencia" method="post" action="alta_result.jsp">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table border="0" cellspacing="0" cellpadding="2">
                                  <tr> 
                                    <td> 
                                      <input type="button" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp'" disabled="yes">
                                    </td>
                                    <td> 
                                      <input type="submit" value="Guardar" name="Guardar" onClick="javascript:envia_unavez();">
                                    </td>
                                    <td>&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                  </tr>
                                </table>
                              </td>
                              <td bgcolor="#E0E0E0" valign="top" align="right"><b> 
                                <input type="hidden" name="ID_AUSENCIA" value="0" size="32">
                                <input name="ID_FUNCIONARIO" type="hidden" value="<%=RSQUERY__MMColParam1%>" size="32">
                                <!--input type="hidden" name="ANULADO" value="NO">
                                <input type="hidden" name="FECHA_ANULACION" size="15" maxlength="10"-->
                                <input name="HORAS" type="hidden" id="HORAS2" value="0" size="5" maxlength="5">
                                <input name="ID_USUARIO" type="hidden" value="<%=session.getValue("MM_ID_USUARIO")%>" size="32">
                                <input type="hidden" name="FECHA_MODI" value="" size="32">
                                Formulario de Alta</b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                <table align="center" cellpadding="2" cellspacing="1" border="0" width="100%">
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="25%" valign="baseline">A&ntilde;o:</td>
                                    <td width="75%" colspan="3" valign="baseline"> 
                                      <input type="text" name="ID_ANO" value="2025" size="6" maxlength="4">
                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="25%" valign="baseline">Tipo 
                                      de Ausencia:</td>
                                    <td width="75%" colspan="3" valign="baseline"> 
                                      <input type="hidden" name="ID_TIPO_AUSENCIA" value="070" size="8" maxlength="8">
                                      <select name="MENU_TIPO_AUSENCIA" onChange="document.formAusencia.ID_TIPO_AUSENCIA.value=document.formAusencia.MENU_TIPO_AUSENCIA.value;">
                                        <%
while (RS_TipoAusencia_hasData) {
%>
                                        <option value="<%=((RS_TipoAusencia.getObject("ID_TIPO_AUSENCIA")!=null)?RS_TipoAusencia.getObject("ID_TIPO_AUSENCIA"):"")%>" <%=((((RS_TipoAusencia.getObject("ID_TIPO_AUSENCIA")!=null)?RS_TipoAusencia.getObject("ID_TIPO_AUSENCIA"):"").toString().equals(("01-0000").toString()))?"SELECTED":"")%>><%=((RS_TipoAusencia.getObject("DESC_TIPO_AUSENCIA")!=null)?RS_TipoAusencia.getObject("DESC_TIPO_AUSENCIA"):"")%></option>
                                        <%
  RS_TipoAusencia_hasData = RS_TipoAusencia.next();
}
RS_TipoAusencia.close();
RS_TipoAusencia = StatementRS_TipoAusencia.executeQuery();
RS_TipoAusencia_hasData = RS_TipoAusencia.next();
RS_TipoAusencia_isEmpty = !RS_TipoAusencia_hasData;
%>
                                      </select>
                                    </td>
                                  </tr>
                                  <% if (!RSHORAS_SINDICALES_isEmpty ) { %>
<tr bgcolor="#f2f2f2"> 
                                    <td align="right" valign="baseline" nowrap>Horas 
                                    Sindicales:</td>
                                    <td colspan="3" align="right" valign="baseline" nowrap><div align="left">
                                        <input type="hidden" name="ID_SINDICALES" value="01-000" size="8" maxlength="8" >
                                        <select name="sindicales"  onChange="document.formAusencia.ID_SINDICALES.value=document.formAusencia.sindicales.value;">
                                          <option value="01-0000"></option>
                                          <%
while (RSHORAS_SINDICALES_hasData) {
%>
                                          <option value="<%=((RSHORAS_SINDICALES.getObject("TOTAL")!=null)?RSHORAS_SINDICALES.getObject("TOTAL"):"")%>" <%=((((RSHORAS_SINDICALES.getObject("TOTAL")!=null)?RSHORAS_SINDICALES.getObject("TOTAL"):"").toString().equals(("01-0000").toString()))?"SELECTED":"")%>><%=((RSHORAS_SINDICALES.getObject("REGISTRO")!=null)?RSHORAS_SINDICALES.getObject("REGISTRO"):"")%></option>
                                          <%
  RSHORAS_SINDICALES_hasData = RSHORAS_SINDICALES.next();
}
RSHORAS_SINDICALES.close();
RSHORAS_SINDICALES = StatementRSHORAS_SINDICALES.executeQuery();
RSHORAS_SINDICALES_hasData = RSHORAS_SINDICALES.next();
RSHORAS_SINDICALES_isEmpty = !RSHORAS_SINDICALES_hasData;
%>
                                        </select>
                                    </div></td>
                                  </tr>
                                  <% } /* end !RSHORAS_SINDICALES_isEmpty */ %>

                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="25%" valign="baseline">Fecha 
                                      Inicio:</td>
                                    <td width="75%" valign="baseline"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td> 
                                            <input type="text" name="FECHA_INICIO" value="<%=(((RS_FECHAHOY_data = RS_FECHAHOY.getObject("FECHA_HOY"))==null || RS_FECHAHOY.wasNull())?"":RS_FECHAHOY_data)%>" onChange="document.formAusencia.FECHA_FIN.value=document.formAusencia.FECHA_INICIO.value;" size="15" maxlength="12">
                                          </td>
                                          <td><a href="javascript:show_Calendario('formAusencia.FECHA_INICIO');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>
                                    </td>
                                    <td nowrap align="right" width="35%" valign="baseline">Fecha 
                                      Fin:</td>
                                    <td width="15%" valign="baseline"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td> 
                                            <input type="text" name="FECHA_FIN" value="<%=(((RS_FECHAHOY_data = RS_FECHAHOY.getObject("FECHA_HOY"))==null || RS_FECHAHOY.wasNull())?"":RS_FECHAHOY_data)%>" size="15" maxlength="12">
                                          </td>
                                          <td><a href="javascript:show_Calendario('formAusencia.FECHA_FIN');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="25%" valign="baseline">Hora 
                                      Inicio:</td>
                                    <td width="75%" colspan="3" valign="baseline"> 
                                      <input name="HORA_INICIO" type="text" id="HORA_INICIO2" size="8" maxlength="5" value="08:00">
                                      (Ej: 08:30) </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="25%" valign="baseline">Hora 
                                      Fin:</td>
                                    <td width="75%" colspan="3" valign="baseline"> 
                                      <input name="HORA_FIN" type="text" id="HORA_FIN2" size="8" maxlength="9" value="09:00">
                                      (Ej: 13:25) </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="25%" valign="baseline">Justificado:</td>
                                    <td width="75%" colspan="3" valign="baseline"> 
                                      <select name="JUSTIFICACION">
                                        <option value="SI">SI</option>
                                        <option value="NO" selected>NO</option>
                                      </select>
                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="25%" bgcolor="#f2f2f2" valign="middle">Observaciones:</td>
                                    <td width="75%" colspan="3" valign="baseline"> 
                                      <textarea name="OBSERVACIONES" cols="60" rows="3"></textarea>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                          </tr>
                          </form>
      </table>
	</div>
</div>
</body>
</html>
<%
RS_TipoAusencia.close();
ConnRS_TipoAusencia.close();
%>
<%
RSHORAS.close();
ConnRSHORAS.close();
%>
<%
RSHORAS_SINDICALES.close();
ConnRSHORAS_SINDICALES.close();
%>

