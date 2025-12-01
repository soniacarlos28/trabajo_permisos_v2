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
String RSCOLOR_old="";
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("select to_char(mod(rownum, 2)) as impar,       to_char(id_dia, 'dd/mm/yyyy') as f_txt,       id_dia,       fecha,       to_CHAR(id_dia, 'MM') || '20' || to_CHAR(id_dia, 'YY') AS MES_FECHA,       entrada,       salida,              devuelve_min_fto_hora(horas_saldo) as horas_saldo,       devuelve_min_fto_hora(horas_hacer) as horas_hacer,       devuelve_min_fto_hora(fuera_saldo) as fuera_saldo,       devuelve_min_fto_hora(horas_fichada_dia) as horas_fichada_dia,       devuelve_min_fto_hora(diferencia) as diferencia,       devuelve_min_fto_hora(horas_fuera_saldo) as horas_fuera_saldo,                     round(horas_hacer) as horas_hacer_m,        to_char(round(diferencia)) as dminutos,        devuelve_min_fto_hora(round(to_char(diferencia))) as DMINUTOS_F,       observaciones,       periodo as MES_FECHA_ANO ,       id_funcionario ,   NVL(ENTRADA,'0') AS ENTRADA_ENT,NVL(SALIDA,'0') AS SALIDA_ENT from FICHAJE_SALDO_COMPLETA_FIN t where id_funcionario= '" + RSPERIODO__MMColParam1 + "' and periodo =  devuelve_periodo('" + RSPERIODO__MMColParam3 + "')   ORDER BY 3,ENTRADA,observaciones desc");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
int Saldo_acumulado=0;
int Saldo_acumulado_tmp=0;
int Saldo_acumulado_tmp_horas=0;
int Saldo_acumulado_tmp_min=0;
int saldo_negativo=0;
String Saldo_hora;
String Saldo_hora_dif;
String saldo_min_txt;
String saldo_min_txt_dif;
String fecha_nueva="";
String fecha_old="";
String tipo_funcionario = "";
String tmp_obs="";
String entrada_ent="";
String salida_ent="";
%>
<%
Driver DriverRSPERIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIO = ConnRSPERIO.prepareStatement("SELECT DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES) || ' de ' || ano as PER2,ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo ,mes ||  ano as per FROM  webperiodo  WHERE ano> to_number(To_char(sysdate,'yyyy'))-5 and  ano ||mes <= to_char(sysdate+30,'YYYYMM') ORDER BY ano,MES");
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
PreparedStatement StatementRSSALDO = ConnRSSALDO.prepareStatement("SELECT SUM(nvl(a.Campo11,0) + nvl(a.Campo9,0)) AS DM  FROM  webfinger   a,        webperiodo  b,       apliweb_usuario   u  where   lpad(b.mes || b.ano,6,'0') = devuelve_periodo('" + RSSALDO__MMColParam3 +"') and  lpad(u.id_funcionario,6,'0')=lpad('" + RSSALDO__MMColParam1 + "',6,'0')  and a.fecha between b.inicio and b.fin and a.codpers = id_fichaje");
ResultSet RSSALDO = StatementRSSALDO.executeQuery();
boolean RSSALDO_isEmpty = !RSSALDO.next();
boolean RSSALDO_hasData = !RSSALDO_isEmpty;
Object RSSALDO_data;
int RSSALDO_numRows = 0; 
%>
<%
String RSPERDESC__MMColParam2 = "000000";
if (request.getParameter("PERIODO") !=null) {RSPERDESC__MMColParam2 = (String)request.getParameter("PERIODO");}
%>
<%
Driver DriverRSPERDESC = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERDESC =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERDESC = ConnRSPERDESC.prepareStatement("select periodo,       per,       per2        from FICHAJE_PERIODO t  where lpad(per, 6, '0') =       DECODE('" + RSPERDESC__MMColParam2 +"',              '000000',              lpad(to_char(sysdate, 'mm'), 2, '0') ||              to_char(sysdate, 'yyyy'),              '" + RSPERDESC__MMColParam2 + "') ");
ResultSet RSPERDESC = StatementRSPERDESC.executeQuery();
boolean RSPERDESC_isEmpty = !RSPERDESC.next();
boolean RSPERDESC_hasData = !RSPERDESC_isEmpty;
Object RSPERDESC_data;
int RSPERDESC_numRows = 0;
%>

