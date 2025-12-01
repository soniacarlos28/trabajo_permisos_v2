<%@page language="java" import="java.util.Date,java.sql.*"%> 
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
if (request.getParameter("ID_FUNCIONARIO")   !=null) {RSQUERY__MMColParam1 = (String)request.getParameter("ID_FUNCIONARIO")  ;}
%>
<%
String RSQUERY__MMColParam2 = "";
if (request.getParameter("NOMBRE")    !=null) {RSQUERY__MMColParam2 = (String)request.getParameter("NOMBRE")   ;}
%>
<%
String RSQUERY__MMColParam3 = "";
if (request.getParameter("APE1")    !=null) {RSQUERY__MMColParam3 = (String)request.getParameter("APE1")   ;}
%>
<%
String RSQUERY__MMColParam4 = "";
if (request.getParameter("APE2")    !=null) {RSQUERY__MMColParam4 = (String)request.getParameter("APE2")   ;}
%>
<%
if (!RSQUERY__MMColParam1.equals("000000")) { 
	session.putValue("MM_ID_FUNCIONARIO", 			RSQUERY__MMColParam1); 
	session.putValue("MM_ID_FUNCIONARIO_NOMBRE", RSQUERY__MMColParam2); 
	session.putValue("MM_ID_FUNCIONARIO_APE1", 			RSQUERY__MMColParam3); 
	session.putValue("MM_ID_FUNCIONARIO_APE2", 			RSQUERY__MMColParam4); 
} else {
	RSQUERY__MMColParam1 = (String) session.getValue("MM_ID_FUNCIONARIO");
	RSQUERY__MMColParam2 = (String) session.getValue("MM_ID_FUNCIONARIO_NOMBRE");
	
}
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT FECHA_ANTIGUEDAD,pe.ID_FUNCIONARIO, CATEGORIA, PUESTO, NOMBRE, APE1, APE2, pe.TIPO_FUNCIONARIO, FECHA_INGRESO, ACTIVO, JORNADA, UPPER(DIRECCION) AS DIRECCION,TELEFONO,NUMERO_SS, LPAD(DNI,8,'0') AS DNI, '' as DESC_FUNCIONARIO  FROM RRHH.PERSONAL_NEW pe  WHERE pe.ID_FUNCIONARIO = '" + RSQUERY__MMColParam1 + "' ");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
String RSEVENTOS__MMColParam1 = "000000";
if (request.getParameter("ID_FUNCIONARIO")      !=null) {RSEVENTOS__MMColParam1 = (String)request.getParameter("ID_FUNCIONARIO")     ;}
%>
<%
String RSEVENTOS__MMColParam3 = "D";
if (request.getParameter("ID_EVENTO")     !=null) {RSEVENTOS__MMColParam3 = (String)request.getParameter("ID_EVENTO")    ;}
%>
<%
if (RSEVENTOS__MMColParam1.equals("000000") ) { 
   	RSEVENTOS__MMColParam1 = RSQUERY__MMColParam1;
    } 
