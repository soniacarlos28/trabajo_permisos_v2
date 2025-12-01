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
// *** Edit Operations: declare variables

// set the form action variable
String MM_editAction = request.getRequestURI();
if (request.getQueryString() != null && request.getQueryString().length() > 0) {
  MM_editAction += "?" + request.getQueryString();
}

// connection information
String MM_editDriver = null, MM_editConnection = null, MM_editUserName = null, MM_editPassword = null;

// redirect information
String MM_editRedirectUrl = null;

// query string to execute
StringBuffer MM_editQuery = null;

// boolean to abort record edit
boolean MM_abortEdit = false;

// table information
String MM_editTable = null, MM_editColumn = null, MM_recordId = null;

// form field information
String[] MM_fields = null, MM_columns = null;
%>
<%
// *** Update Record: set variables

if (request.getParameter("MM_update") != null &&
    request.getParameter("MM_update").toString().equals("formHoras") &&
    request.getParameter("MM_recordId") != null) {

  MM_editDriver     = MM_RRHH_DRIVER;
  MM_editConnection = MM_RRHH_STRING;
  MM_editUserName   = MM_RRHH_USERNAME;
  MM_editPassword   = MM_RRHH_PASSWORD;
  MM_editTable  = "RRHH.HORAS_EXTRASX";
  MM_editColumn = "ID_HORA";
  MM_recordId   = "" + request.getParameter("MM_recordId") + "";
  MM_editRedirectUrl = "index.jsp";
  String MM_fieldsStr = "ID_HORAS|value|TRP_NOMINA|value|ID_FUNCIONARIO|value|ID_USUARIO|value|FECHA_MODI|value|ID_ANO|value|ID_TIPO_HORAS|value|FECHA_HORAS|value|HORA_INICIO|value|HORA_FIN|value|ANULADO|value|DESCRIPCION|value";
  String MM_columnsStr = "ID_HORA|none,none,NULL|TRP_NOMINA|',none,''|ID_FUNCIONARIO|none,none,NULL|ID_USUARIO|',none,''|FECHA_MODI|',none,NULL|ID_ANO|none,none,NULL|ID_TIPO_HORAS|',none,''|FECHA_HORAS|',none,NULL|HORA_INICIO|',none,''|HORA_FIN|',none,''|ANULADO|',none,''|DESC_HORAS_MOTIVO|',none,''";

  // create the MM_fields and MM_columns arrays
  java.util.StringTokenizer tokens = new java.util.StringTokenizer(MM_fieldsStr,"|");
  MM_fields = new String[tokens.countTokens()];
  for (int i=0; tokens.hasMoreTokens(); i++) MM_fields[i] = tokens.nextToken();

  tokens = new java.util.StringTokenizer(MM_columnsStr,"|");
  MM_columns = new String[tokens.countTokens()];
  for (int i=0; tokens.hasMoreTokens(); i++) MM_columns[i] = tokens.nextToken();

  // set the form values
  for (int i=0; i+1 < MM_fields.length; i+=2) {
    MM_fields[i+1] = ((request.getParameter(MM_fields[i])!=null)?(String)request.getParameter(MM_fields[i]):"");
  }

  // append the query string to the redirect URL
  if (MM_editRedirectUrl.length() != 0 && request.getQueryString() != null) {
    MM_editRedirectUrl += ((MM_editRedirectUrl.indexOf('?') == -1)?"?":"&") + request.getQueryString();
  }
}
%>
<%
// *** Update Record: construct a sql update statement and execute it

