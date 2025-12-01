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
// *** Insert Record: set variables

if (request.getParameter("MM_insert") != null) {

  MM_editDriver     = MM_RRHH_DRIVER;
  MM_editConnection = MM_RRHH_STRING;
  MM_editUserName   = MM_RRHH_USERNAME;
  MM_editPassword   = MM_RRHH_PASSWORD;
  MM_editTable  = "RRHH.PERMISO_FUNCIONARIO";
  MM_editRedirectUrl = "index.jsp";
  String MM_fieldsStr = "ID_FUNCIONARIO|value|ID_ANO|value|ID_TIPO_PERMISO|value|NUM_DIAS|value|JUSTIFICADO|value|UNICO|value";
  String MM_columnsStr = "ID_FUNCIONARIO|none,none,NULL|ID_ANO|none,none,NULL|ID_TIPO_PERMISO|',none,''|NUM_DIAS|none,none,NULL|COMPLETO|',none,''|UNICO|',none,''";

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
// *** Insert Record: construct a sql insert statement and execute it

if (request.getParameter("MM_insert") != null) {

  // create the insert sql statement
  StringBuffer MM_tableValues = new StringBuffer(), MM_dbValues = new StringBuffer();
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
    MM_tableValues.append((i!=0)?",":"").append(MM_columns[i]);
    MM_dbValues.append((i!=0)?",":"").append(formVal);
  }
  MM_editQuery = new StringBuffer("insert into " + MM_editTable);
  MM_editQuery.append(" (").append(MM_tableValues.toString()).append(") values (");
  MM_editQuery.append(MM_dbValues.toString()).append(")");
  
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
String RSTIPOPERMISO__MMColParam1 = "101217";
if (session.getValue("MM_ID_FUNCIONARIO") !=null) {RSTIPOPERMISO__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO");}
%>
<%
Driver DriverRSTIPOPERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPOPERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPOPERMISO = ConnRSTIPOPERMISO.prepareStatement("SELECT ID_TIPO_PERMISO || '--' || DECODE(JUSTIFICACION,'--','NO',JUSTIFICACION) || '--' || DECODE(TIPO_DIAS,'N','NATURAL','LABORAL')  || '--' || lpad(NUM_DIAS,3,'0')  || '--'|| unico AS ID_TIPO_PERMISO,   ID_TIPO_PERMISO AS ID_TIPO_PERMISO2,  DESC_TIPO_PERMISO  as  DESC_TIPO_PERMISO,TIPO_DIAS   ,NUM_DIAS           ,       DECODE(JUSTIFICACION,'SI','NO',JUSTIFICACION) as JUSTIFICACION  FROM RRHH.TR_TIPO_PERMISO  WHERE ID_ANO = (select  '2007'  FROM personal_new  WHERE id_funcionario='" + RSTIPOPERMISO__MMColParam1 + "' and  rownum <2 )  ORDER BY id_tipo_permiso");
ResultSet RSTIPOPERMISO = StatementRSTIPOPERMISO.executeQuery();
boolean RSTIPOPERMISO_isEmpty = !RSTIPOPERMISO.next();
boolean RSTIPOPERMISO_hasData = !RSTIPOPERMISO_isEmpty;
Object RSTIPOPERMISO_data;
int RSTIPOPERMISO_numRows = 0;
%>
<%
String RSFUNCIONARIO__MMColParam6 = "000000";
if (request.getParameter("ID_FUNCIONARIO")      !=null) {RSFUNCIONARIO__MMColParam6 = (String)request.getParameter("ID_FUNCIONARIO")     ;}
%>
<%
Driver DriverRSFUNCIONARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFUNCIONARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFUNCIONARIO = ConnRSFUNCIONARIO.prepareStatement("SELECT * from    (select 1 orden ,nombre,ape1,ape2 from personal_new where lpad(id_funcionario,6,'0')=lpad('" + RSFUNCIONARIO__MMColParam6 + "',6,'0')   union select 2 orden,'NO EXISTE FUNCIONARIO' nombre,''ape1,''ape2  FROM dual)   WHERE rownum <2");
ResultSet RSFUNCIONARIO = StatementRSFUNCIONARIO.executeQuery();
boolean RSFUNCIONARIO_isEmpty = !RSFUNCIONARIO.next();
boolean RSFUNCIONARIO_hasData = !RSFUNCIONARIO_isEmpty;
Object RSFUNCIONARIO_data;
int RSFUNCIONARIO_numRows = 0;
%>
<%
Driver DriverRSCALENDARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCALENDARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCALENDARIO = ConnRSCALENDARIO.prepareStatement("SELECT LABORAL  FROM RRHH.CALENDARIO_LABORAL  where id_ano=2007");
ResultSet RSCALENDARIO = StatementRSCALENDARIO.executeQuery();
boolean RSCALENDARIO_isEmpty = !RSCALENDARIO.next();
boolean RSCALENDARIO_hasData = !RSCALENDARIO_isEmpty;
Object RSCALENDARIO_data;
int RSCALENDARIO_numRows = 0;
%>
<%
Driver DriverRSCALEN = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCALEN = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCALEN = ConnRSCALEN.prepareStatement("SELECT DECODE(LABORAL,'SI','<td bgcolor=CCCCCC> </td>',  '<td bgcolor=990033> </td>') AS ID_COLUMNA,id_ano,ID_DIA,  SUBSTR(ID_DIA,1,2) AS ID_MES  FROM calendario_laboral  WHERE substr(id_dia,4,2)='01'    AND ID_aNO=2007  ORDER BY ID_DIA");
ResultSet RSCALEN = StatementRSCALEN.executeQuery();
boolean RSCALEN_isEmpty = !RSCALEN.next();
boolean RSCALEN_hasData = !RSCALEN_isEmpty;
Object RSCALEN_data;
int RSCALEN_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSCALEN_numRows += Repeat1__numRows;
%>

<%
Driver driver = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection connection = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
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
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<body>
<table width="760" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="75%" align="left" valign="top">       
      <table cellspacing=0 cellpadding=3 width=98% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><font face=arial color=#ffffff size=+1><b>Administraci&oacute;n 
            de RRHH - Gesti&oacute;n de permisos</b></font></td>
        </tr>
        </tbody> 
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="va10w"> 
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#e0e0e0"> 
                              <table border="0" cellspacing="1" cellpadding="3">
                                <tr bgcolor="#e0e0e0"> 
                                  <td bgcolor="#AAAAAA"><a href="../Datos" class="ah12b">Datos 
                                    personales&nbsp;</a></td>
                                  <td bgcolor="#E0E0E0"><a href="../Permisos" class="ah12b"><b>Permisos</b></a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Ausencias" class="ah12b">Ausencias</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Bajas" class="ah12b">Bajas</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Horas" class="ah12b">Horas 
                                    extras</a>&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td align="right"> 
                        <table border="0" cellspacing="0" cellpadding="4" width="106">
                          <tr bgcolor="#e0e0e0"> 
                            <td bgcolor="#FFFFFF" align="right"><a href="../../index.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                          <form method="POST" action="<%=MM_editAction%>" name="formPermiso">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table border="0" cellspacing="0" cellpadding="2">
                                  <tr> 
                                    <td> 
                                      <input type="button" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp'" disabled="yes">
                                    </td>
                                    <td> 
                                      <input type="button" value="Guardar" name="Guardar" onClick="document.formPermiso.submit();">
                                    </td>
                                    <td>
                                                                           <input type="button" value="Nuevo funcionario" name="Genera" onClick="window.location='genera_nuevo.jsp'" >
                                    </td>
                                    <td>&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                  </tr>
                                </table>
                              </td>
                              <td bgcolor="#E0E0E0" valign="top" align="right"><b> 
                                <%= "<input type='hidden' name='ID_FUNCIONARIO' value='" + session.getValue("MM_ID_FUNCIONARIO") + "'>" %> <%= "<input type='hidden' name='ID_USUARIO' value='" + session.getValue("MM_ID_USUARIO") + "'>" %> 
                                <input type="hidden" name="FECHA_MODI">
                                Generaci&oacute;n de Permiso</b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                <table align="center" cellpadding="2" cellspacing="1" border="0" width="100%">
                                  <tr bgcolor="#f2f2f2"> 
                                    <td colspan="4" align="right" nowrap><table width="100%"  border="0" cellspacing="2" cellpadding="4">
                                      <tr>
                                        <th scope="col">&nbsp;</th>
                                        <th scope="col"><span class="Estilo1">01</span></th>
                                        <th scope="col"><span class="Estilo1">02</span></th>
                                        <th scope="col"><span class="Estilo1">03</span></th>
                                        <th scope="col"><span class="Estilo1">04</span></th>
                                        <th scope="col"><span class="Estilo1">05</span></th>
                                        <th scope="col"><span class="Estilo1">06</span></th>
                                        <th scope="col"><span class="Estilo1">07</span></th>
                                        <th scope="col"><span class="Estilo1">08</span></th>
                                        <th scope="col"><span class="Estilo1">09</span></th>
                                        <th scope="col"><span class="Estilo1">10</span></th>
                                        <th scope="col"><span class="Estilo1">11</span></th>
                                        <th scope="col"><span class="Estilo1">12</span></th>
                                        <th scope="col"><span class="Estilo1">13</span></th>
                                        <th scope="col"><span class="Estilo1">14</span></th>
                                        <th scope="col"><span class="Estilo1">15</span></th>
                                        <th scope="col"><span class="Estilo1">16</span></th>
                                        <th scope="col"><span class="Estilo1">17</span></th>
                                        <th scope="col"><span class="Estilo1">18</span></th>
                                        <th scope="col"><span class="Estilo1">19</span></th>
                                        <th scope="col"><span class="Estilo1">20</span></th>
                                        <th scope="col"><span class="Estilo1">21</span></th>
                                        <th scope="col"><span class="Estilo1">22</span></th>
                                        <th scope="col"><span class="Estilo1">23</span></th>
                                        <th scope="col"><span class="Estilo1">24</span></th>
                                        <th scope="col"><span class="Estilo1">25</span></th>
                                        <th scope="col"><span class="Estilo1">26</span></th>
                                        <th scope="col"><span class="Estilo1">27</span></th>
                                        <th scope="col"><span class="Estilo1">28</span></th>
                                        <th scope="col"><span class="Estilo1">29</span></th>
                                        <th scope="col"><span class="Estilo1">30</span></th>
                                        <th scope="col"><span class="Estilo1">31</span></th>
                                        <th scope="col">&nbsp;</th>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Ene</span></th>                                       
                                          <% while ((RSCALEN_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                          
                                          <%=(((RSCALEN_data = RSCALEN.getObject("ID_COLUMNA"))==null || RSCALEN.wasNull())?"":RSCALEN_data)%>
                                          <%
  Repeat1__index++;
  RSCALEN_hasData = RSCALEN.next();
}
%>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Feb</span></th>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#990033"><span class="Estilo2"></span></td>
                                        <td bgcolor="#990033"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#990033"><span class="Estilo2"></span></td>
                                        <td bgcolor="#990033"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#990033"><span class="Estilo2"></span></td>
                                        <td bgcolor="#990033"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#990033"><span class="Estilo2"></span></td>
                                        <td bgcolor="#990033"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td bgcolor="#CCCCCC"><span class="Estilo2"></span></td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Mar</span></th>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Abril</span></th>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">May</span></th>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Jun</span></th>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Jul</span></th>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Ago</span></th>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Sep</span></th>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Oct</span></th>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Nov</span></th>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <th scope="row"><span class="Estilo2">Dic</span></th>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#CCCCCC">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td bgcolor="#990033">&nbsp;</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                    </table></td>
                                  </tr>
                                </table>
                                <input type="hidden" name="MM_insert" value="true">
                                <script language="JavaScript">
document.formPermiso.MENU_TIPO_PERMISO.value = document.formPermiso.ID_TIPO_PERMISO.value;
</script>
                              </td>
                            </tr>
                          </form>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>   
  </tr>
</table>
</body>
</html>
<%
RSTIPOPERMISO.close();
ConnRSTIPOPERMISO.close();
%>
<%
RSFUNCIONARIO.close();
ConnRSFUNCIONARIO.close();
%>
<%
RSCALENDARIO.close();
StatementRSCALENDARIO.close();
ConnRSCALENDARIO.close();
%>
<%
RSCALEN.close();
StatementRSCALEN.close();
ConnRSCALEN.close();
%>
