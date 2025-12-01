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
String RSFICHAJE_DIA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSFICHAJE_DIA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSFICHAJE_DIA__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RSFICHAJE_DIA__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
java.util.Calendar cal_periodo = java.util.Calendar.getInstance();
Integer periodo = new Integer( cal_periodo.get(java.util.Calendar.YEAR) );
%>

<%
Driver DriverRSFICHAJE_DIA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFICHAJE_DIA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFICHAJE_DIA = ConnRSFICHAJE_DIA.prepareStatement("SELECT to_DATE(r.FECHA, 'dd/mm/yy') AS FECHA,DENOMINACION,  lpad(trunc( NVL(SUM( to_char( b.hcomputablef,'HH24')*60 + to_char( b.hcomputablef,'MI')),0)/60),2,'0')  ||':'|| lpad(mod( NVL(SUM( to_char( b.hcomputablef,'HH24')*60 + to_char( b.hcomputablef,'MI')),0),60),2,'0')   as HORAS_FICHADAS,    max(    to_char(r.horteo, 'hh24:mi')) as  HORAS_HACER, round(sum( (to_date('30/12/1899' || to_char(b.hcomputablef, 'hh24:mi'),'DD/MM/YYYY HH24:MI') -  DECODE(to_char(b.hcomputableo, 'hh24:mi'),'00:00', b.hcomputableo, r.horteo)) * 60 * 24)) as SALDO_DIARIO FROM PRESENCI     R,        PERSFICH     B, WEBPERIODO   C, PERSONA      P,  APLIWEB.USUARIO    U, CALENDARIO_LABORAL CA,       INCIDIAS t  WHERE lpad(r.codpers, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(r.codpers, 6, '0') =lpad(B.NPERSONAL(+), 6, '0') and t.CODIGO=r.CODINCi    and r.fecha = to_Date('" + RSFICHAJE_DIA__MMColParam2 + "','dd/mm/yyyy')  and lpad(u.id_funcionario, 6, '0') =lpad('" + RSFICHAJE_DIA__MMColParam1 + "',6,'0')   and r.fecha=b.fecha(+)    and CA.id_ano = c.ANO   AND CA.ID_DIA BETWEEN C.INICIO AND C.FIN   AND CA.ID_DIA = r.FECHA    group by to_DATE(r.FECHA, 'dd/mm/yy'),DENOMINACION");
ResultSet RSFICHAJE_DIA = StatementRSFICHAJE_DIA.executeQuery();
boolean RSFICHAJE_DIA_isEmpty = !RSFICHAJE_DIA.next();
boolean RSFICHAJE_DIA_hasData = !RSFICHAJE_DIA_isEmpty;
Object RSFICHAJE_DIA_data;
int RSFICHAJE_DIA_numRows = 0;
%>
<%
String RSTRANS_TOTAL__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RSTRANS_TOTAL__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSTRANS_TOTAL__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RSTRANS_TOTAL__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
Driver DriverRSTRANS_TOTAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTRANS_TOTAL =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTRANS_TOTAL = ConnRSTRANS_TOTAL.prepareStatement("select nvl(count(*), 0) as total from  persona p,  transacciones t, APLIWEB.USUARIO U  where t.fecha = to_Date('" + RSTRANS_TOTAL__MMColParam2 + "', 'dd/mm/yyyy') and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') = lpad('" + RSTRANS_TOTAL__MMColParam1 + "', 6, '0')  and p.numtarjeta = t.pin    and tipotrans in ('3','2', '55') "); 
ResultSet RSTRANS_TOTAL = StatementRSTRANS_TOTAL.executeQuery();
boolean RSTRANS_TOTAL_isEmpty = !RSTRANS_TOTAL.next();
boolean RSTRANS_TOTAL_hasData = !RSTRANS_TOTAL_isEmpty;
Object RSTRANS_TOTAL_data;
int RSTRANS_TOTAL_numRows = 0;
%>
<%
String RSFICHA_TOTAL__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RSFICHA_TOTAL__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSFICHA_TOTAL__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RSFICHA_TOTAL__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
Driver DriverRSFICHA_TOTAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFICHA_TOTAL =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFICHA_TOTAL = ConnRSFICHA_TOTAL.prepareStatement("select nvl(count(*),0) as total  FROM PRESENCI     R, PERSFICH     B,  WEBPERIODO   C, PERSONA      P, APLIWEB.USUARIO    U,   CALENDARIO_LABORAL CA  where     b.fecha = to_Date('" + RSFICHA_TOTAL__MMColParam2 + "','dd/mm/yyyy')   and lpad(r.codpers, 6, '0') = lpad(u.id_fichaje, 6, '0') and r.fecha = CA.ID_DIA  and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0')  and lpad(B.NPERSONAL, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') =lpad('" + RSFICHA_TOTAL__MMColParam1 + "',6,'0')    and CA.id_ano = c.ANO  AND CA.ID_DIA BETWEEN C.INICIO AND C.FIN      AND CA.ID_DIA = B.FECHA");
ResultSet RSFICHA_TOTAL = StatementRSFICHA_TOTAL.executeQuery();
boolean RSFICHA_TOTAL_isEmpty = !RSFICHA_TOTAL.next();
boolean RSFICHA_TOTAL_hasData = !RSFICHA_TOTAL_isEmpty;
Object RSFICHA_TOTAL_data;
int RSFICHA_TOTAL_numRows = 0;
%>

