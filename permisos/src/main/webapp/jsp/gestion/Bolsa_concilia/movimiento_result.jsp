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

String PERMI__PERIODO= "00";
if(request.getParameter("PERIODO") != null){ PERMI__PERIODO= (String)request.getParameter("PERIODO");}

String BOLSA_FUN__JS_NOMBRE = "";
if (request.getParameter("ID_JS_NOMBRE")           !=null) {BOLSA_FUN__JS_NOMBRE = (String)request.getParameter("ID_JS_NOMBRE")          ;}


String PERMI__TR_HORA= "00";
if(request.getParameter("TR_HORA_0") != null){ PERMI__TR_HORA= (String)request.getParameter("TR_HORA_0");}

String PERMI__TR_MINUTO= "00";
if(request.getParameter("TR_MINUTO_0") != null){ PERMI__TR_MINUTO= (String)request.getParameter("TR_MINUTO_0");}

String PERMI__OBSERVACIONES= "AAA";
if(request.getParameter("OBSERVACIONES") != null){ PERMI__OBSERVACIONES= (String)request.getParameter("OBSERVACIONES");}

String PERMI__FECHA_MOVIMIENTO= "0000";
if(request.getParameter("FECHA_MOVIMIENTO") != null){ PERMI__FECHA_MOVIMIENTO= (String)request.getParameter("FECHA_MOVIMIENTO");}

String PERMI__V_ID_REGISTRO = "0000";
if(request.getParameter("ID_REGISTRO") != null){ PERMI__V_ID_REGISTRO = (String)request.getParameter("ID_REGISTRO");}

String PERMI__V_ID_TIPO_MOVIMIENTO = "1"; 
if(request.getParameter("ID_TIPO_MOVIMIENTO") != null){ PERMI__V_ID_TIPO_MOVIMIENTO = (String)request.getParameter("ID_TIPO_MOVIMIENTO");}

String PERMI__V_ID_USUARIO = "0";
if(request.getParameter("ID_USUARIO") != null){ PERMI__V_ID_USUARIO = (String)request.getParameter("ID_USUARIO");}

String PERMI__V_ID_TIPO_OPERACION = "A";
if(request.getParameter("ID_TIPO_OPERACION") != null){ PERMI__V_ID_TIPO_OPERACION = (String)request.getParameter("ID_TIPO_OPERACION");}

String PERMI__V_ID_FUNCIONARIO = "0";

if (session.getAttribute("MM_ID_FUNCIONARIO")           !=null) {PERMI__V_ID_FUNCIONARIO= (String)session.getAttribute("MM_ID_FUNCIONARIO")          ;}
%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call PROCESA_MOV_BOLSA_CONCILIA(?,?,?,?,?,?,?,?,?,?,?)}");
PERMI.setString(1,PERMI__V_ID_REGISTRO);
PERMI.setString(2,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(3,PERMI__V_ID_TIPO_MOVIMIENTO);
PERMI.setString(4,PERMI__TR_HORA);
PERMI.setString(5,PERMI__TR_MINUTO);
PERMI.setString(6,PERMI__FECHA_MOVIMIENTO );
PERMI.setString(7,PERMI__V_ID_TIPO_OPERACION);
PERMI.setString(8,PERMI__V_ID_USUARIO);
PERMI.setString(9,PERMI__OBSERVACIONES);
PERMI.registerOutParameter(10,Types.LONGVARCHAR);
PERMI.registerOutParameter(11,Types.LONGVARCHAR);
Object PERMI_data;
PERMI.execute();
%>

<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Permisos - BOLSA CONCILIACION - POLICIAS</title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">

<body>
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
		<li><a href="../Finger" >Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
		<li><a href="../Bolsa_concilia" id="current">Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" >Incidencias  Fichajes</a></li>
	  </ul>
	</div>

	<table width="740" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
                    
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#E0E0E0">                          
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"><br>
<table width="100%"  border="0" cellspacing="0" cellpadding="4">
 
  <tr> 
   <% String v_id_todook  = (String)  (((PERMI_data = PERMI.getObject(11))==null || PERMI.wasNull())?"":PERMI_data);%>
    <td colspan="3"><div align="left"></div>      
      <p class="Estilo5">Resultado de la operaci&oacute;n:</p></td>
    </tr>
 
 <% if ( v_id_todook.equals("0") ){ %>
 <tr>
    <td valign="middle" scope="row"><img src="../../imagen/ok.jpg" width="25" height="25"></td>
    <td colspan="2" valign="middle"><span class="Estilo9"><%= (((PERMI_data = PERMI.getObject(10))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
    </tr>
<tr>
  <td valign="middle" scope="row">&nbsp;</td>
    <td colspan="2">
      <div align="center">    <input type="button" name="button" value="Inicio" onClick="window.location='index.jsp?ID_JS=' + <%= PERMI__V_ID_FUNCIONARIO %>
    	  +'&PERIODO=' + '<%= PERMI__PERIODO %>'
    	   +'&ID_JS_NOMBRE=' + '<%= BOLSA_FUN__JS_NOMBRE %>'
    	  +'' "
    		  >  </div></td>
 
  <%  } else { %>
    <tr>
    <td valign="middle" scope="row"><img src="../../imagen/delete.png" width="25" height="25"></td>
    <td colspan="2"><span class="Estilo11 Estilo6"><%= (((PERMI_data = PERMI.getObject(10))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
  </tr>
<tr>
    <td colspan="3">
	     <div align="center">    <input type="button" name="button" value="Inicio" onClick="window.location='index.jsp'">  </div></td>
    
    
      
      </td>
    </tr>
  <% } %>
    
  
  
</table>
                                
                      
                              </td>
                            </tr>
                         
                        </table>
                      </td>
                    </tr>
      </table>
  </div>
</div>	
</body>
</html>

<%
ConnPERMI.close();
%>
