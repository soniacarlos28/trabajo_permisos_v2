<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@ include file="../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%><% String RSIMPAR="";
   String RSCOLOR="";

%>
<%
String RSQUERY__MMColParam17 = "AZQSQ";
if (request.getParameter("ID_USUARIO")   !=null) {RSQUERY__MMColParam17 = (String)request.getParameter("ID_USUARIO")  ;}
%>
<%
String RSQUERY__MMColParam1 = "2";
if (request.getParameter("ID_USUARIO")   !=null) {RSQUERY__MMColParam1 = (String)request.getParameter("ID_USUARIO")  ;}
%>
<%
String RSQUERY__MMColParam2 = "1";
if (request.getParameter("APE1")   !=null) {RSQUERY__MMColParam2 = (String)request.getParameter("APE1")  ;}
%>
<%
String RSQUERY__MMColParam3 = "2";
if (request.getParameter("APE2")   !=null) {RSQUERY__MMColParam3 = (String)request.getParameter("APE2")  ;}
%>
<%
String RSQUERY__MMColParam4 = "3";
if (request.getParameter("NOMBRE")   !=null) {RSQUERY__MMColParam4 = (String)request.getParameter("NOMBRE")  ;}
%>
<%
String RSQUERY__MMColParam5 = "4";
if (request.getParameter("DNI")   !=null) {RSQUERY__MMColParam5 = (String)request.getParameter("DNI")  ;}
%>
<%
String RSQUERY__MMColParam6 = "e";
if (request.getParameter("DNI_LETRA")   !=null) {RSQUERY__MMColParam6 = (String)request.getParameter("DNI_LETRA")  ;}
%>
<%
String RSQUERY_SQL = "SELECT distinct pe.ID_FUNCIONARIO as ID_FUNCIONARIO, INITCAP(APE1) AS APE1, INITCAP(APE2) AS APE2,  INITCAP(NOMBRE) AS NOMBRE,           DESC_TIPO_FUNCIONARIO,       FECHA_INGRESO,            FECHA_BAJA,       DECODE(nvl(FECHA_BAJA-sysdate,0),'0','0','1') as ESTADO_BAJA   FROM PERSONAL_NEW PE,TR_TIPO_FUNCIONARIO TR  WHERE 1 = 1 and TIPO_FUNCIONARIO2=tr.id_tipo_funcionario and pe.ID_FUNCIONARIO ||  UPPER(NOMBRE)  ||' ' ||  UPPER(APE1) || ' ' ||    upper(APE2) ||   upper(lpad(dni,8,'0')) || upper(dni_letra)||     UPPER(DESC_TIPO_FUNCIONARIO) like upper('%" + RSQUERY__MMColParam17 + "%')  ";
RSQUERY_SQL += " order by estado_baja, ape1,ape2,nombre";
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
//PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT ID_FUNCIONARIO, INITCAP(APE1) AS APE1, INITCAP(APE2) AS APE2, INITCAP(NOMBRE) AS NOMBRE, ID_FUNCIONARIO, FECHA_INGRESO, ACTIVO, JORNADA, NUMERO_SS, DECODE(TIPO_FUNCIONARIO,'N','Funcionario de la Administración','B','Bomberos','P','POLICIA',' ') as TIPO_FUNCIONARIO  FROM RRHH.PERSONAL  WHERE ID_FUNCIONARIO = '" + RSQUERY__MMColParam1 + "' AND APE1 LIKE '" + RSQUERY__MMColParam2 + "%' AND APE2 LIKE '" + RSQUERY__MMColParam3 + "%' AND NOMBRE LIKE '" + RSQUERY__MMColParam4 + "%' AND DNI = LPAD('" + RSQUERY__MMColParam5 + "',8,0) AND DNI_LETRA LIKE '" + RSQUERY__MMColParam6 + "%'");
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement(RSQUERY_SQL);
StatementRSQUERY.setFetchSize(10);
StatementRSQUERY.setQueryTimeout(0);
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
int Repeat1__numRows = 10;
int Repeat1__index = 0;
RSQUERY_numRows += Repeat1__numRows;
%>
<%
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

int RSQUERY_first = 1;
int RSQUERY_last  = 1;
int RSQUERY_total = -1;

if (RSQUERY_isEmpty) {
  RSQUERY_total = RSQUERY_first = RSQUERY_last = 0;
}

//set the number of rows displayed on this page
if (RSQUERY_numRows == 0) {
  RSQUERY_numRows = 1;
}
%>
<%
// *** Recordset Stats: if we don't know the record count, manually count them

