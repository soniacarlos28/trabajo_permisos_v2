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
String RS_DIA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO_NOMBRE")    !=null) {RS_DIA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO_NOMBRE")   ;}
String RS_DIA__MMColParam2 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO_APE1")    !=null) {RS_DIA__MMColParam2 = (String)session.getValue("MM_ID_FUNCIONARIO_APE1")   ;}
String RS_DIA__MMColParam3 = "000000";
if (request.getParameter("PERIODO")             !=null) {RS_DIA__MMColParam3 = (String)request.getParameter("PERIODO")            ;}


response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment; filename="+  RS_DIA__MMColParam1 + "_" +RS_DIA__MMColParam2 + "_" +  RS_DIA__MMColParam3 +".xls");

%>

<%
String RSPERIODO__MMColParam1 = "000000";
if (request.getParameter("ID_FUNCIONARIO")   !=null) {RSPERIODO__MMColParam1 = (String)request.getParameter("ID_FUNCIONARIO")  ;}
%>
<%
String RSPERIODO__MMColParam5 = "";
if (request.getParameter("NOMBRE")    !=null) {RSPERIODO__MMColParam5 = (String)request.getParameter("NOMBRE")   ;}
%>

<%
String RSQUERY__MMColParam7 = "";
if (request.getParameter("APE1")    !=null) {RSQUERY__MMColParam7 = (String)request.getParameter("APE1")   ;}
%>
<%
String RSQUERY__MMColParam8 = "";
if (request.getParameter("APE2")    !=null) {RSQUERY__MMColParam8 = (String)request.getParameter("APE2")   ;}
%>

