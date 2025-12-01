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

String PERMI__V_ID_REGISTRO = "0000";
if(request.getParameter("ID_REGISTRO") != null){ PERMI__V_ID_REGISTRO = (String)request.getParameter("ID_REGISTRO");}

String PERMI__V_ID_FUNCIONARIO = "0";
if (session.getValue("MM_ID_FUNCIONARIO") !=null) { PERMI__V_ID_FUNCIONARIO = (String)session.getValue("MM_ID_FUNCIONARIO");}

String PERMI__V_PERIODO = "0";
if(request.getParameter("PERIODO") != null){ PERMI__V_PERIODO = (String)request.getParameter("PERIODO");}

String PERMI__V_ID_TIPO_MOVIMIENTO = "0";
if(request.getParameter("ID_TIPO_MOVIMIENTO") != null){ PERMI__V_ID_TIPO_MOVIMIENTO = (String)request.getParameter("ID_TIPO_MOVIMIENTO");}

String PERMI__V_EXCESOS_EN_HORAS = "0";
if(request.getParameter("EXCESOS_EN_HORAS") != null){ PERMI__V_EXCESOS_EN_HORAS = (String)request.getParameter("EXCESOS_EN_HORAS");}

String PERMI__V_EXCESOS_EN_MINUTOS = "0";
if(request.getParameter("EXCESOS_EN_MINUTOS") != null){ PERMI__V_EXCESOS_EN_MINUTOS = (String)request.getParameter("EXCESOS_EN_MINUTOS");}

String PERMI__V_FECHA_MOVIMIENTO = "01/01/2015";
if(request.getParameter("FECHA_MOVIMIENTO") != null){ PERMI__V_FECHA_MOVIMIENTO = (String)request.getParameter("FECHA_MOVIMIENTO");}

String PERMI__V_ID_TIPO_OPERACION = "A";
if(request.getParameter("ID_TIPO_OPERACION") != null){ PERMI__V_ID_TIPO_OPERACION = (String)request.getParameter("ID_TIPO_OPERACION");}

String PERMI__V_ID_USUARIO = "0";
if(request.getParameter("ID_USUARIO") != null){ PERMI__V_ID_USUARIO = (String)request.getParameter("ID_USUARIO");}

String PERMI__V_OBSERVACIONES = "";
if(request.getParameter("OBSERVACIONES") != null){ PERMI__V_OBSERVACIONES = (String)request.getParameter("OBSERVACIONES");}

