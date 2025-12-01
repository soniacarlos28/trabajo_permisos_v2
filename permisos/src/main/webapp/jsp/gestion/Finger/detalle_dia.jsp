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
PreparedStatement StatementRSFICHAJE_DIA = ConnRSFICHAJE_DIA.prepareStatement("SELECT id_secuencia,       id_funcionario,       pin,       id_dia,       devuelve_min_fto_hora(horas_saldo) as horas_saldo,       horas_saldo-horas_hacer as saldo_diario, devuelve_min_fto_hora(horas_fuera_saldo) as fuera_saldo,       devuelve_min_fto_hora(horas_hacer) as horas_hacer,       festivo,       permiso,       ausencia,       turno1,       turno2,       turno3,       id_calendario,       horas_extras_pagada,       horas_extras_compensada,       audit_usuario,       audit_fecha,       incidencias,       numero_fichajes,       numero_transacciones,       obli_mañana_1,       obli_mañana_2,       fle_mañana_1,       fle_mañana_2,       obli_tarde_1,       obli_tarde_2,       fle_tarde_1,       fle_tarde_2,       obli_noche_1,       obli_noche_2,       fle_noche_1,       fle_noche_2,       comida,       libre        FROM fichaje_funcionario_resu_dia  WHERE id_dia =    to_Date('" + RSFICHAJE_DIA__MMColParam2 + "', 'dd/mm/yyyy')   and lpad(id_funcionario, 6, '0') =    lpad('" + RSFICHAJE_DIA__MMColParam1 + "', 6, '0')");
ResultSet RSFICHAJE_DIA = StatementRSFICHAJE_DIA.executeQuery();
boolean RSFICHAJE_DIA_isEmpty = !RSFICHAJE_DIA.next();
boolean RSFICHAJE_DIA_hasData = !RSFICHAJE_DIA_isEmpty;
Object RSFICHAJE_DIA_data;
int RSFICHAJE_DIA_numRows = 0;
String PERIODO_PAR;
%>
<%
String RSSALDO_PERIODO__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSSALDO_PERIODO__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSSALDO_PERIODO__MMColParam3 = "000000";
if (request.getParameter("ID_DIA")             !=null) {RSSALDO_PERIODO__MMColParam3 = (String)request.getParameter("ID_DIA")            ;}
%>  

<%
Driver DriverRSSALDO_PERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSSALDO_PERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSSALDO_PERIODO = ConnRSSALDO_PERIODO.prepareStatement("select sum(horas_saldo-horas_hacer) as saldo  from fichaje_funcionario_resu_dia t,  webperiodo ow where id_funcionario = '" + RSSALDO_PERIODO__MMColParam1 + "'   and mes||ano = devuelve_periodo('" + RSSALDO_PERIODO__MMColParam3 + "') and t.id_dia<>to_Date('29/04/2019','dd/mm/yyyy')     and  t.id_dia  between ow.inicio and ow.fin  and t.id_dia<to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy')");
ResultSet RSSALDO_PERIODO = StatementRSSALDO_PERIODO.executeQuery();
boolean RSSALDO_PERIODO_isEmpty = !RSSALDO_PERIODO.next();
boolean RSSALDO_PERIODO_hasData = !RSSALDO_PERIODO_isEmpty;
Object RSSALDO_PERIODO_data;
int RSSALDO_PERIODO_numRows = 0;
%>

<%
String RSSALDO_NEW__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSSALDO_NEW__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSSALDO_NEW__MMColParam3 = "000000";
if (request.getParameter("ID_DIA")             !=null) {RSSALDO_NEW__MMColParam3 = (String)request.getParameter("ID_DIA")            ;}
%>  
<%
Driver DriverRSSALDO_NEW = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSSALDO_NEW = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSSALDO_NEW = ConnRSSALDO_NEW.prepareStatement("select devuelve_min_fto_hora(sum(horas_saldo-horas_hacer)) as saldo  from fichaje_funcionario_resu_dia t where id_funcionario = '" + RSSALDO_NEW__MMColParam1 + "'   and id_dia ='" + RSSALDO_NEW__MMColParam3 + "'  ");
ResultSet RSSALDO_NEW = StatementRSSALDO_NEW.executeQuery();
boolean RSSALDO_NEW_isEmpty = !RSSALDO_NEW.next();
boolean RSSALDO_NEW_hasData = !RSSALDO_NEW_isEmpty;
Object RSSALDO_NEW_data;
int RSSALDO_NEW_numRows = 0;
%>

 <%