if (RSQUERY_total == -1) {

  // count the total records by iterating through the recordset
    for (RSQUERY_total = 1; RSQUERY.next(); RSQUERY_total++);

  // reset the cursor to the beginning
  RSQUERY.close();
  RSQUERY = StatementRSQUERY.executeQuery();
  RSQUERY_hasData = RSQUERY.next();

  // set the number of rows displayed on this page
  if (RSQUERY_numRows < 0 || RSQUERY_numRows > RSQUERY_total) {
    RSQUERY_numRows = RSQUERY_total;
  }

  // set the first and last displayed record
  RSQUERY_first = Math.min(RSQUERY_first, RSQUERY_total);
  RSQUERY_last  = Math.min(RSQUERY_first + RSQUERY_numRows - 1, RSQUERY_total);
}
%>
<% String MM_paramName = ""; %>
<%
// *** Move To Record and Go To Record: declare variables

ResultSet MM_rs = RSQUERY;
int       MM_rsCount = RSQUERY_total;
int       MM_size = RSQUERY_numRows;
String    MM_uniqueCol = "";
          MM_paramName = "";
int       MM_offset = 0;
boolean   MM_atTotal = false;
boolean   MM_paramIsDefined = (MM_paramName.length() != 0 && request.getParameter(MM_paramName) != null);
%>
<%
// *** Move To Record: handle 'index' or 'offset' parameter

if (!MM_paramIsDefined && MM_rsCount != 0) {

  //use index parameter if defined, otherwise use offset parameter
  String r = request.getParameter("index");
  if (r==null) r = request.getParameter("offset");
  if (r!=null) MM_offset = Integer.parseInt(r);

  // if we have a record count, check if we are past the end of the recordset
  if (MM_rsCount != -1) {
    if (MM_offset >= MM_rsCount || MM_offset == -1) {  // past end or move last
      if (MM_rsCount % MM_size != 0)    // last page not a full repeat region
        MM_offset = MM_rsCount - MM_rsCount % MM_size;
      else
        MM_offset = MM_rsCount - MM_size;
    }
  }

  //move the cursor to the selected record
  int i;
  for (i=0; RSQUERY_hasData && (i < MM_offset || MM_offset == -1); i++) {
    RSQUERY_hasData = MM_rs.next();
  }
  if (!RSQUERY_hasData) MM_offset = i;  // set MM_offset to the last possible record
}
%>
<%
// *** Move To Record: if we dont know the record count, check the display range

if (MM_rsCount == -1) {

  // walk to the end of the display range for this page
  int i;
  for (i=MM_offset; RSQUERY_hasData && (MM_size < 0 || i < MM_offset + MM_size); i++) {
    RSQUERY_hasData = MM_rs.next();
  }

  // if we walked off the end of the recordset, set MM_rsCount and MM_size
  if (!RSQUERY_hasData) {
    MM_rsCount = i;
    if (MM_size < 0 || MM_size > MM_rsCount) MM_size = MM_rsCount;
  }

  // if we walked off the end, set the offset based on page size
  if (!RSQUERY_hasData && !MM_paramIsDefined) {
    if (MM_offset > MM_rsCount - MM_size || MM_offset == -1) { //check if past end or last
      if (MM_rsCount % MM_size != 0)  //last page has less records than MM_size
        MM_offset = MM_rsCount - MM_rsCount % MM_size;
      else
        MM_offset = MM_rsCount - MM_size;
    }
  }

  // reset the cursor to the beginning
  RSQUERY.close();
  RSQUERY = StatementRSQUERY.executeQuery();
  RSQUERY_hasData = RSQUERY.next();
  MM_rs = RSQUERY;

  // move the cursor to the selected record
  for (i=0; RSQUERY_hasData && i < MM_offset; i++) {
    RSQUERY_hasData = MM_rs.next();
  }
}
%>
<%
// *** Move To Record: update recordset stats

// set the first and last displayed record
RSQUERY_first = MM_offset + 1;
RSQUERY_last  = MM_offset + MM_size;
if (MM_rsCount != -1) {
  RSQUERY_first = Math.min(RSQUERY_first, MM_rsCount);
  RSQUERY_last  = Math.min(RSQUERY_last, MM_rsCount);
}

// set the boolean used by hide region to check if we are on the last record
MM_atTotal  = (MM_rsCount != -1 && MM_offset + MM_size >= MM_rsCount);
%>
<%
// *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

