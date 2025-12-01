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

String I_ID_FUNCIONARIO = "000000";
if(session.getValue("MM_ID_FUNCIONARIO") != null){ I_ID_FUNCIONARIO = (String)session.getValue("MM_ID_FUNCIONARIO");}

%>
<%
String RSQUERY__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")   !=null) {RSQUERY__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSQUERY__MMColParam2 = "0000";
if (request.getParameter("PERIODO")  !=null) {RSQUERY__MMColParam2 = (String)request.getParameter("PERIODO") ;}
%>
<%
String RSQUERY__MMColParam3 = "1";
if (request.getParameter("TOTAL")   !=null) {RSQUERY__MMColParam3 = (String)request.getParameter("TOTAL")  ;}
%>
<%
java.util.Calendar cal_periodo = java.util.Calendar.getInstance();
Integer periodo = new Integer( cal_periodo.get(java.util.Calendar.YEAR) );
if (RSQUERY__MMColParam2.equals("0000")) { RSQUERY__MMColParam2 = periodo.toString(); }
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT DECODE(JUSTIFICADO,'--','',CHEQUEA_ENLACE_FICHERO_JUS(ID_ANO,ID_FUNCIONARIO,ID_AUSENCIA,id_estado,'A',2)) as JUSTI_FICHERO,R.JUSTIFICADO,ID_AUSENCIA,FECHA_INICIO AS FECHA_INICIO2, TRE.DESC_ESTADO_PERMISO as DESC_ESTADO_PERMISO,         R.ID_ANO,          R.ID_TIPO_AUSENCIA,          TO_CHAR(fecha_INICIO,'DD/MM/YY') || '' || DECODE( TO_CHAR(fecha_INICIO,'DD/MM/YY'), TO_CHAR(fecha_FIN,'DD/MM/YY'),'',' a ' || TO_CHAR(fecha_FIN,'DD/MM/YY') ) as FECHA_INICIO,         to_char(FECHA_INICIO,'HH24:MI ') as HORA_INICIO,         to_char(FECHA_FIN,'HH24:MI ') as HORA_FIN,         FECHA_FIN,    lpad (((TOTAL_HORAS)  -  mod((TOTAL_HORAS),60))/60,2,0)|| ':' || lpad(mod((TOTAL_HORAS),60),2,0) as TOTAL_HORAS,          TR.ID_TIPO_AUSENCIA,          INITCAP(DESC_TIPO_AUSENCIA) AS DESC_TIPO_AUSENCIA  FROM AUSENCIA R, TR_ESTADO_PERMISO tre,        TR_TIPO_AUSENCIA TR  WHERE TRE.ID_ESTADO_PERMISO=R.ID_ESTADO   AND           R.ID_TIPO_AUSENCIA = TR.ID_TIPO_AUSENCIA AND        (ANULADO IS NULL OR ANULADO =  'NO')          AND R.ID_ANO = '" + RSQUERY__MMColParam2 + "'  AND           R.ID_FUNCIONARIO = '" + RSQUERY__MMColParam1 + "'      AND  '" + RSQUERY__MMColParam3 + "'='" + RSQUERY__MMColParam3 + "'  ORDER BY fecha_INICIO2  DESC");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT DISTINCT TO_CHAR(FECHA_INICIO,'YYYY') AS PERIODO  FROM AUSENCIA where TO_CHAR(FECHA_INICIO,'YYYY')> 2014  and  TO_CHAR(FECHA_INICIO,'YYYY')< 2054 order by 1 desc");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>
<%
String RSQUERY_TOTALES__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSQUERY_TOTALES__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSQUERY_TOTALES__MMColParam2 = "0000";
if (request.getParameter("PERIODO")     !=null) {RSQUERY_TOTALES__MMColParam2 = (String)request.getParameter("PERIODO")    ;}
%>
<%
Driver DriverRSQUERY_TOTALES = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY_TOTALES = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY_TOTALES = ConnRSQUERY_TOTALES.prepareStatement("SELECT R.ID_ANO,                lpad ((sum(TOTAL_HORAS)  -  mod(sum(TOTAL_HORAS),60))/60,3,0)|| ':' || lpad(mod(sum(TOTAL_HORAS),60),2,0) as HORAS_TOTALES,         INITCAP(DESC_TIPO_AUSENCIA) AS DESC_TIPO_AUSENCIA  FROM AUSENCIA R,        TR_TIPO_AUSENCIA TR  WHERE R.ID_TIPO_AUSENCIA = TR.ID_TIPO_AUSENCIA AND        (ANULADO IS NULL OR ANULADO =  'NO')          AND R.ID_ANO = '" + RSQUERY_TOTALES__MMColParam2 + "' AND  R.ID_FUNCIONARIO='" + RSQUERY_TOTALES__MMColParam1 + "'  group by R.ID_ANO,INITCAP(DESC_TIPO_AUSENCIA)");
ResultSet RSQUERY_TOTALES = StatementRSQUERY_TOTALES.executeQuery();
boolean RSQUERY_TOTALES_isEmpty = !RSQUERY_TOTALES.next();
boolean RSQUERY_TOTALES_hasData = !RSQUERY_TOTALES_isEmpty;
Object RSQUERY_TOTALES_data;
int RSQUERY_TOTALES_numRows = 0;
%>
<%
String RS_HORASEXTRAS__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO") !=null) {RS_HORASEXTRAS__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO");}
%>
<%
String RS_HORASEXTRAS__MMColParam2 = "0000";
if (request.getParameter("PERIODO")      !=null) {RS_HORASEXTRAS__MMColParam2 = (String)request.getParameter("PERIODO")     ;}
%>
<%
Driver DriverRS_HORASEXTRAS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_HORASEXTRAS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_HORASEXTRAS = ConnRS_HORASEXTRAS.prepareStatement("SELECT to_char(sysdate,'YYYY') as ID_ANO,lpad((total  -  mod(total,60))/60,4,0)  || ':' || lpad(mod(total,60),2,0) as Horas_extras,  lpad((utilizadas -  mod(utilizadas,60))/60,4,0)  || ':' || lpad(mod(utilizadas,60),2,0) as utilizadas, lpad(  ( (total-utilizadas)  -  mod((total-utilizadas),60))/60,4,0)  || ':' || lpad(mod((total-utilizadas),60),2,0) as disponible  FROM horas_extras_ausencias  WHERE id_funcionario='" + RS_HORASEXTRAS__MMColParam1 + "'  -- and id_ano=" + RS_HORASEXTRAS__MMColParam2 + "");
ResultSet RS_HORASEXTRAS = StatementRS_HORASEXTRAS.executeQuery();
boolean RS_HORASEXTRAS_isEmpty = !RS_HORASEXTRAS.next();
boolean RS_HORASEXTRAS_hasData = !RS_HORASEXTRAS_isEmpty;
Object RS_HORASEXTRAS_data;
int RS_HORASEXTRAS_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSQUERY_numRows += Repeat1__numRows;
%>
<%
int Repeat3__numRows = 10;
int Repeat3__index = 0;
RS_HORASEXTRAS_numRows += Repeat3__numRows;
%>
<%
int Repeat2__numRows = 10;
int Repeat2__index = 0;
RSQUERY_TOTALES_numRows += Repeat2__numRows;
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
<body>
<script type="text/JavaScript">

