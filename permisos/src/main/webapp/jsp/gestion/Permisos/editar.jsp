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
String RSPERIODO__MMColParam15 = "000000";
if (request.getParameter("ID_FUNCIONARIO")   !=null) {RSPERIODO__MMColParam15 = (String)request.getParameter("ID_FUNCIONARIO")  ;}
%>
<%
String RSPERIODO__MMColParam51 = "";
if (request.getParameter("NOMBRE")    !=null) {RSPERIODO__MMColParam51 = (String)request.getParameter("NOMBRE")   ;}
%>

<%
String RSQUERY__MMColParam71 = "";
if (request.getParameter("APE1")    !=null) {RSQUERY__MMColParam71 = (String)request.getParameter("APE1")   ;}
%>
<%
String RSQUERY__MMColParam81 = "";
if (request.getParameter("APE2")    !=null) {RSQUERY__MMColParam81 = (String)request.getParameter("APE2")   ;}
%>
<% String  v_id_tipo_fila=""; %>
<%
if (!RSPERIODO__MMColParam15.equals("000000")) { 
	session.putValue("MM_ID_FUNCIONARIO", 			RSPERIODO__MMColParam15); 
	session.putValue("MM_ID_FUNCIONARIO_NOMBRE", RSPERIODO__MMColParam51); 
	session.putValue("MM_ID_FUNCIONARIO_APE1", 			RSQUERY__MMColParam71); 
	session.putValue("MM_ID_FUNCIONARIO_APE2", 			RSQUERY__MMColParam81); 
	
} else {
	RSPERIODO__MMColParam15 = (String) session.getValue("MM_ID_FUNCIONARIO");
}
%>
<%
String RSPERMISO__MMColParam1 = "0";
if (request.getParameter("ID_PERMISO")  !=null) {RSPERMISO__MMColParam1 = (String)request.getParameter("ID_PERMISO") ;}
%>
<%
Driver DriverRSPERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERMISO = ConnRSPERMISO.prepareStatement("SELECT DESCUENTO_DIAS,NVL(DESCUENTO_BAJAS,'NO') as DESCUENTO_BAJAS,DECODE(tu1_14_22,1, 'Permiso en Turno 1: ' || to_char(p.fecha_inicio,'DD/mm/yyyy') || ' 08:00 a 16:00') as Turno_1,  DECODE(tu2_22_06,1, 'Permiso en Turno 2: ' ||to_char(p.fecha_inicio,'DD/mm/yyyy') || ' 16:00 a 00:00') as Turno_2,      DECODE(tu3_04_14,1, 'Permiso en Turno 3: ' ||to_char(p.fecha_inicio +1,'DD/mm/yyyy') || ' 00:00  a 08:00') as Turno_3,DECODE(tipo_baja,'AL','ACCIDENTE LABORAL','AR','ACCIDENTE LABORAL RECAIDA','AN','ACCIDENTE NO LABORAL','EC','ENFERMEDAD COMUN','') AS tipo_baja,p.id_permiso,          p.id_ano,          id_funcionario,         t. id_tipo_permiso,       t. desc_tipo_permiso,          id_estado,          fecha_soli,          firmado_js,          to_char(fecha_js,'DD/MM/YYYY') as fecha_js,          firmado_ja,          fecha_ja,          firmado_rrhh,          to_char(fecha_rrhh,'DD/MM/YYYY') as fecha_rrhh,          to_char(p.fecha_inicio,'DD/MM/YYYY') as fecha_inicio   ,       to_char(p.fecha_fin,'DD/MM/YYYY') as fecha_fin,          p.num_dias,          hora_inicio,          hora_fin,         p.id_tipo_dias,          dprovincia,          id_grado,          p.justificacion,          p.observaciones,         p.anulado,          fecha_anulacion,                   motivo_denega,          total_horas  FROM permiso p , tr_tipo_permiso t  WHERE id_permiso='" + RSPERMISO__MMColParam1 + "' and p.id_tipo_permiso=t.id_tipo_permiso and  p.id_ano=t.id_ano");
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
PreparedStatement StatementRSFUNCIONARIO = ConnRSFUNCIONARIO.prepareStatement("SELECT * from    (select 1 orden , nombre,ape1,ape2,to_char(tipo_funcionario2) as tipo_funcionario from personal_new where lpad(id_funcionario,6,'0')=lpad('" + RSFUNCIONARIO__MMColParam6 + "',6,'0')   union select 2 orden,'NO EXISTE FUNCIONARIO' nombre,''ape1,''ape2,'0' tipo_funcionario  FROM dual)  WHERE rownum <2");
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
                          <form name="formPermiso" method="get" action="editar_result.jsp">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table border="0" cellspacing="0" cellpadding="2">
                                  <tr> 
                                    <td> 
                                      <input type="button" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp'" disabled="yes">
                                    </td>
                                    <td> 
                                      <input type="submit" value="Guardar" name="Guardar" onClick="javascript:envia_unavez();">
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
             <% String  v_id_tipo_permiso=(String)(((RSPERMISO_data = RSPERMISO.getObject("ID_TIPO_PERMISO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data);%>
                     <% if (v_id_tipo_permiso.equals("11300") ) {%>
                                         <table border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td width="31%"> 
                                               <input type="text" name="B_FECHA_FIN" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("FECHA_FIN"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="15" maxlength="10">
                                              </td>
                                              <td width="22%"><a href="javascript:show_Calendario('formPermiso.B_FECHA_FIN');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a>
                                                <input type="text" disabled="yes" name="TIPO_BAJA" value="<%= (((RSPERMISO_data = RSPERMISO.getObject("TIPO_BAJA"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="45" maxlength="40">
                                              
                                              </td>
                                            </tr>
                                            
                                             <tr bgcolor="#f2f2f2"> 
                                                <td align="right" width="20%">Descuento Enfermedad a bolsa:</td>
                                                <td > 
                                                 <select name="DESCUENTO_BAJAS" >
                                                   <option value="SI" <%=(("SI".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("DESCUENTO_BAJAS"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>SI</option>
                                                   <option value="NO" <%=(("NO".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("DESCUENTO_BAJAS"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>NO</option>
                                                 </select>
                                                 <td></td>
                                                </td>
                                                <td nowrap align="right" width="20%">Descuento en d�as:</td>
                                                <td><input name="DESCUENTO_DIAS"  type="text" id="DESCUENTO_DIAS" value="<%= (((RSPERMISO_data = RSPERMISO.getObject("DESCUENTO_DIAS"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="8" maxlength="5"></td>
                                                 </td>  
                                                </td>   
                                              </tr>                                              
                                         </table>                                                                       
                                          <% }  else { %>
   													<input type="text" disabled="yes" name="FECHA_FIN" value="<%=(((RSPERMISO_data = RSPERMISO.getObject("FECHA_FIN"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%>" size="15" maxlength="10">                                                                                   
                                           <% } %>                                                           
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
         <% String v_tipo_funcionario  = (String)(((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("TIPO_FUNCIONARIO"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data);%>
                         
                           <% if ( v_tipo_funcionario.equals("23") ) { %>
        <% if ( v_id_tipo_permiso.equals("02000")  || v_id_tipo_permiso.equals("02015")   || v_id_tipo_permiso.equals("01015") 
        		|| v_id_tipo_permiso.equals("10100") 	|| v_id_tipo_permiso.equals("11000") || v_id_tipo_permiso.equals("08000") 
        ) { %> 
    <tr> <td colspan="7" align="center"  ><table id="BOMBE">
            <tr><td colspan="5" >
            <tr><td colspan="3" >Guardia: Fecha Inicio a las 08:00 hasta d�a siguiente a las 08:00. Desde el 12 Mayo 2022.</td></tr>
            <tr><td colspan="2" ><%=(((RSPERMISO_data = RSPERMISO.getObject("TURNO_1"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%></td></tr>
            <tr><td colspan="2" ><%=(((RSPERMISO_data = RSPERMISO.getObject("TURNO_2"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%></td></tr>
            <tr><td colspan="2" ><%=(((RSPERMISO_data = RSPERMISO.getObject("TURNO_3"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)%></td></tr>          
             </td></tr>
             </table></td>            
     </tr> 
       <% } %><% } %>
<% if (v_id_tipo_permiso.equals("15000") ) {%>  
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
                  <% if (v_id_tipo_permiso.equals("04000")  || v_id_tipo_permiso.equals("04500") || v_id_tipo_permiso.equals("06100") ) {%>                     
                           <tr bgcolor="#f2f2f2">
                              <% if (v_id_tipo_permiso.equals("06100") ) { %>
                                    <td nowrap align="right"></td>
									<td colspan="4"></td>
           						<% } else { %>
									<td width="9%" align="right" nowrap>Grado:</td>
                                     <td colspan="3"><select name="ID_GRADO" disabled="yes" onChange="document.formPermiso.OBSERVACIONES.value=document.formPermiso.GRADO.options[selectedIndex].text">
                                          <option value="4" <%=(("4".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Padres/Padres pol�ticos 5 D&iacute;as Enfermedad y 4 D&iacute;as Fallecimiento</option>
     <option value="5" <%=(("5".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Hijos/Hijos politicos/Conyuge 5 D&iacute;as (Enfermedad y  Fallecimiento)</option>
     <option value="3" <%=(("3".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Abuelos/Hermanos/Nietos y pol�ticos 4 D&iacute;as Enfermedad y 2 D&iacute;as Fallecimiento</option>
     <option value="1" <%=(("1".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Abuelos/Hermanos politicos 1 D�a(Enfermedad)</option>
     <option value="2" <%=(("2".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Abuelos/Hermanos politicos 2 D�as(Muerte)</option>
     <option value="6" <%=(("6".toString().equals((((RSPERMISO_data = RSPERMISO.getObject("ID_GRADO"))==null || RSPERMISO.wasNull())?"":RSPERMISO_data)))?"SELECTED":"")%>>Tios/sobrinos carnales o c. del conyugue 1 D&iacute;a (Enfermedad y  Fallecimiento)</option>  
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