String MM_keepBoth,MM_keepURL="",MM_keepForm="",MM_keepNone="";
String[] MM_removeList = { "index", MM_paramName };

// create the MM_keepURL string
if (request.getQueryString() != null) {
  MM_keepURL = '&' + request.getQueryString();
  for (int i=0; i < MM_removeList.length && MM_removeList[i].length() != 0; i++) {
  int start = MM_keepURL.indexOf(MM_removeList[i]) - 1;
    if (start >= 0 && MM_keepURL.charAt(start) == '&' &&
        MM_keepURL.charAt(start + MM_removeList[i].length() + 1) == '=') {
      int stop = MM_keepURL.indexOf('&', start + 1);
      if (stop == -1) stop = MM_keepURL.length();
      MM_keepURL = MM_keepURL.substring(0,start) + MM_keepURL.substring(stop);
    }
  }
}

// add the Form variables to the MM_keepForm string
if (request.getParameterNames().hasMoreElements()) {
  java.util.Enumeration items = request.getParameterNames();
  while (items.hasMoreElements()) {
    String nextItem = (String)items.nextElement();
    boolean found = false;
    for (int i=0; !found && i < MM_removeList.length; i++) {
      if (MM_removeList[i].equals(nextItem)) found = true;
    }
    if (!found && MM_keepURL.indexOf('&' + nextItem + '=') == -1) {
      MM_keepForm = MM_keepForm + '&' + nextItem + '=' + java.net.URLEncoder.encode(request.getParameter(nextItem));
    }
  }
}

// create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL + MM_keepForm;
if (MM_keepBoth.length() > 0) MM_keepBoth = MM_keepBoth.substring(1);
if (MM_keepURL.length() > 0)  MM_keepURL = MM_keepURL.substring(1);
if (MM_keepForm.length() > 0) MM_keepForm = MM_keepForm.substring(1);
%>
<%
// *** Move To Record: set the strings for the first, last, next, and previous links

String MM_moveFirst,MM_moveLast,MM_moveNext,MM_movePrev;
{
  String MM_keepMove = MM_keepBoth;  // keep both Form and URL parameters for moves
  String MM_moveParam = "index=";

  // if the page has a repeated region, remove 'offset' from the maintained parameters
  if (MM_size > 1) {
    MM_moveParam = "offset=";
    int start = MM_keepMove.indexOf(MM_moveParam);
    if (start != -1 && (start == 0 || MM_keepMove.charAt(start-1) == '&')) {
      int stop = MM_keepMove.indexOf('&', start);
      if (start == 0 && stop != -1) stop++;
      if (stop == -1) stop = MM_keepMove.length();
      if (start > 0) start--;
      MM_keepMove = MM_keepMove.substring(0,start) + MM_keepMove.substring(stop);
    }
  }

  // set the strings for the move to links
  StringBuffer urlStr = new StringBuffer(request.getRequestURI()).append('?').append(MM_keepMove);
  if (MM_keepMove.length() > 0) urlStr.append('&');
  urlStr.append(MM_moveParam);
  MM_moveFirst = urlStr + "0";
  MM_moveLast  = urlStr + "-1";
  MM_moveNext  = urlStr + Integer.toString(MM_offset+MM_size);
  MM_movePrev  = urlStr + Integer.toString(Math.max(MM_offset-MM_size,0));
}
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
<title>Resultados de la b&uacute;squeda - Administrac&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="#" id="current">Permisos/Ausencias</a></li>
     <li><a href="Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
   
     <li><a href="Finger_apl/index.jsp"  class="ah12b">Finger</a></li>
    <li><a href="Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
      <li><a href="Listados" >Sin Justificar</a></li> 
    <li><a href="Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
 <li><a href="calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
 <li><a href="Bajas/index.jsp" >Bajas Fichero</a></li>
  <li><a href="Informes/index_informes.jsp" >Informes</a></li>