<%
String RSAUSE_TOTAL__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RSAUSE_TOTAL__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSAUSE_TOTAL__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RSAUSE_TOTAL__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
Driver DriverRSAUSE_TOTAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSAUSE_TOTAL =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSAUSE_TOTAL = ConnRSAUSE_TOTAL.prepareStatement("select nvl(count(*),0) as total  FROM AUSENCIA WHERE   id_funcionario =lpad('" + RSAUSE_TOTAL__MMColParam1 + "',6,'0')   and   to_Date('" + RSAUSE_TOTAL__MMColParam2 + "','dd/mm/yyyy') between to_Date(to_char(fecha_inicio, 'dd/mm/yyyy'), 'dd/mm/yyyy') AND    to_Date(to_char(fecha_FIN, 'dd/mm/yyyy'), 'dd/mm/yyyy')  and id_estado=80");
ResultSet RSAUSE_TOTAL = StatementRSAUSE_TOTAL.executeQuery();
boolean RSAUSE_TOTAL_isEmpty = !RSAUSE_TOTAL.next();
boolean RSAUSE_TOTAL_hasData = !RSAUSE_TOTAL_isEmpty;
Object RSAUSE_TOTAL_data;
int RSAUSE_TOTAL_numRows = 0;
%>
<%
String RSCOM_TOTAL__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RSCOM_TOTAL__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSCOM_TOTAL__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RSCOM_TOTAL__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
Driver DriverRSCOM_TOTAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCOM_TOTAL =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCOM_TOTAL = ConnRSCOM_TOTAL.prepareStatement("select nvl(count(*),0) as total  FROM PERMISO WHERE id_tipo_permiso='15000' and   id_funcionario =lpad('" + RSCOM_TOTAL__MMColParam1 + "',6,'0') and   to_Date('" + RSCOM_TOTAL__MMColParam2 + "','dd/mm/yyyy') between to_Date(to_char(fecha_inicio, 'dd/mm/yyyy'), 'dd/mm/yyyy') AND    to_Date(to_char(fecha_FIN, 'dd/mm/yyyy'), 'dd/mm/yyyy')  and id_estado=80");
ResultSet RSCOM_TOTAL = StatementRSCOM_TOTAL.executeQuery();
boolean RSCOM_TOTAL_isEmpty = !RSCOM_TOTAL.next();
boolean RSCOM_TOTAL_hasData = !RSCOM_TOTAL_isEmpty;
Object RSCOM_TOTAL_data;
int RSCOM_TOTAL_numRows = 0;
%>
<%
String RSDET_TRAN__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RSDET_TRAN__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSDET_TRAN__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RSDET_TRAN__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
Driver DriverRSDET_TRAN = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSDET_TRAN =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSDET_TRAN = ConnRSDET_TRAN.prepareStatement("select t.fecha as fecha_d,       to_char(t.FECHA, 'dd/mm/yyyy') AS FECHA,     to_char(t.HORA, 'hh24') AS HORA,       to_char(t.HORA, 'mi')AS MINUTO from  persona p,  transacciones t, APLIWEB.USUARIO U  where t.fecha = to_Date('" + RSTRANS_TOTAL__MMColParam2 + "', 'dd/mm/yyyy') and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') = lpad('" + RSFICHA_TOTAL__MMColParam1 + "', 6, '0')  and p.numtarjeta = t.pin    and tipotrans in ('3','2', '55') order by hora ");
ResultSet RSDET_TRAN = StatementRSDET_TRAN.executeQuery();
boolean RSDET_TRAN_isEmpty = !RSDET_TRAN.next();
boolean RSDET_TRAN_hasData = !RSDET_TRAN_isEmpty;
Object RSDET_TRAN_data;
int RSDET_TRAN_numRows = 0;
%>