String RSINCIDENCIA_DIA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSINCIDENCIA_DIA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSINCIDENCIA_DIA__MMColParam3 = "01/01/2019";
if (request.getParameter("ID_DIA")             !=null) {RSINCIDENCIA_DIA__MMColParam3 = (String)request.getParameter("ID_DIA")            ;}
%>  
<%
Driver DriverRSINCIDENCIA_DIA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSINCIDENCIA_DIA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSINCIDENCIA_DIA = ConnRSINCIDENCIA_DIA.prepareStatement(" select  id_incidencia,   desc_tipo_incidencia,    observaciones  from fichaje_incidencia fi,tr_tipo_incidencia t where id_estado_inc=0 and fi.id_tipo_incidencia=t.id_tipo_incidencia and id_funcionario = '" + RSINCIDENCIA_DIA__MMColParam1 + "' and fecha_incidencia= to_Date('" + RSINCIDENCIA_DIA__MMColParam3 + "','dd/mm/yyyy') ");
ResultSet RSINCIDENCIA_DIA = StatementRSINCIDENCIA_DIA.executeQuery();
boolean RSINCIDENCIA_DIA_isEmpty = !RSINCIDENCIA_DIA.next();
boolean RSINCIDENCIA_DIA_hasData = !RSINCIDENCIA_DIA_isEmpty;
Object RSINCIDENCIA_DIA_data;
int RSINCIDENCIA_DIA_numRows = 0;
%>

<%
String RSPERMISO_DIA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSPERMISO_DIA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSPERMISO_DIA__MMColParam3 = "01/01/2019";
if (request.getParameter("ID_DIA")             !=null) {RSPERMISO_DIA__MMColParam3 = (String)request.getParameter("ID_DIA")            ;}
%>  
<%
Driver DriverRSPERMISO_DIA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERMISO_DIA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERMISO_DIA = ConnRSPERMISO_DIA.prepareStatement(" select pe.id_ano as año,DESC_TIPO_PERMISO, to_char(pe.FEcha_inicio,'dd/mm/yyyy') as fecha_inicio,to_char(pe.fecha_fin,'dd/mm/yyyy') as fecha_fin,desc_estado_permiso as estado ,pe.num_dias as num_dias,pe.justificacion as justificacion from permiso pe, TR_ESTADO_PERMISO t,tr_tipo_permiso tr   where id_estado not in (41,42,40,31,32)and t.id_estado_permiso=pe.id_estado and tr.id_tipo_permiso=pe.id_tipo_permiso and tr.id_Ano=pe.id_ano and id_funcionario = '" + RSPERMISO_DIA__MMColParam1 + "' and  to_Date('" + RSPERMISO_DIA__MMColParam3 + "','dd/mm/yyyy')  between pe.fecha_inicio and nvl(pe.fecha_fin,sysdate)   ");
ResultSet RSPERMISO_DIA = StatementRSPERMISO_DIA.executeQuery();
boolean RSPERMISO_DIA_isEmpty = !RSPERMISO_DIA.next();
boolean RSPERMISO_DIA_hasData = !RSPERMISO_DIA_isEmpty;
Object RSPERMISO_DIA_data;
int RSPERMISO_DIA_numRows = 0;
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
PreparedStatement StatementRSTRANS_TOTAL = ConnRSTRANS_TOTAL.prepareStatement("select nvl(count(*), 0) as total from  persona p,  transacciones t, APLIWEB_USUARIO U  where t.fecha = to_Date('" + RSTRANS_TOTAL__MMColParam2 + "', 'dd/mm/yyyy') and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') = lpad('" + RSTRANS_TOTAL__MMColParam1 + "', 6, '0')  and p.numtarjeta = t.pin    and tipotrans in ('3','2', '55') "); 
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
PreparedStatement StatementRSFICHA_TOTAL = ConnRSFICHA_TOTAL.prepareStatement("select nvl(count(*),0) as total  FROM PRESENCI     R, PERSFICH     B,  WEBPERIODO   C, PERSONA      P, APLIWEB_USUARIO    U,   CALENDARIO_LABORAL CA  where     b.fecha = to_Date('" + RSFICHA_TOTAL__MMColParam2 + "','dd/mm/yyyy')   and lpad(r.codpers, 6, '0') = lpad(u.id_fichaje, 6, '0') and r.fecha = CA.ID_DIA  and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0')  and lpad(B.NPERSONAL, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') =lpad('" + RSFICHA_TOTAL__MMColParam1 + "',6,'0')    and CA.id_ano = c.ANO  AND CA.ID_DIA BETWEEN C.INICIO AND C.FIN      AND CA.ID_DIA = B.FECHA");
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
PreparedStatement StatementRSFICHA = ConnRSFICHA.prepareStatement("select to_char(sysdate,'d') as dia_n ,to_char(sysdate,'day') as dia_no,'DEDO: ' || NVL(PIN,'SIN') || '- TARJETA: ' || NVL(PIN2,'SIN')  as PIN,to_char(nvl(ID_TIPO_FIcHAJE,9))as ID_TIPO_FICHAJE,p.id_funcionario from FUNCIONARIO_FICHAJE f,personal_new p where f.id_funcionario(+)=p.id_funcionario and lpad(p.id_funcionario,6,'0')=lpad('" + RSFICHA__MMColParam1 + "',6,'0') ");

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
PreparedStatement StatementRSDET_TRAN = ConnRSDET_TRAN.prepareStatement("select numserie as clavef,       to_char(fecha_fichaje,'dd/mm/yyyy') as fecha_d,       to_char(fecha_fichaje, 'dd/mm/yyyy') AS FECHA,       to_char(fecha_fichaje, 'hh24') AS HORA,       to_char(fecha_fichaje, 'mi') AS MINUTO,       LPAD(NVL(denom, 'MANUAL  '), 22, ' ') as reloj,	   computadas,	   valido  from fichaje_funcionario_tran f,        relojes       r where to_Date(to_char(fecha_fichaje,'dd/mm/yyyy'),'dd/mm/yyyy') =to_Date('" + RSTRANS_TOTAL__MMColParam2 + "', 'dd/mm/yyyy')       and lpad(f.id_funcionario, 6, '0') =  lpad('" + RSFICHA_TOTAL__MMColParam1 + "', 6, '0')	   and f.reloj = r.numero(+)    order by hora");
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
PreparedStatement StatementRSDET_FICH = ConnRSDET_FICH.prepareStatement("select to_char(fecha_fichaje_entrada, 'hh24:mi') as INICIO,       to_char(fecha_fichaje_salida, 'hh24:mi') AS FIN,       trim(LPAD(NVL(r.denom,'MANUAL  '),22,' '))  as  RELOJ_E,       trim(LPAD(NVL(ra.denom,'MANUAL  '),22,' '))   as  RELOJ_S,      to_char( COMPUTADAS) as computadas,       lpad((horas_saldo-mod(horas_saldo,60))/60,2,'0')  ||':'||  lpad(mod(trunc(horas_saldo),60),2,'0')   as  saldo,       horas_fichadas as horas_fichadas,lpad(ID_SEC_ENTRADA,10,'0')as ID_SEC_ENTRADA ,lpad(ID_SEC_SALIDA,10,'0') as ID_SEC_SALIDA ,NVL(ID_TIPO_HORAS,0) as ID_TIPO_HORAS from fichaje_funcionario ff, relojes r , relojes ra,horas_extras He  where     to_Date(to_char(fecha_fichaje_entrada, 'dd/mm/yyyy'), 'dd/mm/yyyy') =  to_Date('" + RSTRANS_TOTAL__MMColParam2 + "', 'dd/mm/yyyy')  and   lpad(ff.id_funcionario, 6, '0') = lpad('" + RSFICHA_TOTAL__MMColParam1 + "', 6, '0')              and ff.reloj_entrada=r.numero(+)       and ff.reloj_salida=ra.numero(+) and ff.id_secuencia=he.phe(+) and   (he.ANULADO(+) = 'NO' OR he.ANULADO(+) IS NULL) order by INICIO  ");
ResultSet RSDET_FICH = StatementRSDET_FICH.executeQuery();
boolean RSDET_FICH_isEmpty = !RSDET_FICH.next();
boolean RSDET_FICH_hasData = !RSDET_FICH_isEmpty;
Object RSDET_FICH_data;
int RSDET_FICH_numRows = 0;
%>