if (request.getParameter("MM_update") != null &&
    request.getParameter("MM_recordId") != null) {

  // create the update sql statement
  MM_editQuery = new StringBuffer("update ").append(MM_editTable).append(" set ");
  for (int i=0; i+1 < MM_fields.length; i+=2) {
    String formVal = MM_fields[i+1];
    String elem;
    java.util.StringTokenizer tokens = new java.util.StringTokenizer(MM_columns[i+1],",");
    String delim    = ((elem = (String)tokens.nextToken()) != null && elem.compareTo("none")!=0)?elem:"";
    String altVal   = ((elem = (String)tokens.nextToken()) != null && elem.compareTo("none")!=0)?elem:"";
    String emptyVal = ((elem = (String)tokens.nextToken()) != null && elem.compareTo("none")!=0)?elem:"";
    if (formVal.length() == 0) {
      formVal = emptyVal;
    } else {
      if (altVal.length() != 0) {
        formVal = altVal;
      } else if (delim.compareTo("'") == 0) {  // escape quotes
        StringBuffer escQuotes = new StringBuffer(formVal);
        for (int j=0; j < escQuotes.length(); j++)
          if (escQuotes.charAt(j) == '\'') escQuotes.insert(j++,'\'');
        formVal = "'" + escQuotes + "'";
      } else {
        formVal = delim + formVal + delim;
      }
    }
    MM_editQuery.append((i!=0)?",":"").append(MM_columns[i]).append(" = ").append(formVal);
  }
  MM_editQuery.append(" where ").append(MM_editColumn).append(" = ").append(MM_recordId);
  
  if (!MM_abortEdit) {
    // finish the sql and execute it
    Driver MM_driver = (Driver)Class.forName(MM_editDriver).newInstance();
    Connection MM_connection = DriverManager.getConnection(MM_editConnection,MM_editUserName,MM_editPassword);
    PreparedStatement MM_editStatement = MM_connection.prepareStatement(MM_editQuery.toString());
    MM_editStatement.executeUpdate();
    MM_connection.close();

    // redirect with URL parameters
    if (MM_editRedirectUrl.length() != 0) {
      response.sendRedirect(response.encodeRedirectURL(MM_editRedirectUrl));
      return;
    }
  }
}
%>
<%
Driver DriverRS_TipoHoras = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_TipoHoras = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_TipoHoras = ConnRS_TipoHoras.prepareStatement("SELECT DISTINCT ID_TIPO_HORAS, DESC_TIPO_HORAS  FROM RRHH.TR_TIPO_HORA  ORDER BY DESC_TIPO_HORAS");
ResultSet RS_TipoHoras = StatementRS_TipoHoras.executeQuery();
boolean RS_TipoHoras_isEmpty = !RS_TipoHoras.next();
boolean RS_TipoHoras_hasData = !RS_TipoHoras_isEmpty;
Object RS_TipoHoras_data;
int RS_TipoHoras_numRows = 0;
%>
<%
String RSDatosHoras__MMColParam1 = "5";
if (request.getParameter("ID_HORA")   !=null) {RSDatosHoras__MMColParam1 = (String)request.getParameter("ID_HORA")  ;}
%>
<%
String RSDatosHoras__MMColParam2 = "2003";
if (request.getParameter("ID_ANO")  !=null) {RSDatosHoras__MMColParam2 = (String)request.getParameter("ID_ANO") ;}
%>
<%
Driver DriverRSDatosHoras = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSDatosHoras = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSDatosHoras = ConnRSDatosHoras.prepareStatement("SELECT ID_HORA, ID_ANO, ID_FUNCIONARIO, FECHA_HORAS, ID_TIPO_HORAS, HORA_INICIO, HORA_FIN, TOTAL_HORAS, DESC_HORAS_MOTIVO, COMPENSA, FECHA_COMISION,ANULADO,to_char(TRP_NOMINA) as TRP_NOMINA ,phe FROM RRHH.HORAS_EXTRAS  WHERE ID_HORA = " + RSDatosHoras__MMColParam1 + " AND ID_ANO = " + RSDatosHoras__MMColParam2 + "");
ResultSet RSDatosHoras = StatementRSDatosHoras.executeQuery();
boolean RSDatosHoras_isEmpty = !RSDatosHoras.next();
boolean RSDatosHoras_hasData = !RSDatosHoras_isEmpty;
Object RSDatosHoras_data;
int RSDatosHoras_numRows = 0;
%>
<%
String RSQUERY__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")  !=null) {RSQUERY__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO") ;}
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
<script language="Javascript">
function envia_unavez()
{

 if (document.formHoras.Guardar.disabled==false) 
  {
   document.formHoras.Guardar.disabled=true;
   document.formHoras.submit();
  }
}
</script>
<html>
<head>
<title>Gesti&oacute;n de Horas - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<body>
<body>
<div id="apliweb-tabform">
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
  </ul>
