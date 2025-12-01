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
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
    <li><a href="gestion/Listados">Listados Generales</a></li>
    <li><a href="" onClick="show_finger()"  class="ah12b">Finger</a></li>
    <li><a href="gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
  </ul>
</div>
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
	<table width="95%" border="0" cellspacing="0" cellpadding="2">
   <tr>
   <td width=33%>a</td>
   <td width=33%>b</td>
   <td width=33%>c</td> 
   </tr>
        
                <tr>
   <td>aa</td>
   <td>ba</td>
   <td>ca</td> 
   </tr>
        
                                          
                              
           <tr> 
                                  
             <td width=33%>
            
            
            
            <table width="33%" border="0" cellspacing="1" cellpadding="1">                       
                              <tr bgcolor="#cccccc" bordercolor="#333333"> 
                                          <td align="center" width="15%">Enero</td>                                                                                      
                              </tr>                                            
                                                  
                        <table width="33%" border="1" cellspacing="1" cellpadding="1">
                               <tr >                           
    						    <td width="4%" bgcolor="#FFFFFF" ><div align="center">Lu</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Ma</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Mi</div></td>
    							<td width="4%" bgcolor="#FFFFFF" ><div align="center">Ju</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Vi</div></td>
   								<td width="4%" bgcolor="#FF9900" ><div align="center">Sa</div></td>
    							<td width="4%" bgcolor="#FF9900" ><div align="center">Do</div></td>
    						   </tr>
    							
    			              
                                  <tr> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>     <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>   <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>    <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td><td width=4% bgcolor=#FF9900 ><div align=center>01</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>02</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>03</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>04</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>05</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>06</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>07</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>08</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>09</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>10</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>11</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>12</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>13</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>14</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>15</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>16</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>17</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>18</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>19</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>20</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>21</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>22</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>23</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>24</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>25</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>26</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>27</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>28</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>29</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>30</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>31</div></td></tr>
                                   
    							
                           </table>
              </table>              
             </td>     
                
            
              
               
                                          
                               
             <td width=33%>
            
            
            
            <table width="60%" border="0" cellspacing="1" cellpadding="1">                       
                              <tr bgcolor="#cccccc" bordercolor="#333333"> 
                                          <td align="center" width="15%">Febrero</td>                                                                                      
                              </tr>                                            
                                                  
                        <table width="60%" border="1" cellspacing="1" cellpadding="1">
                               <tr >                           
    						    <td width="4%" bgcolor="#FFFFFF" ><div align="center">Lu</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Ma</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Mi</div></td>
    							<td width="4%" bgcolor="#FFFFFF" ><div align="center">Ju</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Vi</div></td>
   								<td width="4%" bgcolor="#FF9900" ><div align="center">Sa</div></td>
    							<td width="4%" bgcolor="#FF9900" ><div align="center">Do</div></td>
    						   </tr>
    							
    			              
                                  <tr> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td><td width=4% bgcolor=#FFFFFF ><div align=center>01</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>02</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>03</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>04</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>05</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>06</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>07</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>08</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>09</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>10</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>11</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>12</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>13</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>14</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>15</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>16</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>17</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>18</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>19</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>20</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>21</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>22</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>23</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>24</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>25</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>26</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>27</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>28</div></td></tr>
                                   
    							
                           </table>
              </table>              
             </td>     
                
            
              
               
                                          
                               
             <td width=100%>
            
            
            
            <table width="60%" border="0" cellspacing="1" cellpadding="1">                       
                              <tr bgcolor="#cccccc" bordercolor="#333333"> 
                                          <td align="center" width="15%">Marzo</td>                                                                                      
                              </tr>                                            
                                                  
                        <table width="60%" border="1" cellspacing="1" cellpadding="1">
                               <tr >                           
    						    <td width="4%" bgcolor="#FFFFFF" ><div align="center">Lu</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Ma</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Mi</div></td>
    							<td width="4%" bgcolor="#FFFFFF" ><div align="center">Ju</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Vi</div></td>
   								<td width="4%" bgcolor="#FF9900" ><div align="center">Sa</div></td>
    							<td width="4%" bgcolor="#FF9900" ><div align="center">Do</div></td>
    						   </tr>
    							
    			              
                                  <tr> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td><td width=4% bgcolor=#FFFFFF ><div align=center>01</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>02</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>03</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>04</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>05</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>06</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>07</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>08</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>09</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>10</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>11</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>12</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>13</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>14</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>15</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>16</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>17</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>18</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>19</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>20</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>21</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>22</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>23</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>24</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>25</div></td>
                                   
                                  <td width=4% bgcolor=#FF9900 ><div align=center>26</div></td></tr><tr>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>27</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>28</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>29</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>30</div></td>
                                   
                                  <td width=4% bgcolor=#FFFFFF ><div align=center>31</div></td></tr>
                                   
    							
                           </table>
              </table>              
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