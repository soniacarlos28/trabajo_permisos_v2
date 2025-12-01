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
String RSPERMISO__MMColParam1 = "0";
if (request.getParameter("ID_PERMISO")  !=null) {RSPERMISO__MMColParam1 = (String)request.getParameter("ID_PERMISO") ;}
%>
<%
Driver DriverRSPERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERMISO = ConnRSPERMISO.prepareStatement("SELECT p.id_permiso,          p.id_ano,          id_funcionario,         t. id_tipo_permiso,       t. desc_tipo_permiso,          id_estado,          fecha_soli,          firmado_js,          to_char(fecha_js,'DD/MM/YYYY') as fecha_js,          firmado_ja,          fecha_ja,          firmado_rrhh,          to_char(fecha_rrhh,'DD/MM/YYYY') as fecha_rrhh,          to_char(p.fecha_inicio,'DD/MM/YYYY') as fecha_inicio   ,       to_char(p.fecha_fin,'DD/MM/YYYY') as fecha_fin,          p.num_dias,          hora_inicio,          hora_fin,         p.id_tipo_dias,          dprovincia,          id_grado,          p.justificacion,          p.observaciones,         p.anulado,          fecha_anulacion,                   motivo_denega,          total_horas  FROM permiso p , tr_tipo_permiso t  WHERE id_permiso='" + RSPERMISO__MMColParam1 + "' and p.id_tipo_permiso=t.id_tipo_permiso and  p.id_ano=t.id_ano");
ResultSet RSPERMISO = StatementRSPERMISO.executeQuery();
boolean RSPERMISO_isEmpty = !RSPERMISO.next();
boolean RSPERMISO_hasData = !RSPERMISO_isEmpty;
Object RSPERMISO_data;
int RSPERMISO_numRows = 0;
%>
<%
String RSFUNCIONARIO__MMColParam6 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO") !=null) {RSFUNCIONARIO__MMColParam6 = (String)session.getValue("MM_ID_FUNCIONARIO");}
%>
<%
Driver DriverRSFUNCIONARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFUNCIONARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFUNCIONARIO = ConnRSFUNCIONARIO.prepareStatement("SELECT * from    (select 1 orden ,nombre,ape1,ape2,tipo_funcionario2 as tipo_funcionario from personal_new where lpad(id_funcionario,6,'0')=lpad('" + RSFUNCIONARIO__MMColParam6 + "',6,'0')   union select 2 orden,'NO EXISTE FUNCIONARIO' nombre,''ape1,''ape2,0 tipo_funcionario  FROM dual)  WHERE rownum <2");
ResultSet RSFUNCIONARIO = StatementRSFUNCIONARIO.executeQuery();
boolean RSFUNCIONARIO_isEmpty = !RSFUNCIONARIO.next();
boolean RSFUNCIONARIO_hasData = !RSFUNCIONARIO_isEmpty;
Object RSFUNCIONARIO_data;
int RSFUNCIONARIO_numRows = 0;
%>
<%
String RSHORAS__MMColParam1 = "1";
if (session.getValue("MM_ID_FUNCIONARIO")  !=null) {RSHORAS__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO") ;}
%>
<%
Driver DriverRSHORAS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSHORAS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSHORAS = ConnRSHORAS.prepareStatement("SELECT trunc((total-utilizadas)/60,0) || ':' || mod(total-utilizadas,60) as horas  FROM horas_Extras_ausencias  WHERE id_funcionario='" + RSHORAS__MMColParam1 + "'");
ResultSet RSHORAS = StatementRSHORAS.executeQuery();
boolean RSHORAS_isEmpty = !RSHORAS.next();
boolean RSHORAS_hasData = !RSHORAS_isEmpty;
Object RSHORAS_data;
int RSHORAS_numRows = 0;
%>
<%
Driver DriverRSESTADO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSESTADO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSESTADO = ConnRSESTADO.prepareStatement("SELECT id_estado_permiso,         desc_estado_permiso  FROM tr_estado_permiso");
ResultSet RSESTADO = StatementRSESTADO.executeQuery();
boolean RSESTADO_isEmpty = !RSESTADO.next();
boolean RSESTADO_hasData = !RSESTADO_isEmpty;
Object RSESTADO_data;
int RSESTADO_numRows = 0;
%>

<%
String thisPage = request.getRequestURI();
%>
<script language="Javascript">
<!--

// -->
function envia_unavez()
{

 if (document.formPermiso.Guardar.disabled==false) 
  {
   document.formPermiso.Guardar.disabled=true;
   document.formPermiso.submit();
  }
}
</script>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH_DESA</title>
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
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
        <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
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
                          <form name="formPermiso" method="get" action="editar_result.jsp">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table border="0" cellspacing="0" cellpadding="2">
                                  <tr> 
                                    <td> 
                                      <input type="button" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp'" disabled="yes">
                                    </td>
                                    <td>                                      
									  <input type="button" value="volver atrás" name="volver atrás2" onClick="history.back()" />
                                    </td>
                                    <td>&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                  </tr>
                                </table>
                              </td>
                              <td bgcolor="#E0E0E0" valign="top" align="right"><b> 
                                <input type="hidden" name="IP" value="0"> 
                                <%= "<input type='hidden' name='ID_FUNCIONARIO' value='" + session.getValue("MM_ID_FUNCIONARIO") + "'>" %> 
                                <input type="hidden" name="ANULADO" value="NO">
                                <input type="hidden" name="FECHA_ANULACION">
                                <%= "<input type='hidden' name='ID_USUARIO' value='" + session.getValue("MM_ID_USUARIO") + "'>" %> 
                                <input type="hidden" name="FECHA_MODI">
                              Formulario de Editar</b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                <table align="center" cellpadding="2" cellspacing="1" border="0" width="100%">
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">A&ntilde;o:</td>
                                    <td width="75%" colspan="6"> 
                                      <input type="text" name="ID_ANO"  disabled="yes" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("ID_ANO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="6" maxlength="4">
                                    <input type="hidden" name="ID_TIPO_FUNCIONARIO" value="<%=(((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("TIPO_FUNCIONARIO"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data)%>" size="16" maxlength="15">                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Tipo 
                                      de Permiso:</td>
                                    <td width="75%" colspan="6"> 
                                      <input type="TEXT" disabled="yes" name="DESC_TIPO_PERMISO" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("DESC_TIPO_PERMISO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="75" maxlength="75">
                                     <input type="hidden"  name="ID_TIPO_PERMISO" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("ID_TIPO_PERMISO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="75" maxlength="75"> 
                                     <input type="hidden"  name="ID_PERMISO" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("ID_PERMISO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="75" maxlength="75">
                                   </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Fecha 
                                      Inicio:</td>
                                    <td valign="middle"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="25%"> 
                                            <input type="text" disabled="yes" name="FECHA_INICIO" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("FECHA_INICIO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" onChange="document.formPermiso.FECHA_FIN.value=document.formPermiso.FECHA_INICIO.value;" size="15" maxlength="10">
</td>
                                          <td width="22%">&nbsp;</td>
                                        </tr>
                                      </table>
                                    </td>
                                    <td colspan="2" align="right">Fecha Fin:</td>
                                    <td colspan="3" align="left"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="31%"> 
                                            <input type="text" disabled="yes" name="FECHA_FIN" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("FECHA_FIN"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="15" maxlength="10">
</td>
                                          <td width="22%">&nbsp;</td>
                                        </tr>
                                      </table>
                                      <div align="left"></div></td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Tipo de D&iacute;as:</td>
                                    <td><select name="TIPO_DIAS" disabled="yes">
                                      <option value="L" <%=(("L".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_TIPO_DIAS"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>LABORAL</option>
                                      <option value="N" <%=(("N".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_TIPO_DIAS"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>NATURAL</option>
                                    </select> 
                                    </td>
                                    <td colspan="2" align="right" nowrap><div align="center">
                                    </div>                                      <div align="right">N&uacute;mero D&iacute;as: </div></td>
                                    <td colspan="3" nowrap>                                    <input type="text" disabled="yes" name="NUM_DIAS" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("NUM_DIAS"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="5" maxlength="5"></td>
                                  </tr>
<% String  ID_TIPO_PERMISO=(String)(((RSPERMISO_data = RSPERMISO.getObject("ID_TIPO_PERMISO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data);%>
<% if (ID_TIPO_PERMISO.equals("15000") ) {%>  
<tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Hora Inicio :</td>
                                    <td><input name="HORA_INICIO" type="text" id="HORA_INICIO" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("HORA_INICIO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="8" maxlength="5"> 
                                    </td>
                                    <td width="1%" nowrap><div align="right">Hora Fin: </div></td>
                                    <td><input name="HORA_FIN" type="text" id="HORA_FIN" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("HORA_FIN"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="8" maxlength="5"></td>
                                    <td colspan="2"><div align="right">Disponibles: </div></td>
                                    <td>
                                      <% if (!RSHORAS_isEmpty ) { %>
                                      <input name="HORA_DIS2" type="text" disabled="yes" id="HORA_FIN2" value="<%=(((RSHORAS_data = RSHORAS.getObject("HORAS"))==null || RSHORAS.wasNull())?"":RSHORAS_data)%>" size="7" maxlength="5">
                                      <% } /* end !RSHORAS_isEmpty */ %></td>
                                  </tr>                   

                       <% } else { %>
                                                          <tr bgcolor="#f2f2f2"> 
                                    <td align="right" width="20%">Justificado:</td>
                                    <td colspan="6">                                      <select name="ID_JUSTIFICACION">
                                          <option value="NO" <%=(("NO".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("JUSTIFICACION"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>NO</option>
                                          <option value="SI" <%=(("SI".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("JUSTIFICACION"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>SI</option>
                                        <option value="--"  <%=(("--".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("JUSTIFICACION"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>--</option>
                                        </select>
                                    </td></tr>     
                   <% } %>
                  <% if (ID_TIPO_PERMISO.equals("04000")  || ID_TIPO_PERMISO.equals("04500") || ID_TIPO_PERMISO.equals("06100") ) {%>                     
                           <tr bgcolor="#f2f2f2">
                              <% if (ID_TIPO_PERMISO.equals("06100") ) { %>
                                    <td nowrap align="right"></td>
									<td colspan="4"></td>
           						<% } else { %>
									<td width="9%" align="right" nowrap>Grado:</td>
                                     <td colspan="3"><select name="ID_GRADO" disabled="yes" onChange="document.formPermiso.OBSERVACIONES.value=document.formPermiso.GRADO.options[selectedIndex].text">
                                       <option value="4" <%=(("4".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Padres/P. Politicos 4 días(Enfermedad o Muerte)</option>
                                       <option value="5" <%=(("5".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Hijos/H. Politicos Conyuge 5 Días (Enfermedad o Muerte)</option>
                                       <option value="2" <%=(("2".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Abuelos/Hermanos/Nietos 2 Días(Enfermedad o Muerte)</option>
                                       <option value="1" <%=(("1".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Abuelos/Hermanos politicos 1 Día(Enfermedad)</option>
                                       <option value="2" <%=(("2".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Abuelos/Hermanos politicos 2 Días(Muerte)</option>
                                       <option value="1" <%=(("1".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Tios/sobrinos carnales o del conyugue 1 Día(Enf. o Mue.)</option>
                                    </select></td>
                               
	                          <% } %>
                                    <td>D/P:</td>
                                    <td><select name="DPROVINCIA">
                                      <option value="NO" selected <%=(("NO".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("DPROVINCIA"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>NO</option>
                                      <option value="SI" <%=(("SI".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("DPROVINCIA"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>SI</option>
                                                                                                                                                                                    </select></td>
                                  </tr>
                   <% }%>
                                  
 <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%" bgcolor="#f2f2f2" valign="middle"><strong>ESTADO:</strong></td>
                                    <td width="75%" colspan="6" valign="baseline"><select name="ID_ESTADO_PERMISO" id="ID_ESTADO_PERMISO">
                                      <%
while (RSESTADO_hasData) {
%>
                                      <option value="<%=((RSESTADO.getObject("ID_ESTADO_PERMISO")!=null)?RSESTADO.getObject("ID_ESTADO_PERMISO"):"")%>" <%=(((RSESTADO.getObject("ID_ESTADO_PERMISO")).toString().equals(((((RSPERMISO_data = RSPERMISO.getObject("ID_ESTADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)).toString()))?"SELECTED":"")%> ><%=((RSESTADO.getObject("DESC_ESTADO_PERMISO")!=null)?RSESTADO.getObject("DESC_ESTADO_PERMISO"):"")%></option>
                                        <%
  RSESTADO_hasData = RSESTADO.next();
}
RSESTADO.close();
RSESTADO = StatementRSESTADO.executeQuery();
RSESTADO_hasData = RSESTADO.next();
RSESTADO_isEmpty = !RSESTADO_hasData;
%>
                                    </select></td>
                                  </tr><tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%" bgcolor="#f2f2f2" valign="middle">Observaciones:</td>
                                    <td width="75%" colspan="7" valign="baseline"> 
                                      <textarea name="OBSERVACIONES" value="" cols="60" rows="3"><%=(((RSPERMISO_data = RSPERMISO.getObject("OBSERVACIONES"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%></textarea>
                                    </td>
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
RSPERMISO.close();
ConnRSPERMISO.close();
%>
<%
RSFUNCIONARIO.close();
ConnRSFUNCIONARIO.close();
%>
<%
RSHORAS.close();
StatementRSHORAS.close();
ConnRSHORAS.close();
%>
<%
RSESTADO.close();
StatementRSESTADO.close();
ConnRSESTADO.close();
%>
