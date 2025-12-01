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
  MM_editTable  = "RRHH.TeMP_PERMISOS";
  MM_editRedirectUrl = "alta_result.jsp";
  String MM_fieldsStr = "ID_PERMISO|value|ID_FUNCIONARIO|value|ANULADO|value|FECHA_ANULACION|value|ID_USUARIO|value|FECHA_MODI|value|ID_ANO|value|ID_TIPO_PERMISO|value|FECHA_INICIO|value|FECHA_FIN|value|NUM_DIAS|value|ID_TIPO_DIAS|value|JUSTIFICADO|value|OBSERVACIONES|value|DPROVINCIA|value";
  String MM_columnsStr = "ID_PERMISO|none,none,NULL|ID_FUNCIONARIO|none,none,NULL|ANULADO|',none,''|FECHA_ANULACION|',none,NULL|ID_USUARIO|',none,''|FECHA_MODI|',none,NULL|ID_ANO|none,none,NULL|ID_TIPO_PERMISO|',none,''|FECHA_INICIO|',none,NULL|FECHA_FIN|',none,NULL|NUM_DIAS|none,none,NULL|ID_TIPO_DIAS|',none,''|JUSTIFICADO|',none,''|OBSERVACIONES|',none,''|DPROVINCIA|',none,''";

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
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT ID_PERMISO, ID_ANO, ID_FUNCIONARIO, ID_TIPO_PERMISO ||'--'||JUSTIFICADO as ID_TIPO_PERMISO , FECHA_INICIO, FECHA_FIN, NUM_DIAS, ID_TIPO_DIAS, JUSTIFICADO, OBSERVACIONES, ANULADO, FECHA_ANULACION, ID_USUARIO, TO_char(sysdate,'DD/MM/YYYY')  AS FECHA_HOY ,FECHA_MODI  FROM RRHH.PERMISOS");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
String RSTIPOPERMISO__MMColParam1 = "2003";
if (request.getParameter("ID_ANO") !=null) {RSTIPOPERMISO__MMColParam1 = (String)request.getParameter("ID_ANO");}
%>
<%
Driver DriverRSTIPOPERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPOPERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPOPERMISO = ConnRSTIPOPERMISO.prepareStatement("SELECT ID_TIPO_PERMISO || '--' || DECODE(JUSTIFICACION,'SI','NO',JUSTIFICACION) || '--' || DECODE(TIPO_DIAS,'N','N','L')  AS ID_TIPO_PERMISO,   ID_TIPO_PERMISO AS ID_TIPO_PERMISO2,  DESC_TIPO_PERMISO || ' - (Días:' ||  num_dias || ' )' as  DESC_TIPO_PERMISO,TIPO_DIAS              ,       DECODE(JUSTIFICACION,'SI','NO',JUSTIFICACION) as JUSTIFICACION  FROM RRHH.TR_TIPO_PERMISO  WHERE ID_ANO = '" + RSTIPOPERMISO__MMColParam1 + "'   ORDER BY id_tipo_permiso");
ResultSet RSTIPOPERMISO = StatementRSTIPOPERMISO.executeQuery();
boolean RSTIPOPERMISO_isEmpty = !RSTIPOPERMISO.next();
boolean RSTIPOPERMISO_hasData = !RSTIPOPERMISO_isEmpty;
Object RSTIPOPERMISO_data;
int RSTIPOPERMISO_numRows = 0;
%>
<%
String RSQUEYFECHAS__MMColParam1 = "01/01/2007";
if (request.getParameter("FECHA_INICIO")  !=null) {RSQUEYFECHAS__MMColParam1 = (String)request.getParameter("FECHA_INICIO") ;}
%>
<%
String RSQUEYFECHAS__MMColParam2 = "01/01/2007";
if (request.getParameter("FECHA_FIN")  !=null) {RSQUEYFECHAS__MMColParam2 = (String)request.getParameter("FECHA_FIN") ;}
%>
<%
String RSQUEYFECHAS__MMColParam3 = "N";
if (request.getParameter("ID_TIPO_DIAS")    !=null) {RSQUEYFECHAS__MMColParam3 = (String)request.getParameter("ID_TIPO_DIAS")   ;}
%>
<%
String RSQUEYFECHAS__MMColParam4 = "01000";
if (request.getParameter("ID_TIPO_PERMISO")    !=null) {RSQUEYFECHAS__MMColParam4 = (String)request.getParameter("ID_TIPO_PERMISO")   ;}
%>
<%
String RSQUEYFECHAS__MMColParam5 = "--";
if (request.getParameter("JUSTIFICADO")    !=null) {RSQUEYFECHAS__MMColParam5 = (String)request.getParameter("JUSTIFICADO")   ;}
%>
<%
String RSFUNCIONARIO__MMColParam6 = "000000";
if (request.getParameter("ID_FUNCIONARIO")      !=null) {RSFUNCIONARIO__MMColParam6 = (String)request.getParameter("ID_FUNCIONARIO")     ;}
%>
<%
Driver DriverRSQUEYFECHAS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUEYFECHAS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUEYFECHAS = ConnRSQUEYFECHAS.prepareStatement("SELECT DECODE(CONTADOR,0,1,CONTADOR) as CONTADOR FROM (SELECT DECODE('" + RSQUEYFECHAS__MMColParam3 + "','N',0, Contador_laboral) +DECODE('" + RSQUEYFECHAS__MMColParam3 + "','L',0,contador_natural) as Contador   from  (SELECT count(*) as contador_laboral,0 contador_natural from calendario_laboral where id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')   and laboral='SI' and id_dia not in (select id_dia  FROM festivos  WHERE id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')  and  reduccion=0)  union  select 0 contador_laboral,count(*) as contador_natural  FROM calendario_laboral where id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')  )  WHERE (        DECODE('" + RSQUEYFECHAS__MMColParam3 + "','N',0, Contador_laboral) <> 0 OR                        DECODE('" + RSQUEYFECHAS__MMColParam3 + "','L',0,contador_natural) <> 0       ))");
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
String RSPERMISO_TIPOS__MMColParam1 = "0000";
if (request.getParameter("ID_ANO")  !=null) {RSPERMISO_TIPOS__MMColParam1 = (String)request.getParameter("ID_ANO") ;}
%>
<%
String RSPERMISO_TIPOS__MMColParam2 = "01000";
if (request.getParameter("ID_TIPO_PERMISO")  !=null) {RSPERMISO_TIPOS__MMColParam2 = (String)request.getParameter("ID_TIPO_PERMISO") ;}
%>
<%
Driver DriverRSPERMISO_TIPOS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERMISO_TIPOS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERMISO_TIPOS = ConnRSPERMISO_TIPOS.prepareStatement("SELECT ID_TIPO_PERMISO || '--' || DECODE(JUSTIFICACION,'SI','NO',JUSTIFICACION)  || '--' || DECODE(TIPO_DIAS,'N','N','L')  AS ID_TIPO_PERMISO,   ID_TIPO_PERMISO AS ID_TIPO_PERMISO2,  DESC_TIPO_PERMISO,TIPO_DIAS              ,       JUSTIFICACION  FROM RRHH.TR_TIPO_PERMISO  WHERE (id_ano=" + RSPERMISO_TIPOS__MMColParam1 + " ) and id_tipo_permiso ='" + RSPERMISO_TIPOS__MMColParam2 + "'");
ResultSet RSPERMISO_TIPOS = StatementRSPERMISO_TIPOS.executeQuery();
boolean RSPERMISO_TIPOS_isEmpty = !RSPERMISO_TIPOS.next();
boolean RSPERMISO_TIPOS_hasData = !RSPERMISO_TIPOS_isEmpty;
Object RSPERMISO_TIPOS_data;
int RSPERMISO_TIPOS_numRows = 0;
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
<script language="Javascript">
<!--
function carga_final(){

   document.formPermiso.MENU_TIPO_PERMISO.value="<%=(((RSPERMISO_TIPOS_data = RSPERMISO_TIPOS.getObject("ID_TIPO_PERMISO"))==null || RSPERMISO_TIPOS.wasNull())?"":RSPERMISO_TIPOS_data)%>";
   document.formPermiso.ID_TIPO_PERMISO.value="<%=RSQUEYFECHAS__MMColParam4%>";

 <%  if ( RSQUEYFECHAS__MMColParam4.equals("01000")) { %>
     document.formPermiso.ID_TIPO_DIAS.value="<%=RSQUEYFECHAS__MMColParam3%>"; 
     document.formPermiso.TIPO_DIAS.value="<%=RSQUEYFECHAS__MMColParam3%>";  
  <%} else { %>
     document.formPermiso.ID_TIPO_DIAS.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(12,11);   
     document.formPermiso.TIPO_DIAS.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(12,11);      
    <% RSQUEYFECHAS__MMColParam3=(String)(((RSPERMISO_TIPOS_data = RSPERMISO_TIPOS.getObject("TIPO_DIAS"))==null || RSPERMISO_TIPOS.wasNull())?"":RSPERMISO_TIPOS_data);%>
 <%}  %>


<%   if (request.getParameter("ID_FUNCIONARIO") !=null) {
      session.putValue("MM_ID_FUNCIONARIO", RSFUNCIONARIO__MMColParam6  );
      session.putValue("MM_ID_FUNCIONARIO_NOMBRE", (((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("NOMBRE"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data));
      session.putValue("MM_ID_FUNCIONARIO_APE1", (((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("APE1"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data));
	  session.putValue("MM_ID_FUNCIONARIO_APE2", (((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("APE2"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data)); 
        } 
	  StatementRSQUEYFECHAS = ConnRSQUEYFECHAS.prepareStatement("SELECT DECODE('" + RSQUEYFECHAS__MMColParam3 + "','N',0, Contador_laboral) +DECODE('" + RSQUEYFECHAS__MMColParam3 + "','L',0,contador_natural) as Contador   from  (SELECT count(*) as contador_laboral,0 contador_natural from calendario_laboral where id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')   and laboral='SI' and id_dia not in (select id_dia  FROM festivos  WHERE id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')  and  reduccion=0)  union  select 0 contador_laboral,count(*) as contador_natural  FROM calendario_laboral where id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')  )  WHERE (        DECODE('" + RSQUEYFECHAS__MMColParam3 + "','N',0, Contador_laboral) <> 0 OR                        DECODE('" + RSQUEYFECHAS__MMColParam3 + "','L',0,contador_natural) <> 0       )");
	  
	   ResultSet RSQUEYFECHAS = StatementRSQUEYFECHAS.executeQuery();
boolean RSQUEYFECHAS_isEmpty = !RSQUEYFECHAS.next();
boolean RSQUEYFECHAS_hasData = !RSQUEYFECHAS_isEmpty;
Object RSQUEYFECHAS_data;
int RSQUEYFECHAS_numRows = 0;
   %>
   
   <%  if (!RSQUEYFECHAS_isEmpty)  {%>
   document.formPermiso.NUM_DIAS.value="<%=(((RSQUEYFECHAS_data = RSQUEYFECHAS.getObject("CONTADOR"))==null || RSQUEYFECHAS.wasNull())?"":RSQUEYFECHAS_data)%>";
  <%  } else { %>
	document.formPermiso.NUM_DIAS.value="1";
  <%  } %>

}
// -->
</script>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<body OnLoad="carga_final()">
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
                            <td bgcolor="#FFFFFF" align="right"><a href="../alta_result.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                          <form method="get" action="<%=MM_editAction%>" name="formPermiso">
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
                                    <td>&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                  </tr>
                                </table>
                              </td>
                              <td bgcolor="#E0E0E0" valign="top" align="right"><b> 
                                <input type="hidden" name="ID_PERMISO">
                                <%= "<input type='hidden' name='ID_FUNCIONARIO' value='" + session.getValue("MM_ID_FUNCIONARIO") + "'>" %> 
                                <input type="hidden" name="ANULADO" value="NO">
                                <input type="hidden" name="FECHA_ANULACION">
                                <%= "<input type='hidden' name='ID_USUARIO' value='" + session.getValue("MM_ID_USUARIO") + "'>" %> 
                                <input type="hidden" name="FECHA_MODI">
                                Formulario de Alta</b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                <table align="center" cellpadding="2" cellspacing="1" border="0" width="100%">
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">A&ntilde;o:</td>
                                    <td width="75%" colspan="6"> 
                                      <input type="text" name="ID_ANO" value="<%= RSPERMISO_TIPOS__MMColParam1%>" size="6" maxlength="4">
                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Tipo 
                                      de Permiso:</td>
                                    <td width="75%" colspan="6"> 
                                      <input type="hidden" name="ID_TIPO_PERMISO" value="01000" size="16" maxlength="15">
                                      <select name="MENU_TIPO_PERMISO" onChange="document.formPermiso.ID_TIPO_PERMISO.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(0,5);document.formPermiso.ID_TIPO_DIAS.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(12,11)";">
                                        <% while (RSTIPOPERMISO_hasData) {
%>
                                        <%= "<option value='" %><%= (((RSTIPOPERMISO_data = RSTIPOPERMISO.getObject("ID_TIPO_PERMISO"))==null || RSTIPOPERMISO.wasNull())?"":RSTIPOPERMISO_data) %><%= "'>" %> <%= (((RSTIPOPERMISO_data = RSTIPOPERMISO.getObject("ID_TIPO_PERMISO2"))==null || RSTIPOPERMISO.wasNull())?"":RSTIPOPERMISO_data) %><%= " - " %> <%= RSTIPOPERMISO_data= RSTIPOPERMISO.getObject("DESC_TIPO_PERMISO") %> <%= "</option>" %> 
                                        <%  RSTIPOPERMISO_hasData = RSTIPOPERMISO.next();
}
RSTIPOPERMISO.close();
RSTIPOPERMISO = StatementRSTIPOPERMISO.executeQuery();
RSTIPOPERMISO_hasData = RSTIPOPERMISO.next();
RSTIPOPERMISO_isEmpty = !RSTIPOPERMISO_hasData;
%>
                                      </select>
                                      <input type="hidden" name="TIPO_DIAS" value="N" size="16" maxlength="15">
                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Fecha 
                                      Inicio:</td>
                                    <td valign="middle"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="25%"> 
                                            <input type="text" name="FECHA_INICIO" value="<%=RSQUEYFECHAS__MMColParam1 %>" onChange="document.formPermiso.FECHA_FIN.value=document.formPermiso.FECHA_INICIO.value;" size="15" maxlength="10">
</td>
                                          <td width="22%"><a href="javascript:show_Calendario('formPermiso.FECHA_INICIO');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>
                                    </td>
                                    <td align="right">Fecha Fin:</td>
                                    <td colspan="4" align="left"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="31%"> 
                                            <input type="text" name="FECHA_FIN" value="<%=RSQUEYFECHAS__MMColParam2 %>" size="15" maxlength="10">
                                          </td>
                                          <td width="22%"><a href="javascript:show_Calendario('formPermiso.FECHA_FIN');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>
                                      <div align="left"></div></td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Tipo de D&iacute;as:</td>
                                    <td><select name="ID_TIPO_DIAS">
                                      <option value="L">LABORAL</option>
                                      <option value="N">NATURAL</option>
                                    </select> 
                                    </td>
                                    <td align="right" nowrap><input type="button" name="Submit" value="Pulsar para calculo Nº Días" onClick="window.location='alta.jsp?FECHA_INICIO=' + document.formPermiso.FECHA_INICIO.value +'&FECHA_FIN=' +  document.formPermiso.FECHA_FIN.value +'&ID_TIPO_DIAS=' + document.formPermiso.ID_TIPO_DIAS.value +'&ID_TIPO_PERMISO='+document.formPermiso.ID_TIPO_PERMISO.value  + '&ID_ANO=' +document.formPermiso.ID_ANO.value " ></td>
                                    <td nowrap><div align="right">N&uacute;mero D&iacute;as: </div></td>
                                    <td colspan="3">                                    <input type="text" name="NUM_DIAS" value="1" size="5" maxlength="5"></td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Justificado:</td>
                                    <td colspan="6"> 
                                      <select name="JUSTIFICADO">
                                        <option value="NO">NO</option>
                                        <option value="SI">SI</option>
                                        <option value="--" selected>--</option>
                                      </select>
                                    </td>
                                  </tr>
                  <% if (RSQUEYFECHAS__MMColParam4.equals("04000")  || RSQUEYFECHAS__MMColParam4.equals("04500") || RSQUEYFECHAS__MMColParam4.equals("06100") ) {%>                     
                           <tr bgcolor="#f2f2f2">
                              <% if (RSQUEYFECHAS__MMColParam4.equals("06100") ) { %>
                                    <td nowrap align="right"></td>
									<td colspan="4"></td>
           						<% } else { %>
									<td nowrap align="right">Grado:</td>
                                     <td colspan="4"><select name="GRADO" onChange="document.formPermiso.OBSERVACIONES.value=document.formPermiso.GRADO.options[selectedIndex].text">
                                      <option value="4">Padres / Padres politicos 4 días(Enfermedad o Muerte)</option>
                                      <option value="5">Hijos / Hijos Politicos /Conyuge 5 Días (Enfermedad o Muerte)</option>
                                      <option value="2">Abuelos/Hermanos/Nietos 2 Días(Enfermedad o Muerte)</option>
                                      <option value="1">Abuelos/Hermanos politicos 1 Día(Enfermedad)</option>
									  <option value="2">Abuelos/Hermanos politicos 2 Días(Muerte)</option>
									  <option value="1">Tios/sobrinos carnales o c. del conyugue 1 Día(Enfermedad o Muerte)</option>
                                    </select></td>
                               
	                          <% } %>
                                    <td>D/P:</td>
                                    <td><select name="DPROVINCIA">
                                      <option value="NO" selected>NO</option>
                                      <option value="SI">SI</option>
                                                                                                                                                                                    </select></td>
                                  </tr>
                   <% }%>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%" bgcolor="#f2f2f2" valign="middle">Observaciones:</td>
                                    <td width="75%" colspan="6" valign="baseline"> 
                                      <textarea name="OBSERVACIONES" cols="60" rows="3"></textarea>
                                    </td>
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
RSQUERY.close();
ConnRSQUERY.close();
%>
<%
RSTIPOPERMISO.close();
ConnRSTIPOPERMISO.close();
%>
<%
RSQUEYFECHAS.close();
ConnRSQUEYFECHAS.close();
%>
<%
RSFUNCIONARIO.close();
ConnRSFUNCIONARIO.close();
%>
<%
RSPERMISO_TIPOS.close();
ConnRSPERMISO_TIPOS.close();
%>