<%
if (!RSPERIODO__MMColParam1.equals("000000")) { 
	session.putValue("MM_ID_FUNCIONARIO", 			RSPERIODO__MMColParam1); 
	session.putValue("MM_ID_FUNCIONARIO_NOMBRE", RSPERIODO__MMColParam5); 
	session.putValue("MM_ID_FUNCIONARIO_APE1", 			RSQUERY__MMColParam7); 
	session.putValue("MM_ID_FUNCIONARIO_APE2", 			RSQUERY__MMColParam8); 
	
} else {
	RSPERIODO__MMColParam1 = (String) session.getValue("MM_ID_FUNCIONARIO");
}
%>
<%
String RSF__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FICHAJE")   !=null) {RSF__MMColParam1 = (String)session.getAttribute("MM_ID_FICHAJE")  ;}
%>
<%
String RSPERIODO__MMColParam2 = "0000";
if (request.getParameter("ANNO")           !=null) {RSPERIODO__MMColParam2 = (String)request.getParameter("ANNO")          ;}
%>
<%
String RSPERIODO__MMColParam3 = "000000";
if (request.getParameter("PERIODO")             !=null) {RSPERIODO__MMColParam3 = (String)request.getParameter("PERIODO")            ;}
%>
<%
String RSIMPAR = ""; 
String RSCOLOR = "";
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT to_char(mod(rownum, 2)) as impar,FECHA as F,'<a href=\"../Finger/detalle_dia.jsp?ID_DIA=' || to_CHAR(FECHA, 'DD/MM/') || '20' || to_CHAR(FECHA, 'yy') || '\">' || to_CHAR(FECHA, 'DD/MM/yy') || '</a>' AS FECHA, to_CHAR(FECHA, 'MM') || '20' || to_CHAR(FECHA, 'YY') AS MES_FECHA, ENTRADA, SALIDA, horas_fichadas,horas_hacer, to_char(to_number(NVL(ROUND(nvl(diferencia_minutos, 0)), 0))) AS DmINUTOS,       observaciones , fecha_mes_ano as mes_fecha_ano  FROM (SELECT to_DATE(R.FECHA, 'dd/mm/yy') AS FECHA, to_char(B.HINICIO, 'hh24:mi') AS ENTRADA,to_char(B.HFIN, 'hh24:mi') AS SALIDA, to_char(b.hcomputablef, 'hh24:mi') Horas_fichadas,to_char(r.horteo, 'hh24:mi') horas_hacer, (to_date('30/12/1899' || to_char(b.hcomputablef, 'hh24:mi'),'DD/MM/YYYY HH24:MI') - DECODE(to_char(b.hcomputableo, 'hh24:mi'),'00:00',b.hcomputableo, r.horteo)) * 60 * 24 as diferencia_minutos, DECODE(substr(to_char(b.hcomputablef, 'hh24:mi'), 1, 2),'00',DECODE(substr(to_char(b.hcomputablef, 'hh24:mi'), 4, 2), '00','Posible Incidencia.Ficheje repetido.','01','Posible Incidencia.Ficheje repetido.','02','Posible Incidencia.Fichaje repetido.',''),DECODE(B.HINICIO,NULL,'SIN FICHAJE EN EL D�A','')) as observaciones, C.MES || C.ANO as fecha_mes_ano FROM PRESENCI R,PERSFICH B,WEBPERIODO   C,PERSONA      P,APLIWEB.USUARIO    U,CALENDARIO_LABORAL CA WHERE lpad(r.codpers, 6, '0') = lpad(u.id_fichaje, 6, '0') and r.fecha = CA.ID_DIA  and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(B.NPERSONAL(+), 6, '0') = lpad(r.codpers, 6, '0') AND lpad(u.id_funcionario, 6, '0') =  lpad('" + RSPERIODO__MMColParam1 + "', 6, '0')  and C.MES || C.ANO =   DECODE('" + RSPERIODO__MMColParam3 + "','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSPERIODO__MMColParam3 + "') and CA.id_ano = c.ANO AND CA.ID_DIA BETWEEN C.INICIO AND C.FIN AND CA.ID_DIA = R.FECHA AND R.FECHA  =b.FECHA(+) and r.codinci='000' and ca.id_dia < sysdate-1 and (  to_char(CA.ID_DIA,'d')<>6 OR  (to_char(CA.ID_DIA,'d')=6 and B.HINICIO is not null) ) UNION SELECT DISTINCT to_DATE(CA.ID_DIA, 'dd/mm/yy') AS fecha, A.hora_inicio AS entrADA,A.hora_fin AS SALIDA,'00:00' as horas_fichadas,'00:00' horas_hacer, DECODE(a.ID_TIPO_PERMISO, 15000, 0, total_horas) as total_horas,'<a href=\"../Permisos/ver.jsp?ID_PERMISO=' || ID_PERMISO || '\" >' || substr(DESC_TIPO_PERMISO, 1, 35) || '</a>' AS observaciones, C.MES || C.ANO as fecha_mes_ano FROM RRHH.PERMISO         A, RRHH.TR_TIPO_PERMISO B, WEBPERIODO     c, PERSONA        P,             CALENDARIO_LABORAL   CA,APLIWEB.USUARIO      U WHERE lpad(a.id_funcionario, 6, '0') = lpad(u.id_funcionario, 6, '0') and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') = lpad('" + RSPERIODO__MMColParam1 + "', 6, '0') and C.MES || C.ANO = DECODE('" + RSPERIODO__MMColParam3 + "','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSPERIODO__MMColParam3 + "') and a.id_tipo_permiso = b.id_tipo_permiso and a.id_ano = b.id_ano and a.id_estado not in ('30','31','32','40','41') and ((A.FECHA_INICIO BETWEEN C.INICIO AND C.FIN) or (A.FECHA_fin BETWEEN C.INICIO AND C.FIN)) and CA.ID_DIA BETWEEN A.FECHA_INICIO AND A.FECHA_fin And ANULADO = 'NO' UNION SELECT to_DATE(id_dia, 'dd/mm/yy') AS fecha, to_char(a.fecha_inicio, 'hh24:mi') as entrADA,to_char(a.fecha_fin, 'hh24:mi') as SALIDA,'00:00' as horas_fichadas,'00:00' horas_hacer,0 total_horas,'<a href=\"../Ausencias/ver.jsp?ID_AUSENCIA=' || ID_AUSENCIA || '\" >' || substr(DESC_TIPO_AUSENCIA, 1, 35) || '</a>' AS observaciones,C.MES || C.ANO as fecha_mes_ano FROM RRHH.ausencia         A, RRHH.TR_TIPO_ausencia B, WEBPERIODO c,PERSONA P, CALENDARIO_LABORAL    CA, APLIWEB.USUARIO   U   WHERE lpad(a.id_funcionario, 6, '0') = lpad(u.id_funcionario, 6, '0')  and lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(u.id_funcionario, 6, '0') = lpad('" + RSPERIODO__MMColParam1 + "', 6, '0') and C.MES || C.ANO =  DECODE('" + RSPERIODO__MMColParam3 + "','000000', lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSPERIODO__MMColParam3 + "') and CA.id_ano = c.ANO  AND CA.ID_DIA BETWEEN C.INICIO AND C.FIN AND a.id_tipo_ausencia = b.id_tipo_ausencia and a.id_ano = ca.id_ano and a.id_estado not in ('30','31','32','40','41') and ((A.FECHA_INICIO BETWEEN C.INICIO AND C.FIN) or (A.FECHA_fin BETWEEN C.INICIO AND C.FIN)) and (to_date(id_dia, 'dd/mm/yy') BETWEEN to_date(to_char(A.FECHA_INICIO, 'DD/MM/yy'), 'DD/MM/yy') and to_date(to_char(A.FECHA_FIN, 'DD/MM/yy'), 'DD/MM/yy')) And (ANULADO = 'NO' OR ANULADO IS NULL) union SELECT to_DATE(id_dia, 'dd/mm/yy') AS fecha, to_char(f.hora, 'hh24:mi') as entrADA, '' as SALIDA,'00:00' as horas_fichadas,  '00:00' horas_hacer,  0 total_horas, 'FICHAJE ABIERTO' AS observaciones, C.MES || C.ANO as fecha_mes_ano FROM fichabie     F, WEBPERIODO   c, PERSONA      P, CALENDARIO_LABORAL CA, APLIWEB.USUARIO    U  WHERE lpad(p.codigo, 6, '0') = lpad(u.id_fichaje, 6, '0') and lpad(F.Clave, 6, '0') = lpad(u.id_fichaje, 6, '0')  and lpad(u.id_funcionario, 6, '0') = lpad('" + RSPERIODO__MMColParam1 + "', 6, '0')  and C.MES || C.ANO = DECODE('" + RSPERIODO__MMColParam3 + "','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSPERIODO__MMColParam3 + "') and CA.id_ano = c.ANO AND CA.ID_DIA BETWEEN C.INICIO AND C.FIN AND F.FECHA = CA.ID_DIA)  ORDER BY 2");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
int Saldo_acumulado=0;
int Saldo_acumulado_tmp=0;
int Saldo_acumulado_tmp2=0;
int Saldo_acumulado_tmp_horas=0;
int Saldo_acumulado_tmp_min=0;
int saldo_negativo=0;
String Saldo_hora;
String Saldo_hora_dif;
String saldo_min_txt;
String saldo_min_txt_dif;
%>
<%
Driver DriverRSPERIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIO = ConnRSPERIO.prepareStatement("SELECT DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES) || ' de ' || ano as PER2,ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo ,mes ||  ano as per FROM  webperiodo  WHERE ano> to_number(To_char(sysdate,'yyyy'))-2 and  ano ||mes <= to_char(sysdate+30,'YYYYMM') ORDER BY ano,MES");
ResultSet RSPERIO = StatementRSPERIO.executeQuery();
boolean RSPERIO_isEmpty = !RSPERIO.next();
boolean RSPERIO_hasData = !RSPERIO_isEmpty;
Object RSPERIO_data;
int RSPERIO_numRows = 0;
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
if (request.getParameter("PERIODO")             !=null) {RSSALDO__MMColParam3 = (String)request.getParameter("PERIODO")            ;}
%>
<%
Driver DriverRSSALDO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSSALDO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSSALDO = ConnRSSALDO.prepareStatement("SELECT SUM(a.Campo11 + a.Campo9) AS DM  FROM  webfinger   a,        webperiodo  b,       apliweb_usuario   u,       bolsa_funcionario bf  where   lpad(b.mes || b.ano,6,'0') = DECODE('" + RSSALDO__MMColParam3 +"','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSSALDO__MMColParam3 + "') and  lpad(u.id_funcionario,6,'0')=lpad('" + RSSALDO__MMColParam1 + "',6,'0')  and a.fecha between b.inicio and b.fin and a.codpers = id_fichaje    and bf.id_funcionario = u.id_funcionario  and bf.id_acumulador = 1 and bf.id_ano = b.ano");
ResultSet RSSALDO = StatementRSSALDO.executeQuery();
boolean RSSALDO_isEmpty = !RSSALDO.next();
boolean RSSALDO_hasData = !RSSALDO_isEmpty;
Object RSSALDO_data;
int RSSALDO_numRows = 0; 
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
String RSPERDESC__MMColParam2 = "000000";
if (request.getParameter("PERIODO") !=null) {RSPERDESC__MMColParam2 = (String)request.getParameter("PERIODO");}
%>
<%
Driver DriverRSPERDESC = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERDESC =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERDESC = ConnRSPERDESC.prepareStatement("SELECT to_chaR(ca.id_dia,'dd/mm/yyyy') aS PERIODO,mes || ANO as PER ,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES) || ' de ' || ano as PER2 FROM  WEBPERIODO   C, CALENDARIO_LABORAL CA WHERE  lpad(c.mes || c.ano,6,'0') = DECODE('" + RSPERDESC__MMColParam2 +"','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSPERDESC__MMColParam2 + "') order by id_dia");
ResultSet RSPERDESC = StatementRSPERDESC.executeQuery();
boolean RSPERDESC_isEmpty = !RSPERDESC.next();
boolean RSPERDESC_hasData = !RSPERDESC_isEmpty;
Object RSPERDESC_data;
int RSPERDESC_numRows = 0;
%>


<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSPERIODO_numRows += Repeat1__numRows;
%>

<%
String RSCONSULTA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSCONSULTA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSCONSULTA__MMColParam2 = "000000";
if (request.getParameter("PERIODO")             !=null) {RSCONSULTA__MMColParam2  = (String)request.getParameter("PERIODO");  }

String RSCONSULTA__MMColParam22;
RSCONSULTA__MMColParam22 = (String)(((RSPERDESC_data = RSPERDESC.getObject("PER2"))==null || RSPERDESC.wasNull())?"":RSPERDESC_data);

%>


<%
Driver DriverRSCONSULTA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCONSULTA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCONSULTA = ConnRSCONSULTA.prepareStatement("select id_dia, c1 ||c2||c3||c4||c5||c6||c7  as d1   from (select  id_dia, max(id_funcionario),  min(columna1) as c1,         min(columna2) as c2, min(columna3) as c3, min(columna4) as c4, min(columna5) as c5, min(columna6) as c6, min(columna7) as c7 from CALENDARIO_COLUMNA_FICHAJE c   where   C.MES||C.ANO =DECODE('" + RSPERIODO__MMColParam3 + "','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSPERIODO__MMColParam3 + "')   and id_funcionario in ('" + RSCONSULTA__MMColParam1 + "',0)    group by id_dia) order by id_dia");
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
String valor_acumulado;
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->

</script>
<script language="Javascript" >
function show_calendario()
{
 	var URL = "calendario.jsp?PERIODO=" + document.getElementById("PERIODO").value ;
	var WNAME = "Calendario";
	var windowW = 230;
	var windowH = 200;
	var windowX = Math.ceil( (window.screen.width  - windowW) / 2 );
	var windowY = Math.ceil( (window.screen.height - windowH) / 2 );
	DIMENSION=",width="+windowW+",height="+windowH;

	splashWin = window.open( URL , WNAME, "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0"+DIMENSION);
	//splashWin.opener = self;
	splashWin.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
	splashWin.focus();
}

</script>
<style type="text/css">
<!--
.Estilo1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
	<table width="95%" border="0" cellspacing="0" cellpadding="0">
                      <tr > 
                      <th>
					    <div align="left">
					      <table border="0" cellspacing="0" cellpadding="2">
					        
					        <tr>
					          
					          <td colspan=12 class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;</td>
							  
							  <td colspan=5 nowrap width="10%" class="va12b"  ><div align="right"><strong>Saldo Periodo. <%=RSCONSULTA__MMColParam22 %>.</strong><%@ include file="/jsp/gestion/includes/layout_end.jsp" %></td>
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
                            
                            <td width="10%" valign="center" class="va12b" ><div align="right">PIN:</div></td>
                                  <td width="7%" valign="top" >
                                    <div align="left"><%=(((RSFICHA_data = RSFICHA.getObject("PIN"))==null || RSFICHA.wasNull())?"":RSFICHA_data)%></div></td>
                                  <td width="6%" valign="center" nowrap  ><div align="right">Ficha<strong>:</strong> </div></td>
                                  <td width="11%" valign="center"> <%=(((RSTIPO_FICHA_data = RSTIPO_FICHA.getObject("DESC_FICHAJE"))==null || RSTIPO_FICHA.wasNull())?"":RSTIPO_FICHA_data)%>                           
                                      
                                     </td>
                                 
                          </tr>
                        </table>
                      </div></th>
                    </tr>     
                       <tr align="right"> 
                      <td colspan="2" bgcolor="#E0E0E0"  class="ah12w">
					 
                        <table width="100%" border="0" cellpadding="2" cellspacing="0">
                          <tr bgcolor="#FFFFFF">
                            <td colspan="5" valign="top"  bgcolor="#f2f2f2"><form name="formListado" method="GET" action="index.jsp">
                                
                                  
						      <div align="center">
						        <% if (!RSSALDO_isEmpty ) { %>
					           </div>
                            </form></td>
                          </tr>
                         
						 
                          <tr bgcolor="#FFFFFF">
                                <table width="100%" border="1" cellspacing="3" cellpadding="2">
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
                        </table>  </tr>
                        </table>
					<% }   %>                    </tr>
                       
                          <tr align="right"> 
                            <td colspan="2" bgcolor="#E0E0E0">
							
                        <% if (!RSSALDO_isEmpty ) { %>
							<table width="90%"  border="0" cellspacing="1" cellpadding="1">
                              <tr>
                                <td colspan=4 width="10%" scope="col"><div align="center"><strong>Fecha</strong></div></td>
                                <td colspan=4 width="10%" scope="col"><div align="center"><strong>Entrada</strong></div></td>
                                <td colspan=4 width="10%" scope="col"> <div align="center"><strong>Salida</strong></div></td>
                                <td colspan=4 width="10%" scope="col"> <div align="center"><strong>Fichadas</strong></div></td>
                                <td colspan=4 width="10%" scope="col"><div align="center"><strong>H. Hacer</strong></div></td>
                                <td colspan=4 width="5%" scope="col"><div align="center">Diferencia en minutos</div></td>
                                <td colspan=4 width="5%" scope="col"><div align="center"><strong>Acum. en minutos</strong></div></td>
                                <td colspan=4 scope="col"><div align="center">Observaciones</div></td>
                              </tr>
                              <% while ((RSPERIODO_hasData)&&(Repeat1__numRows-- != 0)) { 
				
                                    
                            	  RSIMPAR =  (String) (((RSPERIODO_data = RSPERIODO.getObject("IMPAR"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data); 
                            	     if (RSIMPAR.equals("0") )  
                                     	 RSCOLOR="bgcolor=\"#f2f2f2\"";                     	
    									 else 	                   
                                          RSCOLOR="";   
							  	  
							  	  %> 
                             <tr>                 
                              <tr>
                                  <th colspan=4  <%= RSCOLOR %> ><%=(((RSPERIODO_data = RSPERIODO.getObject("FECHA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></th>
                                  <td colspan=4 <%= RSCOLOR %>><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("ENTRADA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                  <td colspan=4 <%= RSCOLOR %>><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("SALIDA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                  <td colspan=4 width="10%"<%= RSCOLOR %>><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("HORAS_FICHADAS"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                  <td colspan=4 <%= RSCOLOR %>><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("HORAS_HACER"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
								  
								  <% valor_acumulado = (String) (((RSPERIODO_data = RSPERIODO.getObject("DMINUTOS"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data); 
								 
							     saldo_negativo=0;
							      Saldo_acumulado_tmp=Integer.parseInt(valor_acumulado);
							      Saldo_acumulado_tmp2=Saldo_acumulado_tmp;
								  if (Saldo_acumulado_tmp <0 ) 
								        { 
								           Saldo_acumulado_tmp= Saldo_acumulado_tmp*-1;
										   saldo_negativo=1;
								        } 
								 Saldo_acumulado_tmp_horas= (int)(Saldo_acumulado_tmp/60);
								 Saldo_acumulado_tmp_min=Saldo_acumulado_tmp-Saldo_acumulado_tmp_horas*60;
								 saldo_min_txt_dif= ""+  (Saldo_acumulado_tmp_min);
								 if (Saldo_acumulado_tmp_min > -1 && Saldo_acumulado_tmp_min < 10) {
                                   saldo_min_txt_dif= "0"+  (Saldo_acumulado_tmp_min); 								 
								 }
								 Saldo_hora_dif=Saldo_acumulado_tmp_horas + ":"+  saldo_min_txt_dif;
                                  if  ( Saldo_acumulado_tmp_min < 0 || Saldo_acumulado_tmp_horas < 0 || saldo_negativo==1) {								
                         		       Saldo_hora_dif= "-" + Saldo_acumulado_tmp_horas + ":"+  saldo_min_txt_dif;
										}				 
								 %>
								  
								  
								  
                                  <td colspan=4 <%= RSCOLOR %>><div align="right"><%=Saldo_acumulado_tmp2%></div></td>
								 <% valor_acumulado = (String) (((RSPERIODO_data = RSPERIODO.getObject("DMINUTOS"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data); 
								 Saldo_acumulado=Saldo_acumulado + Integer.parseInt(valor_acumulado);
							   saldo_negativo=0;
							          Saldo_acumulado_tmp=Saldo_acumulado;
								  if (Saldo_acumulado_tmp <0 ) 
								        { 
								           Saldo_acumulado_tmp= Saldo_acumulado_tmp*-1;
										   saldo_negativo=1;
								        } 
								 Saldo_acumulado_tmp_horas= (int)(Saldo_acumulado_tmp/60);
								 Saldo_acumulado_tmp_min=Saldo_acumulado_tmp-Saldo_acumulado_tmp_horas*60;
								 saldo_min_txt= ""+  (Saldo_acumulado_tmp_min);
								 if (Saldo_acumulado_tmp_min > -1 && Saldo_acumulado_tmp_min < 10) {
                                   saldo_min_txt= "0"+  (Saldo_acumulado_tmp_min); 								 
								 }
								 Saldo_hora=Saldo_acumulado_tmp_horas + ":"+  saldo_min_txt;
                                  if  ( Saldo_acumulado_tmp_min < 0 || Saldo_acumulado_tmp_horas < 0 || saldo_negativo==1) {								
                         		       Saldo_hora= "-" + Saldo_acumulado_tmp_horas + ":"+  saldo_min_txt;
										}				 
								 %>
                                <td colspan=4 <%= RSCOLOR %>><div align="right"><%=Saldo_acumulado%></div></td>
                                  <td colspan=10 <%= RSCOLOR %>><%=(((RSPERIODO_data = RSPERIODO.getObject("OBSERVACIONES"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></td>
                              </tr>
                              <%
  Repeat1__index++;
  RSPERIODO_hasData = RSPERIODO.next();
}
%>
<tr></tr><th colspan=24 align="right">Total</th>
   <td colspan=4><%= mensaje_saldo %></td>
                        </table>							
                          <% } /* end !RSSALDO_isEmpty */ %>								</td>
                          </tr>
  </table>
	
</div>
	</div>
</body>
</html>
<%
RSPERIODO.close();
StatementRSPERIODO.close();
ConnRSPERIODO.close();
%>
<%
RSPERIO.close();
StatementRSPERIO.close();
ConnRSPERIO.close();
%>
<%
RSSALDO.close();
StatementRSSALDO.close();
ConnRSSALDO.close();
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
RSCONSULTA.close();
StatementRSCONSULTA.close();
ConnRSCONSULTA.close();
%>
