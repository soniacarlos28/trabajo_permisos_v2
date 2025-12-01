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
  MM_editTable  = "RRHH.CALENDARIO_LABORAL";
  MM_editColumn = "ID_REGISTRO";
  MM_recordId   = "" + request.getParameter("MM_recordId") + "";
  MM_editRedirectUrl = "index.jsp";
  String MM_fieldsStr = "OBSERVACION|value|LABORAL|value|COMPENSABLE|value";
  String MM_columnsStr = "OBSERVACION|',none,''|LABORAL|',none,''|COMPENSABLE|',none,''";

 
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
<% String bisiesto="";
String RSCABECERA__MMColParam1 = "01/01/2017";
if (request.getParameter("ID_DIA")          !=null) {RSCABECERA__MMColParam1 = (String)request.getParameter("ID_DIA")         ;}
%>
<%
Driver DriverRSCABECERA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCABECERA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCABECERA = ConnRSCABECERA.prepareStatement("SELECT COMPENSABLE, DECODE(to_char(ID_DIA, 'd'),1,'Lunes',2,'Martes',3,'Miercoles ', 4,'Jueves',5,'Viernes',6,'Sabado',7,'Domingo','O') as desc_dia,ID_REGISTRO,ID_ANO,to_char(ID_DIA,'DD/mm/yyyy') as ID_DIA,OBSERVACION,     laboral    FROM calendario_laboral cl WHERE id_dia = to_date('" + RSCABECERA__MMColParam1 + "','DD/mm/YYYY')   ORDER BY id_dia");



ResultSet RSCABECERA = StatementRSCABECERA.executeQuery();
boolean RSCABECERA_isEmpty = !RSCABECERA.next();
boolean RSCABECERA_hasData = !RSCABECERA_isEmpty;
Object RSCABECERA_data;
int RSCABECERA_numRows = 0;
%>

<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSCABECERA_numRows += Repeat1__numRows;
%>

<%
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

int RSCABECERA_first = 1;
int RSCABECERA_last  = 1;
int RSCABECERA_total = -1;

if (RSCABECERA_isEmpty) {
  RSCABECERA_total = RSCABECERA_first = RSCABECERA_last = 0;
}

//set the number of rows displayed on this page
if (RSCABECERA_numRows == 0) {
  RSCABECERA_numRows = 1;
}
%>

<%
// *** Recordset Stats: if we don't know the record count, manually count them

if (RSCABECERA_total == -1) {

  // count the total records by iterating through the recordset
    for (RSCABECERA_total = 1; RSCABECERA.next(); RSCABECERA_total++);

  // reset the cursor to the beginning
  RSCABECERA.close();
  RSCABECERA = StatementRSCABECERA.executeQuery();
  RSCABECERA_hasData = RSCABECERA.next();

  // set the number of rows displayed on this page
  if (RSCABECERA_numRows < 0 || RSCABECERA_numRows > RSCABECERA_total) {
    RSCABECERA_numRows = RSCABECERA_total;
  }

  // set the first and last displayed record
  RSCABECERA_first = Math.min(RSCABECERA_first, RSCABECERA_total);
  RSCABECERA_last  = Math.min(RSCABECERA_first + RSCABECERA_numRows - 1, RSCABECERA_total);
}
%>

<%
String thisPage = request.getRequestURI();
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
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../Gestion/index.jsp">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li> 
     <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b" id="current">Calendario Laboral</a></li> 
<li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
  </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
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
                                            <input type="text" disabled=yes name="ID_A�O2" size="6" maxlength="4" value="<%=(((RSCABECERA_data = RSCABECERA.getObject("ID_ANO"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>">
                                            <input type="hidden"  name="ID_A�O" size="6" maxlength="4" value="<%=(((RSCABECERA_data = RSCABECERA.getObject("ID_ANO"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>">
                                          </td>
                                        </tr>
                                        <tr bgcolor="#f2f2f2"> 
                                          <td align="right">D�a</td>
                                          <td colspan="3"><b><%=(((RSCABECERA_data = RSCABECERA.getObject("DESC_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>-<%=(((RSCABECERA_data = RSCABECERA.getObject("ID_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></b> </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="right">Laboral:</td>
                                          <td colspan="3"><b><select name="LABORAL" id="LABORAL">
            <option value="NO" <%=(("NO".toString().equals((((RSCABECERA_data = RSCABECERA.getObject("LABORAL"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)))?"selected=\"selected\"":"")%>>No</option>
            <option value="SI" <%=(("SI".toString().equals((((RSCABECERA_data = RSCABECERA.getObject("LABORAL"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)))?"selected=\"selected\"":"")%>>Si</option>       
</select></b> </td>
                                        </tr>
                                        <tr bgcolor="#CCCCCC"> 
                                          <td align="right" bgcolor="#f2f2f2">Compensable: 
                                          </td>
                                          <td colspan="3" bgcolor="#f2f2f2"> 
                                            <input type="text" name="COMPENSABLE" value="<%=(((RSCABECERA_data = RSCABECERA.getObject("COMPENSABLE"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>" size="65" maxlength="60">
                                          </td>
                                        </tr>
                                        <tr bgcolor="#CCCCCC"> 
                                          <td align="right" bgcolor="#f2f2f2">Observaci�n: 
                                          </td>
                                          <td colspan="3" bgcolor="#f2f2f2"> 
                                            <input type="text" name="OBSERVACION" value="<%=(((RSCABECERA_data = RSCABECERA.getObject("OBSERVACION"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>" size="65" maxlength="60">
                                          </td>
                                        </tr>
                                        
                                        <tr bgcolor="#FFFFFF" align="center"> 
                                          <td colspan="4"> 
                                            <table border="0" cellspacing="0" cellpadding="0" width="50%">
                                              <tr> 
                                                
                                                <td bgcolor="#FFFFFF" width="5%">&nbsp; 
                                                </td>
                                                <td bgcolor="#FFFFFF"> 
                                                  <input type="submit" name="Buscar2" value="Guardar">
                                                </td>
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                      </table>
                                      
<input type="hidden" name="MM_update" value="formSindicales">
<input type="hidden" name="MM_recordId" value="<%=(((RSCABECERA_data = RSCABECERA.getObject("ID_REGISTRO"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>">
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
</body>
</html>
<%
RSCABECERA.close();
ConnRSCABECERA.close();
%>