function show_confirmar(id)
{
   var text = "¿Realmente desea eliminar Justificante?";
   var r = confirm(text);
   if (r==true) { 
                 //MM_goToURL('self',url + id);
				 
				 window.open('../fichero/eliminarDoc.jsp?PERMISO=A&ID='+id , null,top=0,left=100,height=600,width=940,scrollbars=yes,status=no,toolbar=no ,menubar=no,location=0,directories=no);
   }
   else { 
      alert("Operación cancelada!");  
   }
}
</script>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
          
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>    
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>  
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
    <li><a href="../../gestion/Bajas/index.jsp"  >Bajas Fichero</a></li>
    <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

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
		<li><a href="../Bolsa_concilia" >Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" >Incidencias  Fichajes</a></li>
	  </ul>
	</div>
	<div id="subform">
	<table width="95%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#E0E0E0"> 
                              <table width="100%" border="0" cellspacing="5" cellpadding="0">
                                <tr> 
                                  <td bgcolor="#E0E0E0" valign="top" colspan="3"> 
                                    <table border="0" cellspacing="0" cellpadding="2">
                                      <form name="formBotonera" method=post action="index.jsp">
                                        <tr> 
                                          <td> 
                                            <input type="button" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp'">
                                          </td>
                                          <td> 
                                            <input type="button" value="Guardar" name="Guardar" disabled="yes">
                                          </td>
                                          <td class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;</td>
                                        </tr>
                                      </form>
                                    </table>
                                  </td>
                                  <td bgcolor="#E0E0E0" valign="top" align="right" rowspan="2"> 
                                    <table border="0" cellspacing="0" cellpadding="2" width="100">
                                      <form name="formPeriodo" method=post action="index.jsp">
                                        <tr> 
                                          <td>A&ntilde;o:&nbsp;</td>
                                          <td> 
                                            <select name="PERIODO">
                                              <% while (RSPERIODO_hasData) {
%>
                                              <%= "<option value='" %><%= (((RSPERIODO_data = RSPERIODO.getObject("PERIODO"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data) %><%= "'>" %> <%= RSPERIODO_data= RSPERIODO.getObject("PERIODO") %> <%= "</option>" %> 
                                              <%  RSPERIODO_hasData = RSPERIODO.next();
}
RSPERIODO.close();
RSPERIODO = StatementRSPERIODO.executeQuery();
RSPERIODO_hasData = RSPERIODO.next();
RSPERIODO_isEmpty = !RSPERIODO_hasData;
%>
                                            </select>
                                          </td>
                                          <td> 
                                            <input type="submit" value="Ver" name="submit">
                                          </td>
                                        </tr>
                                      </form>
                                    </table>
                                  </td>
                                </tr>
                                <tr> 
                                  <td bgcolor="#E0E0E0" valign="top"> 
                                    <input type="button" value="Totales" name="TOTALES" onClick="window.location='index.jsp?TOTAL=T&PERIODO='+ document.formPeriodo.PERIODO.value">
                                    <input type="button" name="Detalles" value="Detalles" onClick="window.location='index.jsp?TOTAL=D&PERIODO='+ document.formPeriodo.PERIODO.value">
                                  </td>
                                  <td bgcolor="#E0E0E0" valign="top">&nbsp;</td>
                                  <td bgcolor="#E0E0E0" valign="top">&nbsp;</td>
                                </tr>
                                <tr> 
                                  <td bgcolor="#E0E0E0" valign="top" colspan="4"> 
                                    <% if (RSQUERY__MMColParam3.equals("T")) { %>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                      <tr bgcolor="#FFFFDD"> 
                                        <td colspan="6"><b>Ausencias </b></td>
                                      </tr>
                                      <tr> 
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">A&ntilde;o</span></td>
                                        <td width="80%" bgcolor="#CCCCCC" align="center"><span class="va10b">Tipo 
                                          de Ausencia</span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Horas</span></td>
                                  
                                      </tr>
                                      <% while ((RSQUERY_TOTALES_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                      <tr bgcolor="#FFFFFF"> 
                                        <td width="10%" align="center"><%=(((RSQUERY_TOTALES_data = RSQUERY_TOTALES.getObject("ID_ANO"))==null || RSQUERY_TOTALES.wasNull())?"":RSQUERY_TOTALES_data)%></td>
                                        <td width="80%"><%=(((RSQUERY_TOTALES_data = RSQUERY_TOTALES.getObject("DESC_TIPO_AUSENCIA"))==null || RSQUERY_TOTALES.wasNull())?"":RSQUERY_TOTALES_data)%></td>
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><b><%=(((RSQUERY_TOTALES_data = RSQUERY_TOTALES.getObject("HORAS_TOTALES"))==null || RSQUERY_TOTALES.wasNull())?"":RSQUERY_TOTALES_data)%></b></td>
                                      </tr>
                                      <%
  Repeat2__index++;
  RSQUERY_TOTALES_hasData = RSQUERY_TOTALES.next();
}
%>
                                    </table>
                                  </td>
                                </tr>
                                <tr bgcolor="#FFFFDD"> 
                                  <td colspan="6" bgcolor="#E0E0E0"> 
                                    <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                      <tr> 
                                        <td colspan="8" bgcolor="#FFFFDD"><b>Horas 
                                          extras compensables por ausencias por 
                                          horas.</b></td>
                                      </tr>
                                      <tr> 
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">A&ntilde;o</span></td>
                                        <td width="60%" bgcolor="#CCCCCC" align="center"> 
                                          Horas</td>
                                        <td width="10%" align="center" bgcolor="#CCCCCC">Utilizadas</td>
                                        <td width="10%" align="center" bgcolor="#CCCCCC">Disponibles</td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center">Total 
                                        </td>
                                      </tr>
                                      <% while ((RS_HORASEXTRAS_hasData)&&(Repeat3__numRows-- != 0)) { %>
                                      <tr> 
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><%=(((RS_HORASEXTRAS_data = RS_HORASEXTRAS.getObject("ID_ANO"))==null || RS_HORASEXTRAS.wasNull())?"":RS_HORASEXTRAS_data)%></td>
                                        <td width="60%" bgcolor="#FFFFFF">&nbsp;</td>
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><b><%=(((RS_HORASEXTRAS_data = RS_HORASEXTRAS.getObject("UTILIZADAS"))==null || RS_HORASEXTRAS.wasNull())?"":RS_HORASEXTRAS_data)%></b></td>
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><b><%=(((RS_HORASEXTRAS_data = RS_HORASEXTRAS.getObject("DISPONIBLE"))==null || RS_HORASEXTRAS.wasNull())?"":RS_HORASEXTRAS_data)%></b></td>
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><b><%=(((RS_HORASEXTRAS_data = RS_HORASEXTRAS.getObject("HORAS_EXTRAS"))==null || RS_HORASEXTRAS.wasNull())?"":RS_HORASEXTRAS_data)%></b></td>
                                      </tr>
                                      <%
  Repeat3__index++;
  RS_HORASEXTRAS_hasData = RS_HORASEXTRAS.next();
}
%>
                                    </table>
                                  </td>
                                </tr>
                                <tr> 
                                  <td bgcolor="#E0E0E0" valign="top" colspan="4"> 
                                    <p> 
                                      <% } else if  (!RSQUERY__MMColParam3.equals("T") ) { %>
                                    </p>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                      <tr> 
                                        <td width="2%" bgcolor="#CCCCCC" align="center"><span class="va10b">A&ntilde;o</span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha </span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Inicio</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fin</span></td>
                                        <td width="30%" align="center" nowrap bgcolor="#CCCCCC"><span class="va10b">Tipo 
                                          de Ausencia</span></td>
                                        <td width="20%" bgcolor="#CCCCCC" align="center">Estado</td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center">Just.</td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Horas</span></td>
                                          <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fichero</span></td>
                                      </tr>
                                      <% while ((RSQUERY_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                      <tr bgcolor="#FFFFFF"> 
                                        <td width="10%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("ID_ANO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td width="20%" align="center" nowrap><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_INICIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td width="10%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("HORA_INICIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td width="10%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("HORA_FIN"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td width="20%" nowrap><%= "<a href='editar.jsp?ID_AUSENCIA=" + (((RSQUERY_data = RSQUERY.getObject("ID_AUSENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&ID_ANO=" + (((RSQUERY_data = RSQUERY.getObject("ID_ANO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'>" + (((RSQUERY_data = RSQUERY.getObject("DESC_TIPO_AUSENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "</a>" %></td>
                                        <td width="20%" nowrap><%=(((RSQUERY_data = RSQUERY.getObject("DESC_ESTADO_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td width="3%"><div align="center"><%=(((RSQUERY_data = RSQUERY.getObject("JUSTIFICADO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></div></td>
                                        <td width="10%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("TOTAL_HORAS"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                         <td width="3%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("JUSTI_FICHERO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                    
                                      </tr>
                                      <%
  Repeat1__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                                    </table>
                                    <% } %>
                                  </td>
                                </tr>
                                <tr> 
                                  <td bgcolor="#E0E0E0" valign="top" colspan="4"> 
                                    <script language="JavaScript">
<%= "document.formPeriodo.PERIODO.value = " + RSQUERY__MMColParam2 %>
</script>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
	</div>
	</div>
	
  <%
RSPERIODO.close();
ConnRSPERIODO.close();
%>
<%
RSQUERY_TOTALES.close();
ConnRSQUERY_TOTALES.close();
%>
<%
RS_HORASEXTRAS.close();
ConnRS_HORASEXTRAS.close();
%>
<%
RSQUERY.close();
ConnRSQUERY.close();
%>
</body>
</html>





