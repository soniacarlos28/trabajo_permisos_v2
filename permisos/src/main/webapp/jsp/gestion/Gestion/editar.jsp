<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
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
    request.getParameter("MM_recordId") != null) {

  MM_editDriver     = MM_RRHH_DRIVER;
  MM_editConnection = MM_RRHH_STRING;
  MM_editUserName   = MM_RRHH_USERNAME;
  MM_editPassword   = MM_RRHH_PASSWORD;
  MM_editTable  = "RRHH.HORA_SINDICAL";
  MM_editColumn = "ID_HORA_SINDICAL";
  MM_recordId   = "" + request.getParameter("MM_recordId") + "";
  MM_editRedirectUrl = "index.jsp";
  String MM_fieldsStr = "TotalHoras2|value";
  String MM_columnsStr = "TOTAL_HORAS|none,none,NULL";

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
    }
  }
}
%>
<%
String RSSINDICAL__MMColParam1 = "1";
if (request.getParameter("ID_MES")   !=null) {RSSINDICAL__MMColParam1 = (String)request.getParameter("ID_MES")  ;}
%>
<%
String RSSINDICAL__MMColParam2 = "2";
if (request.getParameter("ID_TIPO_AUSENCIA")  !=null) {RSSINDICAL__MMColParam2 = (String)request.getParameter("ID_TIPO_AUSENCIA") ;}
%>
<%
Driver DriverRSSINDICAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSSINDICAL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSSINDICAL = ConnRSSINDICAL.prepareStatement("SELECT ID_TIPO_AUSENCIA, ID_AnO,ID_FUNCIONARIO ,    DECODE(ID_MES,1,'Enero',2,'Febrero',3,'Marzo',4,'Abril',5,'Mayo',6,'Junio',7,'Julio',8,'Agosto'  ,9,'Septiembre',10,'Octubre',11,'Noviembre',12,'Diciembre','') as MES  ,trunc(TOTAL_HORAS/60,0) as TOTAL,MOD(tOTAL_horas,60) as TOTAL_MINUTOS,ID_HORA_SINDICAL  FROM RRHH.HORA_SINDICAL  WHERE ID_TIPO_AUSENCIA between '500' and '600' and id_mes='" + RSSINDICAL__MMColParam1 + "' and ID_TIPO_AUSENCIA='" + RSSINDICAL__MMColParam2 + "' and id_ano in (2017)");
ResultSet RSSINDICAL = StatementRSSINDICAL.executeQuery();
boolean RSSINDICAL_isEmpty = !RSSINDICAL.next();
boolean RSSINDICAL_hasData = !RSSINDICAL_isEmpty;
Object RSSINDICAL_data;
int RSSINDICAL_numRows = 0;
%>
<html>
<head>
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li ><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Listados">Sin Justificar</a></li>
    <li><a href="" onClick="../Finger">Finger</a></li>
    <li id="active" ><a href="#" id="current">Horas Sindicales</a></li>   
    <li><a href="gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li> 
     <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
  <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
  </ul>
</div>
<div id="form">

<table width="95%" border="0" cellspacing="0" cellpadding="2">
                          <tr> 
                            <td> 
                              <table border="0" cellspacing="0" cellpadding="2" width="100%">
                                <tr bgcolor="#FFFFFF"> 
                                  <td rowspan="4" bgcolor="#FFFFFF" valign="top"> 
                                    <form ACTION="<%=MM_editAction%>" METHOD="POST" name="formSindicales">
                                      <table border="0" cellspacing="0" cellpadding="4">
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="right">A&ntilde;o: </td>
                                          <td colspan="3"> 
                                            <input type="text" name="ID_A�O" size="6" maxlength="4" value="<%=(((RSSINDICAL_data = RSSINDICAL.getObject("ID_AnO"))==null || RSSINDICAL.wasNull())?"":RSSINDICAL_data)%>">
                                          </td>
                                        </tr>
                                        <tr bgcolor="#f2f2f2"> 
                                          <td align="right">C&oacute;digo: </td>
                                          <td colspan="3"><b><%=(((RSSINDICAL_data = RSSINDICAL.getObject("ID_TIPO_AUSENCIA"))==null || RSSINDICAL.wasNull())?"":RSSINDICAL_data)%></b> </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="center">Funcionario:</td>
                                          <td colspan="3"><b><%=(((RSSINDICAL_data = RSSINDICAL.getObject("ID_FUNCIONARIO"))==null || RSSINDICAL.wasNull())?"":RSSINDICAL_data)%></b> </td>
                                        </tr>
                                        <tr bgcolor="#CCCCCC"> 
                                          <td align="right" bgcolor="#f2f2f2">Descripci&oacute;n: 
                                          </td>
                                          <td colspan="3" bgcolor="#f2f2f2"> 
                                            <input type="text" name="Descripcion" size="45" maxlength="40">
                                          </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="right" width="25%">Mes: </td>
                                          <td width="25%"><b><%=(((RSSINDICAL_data = RSSINDICAL.getObject("MES"))==null || RSSINDICAL.wasNull())?"":RSSINDICAL_data)%></b> </td>
                                          <td align="right" width="25%" colspan="-1">Horas:Minutos 
                                          </td>
                                          <td width="25%"> 
                                            <input type="number" name="TotalHoras" size="4" onChange="document.formSindicales.TotalHoras2.value=document.formSindicales.TotalHoras.value*60-document.formSindicales.TotalHoras3.value*-1" value="<%=(((RSSINDICAL_data = RSSINDICAL.getObject("TOTAL"))==null || RSSINDICAL.wasNull())?"":RSSINDICAL_data)%>" >
                                            : 
                                            <input type="number" name="TotalHoras3" size="4" onChange="document.formSindicales.TotalHoras2.value=document.formSindicales.TotalHoras.value*60-document.formSindicales.TotalHoras3.value*-1" value="<%=(((RSSINDICAL_data = RSSINDICAL.getObject("TOTAL_MINUTOS"))==null || RSSINDICAL.wasNull())?"":RSSINDICAL_data)%>" >
                                            <input type="hidden" name="TotalHoras2" size="5">
                                          </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF" align="center"> 
                                          <td colspan="4"> 
                                            <table border="0" cellspacing="0" cellpadding="0" width="50%">
                                              <tr> 
                                                <td align="right" bgcolor="#FFFFFF"> 
                                                  <input type="reset" name="Limpiar2" value="Limpiar">
                                                </td>
                                                <td bgcolor="#FFFFFF" width="5%">&nbsp; 
                                                </td>
                                                <td bgcolor="#FFFFFF"> 
                                                  <input type="submit" name="Buscar2" value="Actualizar">
                                                </td>
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                      </table>
                                      
<input type="hidden" name="MM_update" value="formSindicales">
<input type="hidden" name="MM_recordId" value="<%=(((RSSINDICAL_data = RSSINDICAL.getObject("ID_HORA_SINDICAL"))==null || RSSINDICAL.wasNull())?"":RSSINDICAL_data)%>">
                                    </form>
                                  </td>
                                  <td rowspan="4" align="center" valign="top" bgcolor="#FFFFFF" width="30%"> 
                                    <p>&nbsp;</p>
                                    <p><img src="../../imagen/gestion.jpg" width="101" height="108"></p>
                                  </td>
                                </tr>
                                <tr bgcolor="#FFFFFF"> </tr>
                                <tr bgcolor="#FFFFFF"> </tr>
                                <tr bgcolor="#FFFFFF"> </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
</div>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
</body>
</html>
<%
RSSINDICAL.close();
ConnRSSINDICAL.close();
%>