%>
<%
Driver DriverRSEVENTOS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSEVENTOS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSEVENTOS = ConnRSEVENTOS.prepareStatement("SELECT ID_EVENTO, ID_FUNCIONARIO, FECHA_EVENTO, ID_TIPO_EVENTO, INITCAP(OBSERVACIONES) AS DESC_EVENTO  FROM RRHH.EVENTOS  WHERE id_funcionario='" + RSEVENTOS__MMColParam1 +  "' ORDER BY fecha_evento desc");
ResultSet RSEVENTOS = StatementRSEVENTOS.executeQuery();
boolean RSEVENTOS_isEmpty = !RSEVENTOS.next();
boolean RSEVENTOS_hasData = !RSEVENTOS_isEmpty;
Object RSEVENTOS_data;
int RSEVENTOS_numRows = 0;
%>
<%
int Repeat1__numRows = 10;
int Repeat1__index = 0;
RSEVENTOS_numRows += Repeat1__numRows;
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
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH</title>
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
		<li id="active"><a href="../Datos" id="current">Datos per.</a></li>
		<li><a href="../Permisos">Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
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
                          <tr> 
                            <td bgcolor="#E0E0E0" width="10%"> 
                              <input type="submit" name="Detalles" value="Detalles" onClick="window.location='index.jsp?ID_EVENTO=D&ID_FUNCIONARIO='+ <%=RSEVENTOS__MMColParam1%>">
                            </td>
                            <td bgcolor="#E0E0E0" width="11%"> 
                              <input type="submit" name="evento" value="Eventos" onClick="window.location='index.jsp?ID_EVENTO=E&ID_FUNCIONARIO='+ <%=RSEVENTOS__MMColParam1%>">
                            </td>
                            <td bgcolor="#E0E0E0"> 
                              <input type="submit" disabled="yes" name="evento2" value="Nuevo Evento" onClick="window.location='nuevo_evento.jsp?ID_EVENTO=E&ID_FUNCIONARIO='+ <%=RSEVENTOS__MMColParam1%>">
                            </td>
                            <td bgcolor="#E0E0E0">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td bgcolor="#E0E0E0" colspan="4"> 
                              <% if (RSEVENTOS__MMColParam3.equals("D")) { %>
                              <table width="100%" border="0" cellspacing="1" cellpadding="2">
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b"> 
                                    Identificador:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></span></td>
                                </tr>
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b"> 
                                    Nombre:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></span></td>
                                </tr>
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b">Apellidos:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%=(((RSQUERY_data = RSQUERY.getObject("APE1"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%> <%=(((RSQUERY_data = RSQUERY.getObject("APE2"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></span></td>
                                </tr>
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b"> 
                                    Tipo de Funcionario:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%=(((RSQUERY_data = RSQUERY.getObject("DESC_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></span></td>
                                </tr>
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b"> 
                                    Direcci&oacute;n:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%=(((RSQUERY_data = RSQUERY.getObject("DIRECCION"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></span></td>
                                </tr>
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b"> 
                                    Telefono.:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%=(((RSQUERY_data = RSQUERY.getObject("TELEFONO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></span></td>
                                </tr>
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b"> 
                                    D.N.I.:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%=(((RSQUERY_data = RSQUERY.getObject("DNI"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></span></td>
                                </tr>
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b">Fecha 
                                    Alta:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%= DoDateTime((((RSQUERY_data = RSQUERY.getObject("FECHA_INGRESO"))==null || RSQUERY.wasNull())?"":RSQUERY_data), java.text.DateFormat.LONG, null) %></span></td>
                                </tr>
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b">Fecha 
                                    Antiguedad:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_ANTIGUEDAD"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></span></td>
                                </tr>
                                <tr> 
                                  <td width="25%" bgcolor="#CCCCCC" align="right"><span class="va10b"> 
                                    N&uacute;mero Seg. Social:&nbsp;</span></td>
                                  <td width="75%" bgcolor="#FFFFFF"><span class="va10b"><%=(((RSQUERY_data = RSQUERY.getObject("NUMERO_SS"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></span></td>
                                </tr>
                              </table>
                              <% } else if  (!RSQUERY__MMColParam3.equals("D") ) { %>
                              <table width="100%" border="0" cellspacing="1" cellpadding="2">
                                <tr bgcolor="#CCCCCC"> 
                                  <td width="10%" align="center"><span class="va10b"> 
                                    Identificador</span></td>
                                  <td width="10%" align="center"><span class="va10b"> 
                                    Tipo&nbsp;</span></td>
                                  <td width="10%" align="center"><span class="va10b"> 
                                    Evento&nbsp;</span></td>
                                  <td align="center" width="70%"><span class="va10b"> 
                                    Evento</span></td>
                                </tr>
                                <% while ((RSEVENTOS_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                <tr> 
                                  <td width="10%" bgcolor="#FFFFFF" align="center"><%=(((RSEVENTOS_data = RSEVENTOS.getObject("ID_FUNCIONARIO"))==null || RSEVENTOS.wasNull())?"":RSEVENTOS_data)%></td>
                                  <td width="10%" bgcolor="#FFFFFF" align="center"><%=(((RSEVENTOS_data = RSEVENTOS.getObject("ID_TIPO_EVENTO"))==null || RSEVENTOS.wasNull())?"":RSEVENTOS_data)%></td>
                                  <td width="10%" bgcolor="#FFFFFF" align="center"><%= DoDateTime((((RSEVENTOS_data = RSEVENTOS.getObject("FECHA_EVENTO"))==null || RSEVENTOS.wasNull())?"":RSEVENTOS_data), java.text.DateFormat.SHORT, java.util.Locale.UK) %></td>
                                  <td bgcolor="#FFFFFF" align="center" width="70%"><%=(((RSEVENTOS_data = RSEVENTOS.getObject("DESC_EVENTO"))==null || RSEVENTOS.wasNull())?"":RSEVENTOS_data)%></td>
                                </tr>
                                <%
  Repeat1__index++;
  RSEVENTOS_hasData = RSEVENTOS.next();
}
%>
                              </table>
                              <% } %>
                            </td>
                          </tr>
                        </table>

	</div>
</div>

</body>
</html>
<%
RSQUERY.close();
ConnRSQUERY.close();
%>
<%
RSEVENTOS.close();
ConnRSEVENTOS.close();
%>

