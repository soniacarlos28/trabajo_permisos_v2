<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@ include file="../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT p.id_funcionario,APE1,APE2,NOMBRE,to_char(fecha_inicio_per,'DD/MM/YYYY') as F_INI_PER,  to_char(fecha_fin_per,'DD/MM/YYYY') as F_FIN_PER ,desc_tipo_permiso,  to_char(fecha_inicio_baj,'DD/MM/YYYY') as F_INI_BAJ,to_char(fecha_fin_baj,'DD/MM/YYYY') as F_FIN_BAJ ,ID_TIPO_BAJA  FROM conflicto_permiso_baja t ,TR_TIPO_PERMISO tr,personal_new p  WHERE t.id_tipo_permiso=tr.id_tipo_permiso and tr.id_ano=substr(to_char(sysdate,'DD/MM/YYYY'),7,4) and  p.id_funcionario=t.id_funcionario  ORDER BY fecha_inicio_baj desc");
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
<html>
<head>
<title>Resultados de la b&uacute;squeda - Administrac&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">

</head>
<body>


<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li ><a href="../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
     <li><a href="../gestion/Listados ">Listados Generales</a></li>
    <li><a href="" onClick="show_finger()">Finger</a></li>
    <li><a href="../gestion/Gestion/index.jsp">Horas Sindicales</a></li>  
    <li><a href="../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
  </ul>
  <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
  <%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
</div>
<div id="form">
<table cellspacing=0 border=0 cellpadding="0" width="95%">
  <tr> 
    <td valign=top align="center"> 
      <table cellspacing=0 cellpadding=0 border=0 width="100%">
        <tr> 
          <td valign=top colspan="2"><img src="../../imagen/1x1.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td valign=top align="center">             
            <table cellspacing=0 cellpadding=4 width=100% border=0>
              <tr> 
                <td> 
                  <form name="form1" method="get" action="resultb.jsp">
                    <input type="hidden" name="ID_USUARIO">
                  </form>
                </td>
                <td>&nbsp;</td>
                <td class="va10w" align="right" valign="bottom"><font face=arial color=#ffffff><b><font face="Arial, Helvetica, sans-serif" size="3" color="#003366">Administraci&oacute;n 
                  de RRHH - Coincidencias</font></b></font></td>
              </tr>
              <tbody> 
              <tr> 
                <td bgcolor=#003366 colspan="2" class="va10w"> <b>     </b></td>
                <td bgcolor=#003366 class="va10w" align="right" valign="bottom">Resultados 
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
                      <td colspan="3" align="center" class="va10b">Permiso</td>
                      <td colspan="3" align="center" bgcolor="#CCCCCC" class="va10b">Baja</td>
                    </tr>
                    <% while ((RSQUERY_hasData)&&(Repeat1__numRows-- != 0)) { %>
                    <tr bgcolor="#FFFFFF"> 
                      <td align="center" width="10%"><%= "<a href='gestion/Datos/index.jsp?ID_FUNCIONARIO=" + (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&NOMBRE=" + (((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE1=" + (((RSQUERY_data = RSQUERY.getObject("APE1"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE2=" + (((RSQUERY_data = RSQUERY.getObject("APE2"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'>" %><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td width="33%"><%=(((RSQUERY_data = RSQUERY.getObject("DESC_TIPO_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td width="7%"><%=(((RSQUERY_data = RSQUERY.getObject("F_INI_PER"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td width="8%"><%=(((RSQUERY_data = RSQUERY.getObject("F_FIN_PER"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td align="center" width="7%"><%=(((RSQUERY_data = RSQUERY.getObject("ID_TIPO_BAJA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td align="center" width="10%"><%=(((RSQUERY_data = RSQUERY.getObject("F_INI_BAJ"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td align="center" width="8%"><%=(((RSQUERY_data = RSQUERY.getObject("F_FIN_BAJ"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
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

