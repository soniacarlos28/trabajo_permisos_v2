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
 //MM_editTable  = "RRHH.BORRA_TEST";
  MM_editRedirectUrl = "index.jsp";
  String MM_fieldsStr = "ID_ANO|value|ID_FUNCIONARIO|value|ID_TIPO_PERMISO|value|NUM_DIAS|value|ID_TIPO_DIAS|value|JUSTIFICADO|value|UNICO|value";
  String MM_columnsStr = "ID_ANO|none,none,NULL|ID_FUNCIONARIO|none,none,NULL|ID_TIPO_PERMISO|',none,''|NUM_DIAS|none,none,NULL|ID_TIPO_DIAS|',none,''|COMPLETO|',none,''|UNICO|',none,''";

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
String RSTIPOPERMISO__MMColParam1 = "-1";
if ( session.getValue("MM_ID_FUNCIONARIO") !=null) {RSTIPOPERMISO__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO");}
%>
<%
Driver DriverRSTIPOPERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPOPERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPOPERMISO = ConnRSTIPOPERMISO.prepareStatement("SELECT ID_TIPO_PERMISO || '--' || DECODE(JUSTIFICACION,'--','NO',JUSTIFICACION) || '--' || DECODE(TIPO_DIAS,'N','NATURAL','LABORAL')  || '--' || lpad(NUM_DIAS,3,'0')  || '--'|| unico AS ID_TIPO_PERMISO,   ID_TIPO_PERMISO AS ID_TIPO_PERMISO2,  DESC_TIPO_PERMISO  as  DESC_TIPO_PERMISO,TIPO_DIAS   ,NUM_DIAS           ,       DECODE(JUSTIFICACION,'SI','NO',JUSTIFICACION) as JUSTIFICACION  FROM RRHH.TR_TIPO_PERMISO  WHERE ID_ANO = (select   to_char(sysdate,'yyyy')  FROM personal_new  WHERE id_funcionario='" + RSTIPOPERMISO__MMColParam1 + "' and  rownum <2 )  ORDER BY id_tipo_permiso");
ResultSet RSTIPOPERMISO = StatementRSTIPOPERMISO.executeQuery();
boolean RSTIPOPERMISO_isEmpty = !RSTIPOPERMISO.next();
boolean RSTIPOPERMISO_hasData = !RSTIPOPERMISO_isEmpty;
Object RSTIPOPERMISO_data;
int RSTIPOPERMISO_numRows = 0;
%>
<%
String RSFUNCIONARIO__MMColParam6 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")   !=null) {RSFUNCIONARIO__MMColParam6 = (String)session.getValue("MM_ID_FUNCIONARIO")     ;}
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
int Repeat1__numRows = -1;
int Repeat1__index = 0;
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
<body><div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
     <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li> 
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
      <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>  
       <li><a href="gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
       <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
  </ul>
</div>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" id="current">Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>
		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
	</div>
	<div id="subform">
	
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
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
                                                                           <input type="button" value="Genera todos los permisos" name="Genera" onClick="window.location='genera_todos_permisos.jsp?ID_ANO=2025'" >
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
                                    <td nowrap align="right" width="20%">A&ntilde;o:</td>
                                    <td width="75%" colspan="3"> 
                                      <p> 
                                        <input type="text" name="ID_ANO"  value="2020" size="6" maxlength="4">
                                        <input type="text" name="ID_FUNCIONARIO" value="<%= session.getValue("MM_ID_FUNCIONARIO") %>" >
                                        <input type="hidden" name="ID_ANO2" value="2020" >
                                      </p>
                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Tipo 
                                      de Permiso:</td>
                                    <td width="75%" colspan="3"> 
                                      <input type="text" name="ID_TIPO_PERMISO" value="01000" size="16" maxlength="15">
                                      <select name="MENU_TIPO_PERMISO" onChange="
									     document.formPermiso.ID_TIPO_PERMISO.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(0,5);
										 document.formPermiso.JUSTIFICADO.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(9,7);
										 document.formPermiso.ID_TIPO_DIAS.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(12,11);
									     document.formPermiso.NUM_DIAS2.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(23,20);
										 document.formPermiso.UNICO.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(27,25);
										
										 document.formPermiso.JUSTIFICADO2.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(9,7);
										 document.formPermiso.ID_TIPO_DIAS2.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(18,11);
									     document.formPermiso.NUM_DIAS.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(23,20);
										 document.formPermiso.UNICO2.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(27,25)
										 ";">
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
                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" >Numero D&iacute;as:</td>
                                    <td width="25%"> 
                                      <input type="hidden" name="NUM_DIAS2"   size="4" maxlength="3">
                                      <input type="text"  name="NUM_DIAS"   size="4" maxlength="3">
                                    </td>
                                    <td width="25%" align="right">Tipo de D&iacute;as:</td>
                                    <td width="25%"> 
                                      <input type="hidden" name="ID_TIPO_DIAS" size="10" maxlength="5">
                                      <input type="text" disabled="yes" name="ID_TIPO_DIAS2" size="10" maxlength="5">
                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right">Justificado:</td>
                                    <td width="10%"> 
                                      <input type="hidden" name="JUSTIFICADO"  size="4" maxlength="5">
                                      <input type="text" disabled="yes" name="JUSTIFICADO2"  size="4" maxlength="5">
                                    </td>
                                    <td width="9%" align="right">Unico:</td>
                                    <td> 
                                      <input type="hidden" name="UNICO"  size="4" maxlength="5">
                                      <input type="text" disabled="yes" name="UNICO2"  size="4" maxlength="5">
                                    </td>
                                  </tr>
                                </table>
                                
<input type="hidden" name="MM_insert" value="formPermiso">

<script language="JavaScript">
document.formPermiso.MENU_TIPO_PERMISO.value = document.formPermiso.ID_TIPO_PERMISO.value;
</script>
                              </td>
                            </tr>
                          </form>
      </table>
	</div>
</div>
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
