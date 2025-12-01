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

String CALCULA_P__IN_ID_FUNCIONARIO = "-1";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {CALCULA_P__IN_ID_FUNCIONARIO = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}

String CALCULA_P__IN_ID_ANO = "2022";
if(request.getParameter("ID_ANO") != null){ CALCULA_P__IN_ID_ANO = (String)request.getParameter("ID_ANO");}


%>

<%

Driver DriverCALCULA_P = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnCALCULA_P = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement CALCULA_P = ConnCALCULA_P.prepareCall("{ call CALCULA_PERMISOS_LOS_ANIOS(?,?)}");
CALCULA_P.setString(1,CALCULA_P__IN_ID_FUNCIONARIO);
CALCULA_P.setString(2,CALCULA_P__IN_ID_ANO);

Object CALCULA_P_data;
CALCULA_P.execute();
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
%>
<%
Driver driver = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection connection = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
%>
<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
   <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
     <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li> 
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
     <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li> 
      <li><a href="gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
       <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
 </ul>
</div>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" id="current">Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
	</div>
	<div id="subform">
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formPermiso" method="POST" action="genera_nuevo_calcula.jsp">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table border="0" cellspacing="0" cellpadding="2">
                                  <tr> 
                                    <td>                                    &nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                  </tr>
                                </table>
                              </td>
                              <td bgcolor="#E0E0E0" valign="top" align="right"><b> 
                                <%= "<input type='hidden' name='ID_FUNCIONARIO' value='" + session.getValue("MM_ID_FUNCIONARIO") + "'>" %> <%= "<input type='hidden' name='ID_USUARIO' value='" + session.getValue("MM_ID_USUARIO") + "'>" %> 
                                <input type="hidden" name="FECHA_MODI">
                                 Calculo de los Permisos del año: <%= session.getValue("MM_ID_FUNCIONARIO")  %> </b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                <table align="center" cellpadding="2" cellspacing="1" border="0" width="100%">

                                  <tr align="center">
                                <tr><td align="center"> Calculo correcto</td>                        
                                </tr> 
                                  
                                    <td width="145%" align="center" nowrap ><input type="button" name="Nuevo_funci" value="Volver a permisos" onClick="window.location='index.jsp'" ></td>
                                  </tr>

                                </table>                                                     
                              </td>
                            </tr>
                          </form>
      </table>
	
	</div>
</div>
	
</body>
</html>
