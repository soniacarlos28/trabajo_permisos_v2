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

String PERMI__V_ID_FUNCIONARIO = "0";
if(request.getParameter("ID_FUNCIONARIO") != null){ PERMI__V_ID_FUNCIONARIO = (String)request.getParameter("ID_FUNCIONARIO");}

String PERMI__I_FECHA_P = "01/01/2000";
if(request.getParameter("ID_DIA") != null){ PERMI__I_FECHA_P = (String)request.getParameter("ID_DIA");}

String PERMI__I_CADENA_FICHAJE = "000000";
if (request.getParameter("campo_final")  !=null) {PERMI__I_CADENA_FICHAJE = (String)request.getParameter("campo_final") ;}

String PERMI__I_CADENA_COMPUTADAS = "000000";
if (request.getParameter("computa_final")  !=null) {PERMI__I_CADENA_COMPUTADAS = (String)request.getParameter("computa_final") ;}

%>

<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call FINGER_PROCESA_TRANSACCIONES(?,?,?,?,?)}");
PERMI.setString(1,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(2,PERMI__I_FECHA_P);
PERMI.setString(3,PERMI__I_CADENA_FICHAJE);
PERMI.setString(4,PERMI__I_CADENA_COMPUTADAS);
PERMI.registerOutParameter(5,Types.LONGVARCHAR);
Object PERMI_data;
PERMI.execute();

%>

<%
String RSCONSULTA__MMColParam13 = "000000";
if (request.getParameter("campo_final")  !=null) {RSCONSULTA__MMColParam13 = (String)request.getParameter("campo_final") ;}%>


<%
String valor_acumulado;
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="refresh" content="0;URL=detalle_dia.jsp?ID_DIA=<%= PERMI__I_FECHA_P %>">  
    

<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger"  id="current">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

 </ul>
</div>
  <div id="form">
<div>
	 <ul id="subtabh">
		<li id="active"><a href="../Finger" id="current">Fichajes</a></li>
		<li><a href="../Permisos" >Configuracion</a></li>
		<li><a href="../Permisos" >Calendario</a></li>
		<li><a href="../Ausencias">Alertas</a></li>				
	  </ul>
  </div> 
	<div id="subform">
	<table width="20%" border="3" cellspacing="3" cellpadding="1">
      <tr>
        <td>Regenerando fichajes...</td>
        </tr>
        <tr>
             <td>ID FUNCIONARIO: <%= PERMI__V_ID_FUNCIONARIO %></td>
        </tr>
         <tr>
             <td>fecha: <%= PERMI__I_FECHA_P %></td>
        </tr>
              <tr>
             <td>CADENA: <%= PERMI__I_CADENA_FICHAJE %></td>
        </tr>
        
            <tr>
             <td>Computada: <%= PERMI__I_CADENA_COMPUTADAS %></td>
        </tr>
      
    </table>
  </div>
</div>
</body>
</html>
<%
ConnPERMI.close();
%>