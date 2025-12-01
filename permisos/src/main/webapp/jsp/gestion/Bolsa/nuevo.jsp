<%@page language="java" import="java.util.Date,java.sql.*,javax.swing.JOptionPane" %>
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
// *** Insert Record: set variables

if (request.getParameter("MM_insert") != null && request.getParameter("MM_insert").toString().equals("formBolsa")) {

  MM_editDriver     = MM_RRHH_DRIVER;
  MM_editConnection = MM_RRHH_STRING;
  MM_editUserName   = MM_RRHH_USERNAME;
  MM_editPassword   = MM_RRHH_PASSWORD;
  MM_editTable  = "BOLSA_FUNCIONARIO";
  MM_editRedirectUrl = "index.jsp";

  String MM_fieldsStr ="ID_ANO|value|MAXIMO_ALCANZADO|value|TOPE_HORAS|value|ID_FUNCIONARIO|value|ID_REGISTRO|value|ID_USUARIO|value|ID_ACUMULADOR|value|PENAL_ENERO|value|PENAL_ENERO_MAS|value|PENAL_FEBRERO|value|PENAL_MARZO|value|PENAL_ABRIL|value|PENAL_MAYO|value|PENAL_JULIO|value|PENAL_AGOSTO|value|PENAL_SEPTIEMBRE|value|PENAL_OCTUBRE|value|PENAL_NOVIEMBRE|value|PENAL_DICIEMBRE|value|PENAL_JUNIO|value|FECHA_MODI|value";
  String MM_columnsStr = "ID_ANO|',none,''|MAXIMO_ALCANZADO|',none,''|TOPE_HORAS|',none,''|ID_FUNCIONARIO|',none,''|ID_REGISTRO|',none,''|ID_USUARIO|',none,''|ID_ACUMULADOR|',none,''|PENAL_ENERO|',none,''|PENAL_ENERO_MAS|',none,''|PENAL_FEBRERO|',none,''|PENAL_MARZO|',none,''|PENAL_ABRIL|',none,''|PENAL_MAYO|',none,''|PENAL_JULIO|',none,''|PENAL_AGOSTO|',none,''|PENAL_SEPTIEMBRE|',none,''|PENAL_OCTUBRE|',none,''|PENAL_NOVIEMBRE|',none,''|PENAL_DICIEMBRE|',none,''|PENAL_JUNIO|',none,''|FECHA_MODI|',none,NULL";


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
      return;
    }
  }
}
%>

<%
Driver DriverMOV_BOL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnMOV_BOL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementMOV_BOL = ConnMOV_BOL.prepareStatement("select sec_id_bolsa.nextval as id_registro ,1 as ACUMULADOR ,to_char(sysdate,'YYYY') as ID_ANO, to_date('02/02' || to_char(sysdate,'YYYY')  ,'dd/mm/yyyy') as DT_START,to_date('03/02'|| to_char(to_number(to_char(sysdate,'YYYY'))+1),'dd/mm/yyyy') as DT_END from dual");
ResultSet MOV_BOL = StatementMOV_BOL.executeQuery();
boolean MOV_BOL_isEmpty = !MOV_BOL.next();
boolean MOV_BOL_hasData = !MOV_BOL_isEmpty;
Object MOV_BOL_data;
int MOV_BOL_numRows = 0;
%>


<%
int MOV_BOL__numRows = -1;
int MOV_BOL__index = 0;
MOV_BOL_numRows += MOV_BOL__numRows;
%>

<%
Driver DriverTIPO_BOLSA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnTIPO_BOLSA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementTIPO_BOLSA = ConnTIPO_BOLSA.prepareStatement("Select id_acumulador,desc_motivo_acumular from bolsa_tipo_acumulacion ");
ResultSet TIPO_BOLSA = StatementTIPO_BOLSA.executeQuery();
boolean TIPO_BOLSA_isEmpty = !TIPO_BOLSA.next();
boolean TIPO_BOLSA_hasData = !TIPO_BOLSA_isEmpty;
Object TIPO_BOLSA_data;
int TIPO_BOLSA_numRows = 0;
%>
<%
int TIPO_BOLSA__numRows = -1;
int TIPO_BOLSA__index = 0;
TIPO_BOLSA_numRows += TIPO_BOLSA__numRows;
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
      <li><a href="../../gestion/Bajas/index.jsp"  >Bajas Fichero</a></li>   
       <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
 </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>	
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa" id="current">Bolsa</a></li>
	  </ul>
  </div>
	<div id="subform">
	
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                                <tr>
                                  <td bgcolor="#E0E0E0" valign="top">
                                    <div align="right">
                                      <table border="0" cellspacing="0" cellpadding="2">
                                        <form name="formBotonera" method=post action="index.jsp">
                                          <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;</td>
                                          </tr>
                                        </form>
                                      </table>
                                  </div></td> 
                                  <td align="left" valign="top" bgcolor="#E0E0E0"><div align="right">
                                    <table border="0" cellspacing="0" cellpadding="2" width="100">
                                     
                                        <tr>
                                          <td>&nbsp;</td>
                                      </tr>
                                       
                                    </table>
                                  </div>                                  </tr>
                                <tr> 
                                  <td bgcolor="#E0E0E0" valign="top" colspan="2">
								       
                                    <table width="100%" border="0" cellspacing="1" cellpadding="4">
                      <form ACTION="<%=MM_editAction%>" METHOD="POST" name="formBolsa">  
						
                                      <tr bgcolor="#FFFFDD">                                      
                                        <td colspan="8"><div align="center"> <strong>Creaci&oacute;n de Bolsa </strong></div>                                          <div align="right"></div></td>                                        
                        </tr>
                                      <a name="bolsa" id="bolsa"></a> 
									  <tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center">Tipo</td>
                                            <td colspan="5" align="center" bgcolor="#CCCCCC"><div align="left">
                                              <select name="ID_ACUMULADOR">
          <%
