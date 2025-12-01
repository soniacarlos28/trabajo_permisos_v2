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

String PERMI__V_ID_FUNCIONARIO = "01";
if(request.getParameter("ID_FUNCIONARIO") != null){ PERMI__V_ID_FUNCIONARIO = (String)request.getParameter("ID_FUNCIONARIO");}
%>

<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call CHEQUEA_FUNCIONARIO_DIARIO(?)}");
PERMI.setString(1,PERMI__V_ID_FUNCIONARIO);
Object PERMI_data;
PERMI.execute();

%>

<%
Driver DriverPERMI2 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI2 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI2 = ConnPERMI2.prepareCall("{ call CHEQUEA_FUNCIONARIO_DIARIO(?)}");
PERMI.setString(1,PERMI__V_ID_FUNCIONARIO);
Object PERMI2_data;
PERMI.execute();

%>

<%
String valor_acumulado;
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de PIN - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="refresh" content="0;URL=index.jsp?">  
    

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
        <td>Asignando PIN, si no existe...</td>
        </tr>
     
      
    </table>
  </div>
</div>
</body>
</html>
<%
ConnPERMI.close();
%>