%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call PROCESA_MOVIMIENTO_BOLSA(?,?,?,?,?,?,?,?,?,?,?,?)}");
PERMI.setString(1,PERMI__V_ID_REGISTRO);
PERMI.setString(2,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(3,PERMI__V_PERIODO);
PERMI.setString(4,PERMI__V_ID_TIPO_MOVIMIENTO);
PERMI.setString(5,PERMI__V_EXCESOS_EN_HORAS);
PERMI.setString(6,PERMI__V_EXCESOS_EN_MINUTOS);
PERMI.setString(7,PERMI__V_FECHA_MOVIMIENTO );
PERMI.setString(8,PERMI__V_ID_TIPO_OPERACION);
PERMI.setString(9,PERMI__V_ID_USUARIO);
PERMI.setString(10,PERMI__V_OBSERVACIONES);
PERMI.registerOutParameter(11,Types.LONGVARCHAR);
PERMI.registerOutParameter(12,Types.LONGVARCHAR);
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

<body>

<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
         
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
      <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
     <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>     
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
	<table width="95%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
                    
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#E0E0E0">                          
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"><br>
<table width="100%"  border="0" cellspacing="0" cellpadding="4">
 
  <tr> 
   <% String v_id_todook  = (String)  (((PERMI_data = PERMI.getObject(12))==null || PERMI.wasNull())?"":PERMI_data);%>
    <td colspan="3"><div align="left"></div>      
      <p class="Estilo5">Resultado de la operaci&oacute;n:</p></td>
    </tr>
 
 <% if ( v_id_todook.equals("0") ){ %>
 <tr>
    <td valign="middle" scope="row"><img src="../../imagen/ok.jpg" width="25" height="25"></td>
    <td colspan="2" valign="middle"><span class="Estilo9"><%= (((PERMI_data = PERMI.getObject(11))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
    </tr>
<tr>
  <td valign="middle" scope="row">&nbsp;</td>
    <td colspan="2">
      <div align="center">    <input type="button" name="button" value="Inicio" onClick="window.location='index.jsp'">  </div></td>
 
  <%  } else { %>
    <tr>
    <td valign="middle" scope="row"><img src="../../imagen/mal_rojo.jpg" width="25" height="25"></td>
    <td colspan="2"><span class="Estilo11 Estilo6"><%= (((PERMI_data = PERMI.getObject(11))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
  </tr>
<tr>
    <td colspan="3">
	  <%   
	    if ( PERMI__V_ID_TIPO_OPERACION.equals("A"))
	    {
	  %>
        <input type="button" name="button" value="Volver solicitud" onClick="window.location='alta_movimiento.jsp?ID_REGISTRO=' + <%= PERMI__V_ID_REGISTRO%>  +  '&PERIODO=' + '<%= PERMI__V_PERIODO%>' + '&ID_TIPO_MOVIMIENTO=' + '<%= PERMI__V_ID_TIPO_MOVIMIENTO%>' + '&EXCESOS_EN_HORAS=' + '<%= PERMI__V_EXCESOS_EN_HORAS%>' + '&EXCESOS_EN_MINUTOS=' + '<%= PERMI__V_EXCESOS_EN_MINUTOS%>' +'&FECHA_MOVIMIENTO=' + '<%= PERMI__V_FECHA_MOVIMIENTO%>' + '&ID_TIPO_OPERACION=' + '<%= PERMI__V_ID_TIPO_OPERACION%>' + '&OBSERVACIONES=' + '<%= PERMI__V_OBSERVACIONES%>' + '' ">
     <%  } else  
	    if ( PERMI__V_ID_TIPO_OPERACION.equals("E")  ) 
		{ %>
		  <input type="button" name="button" value="Volver solicitud" onClick="window.location='editar_movimiento.jsp?ID_REGISTRO=' + <%= PERMI__V_ID_REGISTRO%>  +  '&PERIODO=' + '<%= PERMI__V_PERIODO%>' + '&ID_TIPO_MOVIMIENTO=' + '<%= PERMI__V_ID_TIPO_MOVIMIENTO%>'  + '&EXCESOS_EN_HORAS=' + '<%= PERMI__V_EXCESOS_EN_HORAS%>' + '&EXCESOS_EN_MINUTOS=' + '<%= PERMI__V_EXCESOS_EN_MINUTOS%>' + '&FECHA_MOVIMIENTO=' + '<%= PERMI__V_FECHA_MOVIMIENTO%>' + '&ID_TIPO_OPERACION=' + '<%= PERMI__V_ID_TIPO_OPERACION%>' + '&OBSERVACIONES=' + '<%= PERMI__V_OBSERVACIONES%>' +'' ">
		  <%  } else { %>
		 		
		   <input type="button" name="button" value="Volver solicitud" onClick="window.location='borrar_movimiento.jsp?ID_REGISTRO=' + <%= PERMI__V_ID_REGISTRO%>  +  '&PERIODO=' + '<%= PERMI__V_PERIODO%>' + '&ID_TIPO_MOVIMIENTO=' + '<%= PERMI__V_ID_TIPO_MOVIMIENTO%>'  + '&EXCESOS_EN_HORAS=' + '<%= PERMI__V_EXCESOS_EN_HORAS%>' + '&EXCESOS_EN_MINUTOS=' + '<%= PERMI__V_EXCESOS_EN_MINUTOS%>' + '&FECHA_MOVIMIENTO=' + '<%= PERMI__V_FECHA_MOVIMIENTO%>' + '&ID_TIPO_OPERACION=' + '<%= PERMI__V_ID_TIPO_OPERACION%>' + '&OBSERVACIONES=' + '<%= PERMI__V_OBSERVACIONES%>' +'' "> 
       <%  }  %>
    
    
      
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