while (TIPO_BOLSA_hasData) {
%>
 
<option value="<%=((TIPO_BOLSA.getObject("ID_ACUMULADOR")!=null)?TIPO_BOLSA.getObject("ID_ACUMULADOR"):"")%>" <%=(((TIPO_BOLSA.getObject("ID_ACUMULADOR")).toString().equals(((((MOV_BOL_data  = MOV_BOL.getObject("ACUMULADOR"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)).toString()))?"selected=\"selected\"":"")%> ><%=((TIPO_BOLSA.getObject("DESC_MOTIVO_ACUMULAR")!=null)?TIPO_BOLSA.getObject("DESC_MOTIVO_ACUMULAR"):"")%></option>    
          <%
             TIPO_BOLSA_hasData = TIPO_BOLSA.next();
           }
	     TIPO_BOLSA.close();
TIPO_BOLSA = StatementTIPO_BOLSA.executeQuery();
TIPO_BOLSA_hasData = TIPO_BOLSA.next();
TIPO_BOLSA_isEmpty = !TIPO_BOLSA_hasData;
%>
        </select>
                                              <input type="hidden" name="ID_REGISTRO"  id="ID_REGISTRO"  value="<%=(((MOV_BOL_data = MOV_BOL.getObject("ID_REGISTRO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%>">
                                              <input type="hidden" name="ID_USUARIO" value="<%= session.getValue("MM_ID_USUARIO") %>">
											 <%
						 java.text.SimpleDateFormat np_formatter = new java.text.SimpleDateFormat ("dd/MM/yyyy");
						 java.util.Date np_fecha = new java.util.Date();
						 String dateString = np_formatter.format(np_fecha);
						%>
            <input type="hidden" name="FECHA_MODI" value="<%= dateString %>">
			<input type="hidden" name="TOPE_HORAS" value="60">
    		<input type="hidden" name="MAXIMO_ACUMULAR" value="0">
			<input type="hidden" name="PENAL_ENERO" value="0">
    		<input type="hidden" name="PENAL_ENERO_MAS" value="0">
			<input type="hidden" name="PENAL_FEBRERO" value="0">
			<input type="hidden" name="PENAL_MARZO" value="0">
			<input type="hidden" name="PENAL_ABRIL" value="0">
			<input type="hidden" name="PENAL_MAYO" value="0">
			<input type="hidden" name="PENAL_JUNIO" value="0">
			<input type="hidden" name="PENAL_JULIO" value="0">
			<input type="hidden" name="PENAL_AGOSTO" value="0">
			<input type="hidden" name="PENAL_SEPTIEMBRE" value="0">
			<input type="hidden" name="PENAL_OCTUBRE" value="0">
			<input type="hidden" name="PENAL_NOVIEMBRE" value="0">
			<input type="hidden" name="PENAL_DICIEMBRE" value="0">
			<input type="hidden" name="ID_FUNCIONARIO" value="<%=session.getAttribute("MM_ID_FUNCIONARIO")%>">
            <input type="hidden" name="ID_ANO" value=<%=(((MOV_BOL_data = MOV_BOL.getObject("ID_ANO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%>>
            <input type="hidden" name="DT_START" value="">
            <input type="hidden" name="DT_END" value="">
                                            </div></td>
                                        <td colspan="2" align="center" bgcolor="#CCCCCC">&nbsp;</td>
                        </tr>
									   <tr>
									        <td colspan="8" align="center" bgcolor="#66CCFF"><input type="submit" name="CANGELO" value="Guardar Bolsa"></td>
                        </tr> 
											 <input type="hidden" name="MM_insert" value="formBolsa">
								   </form>  
                                    </table>  
	                              </td>
                                </tr>
                               
								  
      </table>
    </div>
</div>
</body>
</html>


<%
MOV_BOL.close();
ConnMOV_BOL.close();
%>
<%
TIPO_BOLSA.close();
ConnTIPO_BOLSA.close();
%>

