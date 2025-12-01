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
  MM_editAction += "?" + request.getQueryString();
}
String consulta = null;
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
    request.getParameter("MM_update").toString().equals("formBolsa") &&
    request.getParameter("MM_recordId") != null) {

  MM_editDriver     = MM_RRHH_DRIVER;
  MM_editConnection = MM_RRHH_STRING;
  MM_editUserName   = MM_RRHH_USERNAME;
  MM_editPassword   = MM_RRHH_PASSWORD;
  MM_editTable  = "BOLSA_FUNCIONARIO";
  MM_editColumn = "ID_REGISTRO";
  MM_recordId   = "" + request.getParameter("MM_recordId") + "";
  MM_editRedirectUrl = "index.jsp";
  String MM_fieldsStr ="ID_USUARIO|value|ID_ACUMULADOR|value|PENAL_ENERO|value|PENAL_ENERO_MAS|value|PENAL_FEBRERO|value|PENAL_MARZO|value|PENAL_ABRIL|value|PENAL_MAYO|value|PENAL_JULIO|value|PENAL_AGOSTO|value|PENAL_SEPTIEMBRE|value|PENAL_OCTUBRE|value|PENAL_NOVIEMBRE|value|PENAL_DICIEMBRE|value|PENAL_JUNIO|value";
  String MM_columnsStr = "ID_USUARIO|',none,''|ID_ACUMULADOR|',none,''|PENAL_ENERO|',none,''|PENAL_ENERO_MAS|',none,''|PENAL_FEBRERO|',none,''|PENAL_MARZO|',none,''|PENAL_ABRIL|',none,''|PENAL_MAYO|',none,''|PENAL_JULIO|',none,''||PENAL_AGOSTO|',none,''|PENAL_SEPTIEMBRE|',none,''|PENAL_OCTUBRE|',none,''|PENAL_NOVIEMBRE|',none,''|PENAL_DICIEMBRE|',none,''|PENAL_JUNIO||',none,''";



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
  
 
  consulta = (String)MM_editQuery.toString();
  out.println(consulta);
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
String BOLSA_FUN__MMColParam1 = "000000";
if (session.getAttribute("MM_ID_FUNCIONARIO")           !=null) {BOLSA_FUN__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")          ;}
%>
<%
String BOLSA_FUN__MMColParam2 = "00";
if (request.getParameter("PERIODO") !=null) {BOLSA_FUN__MMColParam2 = (String)request.getParameter("PERIODO");}
%>
<%
Driver DriverBOLSA_FUN = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnBOLSA_FUN = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementBOLSA_FUN = ConnBOLSA_FUN.prepareStatement("select 1 as BOLSA from bolsa_FUNCIONARIO WHERE  id_funcionario = '" + BOLSA_FUN__MMColParam1 + "' and id_ano = DECODE('" + BOLSA_FUN__MMColParam2 + "' ,'00', to_char(sysdate-45, 'yyyy'),'" + BOLSA_FUN__MMColParam2 + "')     ");
ResultSet BOLSA_FUN = StatementBOLSA_FUN.executeQuery();
boolean BOLSA_FUN_isEmpty = !BOLSA_FUN.next();
boolean BOLSA_FUN_hasData = !BOLSA_FUN_isEmpty;
Object BOLSA_FUN_data;
int BOLSA_FUN_numRows = 0;
%>
<%
String SALDO__MMColParam1 = "000000";
if (session.getAttribute("MM_ID_FUNCIONARIO")           !=null) {SALDO__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")          ;}
%>
<%
String SALDO__MMColParam2 = "00";
if (request.getParameter("PERIODO") !=null) {SALDO__MMColParam2 = (String)request.getParameter("PERIODO");}
%>
<%
Driver DriverSALDO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnSALDO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementSALDO = ConnSALDO.prepareStatement("select DECODE(sign(NVL(trunc(sum(HORAS_EXCESOS * 60 + horas_minutos) / 60), 0)),-1,'<font color=\"#FF0000\">' || trunc(sum(HORAS_EXCESOS * 60 + horas_minutos) / 60) || ' Horas ' || mod(sum(HORAS_EXCESOS * 60 + horas_minutos), 60) || ' Min</font>', DECODE(sign(NVL(mod(sum(HORAS_EXCESOS * 60 + horas_minutos), 60), 0)),-1,'<font color=\"#FF0000\">' ||  trunc(sum(HORAS_EXCESOS * 60 + horas_minutos) / 60) || ' Horas ' ||  mod(sum(HORAS_EXCESOS * 60 + horas_minutos), 60) || ' Min</font>','<font color=\"#000000\">' ||  trunc(sum(HORAS_EXCESOS * 60 + horas_minutos) / 60) ||' Horas ' || mod(sum(HORAS_EXCESOS * 60 + horas_minutos), 60) || ' Min</font>')) as saldo  from bolsa_saldo  WHERE id_funcionario = '" + SALDO__MMColParam1 + "' and id_ano = DECODE('" + SALDO__MMColParam2 + "','00',to_char(sysdate-45, 'yyyy'),'" + SALDO__MMColParam2 + "')  ");
ResultSet SALDO = StatementSALDO.executeQuery();
boolean SALDO_isEmpty = !SALDO.next();
boolean SALDO_hasData = !SALDO_isEmpty;
Object SALDO_data;
int SALDO_numRows = 0;
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT DISTINCT id_ANO AS PERIODO  from bolsa_saldo order by 1 desc");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>
<%
String RSM_MOV__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RSM_MOV__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSM_MOV__MMColParam2 = "00";
if (request.getParameter("PERIODO")   !=null) {RSM_MOV__MMColParam2 = (String)request.getParameter("PERIODO")  ;}
%>
<%
Driver DriverRSM_MOV = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSM_MOV = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSM_MOV = ConnRSM_MOV.prepareStatement("select id_funcionario,id_ano, p_enero_sa, p_febrero_sa, p_marzo_sa, p_abril_sa, p_mayo_sa, p_junio_sa, p_julio_sa, p_agosto_sa, p_septiembre_sa, p_octubre_sa, p_noviembre_sa,  p_diciembre_sa, p_ene_mas_sa ,saldos_positivos,saldos_negativos from RESUMEN_SALDO_BOLSA WHERE id_funcionario = '" + RSM_MOV__MMColParam1+ "' and id_ano = DECODE('" + RSM_MOV__MMColParam2 + "','00', to_char(sysdate-45, 'yyyy'),'" + RSM_MOV__MMColParam2 + "')  order by id_funcionario");

ResultSet RSM_MOV = StatementRSM_MOV.executeQuery();
boolean RSM_MOV_isEmpty = !RSM_MOV.next();
boolean RSM_MOV_hasData = !RSM_MOV_isEmpty;
Object RSM_MOV_data;
int RSM_MOV_numRows = 0;
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
String MOV_BOL__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {MOV_BOL__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String MOV_BOL__MMColParam2 = "00";
if (request.getParameter("PERIODO")   !=null) {MOV_BOL__MMColParam2 = (String)request.getParameter("PERIODO")  ;}
%>
<%
Driver DriverMOV_BOL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnMOV_BOL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementMOV_BOL = ConnMOV_BOL.prepareStatement("select sysdate as fecha_hora,bf.id_registro,bf.id_funcionario,desc_motivo_acumular as tipo,ACUMULADOR,DECODE(penal_enero ,0,'NO','SI') as p_enero,DECODE(penal_enero_mas ,0,'NO','SI') as p_enero_mas,DECODE(penal_febrero,0,'NO','SI') as p_febrero,DECODE(penal_marzo,0,'NO','SI') as p_marzo,DECODE(penal_abril,0,'NO','SI') as p_abril,DECODE(penal_mayo,0,'NO','SI') as p_mayo,DECODE(penal_julio,0,'NO','SI') as p_julio,DECODE(penal_agosto,0,'NO','SI') as p_agosto,DECODE(penal_septiembre,0,'NO','SI') as p_septiembre,DECODE(penal_octubre,0,'NO','SI') as p_octubre,DECODE(penal_noviembre,0,'NO','SI') as p_noviembre,DECODE(penal_diciembre,0,'NO','SI') as p_diciembre,DECODE(penal_junio,0,'NO','SI') as p_junio,maximo_alcanzado,tope_horas || ' Horas ' as TOPE_HORAS,exceso_en_horas|| ' Horas '|| excesos_en_minutos || ' Min ' as Horas_productividad,DECODE(ACUMULADOR,2,exceso_en_horas|| ' Horas '|| excesos_en_minutos || ' Min ',DECODE(tope_horas-excesos_en_minutos,60,tope_horas-exceso_en_horas-decode(excesos_en_minutos,0,0,1),tope_horas-exceso_en_horas-decode(excesos_en_minutos,0,0,1)) || ' Horas '||DECODE(tope_horas- sign(excesos_en_minutos)*excesos_en_minutos ,60,0,60-sign(excesos_en_minutos)*excesos_en_minutos)  || ' Min ' )as Puede_acumular  from bolsa_funcionario bf,bolsa_tipo_acumulacion  bt,bolsa_movimiento bm WHERE bf.id_funcionario = '" + MOV_BOL__MMColParam1+ "' and bf.id_ano = DECODE('" + MOV_BOL__MMColParam2 + "' ,'00', to_char(sysdate-45, 'yyyy'),'" + MOV_BOL__MMColParam2 + "')  and bf.id_acumulador=bt.id_acumulador and bf.id_funcionario=bm.id_funcionario(+) and bf.id_ano= bm.id_ano(+) and       bm.id_tipo_movimiento(+)=4");
ResultSet MOV_BOL = StatementMOV_BOL.executeQuery();
boolean MOV_BOL_isEmpty = !MOV_BOL.next();
boolean MOV_BOL_hasData = !MOV_BOL_isEmpty;
Object MOV_BOL_data;
int MOV_BOL_numRows = 0;
%>




<%
int RSPERIODO__numRows = -1;
int RSPERIODOL__index = 0;
RSPERIODO_numRows += RSPERIODO__numRows;
%>
<%
int MOV_BOL__numRows = -1;
int MOV_BOL__index = 0;
MOV_BOL_numRows += MOV_BOL__numRows;
%>

<%
int BOLSA_FUN__numRows = -1;
int BOLSA_FUN__index = 0;
BOLSA_FUN_numRows += BOLSA_FUN__numRows;
%>

<%
int RSM_MOV__numRows = -1;
int RSM_MOV__index = 0;
RSM_MOV_numRows += RSM_MOV__numRows;
%>

<%
int SALDO__numRows = -1;
int SALDO__index = 0;
SALDO_numRows += SALDO__numRows;
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

<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
         
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li> 
     <li><a href="../../gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
       <li><a href="../../gestion/Bajas/index.jsp"  >Bajas Fichero</a></li>  
        <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
  </ul>
</div>
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
                                        <td>&nbsp;</td>                                        
                                        <td colspan="5"><div align="center"><strong>Saldo bolsa <font color="#000000"><%=(((SALDO_data = SALDO.getObject("SALDO"))==null || SALDO.wasNull())?"":SALDO_data)%></font></strong></div></td>
                                        <td colspan="2"><div align="right">
                                          <input type="submit" name="CANGELO" value="Guardar Bolsa">
                                        </div></td>
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
                                              <input type="hidden" name="ID_REGISTRO"  ID="ID_REGISTRO"  value="<%=(((MOV_BOL_data = MOV_BOL.getObject("ID_REGISTRO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%>">
                                             <input type="hidden" name="ID_USUARIO" value="<%= session.getValue("MM_ID_USUARIO") %>">
											 <%
						 java.text.SimpleDateFormat np_formatter = new java.text.SimpleDateFormat ("dd/MM/yyyy");
						 java.util.Date np_fecha = new java.util.Date();
						 String dateString = np_formatter.format(np_fecha);
						%>
            <input type="hidden" name="FECHA_MODI" value="<%= dateString %>">
                                            </div></td>
                                        <td colspan="2" align="center" bgcolor="#CCCCCC">&nbsp;</td>
                        </tr>
									   <tr>
									        <td width="5%" bgcolor="#66CCFF" align="center">Acumular </td>
                                            <td align="center" nowrap bgcolor="#66CCFF"><div align="left"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("PUEDE_ACUMULAR"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#66CCFF"><div align="right">Horas Productividad </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#66CCFF"><div align="left"><strong><font color="#000000">
                                             
                                               <%=(((MOV_BOL_data = MOV_BOL.getObject("HORAS_PRODUCTIVIDAD"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%>
                                            </font></strong></div></td>
                                            <td align="center" bgcolor="#66CCFF">Maximo</td>
                                         <td colspan="2" align="center" bgcolor="#66CCFF"><span class="va10b"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("TOPE_HORAS"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></span></td>
                                      </tr> 
                                      
                                      <tr>
									        <td width="5%" bgcolor="#99FF99" align="center">Periodo</td>
                                            <td align="center" bgcolor="#99FF99">Horas y minutos</td>
                                            <td align="center" bgcolor="#99FF99">Penalizacion</td>
                                            <td align="center" bgcolor="#99FF99">&nbsp;</td>
                                            <td align="center" bgcolor="#99FF99">&nbsp;</td>
                                            <td colspan="2" align="center" bgcolor="#99FF99">Horas y minutos</td>
                                        <td width="4%" bgcolor="#99FF99" align="center">Penalizacion</td>
									  </tr>
							   <% if (!RSM_MOV_isEmpty) { %>		  
									  <tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">01 Enero </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_ENERO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000">
                                                 <select name="PENAL_ENERO">
                                      <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_ENERO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                      <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_ENERO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                    </select>
                                            </font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">07 Julio </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_JULIO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000">
                                          <select name="PENAL_JULIO">
                                            <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_JULIO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                            <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_JULIO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                          </select>
                                        </font></strong></div></td>
									  </tr><tr>
									        <td width="5%" align="center" nowrap bgcolor="#CCCCCC"><div align="left">02 Febrero </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_FEBRERO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000"><select name="PENAL_FEBRERO">
                                      <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_FEBRERO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                      <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_FEBRERO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                    </select>
                                            </font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">08 Agosto </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_AGOSTO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000">
                                          <select name="PENAL_AGOSTO">
                                            <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_AGOSTO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                            <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_AGOSTO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                          </select>
                                        </font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">03 Marzo </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_MARZO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000"><select name="PENAL_MARZO">
                                      <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_MARZO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                      <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_MARZO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                    </select>
                                            </font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">09 Septiembre </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_SEPTIEMBRE_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000">
                                          <select name="PENAL_SEPTIEMBRE">
                                            <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_SEPTIEMBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                            <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_SEPTIEMBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                          </select>
                                        </font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">04 Abril </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_ABRIL_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000"><select name="PENAL_ABRIL">
                                      <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_ABRIL"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                      <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_ABRIL"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                    </select>
                                            </font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">10 Octubre</div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_OCTUBRE_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000">
                                          <select name="PENAL_OCTUBRE">
                                            <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_OCTUBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                            <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_OCTUBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                          </select>
                                        </font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">05 Mayo </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_MAYO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000">
<select name="PENAL_MAYO">
                                      <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_MAYO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                      <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_MAYO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                    </select>
                                            </font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" nowrap bgcolor="#CCCCCC"><div align="left">11 Noviembre </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_NOVIEMBRE_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000">
                                          <select name="PENAL_NOVIEMBRE">
                                            <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_NOVIEMBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                            <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_NOVIEMBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                          </select>
                                        </font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">06 Junio </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_JUNIO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000">
<select name="PENAL_JUNIO">
                                      <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_JUNIO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                      <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_JUNIO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                    </select>
                                            </font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">12 Diciembre </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_DICIEMBRE_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000">
                                          <select name="PENAL_DICIEMBRE">
                                            <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_DICIEMBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                            <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_DICIEMBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                          </select>
                                        </font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">13 Enero +1 </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_ENE_MAS_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000">
                                          <select name="PENAL_ENERO_MAS">
                                            <option value="1" <%=(("SI".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_ENERO_MAS"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>SI</option>
                                            <option value="0" <%=(("NO".toString().equals((((MOV_BOL_data = MOV_BOL.getObject("P_ENERO_MAS"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)))?"SELECTED":"")%>>NO</option>
                                          </select>
                                        </font></strong></div></td>
									  </tr><tr>
									        <td colspan="2" align="center" bgcolor="#CCCC66"><div align="left">Total positivos<strong><font color="#000000">&nbsp;<%=(((RSM_MOV_data = RSM_MOV.getObject("SALDOS_POSITIVOS"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCC66"><div align="left">Total negativos<strong><font color="#000000">&nbsp;<%=(((RSM_MOV_data = RSM_MOV.getObject("SALDOS_NEGATIVOS"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div>                                              <div align="right"></div></td>
                                            <td colspan="4" align="center" bgcolor="#CCCC66"><div align="right"><strong>Saldo  <font color="#000000"><%=(((SALDO_data = SALDO.getObject("SALDO"))==null || SALDO.wasNull())?"":SALDO_data)%></font></strong></div></td>
                                            </tr>
                                            <% } %>
											 <input type="hidden" name="MM_update" value="formBolsa">
                            <input type="hidden" name="MM_recordId" value="<%=(((MOV_BOL_data = MOV_BOL.getObject("ID_REGISTRO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%>"> 
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
RSPERIODO.close();
ConnRSPERIODO.close();
%>
<%
BOLSA_FUN.close();
ConnBOLSA_FUN.close();
%>
<%
SALDO.close();
ConnSALDO.close();
%>
<%
RSM_MOV.close();
ConnRSM_MOV.close();
%>
<%
MOV_BOL.close();
ConnMOV_BOL.close();
%>
<%
TIPO_BOLSA.close();
ConnTIPO_BOLSA.close();
%>

