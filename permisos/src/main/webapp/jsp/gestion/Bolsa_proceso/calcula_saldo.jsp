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
if (session.getValue("MM_ID_FUNCIONARIO") !=null) { PERMI__V_ID_FUNCIONARIO = (String)session.getValue("MM_ID_FUNCIONARIO");}

String PERMI__V_PERIODO = "0";
if(request.getParameter("PERIODO") != null){ PERMI__V_PERIODO = (String)request.getParameter("PERIODO");}


String PERMI__V_ID_USUARIO = "0";
if(request.getParameter("ID_USUARIO") != null){ PERMI__V_ID_USUARIO = (String)request.getParameter("ID_USUARIO");}



%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call TRASPASA_SALDO_BOLSA(?,?,?)}");
PERMI.setString(1,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(2,PERMI__V_PERIODO);
PERMI.setString(3,PERMI__V_ID_USUARIO);
Object PERMI_data;
PERMI.execute();
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
<meta http-equiv="refresh" content="0;URL=index.jsp">
</html>

<html>
<head>
<body>

<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li> 
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li> 
     <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li> 
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
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa" id="current">Bolsa</a></li>
	  </ul>
  </div>
	<div id="subform">
	<table width="95%" border="0" cellspacing="0" cellpadding="10">
        <tr> 
          <td> 
            <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
                    
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#E0E0E0">                          
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"><br>
<table width="100%"  border="0" cellspacing="0" cellpadding="4">
 
 
 
<tr>
  <td valign="middle" scope="row">
      <div align="center">    Calculando.....  
      </div></td>
    </table>                              </td>
                            </tr>
                        </table>                      </td>
                    </tr>
            </table>          </td>
        </tr>
      </table>
  </div>
</div>	
</body>
</html>


<%
ConnPERMI.close();
%>

