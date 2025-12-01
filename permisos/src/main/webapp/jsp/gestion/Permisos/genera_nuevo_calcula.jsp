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

String CALCULA_P__IN_ID_FUNCIONARIO = "00000";
if(request.getParameter("ID_FUNCIONARIO") != null){ CALCULA_P__IN_ID_FUNCIONARIO = (String)request.getParameter("ID_FUNCIONARIO");}

String CALCULA_P__IN_FECHA_INGRESO = "0";
if(request.getParameter("FECHA_INICIO") != null){ CALCULA_P__IN_FECHA_INGRESO = (String)request.getParameter("FECHA_INICIO");}

String CALCULA_P__IN_FECHA_FIN = "0";
if(request.getParameter("FECHA_FIN") != null){ CALCULA_P__IN_FECHA_FIN = (String)request.getParameter("FECHA_FIN");}

String CALCULA_P__IN_TIPO_FUNCIONARIO = "0";
if(request.getParameter("ID_TIPO_FUNCIONARIO") != null){ CALCULA_P__IN_TIPO_FUNCIONARIO = (String)request.getParameter("ID_TIPO_FUNCIONARIO");}

String CALCULA_P__IN_PERMISOS_ASUNTO = "0";
if(request.getParameter("ASUNTO") != null){ CALCULA_P__IN_PERMISOS_ASUNTO = (String)request.getParameter("ASUNTO");}

String CALCULA_P__IN_PERMISOS_COMPE = "0";
if(request.getParameter("COMPE") != null){ CALCULA_P__IN_PERMISOS_COMPE = (String)request.getParameter("COMPE");}

%>
<%
String RSFUNCIONARIO__MMColParam6 = "000000";
if (request.getParameter("ID_FUNCIONARIO")      !=null) {RSFUNCIONARIO__MMColParam6 = (String)request.getParameter("ID_FUNCIONARIO")     ;}
%>
<%
Driver DriverRSFUNCIONARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFUNCIONARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFUNCIONARIO = ConnRSFUNCIONARIO.prepareStatement("SELECT * from    (select 1 orden ,nombre,ape1,ape2 from personal_new where lpad(id_funcionario,6,'0')=lpad('" + RSFUNCIONARIO__MMColParam6 + "',6,'0')   union select 2 orden,'NO EXISTE FUNCIONARIO' nombre,''ape1,''ape2  FROM dual)  WHERE rownum <2");
ResultSet RSFUNCIONARIO = StatementRSFUNCIONARIO.executeQuery();
boolean RSFUNCIONARIO_isEmpty = !RSFUNCIONARIO.next();
boolean RSFUNCIONARIO_hasData = !RSFUNCIONARIO_isEmpty;
Object RSFUNCIONARIO_data;
int RSFUNCIONARIO_numRows = 0;
%>
<%

Driver DriverCALCULA_P = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnCALCULA_P = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement CALCULA_P = ConnCALCULA_P.prepareCall("{ call CALCULA_PERMISOS(?,?,?,?,?,?)}");
CALCULA_P.setString(1,CALCULA_P__IN_ID_FUNCIONARIO);
CALCULA_P.setString(2,CALCULA_P__IN_FECHA_INGRESO);
CALCULA_P.setString(3,CALCULA_P__IN_FECHA_FIN);
CALCULA_P.setString(4,CALCULA_P__IN_TIPO_FUNCIONARIO);
CALCULA_P.setString(5,CALCULA_P__IN_PERMISOS_ASUNTO);
CALCULA_P.setString(6,CALCULA_P__IN_PERMISOS_COMPE);
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
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
   <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
     <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li> 
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
     <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li> 
      <li><a href="../../gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
      <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li> 
 </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
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
                                Nuevo Funcionario Calculo  de Permisos</b></td>
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
<%
RSFUNCIONARIO.close();
ConnRSFUNCIONARIO.close();
%>

