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
String RSQUERY__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")  !=null) {RSQUERY__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO") ;}
%>
<%
String RSQUERY__MMColParam2 = "0000";
if (request.getParameter("PERIODO") !=null) {RSQUERY__MMColParam2 = (String)request.getParameter("PERIODO");}
%>
<%
java.util.Calendar cal_periodo = java.util.Calendar.getInstance();
Integer periodo = new Integer( cal_periodo.get(java.util.Calendar.YEAR) );
if (RSQUERY__MMColParam2.equals("0000")) { RSQUERY__MMColParam2 = periodo.toString(); }
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT HORAS_EXTRAS.ID_ANO, ID_HORA, FECHA_HORAS, HORAS_EXTRAS.ID_TIPO_HORAS, HORA_INICIO, HORA_FIN, TOTAL_HORAS, DESC_HORAS_MOTIVO, DESC_TIPO_HORAS ,DECODE(TRP_NOMINA,1,'Nomina','No pagadas') AS NOMI FROM RRHH.HORAS_EXTRAS, RRHH.TR_TIPO_HORA  WHERE RRHH.TR_TIPO_HORA.ID_TIPO_HORAS = HORAS_EXTRAS.ID_TIPO_HORAS AND  HORAS_EXTRAS.ID_ANO = " + RSQUERY__MMColParam2 + " AND ID_FUNCIONARIO = " + RSQUERY__MMColParam1 + " and (anulado='NO' or anulado is null) order by fecha_horas desc ,hora_inicio");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT DISTINCT ID_ANO AS PERIODO  FROM RRHH.HORAS_EXTRAS ORDER BY 1 DESC");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSQUERY_numRows += Repeat1__numRows;
%>
<%
Driver driver = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection connection = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
%>
<%
String thisPage = request.getRequestURI();
%>
<%!
public String DoDateTime(java.lang.Object aObject,int nNamedFormat,java.util.Locale aLocale) throws Exception{	
if ((aObject != null) && (aObject instanceof java.util.Date)){
   if (aLocale!=null){
		java.text.DateFormat df = java.text.DateFormat.getDateInstance(nNamedFormat,aLocale);
			return df.format(aObject);
	}
	else{
		java.text.DateFormat df = java.text.DateFormat.getDateInstance(nNamedFormat);
			return df.format(aObject);
	 }
 }
return "";
}
%>
<html>
<head>
<title>Gesti&oacute;n de Horas - Administraci&oacute;n de RRHH</title>
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
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

 </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>
		
		<li><a href="../Horas" id="current">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
		<li><a href="../Bolsa_concilia" >Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" >Incidencias  Fichajes</a></li>
	  </ul>
	</div>
	<div id="subform">
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                          <tr> 
                            <td bgcolor="#E0E0E0" valign="top"> 
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
                            <td bgcolor="#E0E0E0" valign="top" align="right"> 
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
                            <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                              <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                <tr> 
                                  <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">A&ntilde;o</span></td>
                                  <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha 
                                    horas </span></td>
                                  <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Hora 
                                    inicio </span></td>
                                  <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Hora 
                                    fin </span></td>
                                  <td width="35%" bgcolor="#CCCCCC" align="center"><span class="va10b">Tipo 
                                    de Horas</span></td>
                                     <td width="35%" bgcolor="#CCCCCC" align="center"><span class="va10b">Nomina</span></td>
                                  <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Total 
                                    </span></td>
                                </tr>
                                <% while ((RSQUERY_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                <tr bgcolor="#FFFFFF"> 
                                  <td width="10%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("ID_ANO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                  <td width="15%" align="center"><%= DoDateTime((((RSQUERY_data = RSQUERY.getObject("FECHA_HORAS"))==null || RSQUERY.wasNull())?"":RSQUERY_data), java.text.DateFormat.SHORT, java.util.Locale.UK) %></td>
                                  <td width="15%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("HORA_INICIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                  <td width="15%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("HORA_FIN"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                  <td width="35%"><%= "<a href='editar.jsp?ID_HORA=" + (((RSQUERY_data = RSQUERY.getObject("ID_HORA"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&ID_ANO=" + (((RSQUERY_data = RSQUERY.getObject("ID_ANO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'>" + (((RSQUERY_data = RSQUERY.getObject("DESC_TIPO_HORAS"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "</a>" %></td>
                                   <td width="15%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("NOMI"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                    <td width="10%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("TOTAL_HORAS"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                </tr>
                                <%
  Repeat1__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                              <script language="JavaScript">
<%= "document.formPeriodo.PERIODO.value = " + RSQUERY__MMColParam2 %>
</script>
                            </td>
                          </tr>
      </table>
	</div>
</div>
</body>
</html>
<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
<%
RSPERIODO.close();
StatementRSPERIODO.close();
ConnRSPERIODO.close();
%>


<%
RSQUERY.close();
ConnRSQUERY.close();
%>
<%
RSPERIODO.close();
ConnRSPERIODO.close();
%>

