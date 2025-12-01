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
String RS_DIA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO_NOMBRE")    !=null) {RS_DIA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO_NOMBRE")   ;}

String RS_DIA__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RS_DIA__MMColParam2  = (String)request.getParameter("ID_DIA");}

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment; filename="+  RS_DIA__MMColParam1 + "_" +RS_DIA__MMColParam2 +".xls");

%>
<%
String RSF__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FICHAJE")   !=null) {RSF__MMColParam1 = (String)session.getAttribute("MM_ID_FICHAJE")  ;}
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
PreparedStatement StatementRSFICHAJE_DIA = ConnRSFICHAJE_DIA.prepareStatement("SELECT max(to_char(r.hio1,'hh24:mi')) as Obli_mañana_1,max(to_char(r.hfo1,'hh24:mi')) as Obli_mañana_2,max(to_char(r.hif1,'hh24:mi')) as fle_mañana_1, max(to_char(r.hff1,'hh24:mi')) as fle_mañana_2,max(to_char(hio2,'hh24:mi')) as Obli_tarde_1, max(to_char(hfo2,'hh24:mi')) as Obli_tarde_2,max(to_char(r.hif2,'hh24:mi')) as fle_tarde_1,max(to_char(r.hff2,'hh24:mi')) as fle_tarde_2, to_DATE(r.FECHA, 'dd/mm/yy') AS FECHA,DENOMINACION,  lpad(trunc( NVL(SUM( to_char( b.hcomputablef,'HH24')*60 + to_char( b.hcomputablef,'MI')),0)/60),2,'0')  ||':'|| lpad(mod( NVL(SUM( to_char( b.hcomputablef,'HH24')*60 + to_char( b.hcomputablef,'MI')),0),60),2,'0')   as HORAS_FICHADAS,    max(    to_char(r.horteo, 'hh24:mi')) as  HORAS_HACER, round(sum( (to_date('30/12/1899' || to_char(b.hcomputablef, 'hh24:mi'),'DD/MM/YYYY HH24:MI') -  DECODE(to_char(b.hcomputableo, 'hh24:mi'),'00:00', b.hcomputableo, r.horteo)) * 60 * 24)) as SALDO_DIARIO FROM PRESENCI     R,        PERSFICH     B, WEBPERIODO   C, PERSONA      P,  APLIWEB.USUARIO    U, CALENDARIO_LABORAL CA,       INCIDIAS t  WHERE lpad(r.codpers, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(r.codpers, 6, '0') =lpad(B.NPERSONAL(+), 6, '0') and t.CODIGO=r.CODINCi    and r.fecha = to_Date('" + RSFICHAJE_DIA__MMColParam2 + "','dd/mm/yyyy')  and lpad(u.id_funcionario, 6, '0') =lpad('" + RSFICHAJE_DIA__MMColParam1 + "',6,'0')   and r.fecha=b.fecha(+)    and CA.id_ano = c.ANO   AND CA.ID_DIA BETWEEN C.INICIO AND C.FIN   AND CA.ID_DIA = r.FECHA    group by to_DATE(r.FECHA, 'dd/mm/yy'),DENOMINACION order by horas_hacer desc");
ResultSet RSFICHAJE_DIA = StatementRSFICHAJE_DIA.executeQuery();
boolean RSFICHAJE_DIA_isEmpty = !RSFICHAJE_DIA.next();
boolean RSFICHAJE_DIA_hasData = !RSFICHAJE_DIA_isEmpty;
Object RSFICHAJE_DIA_data;
int RSFICHAJE_DIA_numRows = 0;
String PERIODO_PAR;
%>
<%
String RSSALDO__MMColParam1 = "101217";
if (session.getValue("MM_ID_FUNCIONARIO")   !=null) {RSSALDO__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSSALDO__MMColParam2 = "0000";
if (request.getParameter("ANNO")           !=null) {RSSALDO__MMColParam2 = (String)request.getParameter("ANNO")          ;}
%>
<%
String RSSALDO__MMColParam3 = "000000";
if (request.getParameter("ID_DIA")             !=null) {RSSALDO__MMColParam3 = (String)request.getParameter("ID_DIA")            ;}
%>
<%
Driver DriverRSSALDO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSSALDO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSSALDO = ConnRSSALDO.prepareStatement("SELECT SUM(a.Campo11 + a.Campo9) AS DM  FROM  webfinger   a,        webperiodo  b,       apliweb_usuario   u,       bolsa_funcionario bf  where         to_date('" + RSSALDO__MMColParam3 +"','dd/mm/yyyy') between b.inicio and  b.fin  and  lpad(u.id_funcionario,6,'0')=lpad('" + RSSALDO__MMColParam1 + "',6,'0')  and a.fecha between b.inicio and b.fin and a.codpers = id_fichaje    and bf.id_funcionario = u.id_funcionario  and bf.id_acumulador = 1 and bf.id_ano = b.ano");
ResultSet RSSALDO = StatementRSSALDO.executeQuery();
boolean RSSALDO_isEmpty = !RSSALDO.next();
boolean RSSALDO_hasData = !RSSALDO_isEmpty;
Object RSSALDO_data;
int RSSALDO_numRows = 0; 
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
String RSFICHA__MMColParam1= "00";
if (session.getValue("MM_ID_FUNCIONARIO")   !=null) {RSFICHA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")  ;}
%>
<%
Driver DriverRSFICHA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFICHA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFICHA = ConnRSFICHA.prepareStatement("select NVL(PIN,'SIN') as PIN,to_char(nvl(ID_TIPO_FIcHAJE,9))as ID_TIPO_FICHAJE,p.id_funcionario from FUNCIONARIO_FICHAJE f,personal_new p where f.id_funcionario(+)=p.id_funcionario and lpad(p.id_funcionario,6,'0')=lpad('" + RSFICHA__MMColParam1 + "',6,'0') ");

ResultSet RSFICHA = StatementRSFICHA.executeQuery();
boolean RSFICHA_isEmpty = !RSFICHA.next();
boolean RSFICHA_hasData = !RSFICHA_isEmpty;
Object RSFICHA_data;
int RSFICHA_numRows = 0; 
%>
<%
Driver DriverRSTIPO_FICHA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPO_FICHA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPO_FICHA = ConnRSTIPO_FICHA.prepareStatement("select DESC_FICHAJE ,ID_TIPO_FICHAJE from tr_tipo_fichaje tr order by 2");

ResultSet RSTIPO_FICHA = StatementRSTIPO_FICHA.executeQuery();
boolean RSTIPO_FICHA_isEmpty = !RSTIPO_FICHA.next();
boolean RSTIPO_FICHA_hasData = !RSTIPO_FICHA_isEmpty;
Object RSTIPO_FICHA_data;
int RSTIPO_FICHA_numRows = 0; 
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
PreparedStatement StatementRSAUSE_TOTAL = ConnRSAUSE_TOTAL.prepareStatement("select 'Ausencias' as TIPO,to_char(fecha_inicio,'DD/mm/yyyy hh24:mi') as fecha_inicio,to_char(fecha_fin,'DD/mm/yyyy hh24:mi') as fecha_fin,'Si' as justificado   FROM AUSENCIA  WHERE id_funcionario = lpad('" + RSAUSE_TOTAL__MMColParam1 + "', 6, '0')  and to_Date('" + RSAUSE_TOTAL__MMColParam2 + "', 'dd/mm/yyyy') between  to_Date(to_char(fecha_inicio, 'dd/mm/yyyy'), 'dd/mm/yyyy') AND to_Date(to_char(fecha_FIN, 'dd/mm/yyyy'), 'dd/mm/yyyy')  and id_estado = 80 union select 'Compensatorio' AS TIPO,to_char(fecha_inicio,'dd/mm/yyyy') ||  ' ' || hora_inicio as fecha_inicio, to_char(fecha_fin,'dd/mm/yyyy') ||  ' ' ||  hora_fin as fecha_fin,'' from permiso where id_tipo_permiso='15000' and id_funcionario = lpad('" + RSAUSE_TOTAL__MMColParam1 + "', 6, '0')    and to_Date('" + RSAUSE_TOTAL__MMColParam2 + "', 'dd/mm/yyyy') between  to_Date(to_char(fecha_inicio, 'dd/mm/yyyy'), 'dd/mm/yyyy') AND  to_Date(to_char(fecha_FIN, 'dd/mm/yyyy'), 'dd/mm/yyyy')    and id_estado = 80");
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
Driver DriverRSPERIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIO = ConnRSPERIO.prepareStatement("SELECT  ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo ,mes ||  ano as per FROM  webperiodo  WHERE ano>2013 and  ano ||mes <= to_char(sysdate+30,'YYYYMM') ORDER BY ano,MES");
ResultSet RSPERIO = StatementRSPERIO.executeQuery();
boolean RSPERIO_isEmpty = !RSPERIO.next();
boolean RSPERIO_hasData = !RSPERIO_isEmpty;
Object RSPERIO_data;
int RSPERIO_numRows = 0;
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
PreparedStatement StatementRSDET_TRAN = ConnRSDET_TRAN.prepareStatement("select lpad(claveomesa,10,0) as clavef, t.fecha as fecha_d,       to_char(t.FECHA, 'dd/mm/yyyy') AS FECHA,     to_char(t.HORA, 'hh24') AS HORA,       to_char(t.HORA, 'mi')AS MINUTO,LPAD(NVL(denom,'MANUAL  '),22,' ') as reloj from  persona p,  transacciones t, APLIWEB.USUARIO U , relojes r where t.fecha = to_Date('" + RSTRANS_TOTAL__MMColParam2 + "', 'dd/mm/yyyy') and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') = lpad('" + RSFICHA_TOTAL__MMColParam1 + "', 6, '0')  and p.numtarjeta = t.pin  and  t.numero=r.numero(+)  and tipotrans in ('3','2','55','0','39') order by hora ");
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
PreparedStatement StatementRSDET_FICH = ConnRSDET_FICH.prepareStatement("select to_char(t.HINICIO, 'hh24:mi') as INICIO, to_char(t.HFIN, 'hh24:mi') AS FIN,       t.RELOJ,      round( (to_date('30/12/1899' || to_char(t.hcomputablef, 'hh24:mi'),'DD/MM/YYYY HH24:MI') -       DECODE(to_char(t.hcomputableo, 'hh24:mi'),               '00:00',               t.hcomputableo,               r.horteo)) * 60 * 24,2) as saldo,lpad(trunc(NVL(to_char(t.hcomputablef, 'HH24') * 60 + to_char(t.hcomputablef, 'MI'), 0) / 60), 2,'0') || ':' || lpad(mod(NVL(to_char(t.hcomputablef, 'HH24') * 60 + to_char(t.hcomputablef, 'MI'), 0),60), 2,'0') as horas_fichadas  from  persona p,  persfich t, PRESENCI R,APLIWEB.USUARIO    U where t.fecha = to_Date('" + RSDET_FICH__MMColParam2 + "', 'dd/mm/yyyy')    and r.fecha = t.fecha  and p.codigo = t.npersonal  and lpad(r.codpers, 6, '0') = lpad(t.NPERSONAL(+), 6, '0') and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') = lpad('" + RSDET_FICH__MMColParam1 + "', 6, '0') order by INICIO");
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
int Repeat6__numRows = -1;
int Repeat6__index = 0;
RSAUSE_TOTAL_numRows += RSAUSE_TOTAL_numRows;
%>
<%
String RSPERIODO__MMColParam2 = "";
if (request.getParameter("ID_DIA") !=null) {RSPERIODO__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT to_chaR(ca.id_dia,'dd/mm/yyyy') aS PERIODO,mes || ANO as PER ,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES) || ' de ' || ano as PER2 FROM  WEBPERIODO   C, CALENDARIO_LABORAL CA WHERE  CA.ID_DIA BETWEEN C.INICIO AND C.FIN  AND to_Date('" + RSPERIODO__MMColParam2 + "','dd/mm/yyyy') between  C.INICIO AND C.FIN order by id_dia");
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
 String RSCONSULTA__MMColParam22;
 RSCONSULTA__MMColParam22 = (String)(((RSPERIODO_data = RSPERIODO.getObject("PER2"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data);

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

function regenera() {

   var ida = 0;
   var campo_final;
 
   campo_final=""; 

     while (ida < 11 ) 
        {

         	if (       document.getElementById('campoc' + ida).value == 1 || document.getElementById('valorc' + ida).value==3 )

     		    {
                         campo_final= campo_final +  document.getElementById('CLAVE_HORA_' + ida).value + 'X' +
                          + document.getElementById('TR_HORA_' + ida).value + ':' +
                         document.getElementById('TR_MINUTO_' + ida).value + 'v' +
                         document.getElementById('valorc' + ida).value   +'*';
                         
		      }			
							
         	ida = ida + 1;
			  
		}

    
 		
		document.getElementById('campo_final').value=campo_final;
       document.formFICHA.submit();

  
}

function añadir()
{

   var ida = 1;
   var encontrado=0;

   
     while (ida < 11 ) 
        {
	        
			
			thediv = document.getElementById('campoc' + ida).value;
		       		 
		   if (thediv == "0") 
     		    {
		    	 eval('c'+ida).style.display ='';
				 document.getElementById('campoc' + ida).value= 1;
      		     document.getElementById('valorc' + ida).value= 1;
				
		    	 ida=15;
			    }			
							
         	ida = ida + 1;
			  
		}

  
}

function borrar(capa)
{        
	
	eval(capa).style.display='none';   
    thediv = document.getElementById('campo' + capa);
    document.getElementById('valor' + capa).value= 3;
	
	thediv.value = "0" ;                 
}
function mostrar()
{
	vt.style.display='none';
	ot.style.display='';
	ot1.style.display='';
	ot2.style.display='';
};

function ocultar()
{
	vt.style.display='';
	ot.style.display='none';
	ot1.style.display='none';
	ot2.style.display='none';
};


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

	
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
	   <tr > 
                      <th>
					    <div align="left">
					      <table border="0" cellspacing="0" cellpadding="2">
					        
					        <tr>
					          
					          <td  colspan=12 class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;</td>
							  
							  <td colspan=12 nowrap width="10%" class="va12b"  ><div align="right"><strong>Saldo Periodo: <%=RSCONSULTA__MMColParam22 %>.</strong> </div></td>
							  <% 
									Double datos = null;
									Double datos_policia = null;
									String mensaje_saldo  = "";
									double saldo = 0;

									if (RSSALDO_hasData && RSSALDO.getString("DM")!=null) 
										{ 
											datos = new Double( (String) RSSALDO.getString("DM") );
											datos_policia = new Double( (String) RSF__MMColParam1 );
											if (datos_policia.intValue() < 2000)
												{	
												if (datos.intValue() < 0 ) 
												  { 
													mensaje_saldo = "Le faltan "; 
													saldo = datos.doubleValue()*(-1.0); 
	    										 } else { 
													mensaje_saldo = "Le sobran "; 
													saldo = datos.doubleValue(); 
	    											}
									Double ho = new Double( saldo / 60 );
									Double mi = new Double( saldo % 60);
									mensaje_saldo += ho.intValue() + " hora/s y " + mi.intValue() + " minuto/s.";
										} else {
											mensaje_saldo = " "; 
											}	
									} 
									else 
										{ 
											datos = new Double(0);
											mensaje_saldo = "No existen fichajes para el periodo seleccionado.";
										}
											%>						
                              <td colspan=5 width="10%" nowrap class="va12b"  ><div align="right"><strong><%= mensaje_saldo %></strong></div></td>
                            </tr>
					        </table>
				        </div></th>
						
                      <th valign="top" class="va12b"> <div align="right">
                        <table  border="0" cellpadding="4" cellspacing="0" >
                          <tr class="va12b">
                            
                            <td width="10%" valign="top" class="va12b" ><div align="right">PIN:</div></td>
                                  <td width="7%" valign="top" >
                                    <div align="left"><%=(((RSFICHA_data = RSFICHA.getObject("PIN"))==null || RSFICHA.wasNull())?"":RSFICHA_data)%></div></td>
                                  <td width="6%" valign="top" nowrap  ><div align="right">Ficha<strong>:</strong> </div></td>
                                  <td width="11%" valign="top"> <%=(((RSTIPO_FICHA_data = RSTIPO_FICHA.getObject("DESC_FICHAJE"))==null || RSTIPO_FICHA.wasNull())?"":RSTIPO_FICHA_data)%>                           
                                 																	
                                     </td>
                                  <td width="6%" valign="top"  ><div align="center">
                                    
                                    </div></td>
                          </tr>
                        </table>
                      </div></th>
                    </tr>     
                                <tr>  
								 
								  
								</tr>
	                            <tr><td colspan=2> <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
	                             							
  </tr>
  <tr>
                        <% while ((RSCONSULTA_hasData)&&(Repeat3__numRows-- != 0)) { %>
						<%=(((RSCONSULTA_data = RSCONSULTA.getObject("D1"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%>                        <%  						                          
  Repeat3__index++;
  RSCONSULTA_hasData = RSCONSULTA.next();
}
%>
             
                             
                        </table></td>
								</tr>
								<table width="95%"  border="1" cellspacing="1" cellpadding="4">
								<tr align="center"><td colspan=2><table width="100%" border="0" cellspacing="1" cellpadding="4">								     
                                      <tr bgcolor="#FFFFDD"> 
                                        <td colspan="25"><div align="center">
                                          <p><b>Resumen del d&iacute;a</b>:<b> <%= RSFICHAJE_DIA__MMColParam2 %></b></p>
                                          </div></td>
                                          <% 
									 datos = null;
									 datos_policia = null;
									 mensaje_saldo  = "";
									 saldo = 0;

									if (RSFICHAJE_DIA_hasData && RSFICHAJE_DIA.getString("SALDO_DIARIO")!=null) 
										{ 
											datos = new Double( (String) RSFICHAJE_DIA.getString("SALDO_DIARIO") );
											datos_policia = new Double( (String) RSF__MMColParam1 );
											if (datos_policia.intValue() < 2000)
												{	
												if (datos.intValue() < 0 ) 
												  { 
													mensaje_saldo = "Saldo diario le faltan "; 
													saldo = datos.doubleValue()*(-1.0); 
	    										 } else { 
													mensaje_saldo = "Saldo diario le sobran "; 
													saldo = datos.doubleValue(); 
	    											}
									Double ho = new Double( saldo / 60 );
									Double mi = new Double( saldo % 60);
									mensaje_saldo += ho.intValue() + " hora/s y " + mi.intValue() + " minuto/s.";
										} else {
											mensaje_saldo = " "; 
											}	
									} 
									else 
										{ 
											datos = new Double(0);
											mensaje_saldo = "No existen fichajes para el periodo seleccionado.";
										}
											%>						
                              <td colspan=10 width="10%" nowrap class="va12b"  ><div align="center"><strong><%= mensaje_saldo %></strong></div></td>
                            
                                      </tr>                                      
                                       <tr> 
                                        <td width="10%" colspan=5 align="center"><span class="va10b"></span></td>
                                        <td width="30%" colspan=10 bgcolor="#E5E7E9" align="center">Mañana</td>
                                        <td width="30%" colspan=10 bgcolor="#D7DBDD" align="center">Tarde</td>
                                        <td width="30%" colspan=10  align="center"></td>
                                        
                                      </tr>
                                      <tr> 
                                        <td  colspan=5  width="10%" bgcolor="#CCCCCC" align="center">Tipo Día<span class="va10b"></span></td>
                                        <td width="20%" colspan=5 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="20%" colspan=5 bgcolor="#F2F3F4" align="center">Flexible</td>
                                        <td width="20%" colspan=5 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="20%" colspan=5 bgcolor="#F2F3F4" align="center">Flexible</td>                                        
                                        <td width="20%" colspan=5 bgcolor="#CCCCCC" align="center">Horas Jornada</td>
                                         <td width="20%" colspan=5 bgcolor="#CCCCCC" align="center">Horas Fichadas</td>
                                     
                                      </tr>
                                         <tr> 
                                        <td  colspan=5  align="center"><span class="va10b"><%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("DENOMINACION"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%></span>
                                        </td>
                                        <td nowrap  colspan=5  align="center"> 
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_MAÑANA_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_MAÑANA_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                     </td>
                                        <td nowrap  colspan=5  align="center">
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_MAÑANA_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_MAÑANA_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>                               
                                        </td>
                                        <td  nowrap colspan=5  align="center">
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_TARDE_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_TARDE_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>                                
                                           
                                     </td>
                                        <td  nowrap colspan=5  align="center">    
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_TARDE_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_TARDE_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                </td>                                        
                                        <td  colspan=5  align="center">   
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("HORAS_HACER"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                </td>
                                <td  colspan=5  align="center">   
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("HORAS_FICHADAS"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                </td>
                                      </tr>
                                     
                                    </table>	</td>
								</tr>
								</table> <tr>
								<td colspan=2 align="center">
								
               <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                      <tr>
                                        <td colspan=2 width="35%" align="right"><div align="right">										
										    <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                           
                                            <tr>
                                             <td colpsan=8>
		  <table width="75%" >
                      <% if (!RSAUSE_TOTAL_isEmpty ) { %>
								<tr bgcolor="#EFEFEF"  align="center"> 
                                        <td colspan="4"><div align="center">
                                          <p><b>Ausencias o compensatorios en el día</b></p></td>
                                          </tr>
                                          <tr bgcolor="#EFEFEF"> 
                                          <td colspan="1" align="center">Tipo</td>
                                          <td colspan="1" align="center">Hora Inicio</td>
                                          <td colspan="1" align="center">Hora Fin</td>
                                          <td colspan="1" align="center">Justificada</td>
                                          </tr>
                                           <% while ((RSAUSE_TOTAL_hasData)&&(Repeat6__numRows-- != 0)) { %>
                                      <% if (!RSAUSE_TOTAL_isEmpty ) { %>
                                           <tr bgcolor="#ECECEC"> 
                                          <td colspan="1" align="center"><%=(((RSAUSE_TOTAL_data = RSAUSE_TOTAL.getObject("TIPO"))==null || RSAUSE_TOTAL.wasNull())?"":RSAUSE_TOTAL_data)%></td>
                                          <td colspan="1" align="center"><%=(((RSAUSE_TOTAL_data = RSAUSE_TOTAL.getObject("FECHA_INICIO"))==null || RSAUSE_TOTAL.wasNull())?"":RSAUSE_TOTAL_data)%></td>
                                          <td colspan="1" align="center"><%=(((RSAUSE_TOTAL_data = RSAUSE_TOTAL.getObject("FECHA_FIN"))==null || RSAUSE_TOTAL.wasNull())?"":RSAUSE_TOTAL_data)%></td>
                                          <td colspan="1" align="center"><%=(((RSAUSE_TOTAL_data = RSAUSE_TOTAL.getObject("JUSTIFICADO"))==null || RSAUSE_TOTAL.wasNull())?"":RSAUSE_TOTAL_data)%></td>
                                          </tr>
                                           <% } /* end !RSQUERY_isEmpty */ %>
                                           <%
                                           Repeat6__index++;
                                           RSAUSE_TOTAL_hasData = RSAUSE_TOTAL.next();
                                           }
                                           }%>
</table>
  </td> 
                                              <td colspan=3 bgcolor="#33FFFF">
											  <input type="hidden" name="campo_final" value="">
											  <div align="center"><b>Transacciones</b></div></td>
                                        </tr>
                                            <tr> <td  colspan=4 align="center" bgcolor="#CCCCCC"><span class="va10b">LUGAR</span></td>
                                              <td colspan=3 align="center" bgcolor="#CCCCCC"><span class="va10b">HORA</span></td>
                                        </tr>
                                            <% while ((RSDET_TRAN_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                            <% if (!RSDET_TRAN_isEmpty ) { %>
                                            <tr>
										         <td colpsan=4 align="center" valign="bottom" nowrap bgcolor="#FFFFFF">
										        <%=(((RSDET_TRAN_data = RSDET_TRAN.getObject("RELOJ"))==null || RSDET_TRAN.wasNull())?"":RSDET_TRAN_data)%>
											    </td>
											    <td colspan=3 nowrap>
											    <%=(((RSDET_TRAN_data = RSDET_TRAN.getObject("HORA"))==null || RSDET_TRAN.wasNull())?"":RSDET_TRAN_data)%> :
											    <%=(((RSDET_TRAN_data = RSDET_TRAN.getObject("MINUTO"))==null || RSDET_TRAN.wasNull())?"":RSDET_TRAN_data)%>
								     
 
                                  
										       </td> 
                                        </tr>
                                            <% } /* end !RSQUERY_isEmpty */ %>
                                              
                                            <%
  Repeat1__index++;
  RSDET_TRAN_hasData = RSDET_TRAN.next();
                                            }
%>           
           
			  
		
											  
                                        </table> </form></td>
                                        <td>
                                        
                                        </td>
                                        
                                        <td width="75%"><table width="45%" border="0" cellspacing="1" cellpadding="4">
                                      <tr bgcolor="#FFFFDD"> 
                                        <td colspan="5" bgcolor="#CCFFCC"><div align="center"><b>Fichajes</b></div></td>
                                      </tr>
                                      <tr> 
                                        <td align="center" bgcolor="#CCCCCC">INICIO</td>
                                        <td align="center" bgcolor="#CCCCCC">FIN</td>
                                        <td align="center" bgcolor="#CCCCCC">RELOJ</td>
                                        <td colspan=5 align="center" bgcolor="#CCCCCC">TIEMPO FICHADO</td>
                                      </tr>
                                      <% while ((RSDET_FICH_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                      <% if (!RSDET_FICH_isEmpty ) { %>
                                      <tr>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("INICIO"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("FIN"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("RELOJ"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("HORAS_FICHADAS"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                      </tr>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat2__index++;
                                      RSDET_FICH_hasData = RSDET_FICH.next();
}
%>

                                    </table>
								
								</td>
								</tr> <br/>
								<tr><td></td></tr>
		
								
	</table>
		</div>
</div>
	</div>
</body>
</html>
<%
RSPERIO.close();
StatementRSPERIO.close();
ConnRSPERIO.close();
%>
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
<%
RSTIPO_FICHA.close();
StatementRSTIPO_FICHA.close();
ConnRSTIPO_FICHA.close();
%>
<%
RSFICHA.close();
StatementRSFICHA.close();
ConnRSFICHA.close();
%>
<%
RSSALDO.close();
StatementRSSALDO.close();
ConnRSSALDO.close();
%>