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
Driver DriverRSSINDICAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSSINDICAL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSSINDICAL = ConnRSSINDICAL.prepareStatement("SELECT DISTINCT     DECODE(substr(desc_tipo_ausencia,1,5),'HS CC', 1,                                         'HS UG', 2 ,                                        'HS CS', 3 ,                                        'HS SP', 4 ,5) as ordena,  DECODE(substr(desc_tipo_ausencia,1,5),'HS CC', substr(desc_tipo_ausencia,1,9),                                         'HS UG', substr(desc_tipo_ausencia,1,7),                                        'HS CS', substr(desc_tipo_ausencia,1,9),                                         'HS SP', substr(desc_tipo_ausencia,1,10),  5) as ordena2,                                                                              ID_TIPO_AUSENCIA ID_TIPO_AUSENCIA,  ID_TIPO_AUSENCIA||'--'|| SUBSTR((DESC_TIPO_AUSENCIA),1,40) as DESC_TIPO_AUSENCIA      FROM RRHH.TR_TIPO_AUSENCIA  WHERE ID_TIPO_AUSENCIA between '500' and '700' and TR_ANULADO='NO'  ORDER BY ordena, ordena2");
ResultSet RSSINDICAL = StatementRSSINDICAL.executeQuery();
boolean RSSINDICAL_isEmpty = !RSSINDICAL.next();
boolean RSSINDICAL_hasData = !RSSINDICAL_isEmpty;
Object RSSINDICAL_data;
int RSSINDICAL_numRows = 0;
%>
<%
String RSHORAS_MESES__MMColParam1 = "000";
if (request.getParameter("TIPO_AUSENCIA")  !=null) {RSHORAS_MESES__MMColParam1 = (String)request.getParameter("TIPO_AUSENCIA") ;}
%>
<%
Driver DriverRSHORAS_MESES = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSHORAS_MESES = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSHORAS_MESES = ConnRSHORAS_MESES.prepareStatement("SELECT sum(decode( ID_MES,1, trunc(total_horas/60,0),0)) as TOTAL_ENERO,            sum(decode( ID_MES,2, trunc(total_horas/60,0),0)) TOTAL_FEBRERO,            sum(decode( ID_MES,3, trunc(total_horas/60,0),0)) TOTAL_MARZO,            sum(decode( ID_MES,4, trunc(total_horas/60,0),0)) TOTAL_ABRIL,            sum(decode( ID_MES,5, trunc(total_horas/60,0),0)) TOTAL_MAYO,           sum(decode( ID_MES,6, trunc(total_horas/60,0),0)) as TOTAL_JUNIO,            sum(decode( ID_MES,7, trunc(total_horas/60,0),0)) TOTAL_JULIO,            sum(decode( ID_MES,8, trunc(total_horas/60,0),0)) TOTAL_AGOSTO,            sum(decode( ID_MES,9, trunc(total_horas/60,0),0)) TOTAL_SEPTIEMBRE,            sum(decode( ID_MES,10, trunc(total_horas/60,0),0)) TOTAL_OCTUBRE,            sum(decode( ID_MES,12, trunc(total_horas/60,0),0)) TOTAL_DICIEMBRE,            sum(decode( ID_MES,11, trunc(total_horas/60,0),0)) TOTAL_NOVIEMBRE,           MAX(hs.ID_FUNCIONARIO) AS ID_FUNCIONARIO,         MAX(hs.ID_TIPO_AUSENCIA) AS   ID_TIPO_AUSENCIA,           max(substr(DESC_TIPO_AUSENCIA,instr(DESC_TIPO_AUSENCIA,' ',1,1)+1,30)) as DESC_TIPO_AUSENCIA  FROM hora_sindical hs,tr_tipo_ausencia t  WHERE hs.id_tipo_ausencia=" + RSHORAS_MESES__MMColParam1 + " and    hs.id_ano in (2017)    and    hs.id_tipo_ausencia=t.id_tipo_ausencia");
ResultSet RSHORAS_MESES = StatementRSHORAS_MESES.executeQuery();
boolean RSHORAS_MESES_isEmpty = !RSHORAS_MESES.next();
boolean RSHORAS_MESES_hasData = !RSHORAS_MESES_isEmpty;
Object RSHORAS_MESES_data;
int RSHORAS_MESES_numRows = 0;
%>
<script language="Javascript" >
function show_finger()
{
 	var URL = "../Finger/vista_fichajes.jsp";
	var WNAME = "FICHAJES";
	var windowW = 830;
	var windowH = 700;
	var windowX = Math.ceil( (window.screen.width  - windowW) / 2 );
	var windowY = Math.ceil( (window.screen.height - windowH) / 2 );
	DIMENSION=",width="+windowW+",height="+windowH;

	splashWin = window.open( URL , WNAME, "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0"+DIMENSION);
	//splashWin.opener = self;
	splashWin.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
	splashWin.focus();
}
function show_confirm(id, description, url)
{
   var text = "�Realmente desea eliminar: '" + description + "'?";
   var r = confirm(text);
   if (r==true) { 
      MM_goToURL('self',url + id);
   }
   else { 
      alert("Operaci�n cancelada!"); 
   }
}