<%
String RSFICHA__MMColParam1= "00";
if (session.getValue("MM_ID_FUNCIONARIO")   !=null) {RSFICHA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")  ;}
%>
<%
Driver DriverRSFICHA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFICHA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFICHA = ConnRSFICHA.prepareStatement("select 'DEDO: ' || NVL(PIN,'SIN') || '- TARJETA: ' || NVL(PIN2,'SIN')  as PIN, DECODE(NVL(teletrabajo,0),1,'SI','NO') as teletrabajo, to_char(nvl(ID_TIPO_FIcHAJE,9))as ID_TIPO_FICHAJE,p.id_funcionario ,   to_char(nvl(p.tipo_funcionario2,0)) as id_tipo_funcionario from FUNCIONARIO_FICHAJE f,personal_new p where f.id_funcionario(+)=p.id_funcionario and p.id_funcionario=" + RSFICHA__MMColParam1 + " ");

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
String RSFALTAN__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSFALTAN__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSFALTAN__MMColParam2 = "000000";
if (request.getParameter("PERIODO")             !=null) {RSFALTAN__MMColParam2  = (String)request.getParameter("PERIODO");  }
%>

<%
Driver DriverRSFALTAN = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFALTAN = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFALTAN = ConnRSFALTAN.prepareStatement("select ca.ID_DIA,       DECODE(f.fecha_incidencia,              null,              '<td width=\"2%\" bgcolor=\"#FFFFFF\" ><div align=\"center\"></div></td>',              '<td width=\"2%\" bgcolor=\"#FFEE58\" ><div align=\"center\">!</div></td>') AS CADENA  from fichaje_incidencia f, calendario_laboral ca,  webperiodo w where ca.id_dia = f.fecha_incidencia(+)   and ca.id_dia between w.inicio and w.fin     and w.mes || w.ano = devuelve_periodo('" + RSFALTAN__MMColParam2 + "')     and f.id_funcionario(+) in ('" + RSFALTAN__MMColParam1 + "') order by ca.id_dia");
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
String PIN__FUNCIONARIO = (String)(((RSFICHA_data = RSFICHA.getObject("PIN"))==null || RSFICHA.wasNull())?"":RSFICHA_data);
if (PIN__FUNCIONARIO == null) {PIN__FUNCIONARIO ="0000";  }
%>
<%
Driver DriverFICHA_HOY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnFICHA_HOY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementFICHA_HOY = ConnFICHA_HOY.prepareStatement("select  '<a href=../Finger/detalle_dia.jsp?ID_DIA=' || to_CHAR(to_DATE(to_char(FECHA, 'dd/mm/yy'), 'dd/mm/yy'), 'DD/MM/') || '20' || to_CHAR(to_DATE(to_char(FECHA, 'dd/mm/yy'), 'dd/mm/yy'), 'yy') || '>' ||       'HOY' || '</a>' AS FECHA,       DECODE(tipotrans,              40,              to_char(hora, 'hh24:mi') || ' (Intento) ',              to_char(hora, 'hh24:mi')) as horas,       abrev AS RELOJ  from transacciones o, relojes r, funcionario_fichaje ff where ((tipotrans = '2') OR (numserie = 0) or       (dedo = '17' and tipotrans = '3') OR (tipotrans = '2') OR       (dedo = '49' and tipotrans = '3') OR       (tipotrans in (55, 39, 40, 4865, 4356, 4102)))   and (o.pin=ff.pin or o.pin=ff.pin2 ) and  ff.id_funcionario = '" + RSCONSULTA__MMColParam1 + "'   and length(o.pin) <= 4 and o.pin>0   AND FECHA = to_date(to_char(sysdate, 'dd/mm/yyyy'), 'dd/mm/yyyy')   and dECODE(o.numero, 'MA', 91, o.NUMERO) = r.numero order by hora");
ResultSet FICHA_HOY = StatementFICHA_HOY.executeQuery();
boolean FICHA_HOY_isEmpty = !FICHA_HOY.next();
boolean FICHA_HOY_hasData = !FICHA_HOY_isEmpty;
Object FICHA_HOY_data;
int FICHA_HOY_numRows = 0;
int FICHA_HOY_cuantos=0;
%>
<%
String RSSALDO_NEW__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSSALDO_NEW__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSSALDO_NEW__MMColParam2 = "000000";
if (request.getParameter("PERIODO")             !=null) {RSSALDO_NEW__MMColParam2  = (String)request.getParameter("PERIODO");  }
%>
<%
Driver DriverRSSALDO_NEW = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSSALDO_NEW = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSSALDO_NEW = ConnRSSALDO_NEW.prepareStatement("select devuelve_min_fto_hora(nvl(sum(horas_saldo-horas_hacer),0)) as saldo  from fichaje_funcionario_resu_dia t,  webperiodo ow where id_funcionario = '" + RSSALDO_NEW__MMColParam1 + "'   and mes||ano = devuelve_periodo('" + RSSALDO_NEW__MMColParam2 + "')    and  t.id_dia  between ow.inicio and ow.fin  and t.id_dia<to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy')");
ResultSet RSSALDO_NEW = StatementRSSALDO_NEW.executeQuery();
boolean RSSALDO_NEW_isEmpty = !RSSALDO_NEW.next();
boolean RSSALDO_NEW_hasData = !RSSALDO_NEW_isEmpty;
Object RSSALDO_NEW_data;
int RSSALDO_NEW_numRows = 0;
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
function envia_unavez()
{


   document.formListado.submit();
  
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
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
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
<link rel="stylesheet" href="estilos_mejorado_tabs.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
    display: flex;
    flex-direction: row;
    font-family: "Open Sans", sans-serif;
}

nav {
    width: 220px;
    background-color: #003366;
    padding-top: 1em;
    height: 100vh;
}

nav ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

nav ul li {
    position: relative;
}

nav ul li a {
    display: block;
    color: white;
    padding: 12px 20px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.3s;
}

nav ul li a:hover {
    background-color: #005599;
}

nav ul li ul {
    display: none;
    background-color: #004080;
    position: static;
    padding-left: 1em;
}

nav ul li:hover ul {
    display: block;
}

main {
    flex-grow: 1;
    padding: 2em;
}
</style>

</head>
<body>

<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>

<nav>
<ul>
<li><a href="#">Inicio</a></li>
<li><a href="#">Usuarios</a>
    <ul>
        <li><a href="#">Resumen</a></li>
        <li><a href="#">Detalle</a></li>
    </ul>
</li>
<li><a href="#">Informes</a></li>
<li><a href="#">Configuraci�n</a></li>
</ul>
</nav>
<main>

    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
         
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
      <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>  
       <li><a href="../../gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
       <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
       <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

       
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
		<li><a href="../Finger" id="current">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
		<li><a href="../Bolsa_concilia" >Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" >Incidencias  Fichajes</a></li>
	  </ul>
	</div>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr > 
                      <th>
					    <div align="left">
					      <table border="0" cellspacing="0" cellpadding="2">
					        
					        <tr>
					          
					          <td class="va12b">&nbsp;<input type="button" value="Configuracion" name="Configuracion" onClick="window.location='index_configuracion.jsp'">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO") %>--<%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;
					          <input type="button" value="Asignar pin fichaje" name="Asignar pin" onClick="window.location='asigna_pin.jsp?ID_FUNCIONARIO=<%= RSSALDO_NEW__MMColParam1%>'">
					          &nbsp;&nbsp;Fichaje_teletrabajo:&nbsp; <%=(((RSFICHA_data = RSFICHA.getObject("TELETRABAJO"))==null || RSFICHA.wasNull())?"":RSFICHA_data)%>&nbsp;&nbsp; <input type="button" value="Cambiar" name="Cambiar" onClick="window.location='cambia_firma_tele.jsp?ID_FUNCIONARIO=<%= RSSALDO_NEW__MMColParam1%>'">
					         
					          
					          
					          
					          </td>
							  <td nowrap width="10%" class="va12b"  ><div align="right">Saldo Periodo:
<% if (!RSSALDO_NEW_isEmpty ) { %>
<strong><%=(((RSSALDO_NEW_data = RSSALDO_NEW.getObject("SALDO"))==null || RSSALDO_NEW.wasNull())?"":RSSALDO_NEW_data)%></strong>
<% } %></div></td>
							  <td nowrap width="10%" class="va12b"  ><div align="right"></div></td>
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
											datos_policia = new Double( (String) RSF__MMColParam1 );											
											mensaje_saldo = "No existen fichajes para el periodo seleccionado.";
											if (datos_policia.intValue() > 2000)
											{
												
												mensaje_saldo = "Sin saldo. Policia.";	
											}
										}
											%>						
                              <td width="10%" nowrap class="va12b"  ><div align="right"><strong></strong></div></td>
                            </tr>
					        </table>
				        </div></th>
						
                      <th valign="top" class="va12b"> <div align="right">
                        <table  border="0" cellpadding="4" cellspacing="0" >
                          <tr class="va12b">
                            
                            <td width="10%" valign="center" class="va12b" ><div align="right">PIN:</div></td>
                                  <td width="7%" valign="center" >
                                    <div align="left"><%=(((RSFICHA_data = RSFICHA.getObject("PIN"))==null || RSFICHA.wasNull())?"":RSFICHA_data)%></div></td>
                                  <td width="6%" valign="center" nowrap  ><div align="right">Ficha<strong>:</strong> </div></td>
                                  <td width="11%" valign="center"> <%=(((RSTIPO_FICHA_data = RSTIPO_FICHA.getObject("DESC_FICHAJE"))==null || RSTIPO_FICHA.wasNull())?"":RSTIPO_FICHA_data)%>                           
                                      
                                     </td>
                                  <td width="6%" valign="top"  >
                                      <% if ( (!RSPERIODO_isEmpty) ) { %>
                                  <a href="index_excel.jsp?PERIODO=<%= (((RSPERIODO_data = RSPERIODO.getObject("MES_FECHA_ANO"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data) %> "><img src="../../imagen/excel_f.jpg" border="0" width="61" height="28" alt="Exporta a Excel"></a><div align="center">
                                      <% } %>
                                    
                                    </div></td>
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
						       
					            <table border="0" cellpadding="4" cellspacing="0" bgcolor="#f2f2f2">
									        
						          <tr bgcolor="#FFFFFF">
									          
									          
									          
						            <td align="right" nowrap bgcolor="#f2f2f2">Calendario del Periodo: </td>
                                             <td align="left" bgcolor="#f2f2f2">
                                            
                                 <% if ( (!RSPERIODO_isEmpty) ) { %>
                                             <select name="PERIODO"  onChange="javascript:envia_unavez();">
                                               <%
                                                 while (RSPERIO_hasData) {
                                                %>
                                               <option value="<%=((RSPERIO.getObject("PER")!=null)?RSPERIO.getObject("PER"):"")%>" <%=(((RSPERIO.getObject("PER")).toString().equals(((((RSPERIODO_data = RSPERIODO.getObject("MES_FECHA_ANO"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)).toString()))?"SELECTED":"")%> ><%=((RSPERIO.getObject("PERIODO")!=null)?RSPERIO.getObject("PERIODO"):"")%></option>
                                                <%
  													RSPERIO_hasData = RSPERIO.next();
													}
													RSPERIO.close();
													RSPERIO = StatementRSPERIO.executeQuery();
													RSPERIO_hasData = RSPERIO.next();
													RSPERIO_isEmpty = !RSPERIO_hasData;
												%>
                                             </select>
                                   <% } else { %> 
                                           <select name="PERIODO" maxlength="100" onChange="javascript:envia_unavez();">
                                               <%
                                                 while (RSPERIO_hasData) {
                                                %>
                                               <option value="<%=((RSPERIO.getObject("PER")!=null)?RSPERIO.getObject("PER"):"")%>" <%=((RSPERIODO__MMColParam3.toString().equals((((RSPERIO_data = RSPERIO.getObject("PER"))==null || RSPERIO.wasNull())?"":RSPERIO_data)))?"selected=\"selected\"":"")%> ><%=((RSPERIO.getObject("PERIODO")!=null)?RSPERIO.getObject("PERIODO"):"")%></option>
                                                <%
  													RSPERIO_hasData = RSPERIO.next();
													}
													RSPERIO.close();
													RSPERIO = StatementRSPERIO.executeQuery();
													RSPERIO_hasData = RSPERIO.next();
													RSPERIO_isEmpty = !RSPERIO_hasData;
												%>
                                             </select>
							
                                    <% } %>            
                                             
                                             
                                             </td>  <td><a href='regenera_saldo_periodo.jsp?ID_FUNCIONARIO=<%= RSSALDO_NEW__MMColParam1%>&ID_PERIODO=<%= (((RSPERIODO_data = RSPERIODO.getObject("MES_FECHA_ANO"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data) %>' >
                       <img	src="../../imagen/regenerar.jpg" alt="Regenerar Saldo PERIODO" width="20" height="20" border="0"></a></td>

                                             
										 
                                            
                                             
                                  </tr>
					             </table>
						      </div>
                            </form></td>
                          </tr>
                         
						 <tr>
                    <th align="left" colspan=3>
                         <% while (FICHA_HOY_hasData) 
   							{   if (FICHA_HOY_cuantos == 0) {%>
         							<%=(((FICHA_HOY_data = FICHA_HOY.getObject("FECHA"))==null || FICHA_HOY.wasNull())?"":FICHA_HOY_data)%>
         							<% } %>
		 						   Fichaje: <%= FICHA_HOY_cuantos+1 %> <%=(((FICHA_HOY_data = FICHA_HOY.getObject("HORAS"))==null || FICHA_HOY.wasNull())?"":FICHA_HOY_data)%>                        
                                   <%=(((FICHA_HOY_data = FICHA_HOY.getObject("RELOJ"))==null || FICHA_HOY.wasNull())?"":FICHA_HOY_data)%> --
  
  <%
     FICHA_HOY_cuantos=FICHA_HOY_cuantos+1;
     FICHA_HOY_hasData = FICHA_HOY.next(); 
	  
  }
%>   </th>
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
            } %>
            
            <tr>
              <% while ((RSFALTAN_hasData)&&(Repeat13__numRows-- != 0)) { %>
						<%=(((RSFALTAN_data = RSFALTAN.getObject("CADENA"))==null || RSFALTAN.wasNull())?"":RSFALTAN_data)%>                        <%  						                          
  Repeat13__index++;
						RSFALTAN_hasData = RSFALTAN.next();
}
%>
                   </tr>   
                   
                        </table>  </tr>
            
            
                        
                        </table>
					                   </tr>
                       
                          <tr align="right"> 
                            <td colspan="2" bgcolor="#E0E0E0">
							
                        <% if (!RSPERIODO_isEmpty ) { %>
							<table width="90%"  border="0" cellspacing="1" cellpadding="1" >
                              <tr>
                                <td width="7%" scope="col"><div align="center"><strong>Fecha</strong></div></td>
                                <td width="5%" scope="col"><div align="center"><strong>Entrada</strong></div></td>
                                <td width="5%" scope="col"> <div align="center"><strong>Salida</strong></div></td>
                                <td width="7%" scope="col"> <div align="center"><strong>Fuera Saldo</strong></div></td>
                                <td width="5%" scope="col"> <div align="center"><strong>Fichadas</strong></div></td>
                                
                                <td width="10%" scope="col"><div align="center"><strong>H. Hacer</strong></div></td>
                                <td width="10%" scope="col"><div align="center">Diferencia</div></td>
                                <td width="10%" scope="col"><div align="center"><strong>Saldo ese d�a.</strong></div></td>
                                <td scope="col"><div align="center">Observaciones</div></td>
                              </tr>
                              
                              <%  tipo_funcionario = (String) (((RSFICHA_data = RSFICHA.getObject("ID_TIPO_FUNCIONARIO"))==null || RSFICHA.wasNull())?"":RSFICHA_data);
                              
                              %>
                              <% while ((RSPERIODO_hasData)&&(Repeat1__numRows-- != 0)) { 
				
                                    
                            	  RSIMPAR =  (String) (((RSPERIODO_data = RSPERIODO.getObject("IMPAR"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data); 
                            	  
							  	  %> 
                             <tr>                 
                              
                                  <% fecha_nueva = (String) (((RSPERIODO_data = RSPERIODO.getObject("F_TXT"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data); %>    
                                    <% entrada_ent = (String) (((RSPERIODO_data = RSPERIODO.getObject("ENTRADA_ENT"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data); %>                                  
                                    <% salida_ent = (String) (((RSPERIODO_data = RSPERIODO.getObject("SALIDA_ENT"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data); %>
                                                               
                                  <% if ( (!fecha_nueva.equals(fecha_old))   )   
                                  {
                                       if  (RSCOLOR_old.equals(""))                                         
                                    	   RSCOLOR="bgcolor=\"#f2f2f2\"";
                                       else
                                    	   RSCOLOR="";   
                                      
                                       %>    
                                   <tr>                                                                    
                                     <td   <%= RSCOLOR %>><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("FECHA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></td>
                                     <td   <%= RSCOLOR %>><div align="center"></td> 
                                     <td   <%= RSCOLOR %>><div align="center"></td>
                                      <% if  (!tipo_funcionario.equals("21"))  {%>
                                      <td   <%= RSCOLOR %>><div align="center"></td>
                                                                         
                                      <td width="10%"<%= RSCOLOR %>><div align="right"><%=(((RSPERIODO_data = RSPERIODO.getObject("HORAS_FICHADA_DIA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                       <td <%= RSCOLOR %>><div align="right"><%=(((RSPERIODO_data = RSPERIODO.getObject("HORAS_HACER"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
							          <td <%= RSCOLOR %>><div align="right"><%=   (((RSPERIODO_data = RSPERIODO.getObject("DMINUTOS_F"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data) %></div></td>
                                   
							       
                                      <% } else { %> 
                                      <td <%= RSCOLOR %>><div align="center"></div></td>   
                                       <td <%= RSCOLOR %>><div align="center"></div></td>   
                                        <td <%= RSCOLOR %>><div align="center"></div></td>   
                                         <td <%= RSCOLOR %>><div align="center"></div></td>    
                                     <% } %>    
                                     
                                     
                                     <% 
                                       fecha_old=fecha_nueva;
                                       valor_acumulado = "0"; 
                                       Saldo_hora ="";
                                       
                               if  (!tipo_funcionario.equals("21"))  {
								      
								    			   
							    	   valor_acumulado =(String) (((RSPERIODO_data = RSPERIODO.getObject("DMINUTOS"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data);
								    	
							              
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
								 			 if (Saldo_acumulado_tmp_min > -1 && Saldo_acumulado_tmp_min < 10) 
								 			    {
                                 				  saldo_min_txt= "0"+  (Saldo_acumulado_tmp_min); 								 
								 				}
								 			Saldo_hora=Saldo_acumulado_tmp_horas + ":"+  saldo_min_txt;
                                			  if  ( Saldo_acumulado_tmp_min < 0 || Saldo_acumulado_tmp_horas < 0 || saldo_negativo==1) 
                                			    {								
                       		       			   Saldo_hora= "-" + Saldo_acumulado_tmp_horas +   ":"+   saldo_min_txt ;
												}	
                                			  
                               }		
                                			  
                                	  RSCOLOR_old=RSCOLOR;	  
								 		  %>								
                                      
                                        	<% if  (!tipo_funcionario.equals("21"))  {%>
                                    		<td <%= RSCOLOR %>><div align="center"><%=   Saldo_hora %></div></td>
                                   		<% } else { %> 
                                     		<td <%= RSCOLOR %>><div align="center"></div></td>							
                                    	<% } %>  
								                                  						
                                         <% if ( (entrada_ent.equals("0"))  &&  (salida_ent.equals("0")) ) 
                                         {%>
                                         <td <%= RSCOLOR %>><div align="left"><%=   (((RSPERIODO_data = RSPERIODO.getObject("OBSERVACIONES"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data) %></div></td>
                                         <% } else { %> 
                                          <td <%= RSCOLOR %>><div align="center"></div></td>    
                                         <% } %>    
                                    	  
                                    	  </tr>
                                 <% } %>  
                                 
                                     
                                  <% if ( (!entrada_ent.equals("0"))  &&  (!salida_ent.equals("0")) )   
                                  {%>   	
                                    <tr>
                                    <td <%= RSCOLOR %>><div align="center"></div></td> 
                                    <td <%= RSCOLOR %>><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("ENTRADA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                    <td <%= RSCOLOR %>><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("SALIDA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                    <td <%= RSCOLOR %>><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("FUERA_SALDO"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                    <td nowrap <%= RSCOLOR %>><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("HORAS_SALDO"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                    <td <%= RSCOLOR %>><div align="center"></td> 
                                    <td <%= RSCOLOR %>><div align="center"></td> 
                                    <td <%= RSCOLOR %>><div align="center"></td> 
                                   <td <%= RSCOLOR %>><div align="left"><%=(((RSPERIODO_data = RSPERIODO.getObject("OBSERVACIONES"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                    </tr>
                                   <% } %>    
                                 
								  
								  
								  
								  
								
                                
                           
                              <% 
  Repeat1__index++;
  RSPERIODO_hasData = RSPERIODO.next();
}
%>
                        </table>							
                          <% } /* end !RSSALDO_isEmpty */ %>								</td>
                          </tr>
  </table>
	
</div>
	</div>
</main>
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
RSPERDESC.close();
StatementRSPERDESC.close();
ConnRSPERDESC.close();
%>
<%
RSCONSULTA.close();
StatementRSCONSULTA.close();
ConnRSCONSULTA.close();
%>