<%
int Repeat1__numRows = -1;
int RS_total = 0;
int Repeat1__index = 0;
RSDET_TRAN_numRows += RSDET_TRAN_numRows;
%>

<%
// *** Recordset Stats: if we don't know the record count, manually count them

  // count the total records by iterating through the recordset
    for (RS_total = 0; RSDET_FICH.next(); RS_total++);

  // reset the cursor to the beginning
    RSDET_FICH.close();
  RSDET_FICH = StatementRSDET_FICH.executeQuery();
  RSDET_FICH_hasData = RSDET_FICH.next();


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
String RSCONSULTA__MMColParam2 = "000000";
if (request.getParameter("PERIODO")             !=null) {RSCONSULTA__MMColParam2  = (String)request.getParameter("PERIODO");  }

String RSPERIODO__MMColParam3;
RSPERIODO__MMColParam3 = (String)(((RSPERIODO_data = RSPERIODO.getObject("PER"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data);

%>


<%
Driver DriverRSCONSULTA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCONSULTA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCONSULTA = ConnRSCONSULTA.prepareStatement("select distinct id_dia, des_col  as d1   from calendario_final  c where   C.MES||C.ANO =DECODE('" + RSPERIODO__MMColParam3 + "','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSPERIODO__MMColParam3 + "')   and id_funcionario in ('" + RSCONSULTA__MMColParam1 + "',0)    order by id_dia");
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
Driver DriverRSFALTAN = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFALTAN = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFALTAN = ConnRSFALTAN.prepareStatement("select ca.ID_DIA ,        DECODE(r.id_dia,null, '<td width=\"2%\" bgcolor=\"#FFFFFF\" ><div align=\"center\"></div></td>','<td width=\"2%\" bgcolor=\"#FFEE58\" ><div align=\"center\">!</div></td>') AS CADENA                                   from resumen_saldo r  ,calendario_laboral ca,  webperiodo w         where                ca.id_dia =r.id_dia(+) and               ca.id_dia between w.inicio and w.fin and               HH(+) <> 0 and HR(+) = 0                              and w.mes ||w.ano =DECODE('" + RSCONSULTA__MMColParam2 + "','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSCONSULTA__MMColParam2 + "')   and r.id_funcionario(+) in ('" + RSCONSULTA__MMColParam1 + "',0)    and ano > 2015     order by ca.id_dia");
ResultSet RSFALTAN = StatementRSFALTAN.executeQuery();
boolean RSFALTAN_isEmpty = !RSFALTAN.next();
boolean RSFALTAN_hasData = !RSFALTAN_isEmpty;
Object RSFALTAN_data;
int RSFALTAN_numRows = 0;
%>
<%
int Repeat13__numRows = -1;
int Repeat13__index = 0;
RSFALTAN_numRows += Repeat13__numRows;
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
<%
Driver DriverRS_TipoHoras = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_TipoHoras = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_TipoHoras = ConnRS_TipoHoras.prepareStatement("SELECT DISTINCT ID_TIPO_HORAS, DESC_TIPO_HORAS || '--Factor: '|| FACTOR as DESC_TIPO_HORAS  FROM RRHH.TR_TIPO_HORA  ORDER BY DESC_TIPO_HORAS");
ResultSet RS_TipoHoras = StatementRS_TipoHoras.executeQuery();
boolean RS_TipoHoras_isEmpty = !RS_TipoHoras.next();
boolean RS_TipoHoras_hasData = !RS_TipoHoras_isEmpty;
Object RS_TipoHoras_data;
int RS_TipoHoras_numRows = 0;
%>
							  


<script language="Javascript" >

function regenera(ida3) {

   var ida = 0;
   var ida2= ida3+1;
   var campo_final; 
   var computa_final;
 
   campo_final=""; 
   computa_final="";
   
     while (ida < 11 ) 
        {

         	if (       document.getElementById('campoc' + ida).value == 1 || document.getElementById('valorc' + ida).value==3 )

     		    {
                         campo_final= campo_final + 'CLAVE' 
                                                + document.getElementById('CLAVE_HORA_' + ida).value + 
                                     ';FICHAJE' + document.getElementById('TR_HORA_' + ida).value + ':' 
                                                + document.getElementById('TR_MINUTO_' + ida).value + 
                                       ';VALOR' + document.getElementById('valorc' + ida).value   +';*';
                         
		      }		

          
         	      
       if (ida2 > ida ) //quitado && ida3 > 0
           {	
           if (document.getElementById('COMPUTA_' + ida))     
         	if (       document.getElementById('COMPUTA_' + ida).value == "1" || document.getElementById('COMPUTA_' + ida).value == "2" || document.getElementById('COMPUTA_' + ida).value == "0" )

 		       {
                     computa_final= computa_final + 'CLAVE_FICHAJE'   
                                    + document.getElementById('CLAVE_ENTRADA_' + ida).value 
                                    + ';VALOR' +  document.getElementById('COMPUTA_' + ida).value
                                    + ';TIPO_HORAS' + document.getElementById('TIPO_HORAS_' + ida).value + ';*';
                   
                    
	           }		  
            }


					
         	ida = ida + 1;
			  
		}


 		
		document.getElementById('campo_final').value=campo_final;
		document.getElementById('computa_final').value=computa_final;
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

function mostrarOcultar( tipo) 
{ 

	
         	if (       document.getElementById('COMPUTA_' + tipo).value == 1 || document.getElementById('COMPUTA_' + tipo).value==2 )
                   document.getElementById('HORAS_EXTRAS_TIPO_'+ tipo).style.display='';  
            else                           
                   document.getElementById('HORAS_EXTRAS_TIPO_'+ tipo).style.display='none';  
    
};
function carga_final(ida2)
{
	
    ida=0;
    var ida3= ida2+1;
    
	 while (ida < ida3 ) 
     {

		 if (  document.getElementById('COMPUTA_' + ida).value == 1 || document.getElementById('COMPUTA_' + ida).value==2 )
             document.getElementById('HORAS_EXTRAS_TIPO_'+ ida).style.display='';  
          else                           
             document.getElementById('HORAS_EXTRAS_TIPO_'+ ida).style.display='none';  
      	 ida = ida + 1;
     }
	    		
	
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
<body  OnLoad="carga_final(<%=  RS_total %>)">
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
      <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>  
       <li><a href="gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
       <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
        <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

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
		<li><a href="../Finger" id="current">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
		<li><a href="../Bolsa_concilia" >Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" >Incidencias  Fichajes</a></li>
	  </ul>
	</div>
	
	<table width="100%" border="0" cellspacing="5" cellpadding="0">
	   <tr > 
                      <th>
					    <div align="left">
					      <table border="0" cellspacing="0" cellpadding="2">
					        
					        <tr>
					          
					          <td class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;</td>
							  
							  <td nowrap width="10%" class="va12b"  ><div align="right"><strong>Saldo Periodo:</strong> </div></td>
							  					 <% 
									Double datos = null;
									Double datos_policia = null;
									String mensaje_saldo  = "";
									double saldo = 0;

									if (RSSALDO_PERIODO_hasData && RSSALDO_PERIODO.getString("SALDO")!=null) 
										{ 
											datos = new Double( (String) RSSALDO_PERIODO.getString("SALDO") );
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
                            
                            <td width="10%" valign="center" class="va12b" ><div align="right">PIN:</div></td>
                                  <td width="7%" valign="center" >
                                    <div align="left"><%=(((RSFICHA_data = RSFICHA.getObject("PIN"))==null || RSFICHA.wasNull())?"":RSFICHA_data)%> </div></td>
                                  <td width="6%" valign="center" nowrap  ><div align="right">Ficha<strong>:</strong> </div></td>
                                  <td width="11%" valign="center"> <%=(((RSTIPO_FICHA_data = RSTIPO_FICHA.getObject("DESC_FICHAJE"))==null || RSTIPO_FICHA.wasNull())?"":RSTIPO_FICHA_data)%>                           
                                   <td width="1%" align="right" valign="top" nowrap bgcolor="#ffffff"><a href="detalle_dia_excel.jsp?ID_DIA=<%= RSSALDO_NEW__MMColParam3 %> "><img src="../../imagen/excel_f.jpg" border="0" width="61" height="28" alt="Exporta a Excel"></a></td>         
                      																				
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

             <tr>
              <% while ((RSFALTAN_hasData)&&(Repeat13__numRows-- != 0)) { %>
						<%=(((RSFALTAN_data = RSFALTAN.getObject("CADENA"))==null || RSFALTAN.wasNull())?"":RSFALTAN_data)%>                        <%  						                          
  Repeat13__index++;
						RSFALTAN_hasData = RSFALTAN.next();
}
%>
                   </tr>          
                        </table></td>
								</tr>
								 <% if (!RSFICHAJE_DIA_isEmpty ) { %>
								 <tr>
								 <td colspan=2>
								<table width="100%"  border="1" cellspacing="1" cellpadding="4">
								<tr align="center"><td colspan=2><table width="100%" border="0" cellspacing="1" cellpadding="4">								     
                                      <tr bgcolor="#FFFFDD"> 
                                        <td colspan="14"><div align="center">
                                          <p><b>Resumen del d&iacute;a</b>:<b> <%= RSFICHAJE_DIA__MMColParam2 %></b></p>
                                          </div></td>
                                         				
                              <td colspan=3 width="10%" nowrap class="va12b"  ><div align="center"><strong><strong><%=(((RSSALDO_NEW_data = RSSALDO_NEW.getObject("SALDO"))==null || RSSALDO_NEW.wasNull())?"":RSSALDO_NEW_data)%></strong></strong></div></td>
                            
                                      </tr>                                      
                                       <tr> 
                                        
                                        <td width="30%" colspan=4 bgcolor="#E5E7E9" align="center">Mañana</td>
                                        <td width="30%" colspan=4 bgcolor="#D7DBDD" align="center">Tarde</td>
                                        <td width="30%" colspan=4 bgcolor="#E5E7E9" align="center">Noche</td>
                                        <td width="30%" colspan=2 bgcolor="#D7DBDD" align="center">Opciones</td>
                                         <td width="30%" colspan=3 bgcolor="#E5E7E9" align="center">Jornada</td>
                                        
                                      </tr>
                                      <tr>                                        
                                        <td width="10%" colspan=2 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="10%" colspan=2 bgcolor="#F2F3F4" align="center">Flexible</td>
                                        <td width="10%" colspan=2 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="10%" colspan=2 bgcolor="#F2F3F4" align="center">Flexible</td> 
                                         <td width="10%" colspan=2 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="10%" colspan=2 bgcolor="#F2F3F4" align="center">Flexible</td>
                                        <td width="10%" colspan=1 bgcolor="#CACFD2" align="center">Comida</td>
                                        <td width="10%" colspan=1 bgcolor="#F2F3F4" align="center">Libre</td>                                                                                                                    
                                        <td width="10%" colspan=1 bgcolor="#CCCCCC" align="center">Hacer</td>
                                         <td width="10%" colspan=1 bgcolor="#CCCCCC" align="center">Fichadas</td>
                                            <td width="10%" colspan=1 bgcolor="#CCCCCC" align="center">Fuera Saldo</td>
                                     
                                      </tr>
                                      <% if (!RSFICHAJE_DIA_isEmpty ) { %>
                                         <tr> 
                                          <td nowrap width="10%" colspan=2  align="center"> 
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_MAÑANA_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_MAÑANA_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                     </td>
                                        <td nowrap width="10%" colspan=2  align="center">
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_MAÑANA_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_MAÑANA_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>                              
                                        </td>
                                        <td width="10%" nowrap colspan=2  align="center">
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_TARDE_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_TARDE_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>                                
                                           
                                     </td>
                                        <td width="10%" nowrap colspan=2  align="center">    
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_TARDE_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_TARDE_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                </td>      
                                 <td width="10%" nowrap colspan=2  align="center">
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_NOCHE_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("OBLI_NOCHE_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>                                
                                           
                                     </td>
                                        <td width="10%" nowrap colspan=2  align="center">    
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_NOCHE_1"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%> - 
                                          <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FLE_NOCHE_2"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                </td>      <td width="10%" colspan=1  align="center">   
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("COMIDA"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                </td>
                                 <td width="10%" colspan=1  align="center">   
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("LIBRE"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                </td>                                              
                                        <td width="10%" colspan=1  align="center" nowrap>   
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("HORAS_HACER"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>                                </td>
                                <td width="10%" colspan=1  align="center" nowrap>   
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("HORAS_SALDO"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                </td>
                                   <td width="10%" colspan=1  align="center" nowrap>   
                                           <%=(((RSFICHAJE_DIA_data = RSFICHAJE_DIA.getObject("FUERA_SALDO"))==null || RSFICHAJE_DIA.wasNull())?"":RSFICHAJE_DIA_data)%>
                                </td>
                                      </tr> <% } %>
                                     
                                    </table>	</td>
                                    
								</tr>
								</table> 
								 </td>
								 </tr>
								  <% } %>
								   <% if (!RSPERMISO_DIA_isEmpty ) { %>
								  <tr>
								    <td colspan=2 align="center" bgcolor="#E0E7FE">
								   	<table width="100%"  border="1" cellspacing="1" cellpadding="4">
								    <tr align="center"> <td colspan="14"><div align="center">
                                          <p><b>Permisos en el día</b>:<b> <%= RSFICHAJE_DIA__MMColParam2 %></b></p>
                                          </div></td>
								    </tr>
								    <tr> 
                                         <td width="15%" colspan=1 bgcolor="#E5E7E9" align="center">Año</td>
                                         <td width="15%" colspan=1 bgcolor="#E5E7E9" align="center">Tipo</td>
                                        <td width="15%" colspan=1 bgcolor="#E5E7E9" align="center">Fecha Inicio</td>
                                        <td width="15%" colspan=1 bgcolor="#D7DBDD" align="center">Fecha Fin</td>
                                        <td width="15%" colspan=1 bgcolor="#E5E7E9" align="center">Estado </td>
                                        <td width="15%" colspan=1 bgcolor="#D7DBDD" align="center">Número días</td>
                                         <td width="15%" colspan=1 bgcolor="#E5E7E9" align="center">Justificado</td>
                                        
                                      </tr>
                                      
                                      <tr> <td nowrap width="17%"  bgcolor="#FFFFFF" align="center"><%=(((RSPERMISO_DIA_data = RSPERMISO_DIA.getObject("AÑO"))==null || RSPERMISO_DIA.wasNull())?"":RSPERMISO_DIA_data)%></td>                                                                                   
                                           <td nowrap width="17%"  bgcolor="#FFFFFF" align="center"><%=(((RSPERMISO_DIA_data = RSPERMISO_DIA.getObject("DESC_TIPO_PERMISO"))==null || RSPERMISO_DIA.wasNull())?"":RSPERMISO_DIA_data)%></td>                                        
                                          <td nowrap width="17%"  bgcolor="#FFFFFF" align="center"><%=(((RSPERMISO_DIA_data = RSPERMISO_DIA.getObject("FECHA_INICIO"))==null || RSPERMISO_DIA.wasNull())?"":RSPERMISO_DIA_data)%></td>
                                          <td nowrap width="17%"   bgcolor="#FFFFFF" align="center"><%=(((RSPERMISO_DIA_data = RSPERMISO_DIA.getObject("FECHA_FIN"))==null || RSPERMISO_DIA.wasNull())?"":RSPERMISO_DIA_data)%></td>
                                          <td nowrap width="17%"   bgcolor="#FFFFFF" align="center"><%=(((RSPERMISO_DIA_data = RSPERMISO_DIA.getObject("ESTADO"))==null || RSPERMISO_DIA.wasNull())?"":RSPERMISO_DIA_data)%></td>
                                          <td nowrap width="17%"   bgcolor="#FFFFFF" align="center"><%=(((RSPERMISO_DIA_data = RSPERMISO_DIA.getObject("NUM_DIAS"))==null || RSPERMISO_DIA.wasNull())?"":RSPERMISO_DIA_data)%></td>
                                          <td nowrap width="17%"   bgcolor="#FFFFFF" align="center"><%=(((RSPERMISO_DIA_data = RSPERMISO_DIA.getObject("JUSTIFICACION"))==null || RSPERMISO_DIA.wasNull())?"":RSPERMISO_DIA_data)%></td>
                                       </tr>
								    </table>
								 </td>
								 </tr>
								  <% } %>
								  <% if (!RSINCIDENCIA_DIA_isEmpty ) { %>
								  <tr>
								    <td colspan=2 align="center" >
								   	<table width="50%"  border="1" cellspacing="1" cellpadding="4"  bgcolor="#FCE4E4" >
								    <tr align="center"> <td colspan="14"><div align="center">
                                          <p><b>Incidencias en el día</b>:<b> <%= RSFICHAJE_DIA__MMColParam2 %></b></p>
                                          </div></td>
								    </tr>
								    <tr> 
                                         
                                         <td colspan=1 bgcolor="#E5E7E9" align="center">Tipo Incidencia</td>
                                        <td  colspan=1 bgcolor="#E5E7E9" align="center">Observaciones</td>
                                        
                                      </tr>
                                      
                                      <tr> <td nowrap width="17%"  bgcolor="#FFFFFF" align="center"><%=(((RSINCIDENCIA_DIA_data = RSINCIDENCIA_DIA.getObject("DESC_TIPO_INCIDENCIA"))==null || RSINCIDENCIA_DIA.wasNull())?"":RSINCIDENCIA_DIA_data)%></td>                                                                                   
                                           <td nowrap width="17%"  bgcolor="#FFFFFF" align="center"><%=(((RSINCIDENCIA_DIA_data = RSINCIDENCIA_DIA.getObject("OBSERVACIONES"))==null || RSINCIDENCIA_DIA.wasNull())?"":RSINCIDENCIA_DIA_data)%></td>                                        
                                      </tr>
								    </table>
								 </td>
								 </tr>
								  <% } %>
								<tr>
								<td colspan=2 align="center">
			 <form name="formFICHA" method=post action="procesa_tran.jsp">					
               <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                      <tr>
                                        <td colspan=2 width="35%" align="right"><div align="right">										
										 <td align="right"><a href="javascript:añadir();"><img src="../../imagen/new.png" alt="Añadir transacción"	width="20" height="20" border="0"></a>
										     <a href="javascript:regenera( <%=  RS_total %>  );"><img src="../../imagen/regenerar.jpg" alt="Regenerar Fichajes"	width="20" height="20" border="0"></a>
										    </div> 
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
											  <input type="hidden" id="campo_final" name="campo_final"  value="">
											  <input type="hidden" id="computa_final" name="computa_final"  value="">
											  <input type="hidden" id="ID_DIA" name="ID_DIA" value="<%= RSFICHAJE_DIA__MMColParam2%>">
											  <input type="hidden" id="ID_FUNCIONARIO" name="ID_FUNCIONARIO" value="<%= RSFICHAJE_DIA__MMColParam1%>">
											  <div align="center"><b>Transacciones</b></div></td>
                                        </tr>
                                            <tr> <td align="center" bgcolor="#CCCCCC"><span class="va10b">LUGAR</span></td>
                                              <td colspan=2 align="center" bgcolor="#CCCCCC"><span class="va10b">HORA</span></td>
                                        </tr>
                                            <% while ((RSDET_TRAN_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                            <% if (!RSDET_TRAN_isEmpty ) { %>
                                            <tr id="c<%= Repeat1__index %>" style="DISPLAY: ">
										         <td  align="center" valign="bottom" nowrap bgcolor="#FFFFFF">
										        <%=(((RSDET_TRAN_data = RSDET_TRAN.getObject("RELOJ"))==null || RSDET_TRAN.wasNull())?"":RSDET_TRAN_data)%>
											    </td>
											    <td nowrap>
											    
											    <input type="hidden"  id="CLAVE_HORA_<%= Repeat1__index %>" name="CLAVE_HORA_<%= Repeat1__index %>" value="<%=(((RSDET_TRAN_data = RSDET_TRAN.getObject("CLAVEF"))==null || RSDET_TRAN.wasNull())?"":RSDET_TRAN_data)%>"  size="10" maxlength="15">
											    <select id="TR_HORA_<%= Repeat1__index %>"  name="TR_HORA_<%= Repeat1__index %>" onChange="document.formFICHA.valorc<%= Repeat1__index %>.value=1;">
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
								   <select id="TR_MINUTO_<%= Repeat1__index %>" name="TR_MINUTO_<%= Repeat1__index %>" onChange="document.formFICHA.valorc<%= Repeat1__index %>.value=1;">
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
								   <a href="javascript:borrar('c<%= Repeat1__index %>');"> <img src="../../imagen/delete.png" alt="Borrar"	width="20" height="20" border="0"></a><input type="hidden" id="campoc<%= Repeat1__index %>" value="1">
								   <input type="hidden" id="valorc<%= Repeat1__index %>" name="valorc<%= Repeat1__index %>" value="0">
										       </td> 
                                        </tr>
                                            <% } /* end !RSQUERY_isEmpty */ %>
                                              
                                            <%
  Repeat1__index++;
  RSDET_TRAN_hasData = RSDET_TRAN.next();
}
%>           
           <%  Repeat1__index--;
		       while (Repeat1__index++ != 10) { %>
  
    
                                        
               <tr id="c<%= Repeat1__index %>" style="DISPLAY: none">
                      <td  align="left" valign="bottom" nowrap bgcolor="#FFFFFF">MANUAL</td> 
                      <td>
											  <input type="hidden"  id="CLAVE_HORA_<%= Repeat1__index %>" name="CLAVE_HORA_<%= Repeat1__index %>" value="0000000000" size="10" maxlength="10">
											   
											  <select id="TR_HORA_<%= Repeat1__index %>" name="TR_HORA_<%= Repeat1__index %>" onChange="document.formFICHA.valorc<%= Repeat1__index %>.value=2;">
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
                                  </select><select id="TR_MINUTO_<%= Repeat1__index %>" name="TR_MINUTO_<%= Repeat1__index %>" onChange="document.formFICHA.valorc<%= Repeat1__index %>.value=2;">
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
                                  <a href="javascript:borrar('c<%= Repeat1__index %>');"> <img src="../../imagen/delete.png" alt="Borrar"	width="20" height="20" border="0"></a> <input type="hidden" id="campoc<%= Repeat1__index %>" value="0">
								  <input type="hidden" id="valorc<%= Repeat1__index %>" name="valorc<%= Repeat1__index %>" value="0">
								 </td> 	 
					  </tr>
				
			  
		 <% } %>
											  
                                        </table> </td>
                                        <td><img src="../../imagen/flecha.jpg" 	width="108" height="64" border="0">
                                        
                                        </td>
                                        
                                        <td width="75%"><table width="45%" border="0" cellspacing="1" cellpadding="4">
                                      <tr bgcolor="#FFFFDD"> 
                                        <td colspan="4" bgcolor="#CCFFCC"><div align="center"><b>Fichajes</b></div></td>
                                      </tr>
                                      <tr>
                                        <td align="center" bgcolor="#CCCCCC">INICIO</td>
                                        <td align="center" bgcolor="#CCCCCC">FIN</td>
                                        <td align="center" bgcolor="#CCCCCC">TIEMPO FICHADO</td>
                                         <td align="center" bgcolor="#CCCCCC">COMPUTA PARA SALDO</td>
                                      </tr>
                                      <% while ((RSDET_FICH_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                      <% if (!RSDET_FICH_isEmpty ) { %>
                                      <tr>
                                 
                                        <input type="hidden"  id="CLAVE_ENTRADA_<%= Repeat2__index %>" name="CLAVE_ENTRADA_<%= Repeat2__index %>" value="<%=(((RSDET_FICH_data = RSDET_FICH.getObject("ID_SEC_ENTRADA"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%>"  size="10" maxlength="10">
                                        <input type="hidden"  id="CLAVE_SALIDA_<%= Repeat2__index %>" name="CLAVE_SALIDA_<%= Repeat2__index %>" value="<%=(((RSDET_FICH_data = RSDET_FICH.getObject("ID_SEC_SALIDA"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%>"  size="10" maxlength="10">
                                       
                                        
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("INICIO"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("FIN"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                                             
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSDET_FICH_data = RSDET_FICH.getObject("SALDO"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%></td>
                                           <td align="center" bgcolor="#FFFFFF">
											      <select ID="COMPUTA_<%= Repeat2__index %>" name="COMPUTA_<%= Repeat2__index %>" size="1" onChange="javascript:mostrarOcultar(<%= Repeat2__index %>);">        
											         <option value="0" <%=(("0".toString().equals((((RSDET_FICH_data = RSDET_FICH.getObject("COMPUTADAS"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)))?"SELECTED":"")%>>Si</option>
											         <option value="1" <%=(("1".toString().equals((((RSDET_FICH_data = RSDET_FICH.getObject("COMPUTADAS"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)))?"SELECTED":"")%>>No, Horas Extras Compensadas</option>
											         <option value="2" <%=(("2".toString().equals((((RSDET_FICH_data = RSDET_FICH.getObject("COMPUTADAS"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)))?"SELECTED":"")%>>No, Horas Extras Pagadas</option>
											         <option value="3" <%=(("3".toString().equals((((RSDET_FICH_data = RSDET_FICH.getObject("COMPUTADAS"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)))?"SELECTED":"")%>>No, Horas Tribunal</option>
											    
											      </select>
										   </td>
										     		  
                                           <td id="HORAS_EXTRAS_TIPO_<%= Repeat2__index %>">               
											     <select name="MENU_TIPO_HORAS_<%= Repeat2__index %>" onChange="document.formFICHA.TIPO_HORAS_<%= Repeat2__index %>.value=document.formFICHA.MENU_TIPO_HORAS_<%= Repeat2__index %>.value;">
											                                        
													       <%
											             while (RS_TipoHoras_hasData) {
											               %>
                                                 <option value="<%=((RS_TipoHoras.getObject("ID_TIPO_HORAS")!=null)?RS_TipoHoras.getObject("ID_TIPO_HORAS"):"")%>"<%=(((RS_TipoHoras.getObject("ID_TIPO_HORAS")).toString().equals(((((RSDET_FICH_data = RSDET_FICH.getObject("ID_TIPO_HORAS"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)).toString()))?"SELECTED":"")%> ><%=((RS_TipoHoras.getObject("DESC_TIPO_HORAS")!=null)?RS_TipoHoras.getObject("DESC_TIPO_HORAS"):"")%></option>
											                                         <%
											               RS_TipoHoras_hasData = RS_TipoHoras.next();
											                 }
											               RS_TipoHoras.close();
											               RS_TipoHoras = StatementRS_TipoHoras.executeQuery();
											               RS_TipoHoras_hasData = RS_TipoHoras.next();
											               RS_TipoHoras_isEmpty = !RS_TipoHoras_hasData;
											             %>
                                                  </select>
									  		        <input type="hidden" ID="TIPO_HORAS_<%= Repeat2__index %>" name="TIPO_HORAS_<%= Repeat2__index %>"  value="<%=(((RSDET_FICH_data = RSDET_FICH.getObject("ID_TIPO_HORAS"))==null || RSDET_FICH.wasNull())?"":RSDET_FICH_data)%>" size="8" maxlength="8" >
</td> 	         
                                       
                                     
                                      </tr>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat2__index++;
                                      RSDET_FICH_hasData = RSDET_FICH.next();
}
%>

                                    </table>
								
								
								</tr> <br/>
								<tr><td colspan=5 align="center"></td></tr>
		
								<tr><td colspan=5 align="center">   <input type="button" value="Volver" name="Volver" onClick="window.location='index.jsp?PERIODO=<%= RSCONSULTA__MMColParam2%>'" ></td></tr>
		
								
	</table>
	</form>
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
RSSALDO_PERIODO.close();
StatementRSSALDO_PERIODO.close();
ConnRSSALDO_PERIODO.close();
%>