<li><a href="Formacion/index_formacion.jsp" >Formacion</a></li>
<li><a href="Carga_nomina/carga.jsp"  >Carga Nominas</a></li>

  </ul>
  </div>
  <div id="form">
  <table cellspacing=0 border=0 cellpadding="0" width="95%">
  <tr> 
    <td valign=top align="center"> 
      <table cellspacing=0 cellpadding=0 border=0 width="100%">
        <tr> 
          <td valign=top colspan="2"><img src="../imagen/1x1.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td valign=top align="center">             
            <table cellspacing=0 cellpadding=4 width=100% border=0>
             
              <tbody> 
              <tr> 
                <td bgcolor=#EEEEEE colspan="2" class="va10w"> Se busc&oacute;: 
                  <b><%= RSQUERY__MMColParam17 %>  ( en rojo si la persona tiene fecha baja)</b></td>
                <td bgcolor=#EEEEEE class="va10w" align="right" valign="bottom">Resultados 
                  <%=(RSQUERY_first)%> - <%=(RSQUERY_last)%> de un total de <%=(RSQUERY_total)%> empleados.</td>
              </tr>
              </tbody> 
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#f2f2f2"> 
                  <table width="100%" border="0" cellspacing="1" cellpadding="2">
                    <tr bgcolor="#CCCCCC"> 
                      <td class="va10b" align="center" width="10%">Funcionario</td>
                      <td class="va10b" width="15%">Nombre</td>
                      <td class="va10b" width="15%">Apellido 1&ordm;</td>
                      <td class="va10b" width="10%">Apellido 2&ordm;</td>
                      <td class="va10b" bgcolor="#CCCCCC" align="center" width="15%">Tipo</td>
                      <td class="va10b" align="center" width="8%">Fecha Ingreso</td>
                       <td class="va10b" align="center" width="7%">Fecha Baja</td>
                      <td class="va10b" align="center" width="15%">Unidad</td>
                      
                    </tr>
                    <% while ((RSQUERY_hasData)&&(Repeat1__numRows-- != 0)) { %>
                    <%   RSIMPAR =  (String) (((RSQUERY_data = RSQUERY.getObject("ESTADO_BAJA"))==null || RSQUERY.wasNull())?"":RSQUERY_data); 
                            	     if (RSIMPAR.equals("1") )  
                                     	 RSCOLOR="bgcolor=\"#FAD2D2\"";                     	
    				               else 	                   
                                          RSCOLOR="";   
							  	  
							  	  %> 
                                        
                    <tr bgcolor="#FFFFFF"> 
                      <td <%= RSCOLOR %> align="center" width="10%"><%= "<a href='Datos/index.jsp?ID_FUNCIONARIO=" + (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&NOMBRE=" + (((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE1=" + (((RSQUERY_data = RSQUERY.getObject("APE1"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE2=" + (((RSQUERY_data = RSQUERY.getObject("APE2"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'>" %><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td <%= RSCOLOR %> width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td <%= RSCOLOR %> width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("APE1"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td <%= RSCOLOR %> width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("APE2"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td <%= RSCOLOR %> align="center" width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("DESC_TIPO_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td <%= RSCOLOR %> align="center" width="8%"><%= DoDateTime((((RSQUERY_data = RSQUERY.getObject("FECHA_INGRESO"))==null || RSQUERY.wasNull())?"":RSQUERY_data), java.text.DateFormat.SHORT, java.util.Locale.UK) %></td>
                       <td <%= RSCOLOR %> align="center" width="7%"><%= DoDateTime((((RSQUERY_data = RSQUERY.getObject("FECHA_BAJA"))==null || RSQUERY.wasNull())?"":RSQUERY_data), java.text.DateFormat.SHORT, java.util.Locale.UK) %></td>                    
                      
                    </tr>
                    <%
  Repeat1__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                  </table>
                </td>
              </tr>
            </table>
            <table border="0" width="25%" cellpadding="2" cellspacing="2">
              <tr> 
                <td width="23%" align="center"> 
                  <% if (MM_offset !=0) { %>
                  <a href="<%=MM_moveFirst%>"><img src="../imagen/First.gif" border=0></a> 
                  <% } /* end MM_offset != 0 */ %>
                </td>
                <td width="31%" align="center"> 
                  <% if (MM_offset !=0) { %>
                  <a href="<%=MM_movePrev%>"><img src="../imagen/Previous.gif" border=0></a> 
                  <% } /* end MM_offset != 0 */ %>
                </td>
                <td width="23%" align="center"> 
                  <% if (!MM_atTotal) { %>
                  <a href="<%=MM_moveNext%>"><img src="../imagen/Next.gif" border=0></a> 
                  <% } /* end !MM_atTotal */ %>
                </td>
                <td width="23%" align="center"> 
                  <% if (!MM_atTotal) { %>
                  <a href="<%=MM_moveLast%>"><img src="../imagen/Last.gif" border=0></a> 
                  <% } /* end !MM_atTotal */ %>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td valign=top> 
            
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
  </div>

</body>
</html>
<%
RSQUERY.close();
ConnRSQUERY.close();
%>