</script>
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
     <li><a href="../../gestion/Finger_apl/index.jsp"  class="ah12b">Finger</a></li>
    <li id="active" ><a href="#" id="current">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
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
                                  <td bgcolor="#FFFFFF" valign="top"> 
                                    <form name="formSindicales" method=post action="index.jsp">
                                      <table border="0" cellspacing="0" cellpadding="4">
                                        <tr bgcolor="#FFFFFF"> 
                                          <td colspan="4"> 
                                            <table border="0" cellspacing="0" cellpadding="4">
                                              <tr> 
                                                <td><font color="#000000">Funcionario:</font> 
                                                </td>
                                                <td> 
                                                  <select name="TIPO_AUSENCIA">
                                                    <option value="000" selected></option>
                                                    <% while (RSSINDICAL_hasData) {
%>
                                                    <%= "<option value='" %><%= (((RSSINDICAL_data = RSSINDICAL.getObject("ID_TIPO_AUSENCIA"))==null || RSSINDICAL.wasNull())?"":RSSINDICAL_data) %><%= "'>" %> <%= RSSINDICAL_data= RSSINDICAL.getObject("DESC_TIPO_AUSENCIA") %> <%= "</option>" %> 
                                                    <%  RSSINDICAL_hasData = RSSINDICAL.next();
}
RSSINDICAL.close();
RSSINDICAL = StatementRSSINDICAL.executeQuery();
RSSINDICAL_hasData = RSSINDICAL.next();
RSSINDICAL_isEmpty = !RSSINDICAL_hasData;
%>
                                                  </select>
                                                </td>
                                                <td> 
                                                  <input type="submit" value="Ver" name="submit">
                                             </td><td>     
                                          <a href="nuevo.jsp"><img	src="../../imagen/new.png" alt="Nuevo" width="20" height="20" border="0"></a>
			   
                                             </td> </tr>
                                            </table>
                                          </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td colspan="4"> 
                                            <table border="0" cellspacing="0" cellpadding="2">
                                              <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td colspan="2"> 
                                                  <table border="0" cellspacing="0" cellpadding="2">
                                                    <tr> 
                                               
                                                      <td align="right" bgcolor="#f2f2f2" bordercolor="#333333">Funcionario:  </td>
                                                      <td align="center" nowrap bordercolor="#333333" bgcolor="#f2f2f2"><b><%=(((RSHORAS_MESES_data = RSHORAS_MESES.getObject("DESC_TIPO_AUSENCIA"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data)%></b></td>
                                                                                                       </tr>
                                                  </table>
                                                </td>
                                                <td colspan="2"> 
                                                  <table border="0" cellspacing="0" cellpadding="2">
                                                    <tr bgcolor="#f2f2f2" bordercolor="#333333"> 
                                                      <td>Tipo Ausencia: </td>
                                                      <td align="center"><b><%=(((RSHORAS_MESES_data = RSHORAS_MESES.getObject("ID_TIPO_AUSENCIA"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data)%></b></td>
                                                 <%  if (!RSHORAS_MESES_isEmpty) { %>
                                                  <td>
                                                   <a href="javascript:show_confirm('<%=(((RSHORAS_MESES_data = RSHORAS_MESES.getObject("ID_TIPO_AUSENCIA")) == null || RSHORAS_MESES
							.wasNull()) ? "" : RSHORAS_MESES_data)%>','<%=(((RSHORAS_MESES_data = RSHORAS_MESES.getObject("DESC_TIPO_AUSENCIA")) == null || RSHORAS_MESES
							.wasNull()) ? "" : RSHORAS_MESES_data)%>','eliminar.jsp?ID_TIPO_AUSENCIA=')"><img
			src="../../imagen/delete.png" alt="Eliminar" width="20" height="20" border="0"></a>
			    </td>
			        <%  } %>
                                                    </tr>
                                                  </table>
                                                </td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td colspan="4"> 
                                                  <hr size="1" width="400">
                                                </td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="right" width="15%">Enero: 
                                                </td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=1&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_ENERO"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                                <td width="15%" align="right">Julio:</td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=7&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_JULIO"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                              </tr>
                                              <tr bgcolor="#f2f2f2" bordercolor="#333333"> 
                                                <td align="right" width="15%">Febrero: 
                                                </td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=2&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_FEBRERO"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                                <td width="15%" align="right">Agosto:</td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=8&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_AGOSTO"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="right" width="15%">Marzo: 
                                                </td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=3&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_MARZO"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                                <td width="15%" align="right">Septiembre:</td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=9&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_SEPTIEMBRE"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                              </tr>
                                              <tr bgcolor="#f2f2f2" bordercolor="#333333"> 
                                                <td align="right" width="15%">Abril: 
                                                </td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=4&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_ABRIL"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                                <td width="15%" align="right">Octubre: 
                                                </td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=10&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_OCTUBRE"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                              </tr>
                                              <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="right" width="15%">Mayo: 
                                                </td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=5&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_MAYO"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                                <td width="15%" align="right">Noviembre:</td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=11&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_NOVIEMBRE"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                              </tr>
                                              <tr bgcolor="#f2f2f2" bordercolor="#333333"> 
                                                <td align="right" width="15%">Junio: 
                                                </td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=6&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_JUNIO"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                                <td width="15%" align="right">Diciembre:</td>
                                                <td width="35%"><b><%= "<a href='editar.jsp?ID_MES=12&ID_TIPO_AUSENCIA=" + RSHORAS_MESES__MMColParam1 +"'>" + (((RSHORAS_MESES_data = RSHORAS_MESES.getObject("TOTAL_DICIEMBRE"))==null || RSHORAS_MESES.wasNull())?"":RSHORAS_MESES_data) + " Horas</a>" %></b></td>
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                      </table>
                                    </form>
                                  </td>
                                </tr>
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
<%
RSHORAS_MESES.close();
ConnRSHORAS_MESES.close();
%>