<%
String RSDET_FICH__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RSDET_FICH__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSDET_FICH__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RSDET_FICH__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
Driver DriverRSDET_FICH = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSDET_FICH =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSDET_FICH = ConnRSDET_FICH.prepareStatement("select to_char(t.HINICIO, 'hh24:mi') as INICIO, to_char(t.HFIN, 'hh24:mi') AS FIN,       t.RELOJ,      round( (to_date('30/12/1899' || to_char(t.hcomputablef, 'hh24:mi'),'DD/MM/YYYY HH24:MI') -       DECODE(to_char(t.hcomputableo, 'hh24:mi'),               '00:00',               t.hcomputableo,               r.horteo)) * 60 * 24,2) as saldo  from  persona p,  persfich t, PRESENCI R,APLIWEB.USUARIO    U where t.fecha = to_Date('" + RSDET_FICH__MMColParam2 + "', 'dd/mm/yyyy')    and r.fecha = t.fecha  and p.codigo = t.npersonal  and lpad(r.codpers, 6, '0') = lpad(t.NPERSONAL(+), 6, '0') and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') = lpad('" + RSDET_FICH__MMColParam1 + "', 6, '0') order by INICIO");
ResultSet RSDET_FICH = StatementRSDET_FICH.executeQuery();
boolean RSDET_FICH_isEmpty = !RSDET_FICH.next();
boolean RSDET_FICH_hasData = !RSDET_FICH_isEmpty;
Object RSDET_FICH_data;
int RSDET_FICH_numRows = 0;
%>

<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSDET_TRAN_numRows += RSDET_TRAN_numRows;
%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RSDET_FICH_numRows += RSDET_FICH_numRows;
%>
<%
String RSPERIODO__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RSPERIODO__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT to_chaR(ca.id_dia,'dd/mm/yyyy') aS PERIODO,mes || ANO as PER FROM  WEBPERIODO   C, CALENDARIO_LABORAL CA WHERE  CA.ID_DIA BETWEEN C.INICIO AND C.FIN  AND to_Date('" + RSPERIODO__MMColParam2 + "','dd/mm/yyyy') between  C.INICIO AND C.FIN order by id_dia");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>

