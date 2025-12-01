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
                          <form name="formPermiso" method="get" action="genera_nuevo_calcula.jsp">
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
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">A&ntilde;o:</td>
                                    <td width="75%" colspan="3" align="left"> 
                                      <p> 
                                        <input type="text" name="ID_ANO"  value="2020" size="6" maxlength="4">
                                        <input type="hidden" name="ID_FUNCIONARIO" value="<%= session.getValue("MM_ID_FUNCIONARIO") %>" >
                                        <input type="hidden" name="ID_ANO2" value="2020" >
                                      </p>
                                    </td>
                                  </tr>
 									<tr bgcolor="f2f2f2">
 									  <td align="right">Fecha Ingreso:</td>
										<td width="75%" align="left"><input name="FECHA_INICIO" type="text" value="01/01/2004" size="15"></td>
  									    <td align="right">Fecha Fin : </td>
  									    <td><input name="FECHA_FIN" type="text" value="01/01/2400" size="15"></td>
 									</tr>


                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Tipo 
                                      de Funcionario:</td>
                                    <td width="75%" colspan="3" align="left"> 
                                      <select name="ID_TIPO_FUNCIONARIO">
                                        <option value="N">AYUNTAMIENTO OFICINAS</option>
                                        <option value="P">POLICIA</option>
                                        <option value="B">BOMBERO</option>
                                        <option value="SP">SERVICIO PERMANENTE</option>
                                      </select>
</td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" >Asuntos propios:</td>
                                    <td width="75%"> 
                                      <select name="ASUNTO">
                                        <option value="S">SI</option>
                                        <option value="N">NO</option>
                                      </select>
</td>
                                    <td width="25%" align="right">Compensatorios:</td>
                                    <td width="25%"> 
                                      <select name="COMPE">
                                        <option value="S">SI</option>
                                        <option value="N">NO</option>
                                      </select>
                                    </td>
                                  </tr>

                                  <tr align="center"> 
                                    <td colspan="4" nowrap ><input type="submit" name="Nuevo_funci" value="Genera permisos"></td>
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

