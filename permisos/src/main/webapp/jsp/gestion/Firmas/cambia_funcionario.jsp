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
  String queryString = request.getQueryString();
  String tempStr = "";
  for (int i=0; i < queryString.length(); i++) {
    if (queryString.charAt(i) == '<') tempStr = tempStr + "&lt;";
    else if (queryString.charAt(i) == '>') tempStr = tempStr + "&gt;";
    else if (queryString.charAt(i) == '"') tempStr = tempStr +  "&quot;";
    else tempStr = tempStr + queryString.charAt(i);
  }
  MM_editAction += "?" + tempStr;
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
    request.getParameter("MM_update").toString().equals("form1") &&
    request.getParameter("MM_recordId") != null) {

  MM_editDriver     = MM_RRHH_DRIVER;
  MM_editConnection = MM_RRHH_STRING;
  MM_editUserName   = MM_RRHH_USERNAME;
  MM_editPassword   = MM_RRHH_PASSWORD;
  MM_editTable  = "RRHH.FUNCIONARIO_FIRMA";
  MM_editColumn = "ID_FUNCIONARIO";
  MM_recordId   = "" + request.getParameter("MM_recordId") + "";
  MM_editRedirectUrl = "index.jsp";
  String MM_fieldsStr = "ID_JS|value|ID_DELEGADO_JS|value|ID_JA|value";
  String MM_columnsStr = "id_ver_plani_1|none,none,NULL|id_ver_plani_2|none,none,NULL|id_ver_plani_3|none,none,NULL";

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

String I_ID_FUNCIONARIO = "101216";
if(session.getValue("MM_ID_FUNCIONARIO") != null){ I_ID_FUNCIONARIO = (String)session.getValue("MM_ID_FUNCIONARIO");}

%>
<%
String RSQUERYJS__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")   !=null) {RSQUERYJS__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")  ;}
%>
<%
Driver DriverRSQUERYJS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERYJS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERYJS = ConnRSQUERYJS.prepareStatement("SELECT f.id_funcionario,lpad(id_ver_plani_1,6,' ') as id_js  ,pe.nombre || ' ' || pe.ape1 || ' ' || pe.ape2 as nombre  FROM personal_new pe, funcionario_firma f  WHERE f.id_funcionario='" + RSQUERYJS__MMColParam1 + "' and         pe.id_funcionario=id_ver_plani_1");
ResultSet RSQUERYJS = StatementRSQUERYJS.executeQuery();
boolean RSQUERYJS_isEmpty = !RSQUERYJS.next();
boolean RSQUERYJS_hasData = !RSQUERYJS_isEmpty;
Object RSQUERYJS_data;
int RSQUERYJS_numRows = 0;
%>
<%
String RSQUERYJA__MMColParam1 = "00000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSQUERYJA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
Driver DriverRSQUERYJA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERYJA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERYJA = ConnRSQUERYJA.prepareStatement("SELECT f.id_funcionario,lpad(id_ver_plani_3,6,' ') as id_ja  ,pe.nombre || ' ' || pe.ape1 || ' ' || pe.ape1  as nombre  FROM personal_new pe, funcionario_firma f  WHERE f.id_funcionario='" + RSQUERYJA__MMColParam1 + "' and         pe.id_funcionario=id_ver_plani_3");
ResultSet RSQUERYJA = StatementRSQUERYJA.executeQuery();
boolean RSQUERYJA_isEmpty = !RSQUERYJA.next();
boolean RSQUERYJA_hasData = !RSQUERYJA_isEmpty;
Object RSQUERYJA_data;
int RSQUERYJA_numRows = 0;
%>
<%
Driver DriverRSTODOS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTODOS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTODOS = ConnRSTODOS.prepareStatement("SELECT distinct id_f, nombre, ape  from (  SELECT  '0' as id_f, ' ' as nombre ,'AAAAA' as ape from dual UNION   SELECT lpad(id_funcionario, 6, ' ') as id_f,rpad(' ' || pe.ape1 || ' ' || pe.ape2 ||' ,'|| pe.nombre , 60, ' ') as nombre,ape1 || ape2 as ape FROM personal_new pe  where fecha_baja is null or fecha_baja > sysdate -60  ) ORDER BY ape");
ResultSet RSTODOS = StatementRSTODOS.executeQuery();
boolean RSTODOS_isEmpty = !RSTODOS.next();
boolean RSTODOS_hasData = !RSTODOS_isEmpty;
Object RSTODOS_data;
int RSTODOS_numRows = 0;
%>
<%
String RSFUNCIONARIO__MMColParam1 = "0000";
if (session.getValue("MM_ID_FUNCIONARIO")     !=null) {RSFUNCIONARIO__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")    ;}
%>
<%
Driver DriverRSFUNCIONARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFUNCIONARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFUNCIONARIO = ConnRSFUNCIONARIO.prepareStatement("SELECT distinct id_funcionario as id_funcionario  FROM personal_new  WHERE id_funcionario='" + RSFUNCIONARIO__MMColParam1 + "'");
ResultSet RSFUNCIONARIO = StatementRSFUNCIONARIO.executeQuery();
boolean RSFUNCIONARIO_isEmpty = !RSFUNCIONARIO.next();
boolean RSFUNCIONARIO_hasData = !RSFUNCIONARIO_isEmpty;
Object RSFUNCIONARIO_data;
int RSFUNCIONARIO_numRows = 0;
%>
<%
String RSDELEGADOJS__MMColParam1 = "00000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSDELEGADOJS__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
Driver DriverRSDELEGADOJS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSDELEGADOJS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSDELEGADOJS = ConnRSDELEGADOJS.prepareStatement("SELECT f.id_funcionario,lpad(id_ver_plani_2,6,' ') as id_delegado_js  ,pe.nombre || ' ' || pe.ape1 || ' ' || pe.ape2  as nombre  FROM personal_new pe, funcionario_firma f  WHERE f.id_funcionario='" + RSDELEGADOJS__MMColParam1 + "' and         pe.id_funcionario=id_ver_plani_2");
ResultSet RSDELEGADOJS = StatementRSDELEGADOJS.executeQuery();
boolean RSDELEGADOJS_isEmpty = !RSDELEGADOJS.next();
boolean RSDELEGADOJS_hasData = !RSDELEGADOJS_isEmpty;
Object RSDELEGADOJS_data;
int RSDELEGADOJS_numRows = 0;
%>
<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de RRHH - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
   <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
 <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
  </ul>
</div>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>
		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas" id="current">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
	</div>
	<div id="subform">
	<table width="95%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#E0E0E0"><table width="100%" border="0" cellspacing="5" cellpadding="0">
                              <form name="formPermiso" method="post" action="alta_result.jsp">
                                <tr>
                                  <td bgcolor="#E0E0E0" valign="top">
                                    <table border="0" cellspacing="0" cellpadding="2">
                                      <tr>
                                        <td>&nbsp;
                                        </td>
                                        <td>Funcionario:</td>
                                        <td>&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                      </tr>
                                  </table></td>
                                  <td bgcolor="#E0E0E0" valign="top" align="right"><b>                                    <%= "<input type='hidden' name='ID_FUNCIONARIO' value='" + session.getValue("MM_ID_FUNCIONARIO") + "'>" %>                                    <%= "<input type='hidden' name='ID_USUARIO' value='" + session.getValue("MM_ID_USUARIO") + "'>" %>
 Edita Firmas       </b></td>
                                </tr>
                                <tr>
                                  <td bgcolor="#E0E0E0" valign="top" colspan="2">                                    </td>
                                </tr>
                              </form>
                            </table></td>
                          </tr>
<tr><td><form name="form1" method="POST" action="<%=MM_editAction%>">
  <table width="100%"  border="0" cellspacing="2" cellpadding="4">
    <tr>
      <td colspan="3" bgcolor="#FFCCCC" scope="col"><div align="center">Personas que tienen  permiso <strong>SOLO PARA VER</strong> los permisos y ausencias de este funcionario, <strong>EN EL PLANIFICADOR</strong></div></td>
    </tr>
    <tr>
      <th nowrap scope="row"><div align="right">Persona 1 :</div></th>
      <td colspan="2" bgcolor="#FFFFFF">
   <%  if (!RSQUERYJS_isEmpty)
            { %>
        <input type="text" disabled="yes" ID="ID_JS_ID" size="8"   value=<%=(((RSQUERYJS_data = RSQUERYJS.getObject("ID_JS"))==null || RSQUERYJS.wasNull())?"":RSQUERYJS_data)%> >
      <input type="text" textcolor=#FFFFFF  ID="ID_JS_NOMBRE" size="35"   value="<%=(((RSQUERYJS_data = RSQUERYJS.getObject("NOMBRE"))==null || RSQUERYJS.wasNull())?"":RSQUERYJS_data)%>" >
      <input type="hidden" name="ID_JS" ID="ID_JS" size="6" value=<%=(((RSQUERYJS_data = RSQUERYJS.getObject("ID_JS"))==null || RSQUERYJS.wasNull())?"":RSQUERYJS_data)%> ><input type="button" name="" value="Cambiar"
      onClick="javascript:window.open('../Busqueda/index_busqueda_funcionario.jsp?CAMPO=ID_JS' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');"   >
        <%  } else { %>    
           <input type="text" disabled="yes" ID="ID_JS_ID" size="8"   value="" >
      <input type="text" textcolor=#FFFFFF  ID="ID_JS_NOMBRE" size="35"   value="" >
      <input type="hidden" name="ID_JS" ID="ID_JS" size="6" value="" ><input type="button" name="" value="Insertar"
      onClick="javascript:window.open('../Busqueda/index_busqueda_funcionario.jsp?CAMPO=ID_JS' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');"      > 
         <%  }  %>
      </td>
    </tr>
	
	 <tr>
      <th nowrap scope="row"><div align="right">Persona 2 :</div></th>       
      <td colspan="2" bgcolor="#FFFFFF">
      <%  if (!RSDELEGADOJS_isEmpty)
            { %>
        <input type="text" disabled="yes" ID="ID_DELEGADO_JS_ID" size="8"   value=<%=(((RSDELEGADOJS_data = RSDELEGADOJS.getObject("ID_DELEGADO_JS"))==null || RSDELEGADOJS.wasNull())?"":RSDELEGADOJS_data)%> >
      <input type="text" " ID="ID_DELEGADO_JS_NOMBRE" size="35"   value="<%=(((RSDELEGADOJS_data = RSDELEGADOJS.getObject("NOMBRE"))==null || RSDELEGADOJS.wasNull())?"":RSDELEGADOJS_data)%>" >
      <input type="hidden" name="ID_DELEGADO_JS" ID="ID_DELEGADO_JS" size="25" value=<%=(((RSDELEGADOJS_data = RSDELEGADOJS.getObject("ID_DELEGADO_JS"))==null || RSDELEGADOJS.wasNull())?"":RSDELEGADOJS_data)%>><input type="button" name="" value="Cambiar"
      onClick="javascript:window.open('../Busqueda/index_busqueda_funcionario.jsp?CAMPO=ID_DELEGADO_JS' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');"      > 
          <%  } else { %>    
      <input type="text" disabled="yes" ID="ID_DELEGADO_JS_ID" size="8"   value="" >
      <input type="text" " ID="ID_DELEGADO_JS_NOMBRE" size="35"   value="" >
      <input type="hidden" name="ID_DELEGADO_JS" ID="ID_DELEGADO_JS" size="25" value=""><input type="button" name="" value="Insertar"
      onClick="javascript:window.open('../Busqueda/index_busqueda_funcionario.jsp?CAMPO=ID_DELEGADO_JS' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');"      > 
     <%  }  %>
      </td>
    </tr>
	
    <tr>
      <th width="15%" scope="row"><div align="right">Persona 3 :</div></th>
       <td colspan="2" bgcolor="#FFFFFF">
      <%  if (!RSQUERYJA_isEmpty)
            { %>
         
         <input type="text" disabled="yes" ID="ID_JA_ID" size="8"   value=<%=(((RSQUERYJA_data = RSQUERYJA.getObject("ID_JA"))==null || RSQUERYJA.wasNull())?"":RSQUERYJA_data)%> >
      <input type="text"  ID="ID_JA_NOMBRE" size="35"   value="<%=(((RSQUERYJA_data = RSQUERYJA.getObject("NOMBRE"))==null || RSQUERYJA.wasNull())?"":RSQUERYJA_data)%>" >
      <input type="hidden" name="ID_JA"  ID="ID_JA" size="25" value=<%=(((RSQUERYJA_data = RSQUERYJA.getObject("ID_JA"))==null || RSQUERYJA.wasNull())?"":RSQUERYJA_data)%>><input type="button" name="" value="Cambiar"
      onClick="javascript:window.open('../Busqueda/index_busqueda_funcionario.jsp?CAMPO=ID_JA' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');"      >   
           <%  } else { %>       
            <input type="text" disabled="yes" ID="ID_JA_ID" size="8"   value="" >
      <input type="text"  ID="ID_JA_NOMBRE" size="35"   value="" >
      <input type="hidden" name="ID_JA"  ID="ID_JA" size="25" value=""><input type="button" name="" value="Insertar"
      onClick="javascript:window.open('../Busqueda/index_busqueda_funcionario.jsp?CAMPO=ID_JA' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');"      >   
     <%  }  %>
</div></td></tr>
    <tr>
      <th colspan="3" scope="row"><div align="center">
          <input type="submit" name="Submit2" value="Guardar Permisos sobre Planificador">
      </div></th>
    </tr>
  </table>
    
  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="<%=(((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("ID_FUNCIONARIO"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data)%>">
</form>
    </td></tr>
                      </table>
	
	</div>
	</div>
  <%
RSQUERYJS.close();
ConnRSQUERYJS.close();
%>
</body>
</html>
<%
RSQUERYJA.close();
StatementRSQUERYJA.close();
ConnRSQUERYJA.close();
%>
<%
RSTODOS.close();
ConnRSTODOS.close();
%>
<%
RSFUNCIONARIO.close();
StatementRSFUNCIONARIO.close();
ConnRSFUNCIONARIO.close();
%>
<%
RSDELEGADOJS.close();
StatementRSDELEGADOJS.close();
ConnRSDELEGADOJS.close();
%>
