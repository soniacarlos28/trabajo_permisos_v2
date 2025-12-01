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
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT ID_FUNCIONARIO, NOMBRE, SALDO_REAL, SALDO_BOLSA,  DIAS_TRABAJADOS, INCIDENCIA, to_char(FECHA_CARGA,'DD/mm/YYYY hh24:MI') as FECHA_CARGA,   PERIODO,   ID_USUARIO,FECHA_MODI,ID_ANIO,TIPO_CARGA , PERIODO || ID_ANIO AS PER FROM BOLSA_CARGA_MENSUAL ORDER BY POSICION");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<% String RSIMPAR="";
   String RSCOLOR="";

%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RSQUERY_numRows += Repeat2__numRows;
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

<script language="Javascript" >
function comprobar(){
 if(document.getElementById('ip').value == "" || document.getElementById('ip').value.length == 0){
  alert("Introduce IP/HOSTNAME/URL.");
  document.getElementById('ip').focus;
 }else{ http_ping() }
}
function http_ping() {
 
var fqdn = document.getElementById('ip').value;
var NB_ITERATIONS = 4; // numero de loops
var MAX_ITERATIONS = 5; // XMLHttpRequest esta limitado seg�n el navegador
var TIME_PERIOD = 1000; // 1000 ms entre cada ping
var i = 0;
var over_flag = 0;
var time_cumul = 0;
var REQUEST_TIMEOUT = 9000;
var TIMEOUT_ERROR = 0;
 
document.getElementById('result').innerHTML = " Haciendo ping a " + fqdn + " con 32 bytes de datos:";
 
var ping_loop = setInterval(function() {
 
 
        // para evitar URLs inexistentes
        url = "http://" + fqdn + "/a30Fkezt_77" + Math.random().toString(36).substring(7);
 
        if (i < MAX_ITERATIONS) {
 
            var ping = new XMLHttpRequest();
 
            i++;
            ping.seq = i;
            over_flag++;
 
            ping.date1 = Date.now();
 
            ping.timeout = REQUEST_TIMEOUT; 
 
            ping.onreadystatechange = function() { 
 
                if (ping.readyState == 4 && TIMEOUT_ERROR == 0) {
 
                    over_flag--;
  
                    if (ping.seq > 1) {
                        delta_time = Date.now() - ping.date1;
                        time_cumul += delta_time;
                        document.getElementById('result').innerHTML += " Respuesta desde " + fqdn + "  bytes=32 secuencia_http=" + (ping.seq-1) + " tiempo=" + delta_time + " ms";
                    }
                }
            }
 
 
            ping.ontimeout = function() {
                TIMEOUT_ERROR = 1;
            }
 
            ping.open("GET", url, true);
            ping.send();
 
        }
 
        if ((i > NB_ITERATIONS) && (over_flag < 1)) { 
 
            clearInterval(ping_loop);
            var avg_time = Math.round(time_cumul / (i - 1));
      
            document.getElementById('result').innerHTML += "todo bien";
     alert(tiempoTotal);
 
        }
 
        if (TIMEOUT_ERROR == 1) { 
 
            clearInterval(ping_loop);
            document.getElementById('result').innerHTML += "error";
            return;
 
        }
 
    }, TIME_PERIOD);
}

</script>
<html>
<head>
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>
    <li><a href="" onClick="show_finger()"  class="ah12b" id="current" >Finger</a></li>
    <li><a href="gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
      <li><a href="../../gestion/Bolsa_proceso/index.jsp" >Proceso Bolsa</a></li> 
  
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
   <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
    </ul>
  <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <form id="direccion">
  <input type="text" id="ip" value=""/>
  <input type="button" value="Ping" onClick="comprobar()"/>
</form>
<div id="result"></div>
  
</body>
</html>



<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