<%
String RSCONSULTA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSCONSULTA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSCONSULTA__MMColParam2;
 RSCONSULTA__MMColParam2 = (String)(((RSPERIODO_data = RSPERIODO.getObject("PER"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data);

%>


<%
Driver DriverRSCONSULTA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCONSULTA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCONSULTA = ConnRSCONSULTA.prepareStatement("select id_dia, c1 ||c2||c3||c4||c5||c6||c7  as d1   from (select  id_dia, max(id_funcionario),  min(columna1) as c1,         min(columna2) as c2, min(columna3) as c3, min(columna4) as c4, min(columna5) as c5, min(columna6) as c6, min(columna7) as c7 from CALENDARIO_COLUMNA_FICHAJE c   where   C.MES||C.ANO =DECODE('" + RSCONSULTA__MMColParam2 + "','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSCONSULTA__MMColParam2 + "')   and id_funcionario in ('" + RSCONSULTA__MMColParam1 + "',0)    group by id_dia) order by id_dia");
ResultSet RSCONSULTA = StatementRSCONSULTA.executeQuery();
boolean RSCONSULTA_isEmpty = !RSCONSULTA.next();
boolean RSCONSULTA_hasData = !RSCONSULTA_isEmpty;
Object RSCONSULTA_data;
int RSCONSULTA_numRows = 0;
%>
<%
int Repeat3__numRows = -1;
int Repeat3__index = 0;
RSCONSULTA_numRows += Repeat3__numRows;
%>

<%
Driver DriverRSTR_HORA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTR_HORA =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTR_HORA = ConnRSTR_HORA.prepareStatement("select ID_HORA,VALOR from rrhh.tr_hora order by 1 ");
ResultSet RSTR_HORA = StatementRSTR_HORA.executeQuery();
boolean RSTR_HORA_isEmpty = !RSTR_HORA.next();
boolean RSTR_HORA_hasData = !RSTR_HORA_isEmpty;
Object RSTR_HORA_data;
int RSTR_HORA_numRows = 0;
%>


<%
Driver DriverRSTR_MINUTO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTR_MINUTO =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTR_MINUTO = ConnRSTR_MINUTO.prepareStatement("select ID_MINUTO,VALOR from rrhh.tr_MINUTO order by 1 ");
ResultSet RSTR_MINUTO = StatementRSTR_MINUTO.executeQuery();
boolean RSTR_MINUTO_isEmpty = !RSTR_MINUTO.next();
boolean RSTR_MINUTO_hasData = !RSTR_MINUTO_isEmpty;
Object RSTR_MINUTO_data;
int RSTR_MINUTO_numRows = 0;
%>


<script language="Javascript" >


function mostrar()
{
	vt.style.display='none';
	ot.style.display='';
}

function ocultar()
{
	vt.style.display='';
	ot.style.display='none';
}

</script>



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
    <li><a href="gestion/Listados">Listados Generales</a></li>
    <li><a href="" onClick="show_finger()"  class="ah12b">Finger</a></li>
    <li><a href="gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
  </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>
		<li><a href="../Bajas">Bajas</a></li>
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger"  id="current">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
  </div>
	<div id="subform">
	
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                                <tr>
                                  <td width="51%" valign="top" bgcolor="#E0E0E0">
                                    <table border="0" cellspacing="0" cellpadding="2">
                                      <form name="formBotonera" method=post action="index.jsp">
                                        <tr>
                                          <td width="76">
                                          <input type="button" value="Regenerar" name="Nuevo" onClick="window.location='alta.jsp?ID_ANO=2015'" >                                          </td>
                                          <td width="60">&nbsp;</td>
                                          <td width="135">&nbsp;</td>
                                          <td width="632" nowrap class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;</td>
                                        </tr>
                                      </form>
                                  </table></td> 
                                  <td width="9%" align="left" valign="top" bgcolor="#E0E0E0"><table border="0" cellspacing="0" cellpadding="2" width="100">
                                    <form name="formPeriodo" method=post action="detalle_dia.jsp">
                                      <tr>
                                        <td>D�a&nbsp;</td>
                                        <td>
                                          <select name="ID_DIA">
                                            <% while (RSPERIODO_hasData) {
%>
                                            <%= "<option value='" %><%= (((RSPERIODO_data = RSPERIODO.getObject("PERIODO"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data) %><%= "'>" %> <%= RSPERIODO_data= RSPERIODO.getObject("PERIODO") %> <%= "</option>" %>
                                            <%  RSPERIODO_hasData = RSPERIODO.next();
}
RSPERIODO.close();
RSPERIODO = StatementRSPERIODO.executeQuery();
RSPERIODO_hasData = RSPERIODO.next();
RSPERIODO_isEmpty = !RSPERIODO_hasData;
%>
                                          </select>                                        </td>
                                        <td>
                                          <input type="submit" value="Ver" name="submit">                                        </td>
                                      </tr>
                                    </form>
                                </table>                                </tr>
                                <tr> 
                                  <td  valign="top" colspan="2"> 
								  <table width="55%" border="1" cellspacing="1" cellpadding="4">
								    <div id="vt" style="DISPLAY:"><a href="javascript:mostrar();">Calendario</a>&nbsp;
							  </div> 
							  <div id="ot" style="DISPLAY: none"><a href="javascript:ocultar();">Ocultar</a>&nbsp;
								   <tr > 
                                        <td width="5%" valign="top" align="left"  bgcolor="#f2f2f2">
							  
							 
							 
 

<table width="20%" border="1" cellpadding="3" cellspacing="1" bordercolor="#CCCCCC">
                    <tr>
    <th width="20%" bgcolor="#9999FF" scope="col">L</th>
    <th width="20%" bgcolor="#9999FF" scope="col">M</th>
    <th width="20%" bgcolor="#9999FF"  scope="col">X</th>
    <th width="20%" bgcolor="#9999FF" scope="col">J</th>
    <th width="20%" bgcolor="#9999FF" scope="col">V</th>
    <th width="20%" bgcolor="#E0E0E0" scope="col">S</th>
    <th width="20%" bgcolor="#E0E0E0" scope="col">D</th>
  </tr>
                        <% while ((RSCONSULTA_hasData)&&(Repeat3__numRows-- != 0)) { %>
						<%=(((RSCONSULTA_data = RSCONSULTA.getObject("D1"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%>                        <%  						                          
  Repeat3__index++;
  RSCONSULTA_hasData = RSCONSULTA.next();
}
%>
                  </table></td>
                              <td colspan="7" align="left" bgcolor="#f2f2f2">
                                <table width="100%" border="0" cellspacing="3" cellpadding="1">
                                  <tr >
    <td width="3%"  bgcolor="#0099FF" class="Estilo13" scope="col">&nbsp;</td>
    <td nowrap bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Vacaciones</span></td>
    <td width="3%" bgcolor="#00CC66" class="Estilo12" scope="col"></strong></td>
    <td nowrap bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Asuntos Propios</span></td>
    <td width="3%"  bgcolor="#CCCCFF" class="Estilo12" scope="col">&nbsp;</td>
    <td nowrap bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Compensatorios</span></td>
    <td width="3%"  bgcolor="#CC3300" class="Estilo12" scope="col">&nbsp;</td>
    <td bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Otros</span></td>
  </tr>
  <tr>
  <td width="3%"  bgcolor="#333333" class="Estilo13" scope="col">&nbsp;</td>
    <td nowrap bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Fallecimiento/Enfermedad familiar</span></td>
    <td width="3%" bgcolor="#FFCC99" class="Estilo12" scope="col"></strong></td>
    <td bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Cursos</span></td>
    <td bgcolor="#CCCC33" class="Estilo12" scope="col">&nbsp;</td>
    <td colspan="3" bgcolor="#f2f2f2" class="Estilo12" scope="col">Bajas</td>
	<td bgcolor="#FF9900" class="Estilo12" scope="col">&nbsp;</td>
    <td colspan="3" bgcolor="#f2f2f2" class="Estilo12" scope="col">Festivos</td>
  </tr>
                                </table>
                              
	
							  </td>
                                      </tr>
									    </div> 
                                      <tr bgcolor="#FFFFDD"> 
                                        <td colspan="8"><div align="center"><b>Resumen d&iacute;a</b></div></td>
                                      </tr>
                                      <tr> 
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Transacciones</span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center">Fichajes</td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Ause</span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Comp</span></td>
                                        <td width="35%" bgcolor="#CCCCCC" align="center"><span class="va10b">TIPO DIA </span></td>
                                        <td width="10%" align="center" bgcolor="#CCCCCC">Horas fichadas </td>
                                        <td width="10%" align="center" bgcolor="#CCCCCC">Horas realizar </td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Saldo d&iacute;a </span></td>
                                      </tr>
                                      <% while ((RSFICHAJE_DIA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                      <% if (!RSFICHAJE_DIA_isEmpty ) { %>
                                      <tr>
                                        <td width="5%" align="center" bgcolor="#FFFFFF"><%=(((RSTRANS_TOTAL_data = RSTRANS_TOTAL.getObject("TOTAL"))==null || RSTRANS_TOTAL.wasNull())?"":RSTRANS_TOTAL_data)%></td>
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><%=(((RSFICHA_TOTAL_data = RSFICHA_TOTAL.getObject("TOTAL"))==null || RSFICHA_TOTAL.wasNull())?"":RSFICHA_TOTAL_data)%></td>
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><%=(((RSAUSE_TOTAL_data = RSAUSE_TOTAL.getObject("TOTAL"))==null || RSAUSE_TOTAL.wasNull())?"":RSAUSE_TOTAL_data)%></td>
                                        <td width="10%" nowrap bgcolor="#FFFFFF"><div align="center"><%=(((RSCOM_TOTAL_data = RSCOM_TOTAL.getObject("TOTAL"))==null || RSCOM_TOTAL.wasNull())?"":RSCOM_TOTAL_data)%></div></td>
                                        <td width="35%" nowrap bgcolor="#FFFFFF"><%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("DENOMINACION"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%></td>
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("HORAS_FICHADAS"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%></td>
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("HORAS_HACER"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%></td>
                                        <td width="10%" align="center" bgcolor="#FFFFFF"><%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("SALDO_DIARIO"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%></td>
                                      </tr>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat1__index++;
  RSFICHAJE_DIA_hasData = RSFICHAJE_DIA.next();
}
%>
                                    </table>								  </td>
                                </tr>
                                <tr> 
                                  <td valign="top" colspan="2">&nbsp;</td>
                                </tr>
                                <tr> 
                                  <td colspan="2" ><table width="100%" border="0" cellspacing="0" cellpadding="2">
                                      <tr>
                                        <td width="25%"><div align="right"><a href="detalle_tra.jsp?ID_DIA=<%= RSTRANS_TOTAL__MMColParam2   %>"><img src="../../imagen/new.png" alt="Nuevo"	width="20" height="20" border="0"></a></div><table width="35%" border="1" cellspacing="1" cellpadding="4">
                                            <tr bgcolor="#FFFFDD"> 
                                              <td bgcolor="#33FFFF"><div align="center"><b>Transacciones</b></div></td>
                                        </tr>
                                            <tr> 
                                              <td align="center" bgcolor="#CCCCCC"><span class="va10b">HORA</span></td>
                                        </tr>
                                            <% while ((RSDET_TRAN_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                            <% if (!RSDET_TRAN_isEmpty ) { %>
                                            <tr>
                                              <td align="center" valign="bottom" nowrap bgcolor="#FFFFFF">
											    <select name="TR_HORA_<%= Repeat1__index %>">
                                    <%
while (RSTR_HORA_hasData) {
%>
                                    <option value="<%=((RSTR_HORA.getObject("ID_HORA")!=null)?RSTR_HORA.getObject("ID_HORA"):"")%>"  <%=(((RSTR_HORA.getObject("ID_HORA")).toString().equals(((((RSDET_TRAN_data = RSDET_TRAN.getObject("HORA"))==null || RSDET_TRAN.wasNull())?"":RSDET_TRAN_data)).toString()))?"SELECTED":"")%> ><%=((RSTR_HORA.getObject("ID_HORA")!=null)?RSTR_HORA.getObject("ID_HORA"):"")%></option>
                                    <%
  RSTR_HORA_hasData = RSTR_HORA.next();
}
RSTR_HORA.close();
RSTR_HORA = StatementRSTR_HORA.executeQuery();
RSTR_HORA_hasData = RSTR_HORA.next();
RSTR_HORA_isEmpty = !RSTR_HORA_hasData;
%>
                                  </select>
								   <select name="TR_MINUTO_<%= Repeat1__index %>">
                                    <%
while (RSTR_MINUTO_hasData) {
%>
                                    <option value="<%=((RSTR_MINUTO.getObject("ID_MINUTO")!=null)?RSTR_MINUTO.getObject("ID_MINUTO"):"")%>"  <%=(((RSTR_MINUTO.getObject("ID_MINUTO")).toString().equals(((((RSDET_TRAN_data = RSDET_TRAN.getObject("MINUTO"))==null || RSDET_TRAN.wasNull())?"":RSDET_TRAN_data)).toString()))?"SELECTED":"")%> ><%=((RSTR_MINUTO.getObject("ID_MINUTO")!=null)?RSTR_MINUTO.getObject("ID_MINUTO"):"")%></option>
                                    <%
  RSTR_MINUTO_hasData = RSTR_MINUTO.next();
}
RSTR_MINUTO.close();
RSTR_MINUTO = StatementRSTR_MINUTO.executeQuery();
RSTR_MINUTO_hasData = RSTR_MINUTO.next();
RSTR_MINUTO_isEmpty = !RSTR_MINUTO_hasData;
%>
                                  </select>
								   <a href="detalle_tra.jsp?ID_DIA=<%= RSTRANS_TOTAL__MMColParam2   %>"><img src="../../imagen/delete.png" alt="Nuevo"	width="20" height="20" border="0"></a></td>
                                        </tr>
                                            <% } /* end !RSQUERY_isEmpty */ %>
                                              
                                            <%
  Repeat1__index++;
  RSDET_TRAN_hasData = RSDET_TRAN.next();
}
%>           <% while (Repeat1__index++ != 10) { %>
 
              <div id="c<%= Repeat1__index %>" style="DISPLAY: none">
               <tr>
                      <td align="left" valign="bottom" nowrap bgcolor="#FFFFFF">
											  
											  <select name="TR_HORA_<%= Repeat1__index %>">
                                    <%
while (RSTR_HORA_hasData) {
%>
     <option value="<%=((RSTR_HORA.getObject("ID_HORA")!=null)?RSTR_HORA.getObject("ID_HORA"):"")%>"><%=((RSTR_HORA.getObject("ID_HORA")!=null)?RSTR_HORA.getObject("ID_HORA"):"")%></option>
                                   <%
 
 RSTR_HORA_hasData = RSTR_HORA.next();
}
RSTR_HORA.close();
RSTR_HORA = StatementRSTR_HORA.executeQuery();
RSTR_HORA_hasData = RSTR_HORA.next();
RSTR_HORA_isEmpty = !RSTR_HORA_hasData;
%>
                                  </select><select name="TR_MINUTO_<%= Repeat1__index %>">
                                    <%
while (RSTR_MINUTO_hasData) {
%>
    <option value="<%=((RSTR_MINUTO.getObject("ID_MINUTO")!=null)?RSTR_MINUTO.getObject("ID_MINUTO"):"")%>"><%=((RSTR_MINUTO.getObject("ID_MINUTO")!=null)?RSTR_MINUTO.getObject("ID_MINUTO"):"")%></option>
                                    <%
  RSTR_MINUTO_hasData = RSTR_MINUTO.next();
}
RSTR_MINUTO.close();
RSTR_MINUTO = StatementRSTR_MINUTO.executeQuery();
RSTR_MINUTO_hasData = RSTR_MINUTO.next();
RSTR_MINUTO_isEmpty = !RSTR_MINUTO_hasData;
%>
                                  </select>
                                  <a href="detalle_tra.jsp?ID_DIA=<%= RSTRANS_TOTAL__MMColParam2   %>"><img src="../../imagen/delete.png" alt="Nuevo"	width="20" height="20" border="0"></a> </td>
											  
										  </tr></div>
		 <% } %>
											  
                                          </table></td>
                                        <td width="75%"><table width="45%" border="1" cellspacing="1" cellpadding="4">
                                      <tr bgcolor="#FFFFDD"> 
                                        <td colspan="4" bgcolor="#CCFFCC"><div align="center"><b>Fichajes</b></div></td>
                                      </tr>
                                      <tr> 
                                        <td align="center" bgcolor="#CCCCCC">INICIO</td>
                                        <td align="center" bgcolor="#CCCCCC">FIN</td>
                                        <td align="center" bgcolor="#CCCCCC">RELOJ</td>
                                        <td align="center" bgcolor="#CCCCCC">SALDO</td>
                                      </tr>
                                      <% while ((RSDET_FICH_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                      <% if (!RSDET_FICH_isEmpty ) { %>
                                      <tr>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("INICIO"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("FIN"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("RELOJ"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("SALDO"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                      </tr>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat2__index++;
  RSDET_FICH_hasData = RSDET_FICH.next();
}
%>
                                    </table></td>
                                      </tr>
                                    </table></td>
                                </tr>
                                
                               
                                <tr> 
                                  <td valign="top" colspan="2"> 
                                  </td>
                                </tr>
      </table>
	</div>
</div>
	</div>
</body>
</html>
<%
RSFICHAJE_DIA.close();
ConnRSFICHAJE_DIA.close();
%>
<%
RSTRANS_TOTAL .close();
ConnRSTRANS_TOTAL .close();
%>
<%
RSAUSE_TOTAL.close();
ConnRSAUSE_TOTAL.close();
%>
<%
RSFICHA_TOTAL.close();
StatementRSFICHA_TOTAL.close();
ConnRSFICHA_TOTAL.close();
%>
<%
RSCOM_TOTAL.close();
StatementRSCOM_TOTAL.close();
ConnRSCOM_TOTAL.close();
%>
<%
RSDET_TRAN.close();
ConnRSDET_TRAN.close();
%>
<%
RSDET_FICH.close();
ConnRSDET_FICH.close();
%>
<%
RSTR_MINUTO.close();
ConnRSTR_MINUTO.close();
%>
<%
RSTR_HORA.close();
ConnRSTR_HORA.close();
%>