</div>
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
	  </ul>
	</div>
	<div id="subform">
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                          <form ACTION="alta_result.jsp" METHOD="POST" name="formHoras">
                            <tr> 
                              <td width="82%" valign="top" bgcolor="#E0E0E0"> 
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
                              <td width="18%" align="right" valign="top" bgcolor="#E0E0E0"><b> 
                                <input type="hidden" name="ID_HORAS" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("ID_HORA"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>" size="32">
                                 <input type="hidden" name="PHE" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("PHE"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>" size="32">
                              
                                <input name="ID_FUNCIONARIO" type="hidden" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("ID_FUNCIONARIO"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>" size="32">
                                <!--input type="hidden" name="ANULADO" value="NO">
                                <input type="hidden" name="FECHA_ANULACION" size="15" maxlength="10"-->
                                <input name="ID_USUARIO" type="hidden" value="<%=session.getValue("MM_ID_USUARIO")%>" size="32">
                                <input type="hidden" name="FECHA_MODI" value="" size="32">
                                Formulario de Modificacion</b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                <table align="center" cellpadding="2" cellspacing="1" border="0" width="100%">
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">A&ntilde;o:</td>
                                    <td colspan="3"> 
                                      <input type="text" name="ID_ANO" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("ID_ANO"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>" size="6" maxlength="4">
                                    </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Tipo 
                                      de Horas:</td>
                                    <td colspan="3"> 
                                      <input type="text" name="ID_TIPO_HORAS2" disabled="yes" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("ID_TIPO_HORAS"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>" size="8" maxlength="8" onChange="document.formHoras.MENU_TIPO_HORAS.value=document.formHoras.ID_TIPO_HORAS.value">
                                      <select name="MENU_TIPO_HORAS" disabled="yes"  onChange="document.formHoras.ID_TIPO_HORAS.value=document.formHoras.MENU_TIPO_HORAS.value;">
                                        <%
while (RS_TipoHoras_hasData) {
%>
                                        <option value="<%=((RS_TipoHoras.getObject("ID_TIPO_HORAS")!=null)?RS_TipoHoras.getObject("ID_TIPO_HORAS"):"")%>"><%=((RS_TipoHoras.getObject("DESC_TIPO_HORAS")!=null)?RS_TipoHoras.getObject("DESC_TIPO_HORAS"):"")%></option>
                                        <%
  RS_TipoHoras_hasData = RS_TipoHoras.next();
}
RS_TipoHoras.close();
RS_TipoHoras = StatementRS_TipoHoras.executeQuery();
RS_TipoHoras_hasData = RS_TipoHoras.next();
RS_TipoHoras_isEmpty = !RS_TipoHoras_hasData;
%>
                                      </select>
                                      <input type="hidden" name="ID_TIPO_HORAS"  value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("ID_TIPO_HORAS"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>" size="8" maxlength="8" onChange="document.formHoras.MENU_TIPO_HORAS.value=document.formHoras.ID_TIPO_HORAS.value">
                                    </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Fecha 
                                      de Horas:</td>
                                    <td colspan="3"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td> 
                                            <input type="text" name="FECHA_HORAS" value="<%= DoDateTime((((RSDatosHoras_data = RSDatosHoras.getObject("FECHA_HORAS"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data), java.text.DateFormat.SHORT, java.util.Locale.UK) %>" size="15" maxlength="10">
                                          </td>
                                          <td><a href="javascript:show_Calendario('formHoras.FECHA_HORAS');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Hora 
                                      Inicio:</td>
                                    <td width="25%"> 
                                      <input name="HORA_INICIO2" disabled="yes" type="text" id="HORA_INICIO" size="5" maxlength="5" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("HORA_INICIO"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>">
                                      <input name="HORA_INICIO" type="hidden" id="HORA_INICIO" size="5" maxlength="5" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("HORA_INICIO"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>">
                                      (Ej: 08:30) </td>
                                    <td width="20%"> 
                                      <div align="right">Hora Fin:</div>
                                    </td>
                                    <td width="27%"> 
                                      <input name="HORA_FIN2" disabled="yes" type="text" id="HORA_INICIO2" size="5" maxlength="5" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("HORA_FIN"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>">
                                      <input name="HORA_FIN" type="hidden" id="HORA_INICIO2" size="5" maxlength="5" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("HORA_FIN"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>">
                                      (Ej: 08:30) </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Cantidad</td>
                                    <td colspan="3"> 
                                      <input name="CANTIDAD" type="text" id="CANTIDAD" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("TOTAL_HORAS"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>" size="5">
                                       <select name="TRP_NOMINA">
                                                <option value="1" <%=(("1".toString().equals((((RSDatosHoras_data = RSDatosHoras.getObject("TRP_NOMINA"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)))?"SELECTED":"")%>>Nomina</option>
                                            <option value="0" <%=(("0".toString().equals((((RSDatosHoras_data = RSDatosHoras.getObject("TRP_NOMINA"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)))?"SELECTED":"")%>>No pagadas, compensadas a bolsa de horas</option>
                                      
                                          </select>
                                    </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Anulado:</td>
                                    <td colspan="3"> 
                                      <select name="ANULADO" id="select">
                                        <option value="SI">SI</option>
                                        <option value="NO" selected>NO</option>
                                      </select>
                                    </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%" bgcolor="#f2f2f2" valign="middle">Descripci&oacute;n 
                                      del motivo de las horas:</td>
                                    <td colspan="3"> 
                                      <textarea name="DESCRIPCION" cols="60" rows="3" id="DESCRIPCION"><%=(((RSDatosHoras_data = RSDatosHoras.getObject("DESC_HORAS_MOTIVO"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%></textarea>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <input type="hidden" name="ID_TIPO_OPERACION" value="2" size="32">
                            <input type="hidden" name="MM_update" value="formHoras">
                            <input type="hidden" name="MM_recordId" value="<%=(((RSDatosHoras_data = RSDatosHoras.getObject("ID_HORA"))==null || RSDatosHoras.wasNull())?"":RSDatosHoras_data)%>">
                          </form>
                        </table>
	
</div>
</div>
	
	
  <script language="JavaScript">
document.formHoras.MENU_TIPO_HORAS.value = document.formHoras.ID_TIPO_HORAS.value;
document.formHoras.COMPENSACION.value = document.formHoras.OC_COMPENSACION.value;
</script>
</body>
</html>
<%
RS_TipoHoras.close();
ConnRS_TipoHoras.close();
%>
<%
RSDatosHoras.close();
ConnRSDatosHoras.close();
%>
