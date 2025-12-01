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
String RSTIPO_PERMISO__MMColParam2 = "0000";
if (request.getParameter("ID_ANO")    !=null) {RSTIPO_PERMISO__MMColParam2 = (String)request.getParameter("ID_ANO")   ;}
%>
<%
String RSTIPO_PERMISO__MMColParam3 = "00";
if (request.getParameter("ID_PERMISO")      !=null) {RSTIPO_PERMISO__MMColParam3 = (String)request.getParameter("ID_PERMISO")     ;}
%>
<%
Driver DriverRSTIPO_PERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPO_PERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPO_PERMISO = ConnRSTIPO_PERMISO.prepareStatement("SELECT to_char(pe.tipo_funcionario2) as tipo_funcionario,a.id_permiso,  a.id_ano,  a.id_funcionario,  a.id_tipo_permiso,  to_char(a.id_estado) as ID_ESTADO,    TO_CHAR(a.fecha_soli,'DD/MM/YYYY') as FECHA_SOLI,  to_char(nvl(a.firmado_js,'')) as firmado_js,  TO_CHAR(a.fecha_js,'DD/MM/YYYY') as FECHA_JS ,to_char(nvl( a.firmado_ja,'')) as FIRMADO_JA, to_char( a.fecha_ja,'DD/MM/YYYY') as FECHA_JA,  to_CHAR(nvl(a.firmado_rrhh,'')) AS FIRMADO_RRHH,  to_char(a.fecha_rrhh,'DD/MM/YYYY') as fecha_rrhh,  to_char(a.fecha_inicio,'DD/MM/YYYY') as fecha_inicio ,  to_char(a.fecha_fin,'DD/MM/YYYY') as fecha_fin,  a.num_dias,  DECODE(pe.tipo_funcionario2,23,DECODE(a.id_tipo_permiso ,'15000',a.hora_inicio,'' ),a.hora_inicio) as hora_inicio,       DECODE(pe.tipo_funcionario2,23,DECODE(a.id_tipo_permiso ,'15000',a.hora_fin,'' ),a.hora_fin) as hora_fin,  d.DESC_tipo_dias,  a.dprovincia,  desc_grado,  a.justificacion,  a.observaciones,  a.anulado,  a.fecha_anulacion,  substr( B.DESC_TIPO_PERMISO, 1,20) as DESC_TIPO_PERMISO,  DESC_ESTADO_PERMISO,DES_TIPO_PERMISO_LARGA,INITCAP(NOMBRE) ||' '|| INITCAP(APE1) ||' '|| INITCAP(APE2) as NOMBRE ,  DECODE(tu1_14_22,1, 'Permiso en Turno 1: ' || to_char(a.fecha_inicio,'DD/mm/yyyy') || ' 14:00 a 22:00') as Turno_1,  DECODE(tu2_22_06,1, 'Permiso en Turno 2: ' ||to_char(a.fecha_inicio,'DD/mm/yyyy') || ' 22:00 a 06:00') as Turno_2,      DECODE(tu3_04_14,1, 'Permiso en Turno 3: ' ||to_char(a.fecha_inicio +1,'DD/mm/yyyy') || ' 06:00  a 14:00') as Turno_3  FROM PERMISO A, TR_TIPO_PERMISO B,TR_ESTADO_PERMISO T,tr_tipo_dias d,TR_GRADO G,personal_new pe  WHERE a.id_funcionario=pe.id_funcionario and           A.ID_GRADO=G.ID_GRADO(+)  AND               A.ID_TIPO_DIAS=D.ID_TIPO_DIAS  AND     A.ID_ANO = '" + RSTIPO_PERMISO__MMColParam2 + "'   AND ID_PERMISO=" + RSTIPO_PERMISO__MMColParam3 + "   AND (A.ANULADO = 'NO' OR a.ANULADO IS NULL ) and      t.id_ESTADO_permiso=a.id_EStado   AND A.ID_TIPO_PERMISO = B.ID_TIPO_PERMISO AND A.ID_ANO = B.ID_ANO  ORDER BY FECHA_INICIO DESC");
ResultSet RSTIPO_PERMISO = StatementRSTIPO_PERMISO.executeQuery();
boolean RSTIPO_PERMISO_isEmpty = !RSTIPO_PERMISO.next();
boolean RSTIPO_PERMISO_hasData = !RSTIPO_PERMISO_isEmpty;
Object RSTIPO_PERMISO_data;
int RSTIPO_PERMISO_numRows = 0;
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
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp" id="current">Autorizar</a></li>
      
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
    </ul>
</div>
<div id="form"><div>
	  <ul id="subtabh">
		<li><a href="../../gestion/Permisos_vo_rrhh/index.jsp" id="current">Permisos pendientes autorizar</a></li>
		<li><a href="../../gestion/Ausencias_vo_rrhh/index.jsp" >Ausencias pendientes autorizar</a></li>	
		<li><a href="../../gestion/Fichajes_vo_rrhh/index.jsp">Fichajes pendientes autorizar</a></li>	
	  </ul>
	</div>
<div id="subform">
<table width="760" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="75%" align="left" valign="top">       
      <table cellspacing=0 cellpadding=3 width=98% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><div align="left"><font face=arial color=#ffffff size=+1><b>Recursos Humanos -  Firma de Permisos - VO de Solicitud</b></font></div></td>
        </tr>
        </tbody> 
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
                    <tr> 
                      <td class="va10w">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                      </td>
                      <td align="right"> 
                      <b>                      </b>                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#E0E0E0">
                          <form name="formPermiso">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bordercolor="#FFFFFF">
                                  <tr bgcolor="#f2f2f2"> 
                                    <td colspan="13" align="right" bgcolor="#E0E0E0"><div align="left"> </div>                                      
                                    
                                      <div align="left" class="Estilo5"> Detalle del Permiso Solicitado:                                     </div></td>
                                        <td>   <a href="#" onClick="javascript:window.open('mi_calendario.jsp?ID_FUNCIONARIO=<%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("ID_FUNCIONARIO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%>' ,null,'top=0,left=100,height=800,width=940,scrollbars=yes,status=no,toolbar=no ,menubar=no,location=0,directories=no');">Mostrar su Calendario</a></td>
                                     
                                  </tr><tr  bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Solicitado:</strong></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("NOMBRE"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%> </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0"></td>
                                    <td nowrap bgcolor="#E0E0E0"><div align="right"><strong>
   Permiso:</strong></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0">                                      <span class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("DES_TIPO_PERMISO_LARGA"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></span><span class="Estilo5">
                                      <% String v_id_tipo_permiso  = (String)  (((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("ID_TIPO_PERMISO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data);%>
                                      <% String v_id_justificado  = (String)(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("JUSTIFICACION"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data);%>
                                       <% String v_tipo_funcionario  = (String)(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("TIPO_FUNCIONARIO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data);%>
    
                                      <input name="ID_PERMISO" type="hidden" value="<%= RSTIPO_PERMISO__MMColParam3 %>" >
                                      <input name="ID_ANO" type="hidden" value="<%= RSTIPO_PERMISO__MMColParam2 %>" >
                                      <input name="FECHA_INICIO" type="hidden" value="<%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("FECHA_INICIO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%>" >
                                      <input name="FECHA_FIN" type="hidden" value="<%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("FECHA_FIN"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%>" >
                                    </span>                                    </td>
                                  </tr>
                                  <tr id="VACA" bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Tipo dias:</strong></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("DESC_TIPO_DIAS"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%> </td>
                                  </tr>
   								<% if ( v_id_tipo_permiso.equals("04500")  || v_id_tipo_permiso.equals("04000")) { %>
                           <tr id="GRAD" bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Grado:                                     </strong></div></td>
                                    <td colspan="3"  bgcolor="#E0E0E0"><div align="left" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("DESC_GRADO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%>
                                    </div></td>
                                    <td width="1%" bgcolor="#E0E0E0"><div align="right"><strong>D/P:</strong></div></td>
                                    <td bgcolor="#E0E0E0" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("DPROVINCIA"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></td>
                           </tr>
                                <% } %>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td valign="middle" nowrap bgcolor="#E0E0E0">                                    <div align="left"></div>                                    
                                    <div align="right"><strong>Fecha Inicio:</strong></div></td>
                                    <td width="276" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("FECHA_INICIO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%>
                                    </div></td>
                                    <td width="77" align="left" valign="middle" nowrap bgcolor="#E0E0E0"><div align="right"><strong>Fecha Fin:</strong></div></td>
                                    <td width="188" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("FECHA_FIN"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></div></td>
                                    <td align="left" valign="middle" nowrap bgcolor="#E0E0E0"><div align="right"><strong>N&uacute;mero de d&iacute;as : </strong></div></td>
                                    <td colspan="2" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("NUM_DIAS"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%>
                                    </div></td>
                                    <td width="5" colspan="4" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left"></div></td>
                                  </tr>
                                              <% if ( v_tipo_funcionario.equals("23") ) { %>
        <% if ( v_id_tipo_permiso.equals("02000")  || v_id_tipo_permiso.equals("02015")   || v_id_tipo_permiso.equals("01015") ) { %> 
    <tr> <td colspan="7" ><table id="BOMBE">
            <tr><td colspan="5" >
            <tr><td colspan="3" >Guardia: Fecha Inicio a las 14:00 hasta día siguiente a las 14:00.</td></tr>
            <tr><td colspan="2" ><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("TURNO_1"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></td></tr>
            <tr><td colspan="2" ><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("TURNO_2"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></td></tr>
            <tr><td colspan="2" ><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("TURNO_3"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></td></tr>          
             </td></tr>
             </table></td>            
     </tr> 
       <% } %><% } %>
                                  
                                 <% if ( v_id_tipo_permiso.equals("15000") ) { %>
                                  <tr id="COMPE" bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Hora Inicio:</strong></div></td>
                                    <td bgcolor="#E0E0E0" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("HORA_INICIO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Hora Fin: </strong></div></td>
                                    <td bgcolor="#E0E0E0" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("HORA_FIN"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></td>
                                    <td colspan="7" bgcolor="#E0E0E0">&nbsp;</td>
                                  </tr>
                                <% } if (v_id_justificado.equals("--")) { %>
								 <tr id="VACION" bgcolor="#f2f2f2">
                                    <td colspan="13" align="right" bgcolor="#E0E0E0"><div align="right"></div></td>
                                  </tr>
                                 <% } else  { %>								
                                 <tr  bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Justificado:</strong></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0" class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("JUSTIFICACION"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></td>
                                  </tr>                              
                                 <% }  %>	
                                
                                 
                                </table>
                                <br>
                                <table width="100%"  border="0" cellspacing="0" cellpadding="4">
                                  <tr bgcolor="#FFFFFF">
                                    <th colspan="2" scope="col">                                      <div align="left">
                                        <% String direccion_p= "'/desa/Aplicacion/Rrhh/Gestion/Firma/Permisos/firmar_plani_p.jsp?FECHA_INICIO=" + (((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("FECHA_INICIO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data) + "&FECHA_FIN=" + (((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("FECHA_FIN"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)+"'"; %>
                                      </div></th>
                                   <th colspan="2" scope="col">&nbsp;</th>
                                  </tr>
                                  <tr>
                                    <td width="5%" rowspan="2"><div align="left"><img src="../../../Produccion/imagen/numero_1.jpg" width="25" height="25"></div></td>
                                    <td width="25%" rowspan="2" nowrap><p class="Estilo5">V&ordm; B&ordm; Solicitud
                                        <input type="button" name="Submit" value="Autorizar" onClick="window.location='firmar_result_p.jsp?V_ID_FIRMA=1&ID_PERMISO=' +  document.formPermiso.ID_PERMISO.value +'&ID_ANO=' + document.formPermiso.ID_ANO.value">
                                    </p></td>
                                    <td rowspan="2" nowrap><span class="Estilo5">o Denegar                                    </span><span class="Estilo5">
                                    </span></td>
                                    <td nowrap><div align="center">Motivo:
                                        <input name="MOTIVO" type="text" id="MOTIVO" size="32"> 
                                      </div></td>
                                  </tr>
                                  <tr>
                                    <td><div align="center"><span class="Estilo5">
                                      <input type="button" name="Submit2" value="Denegar" onClick="window.location='firmar_result_p.jsp?V_ID_FIRMA=0&V_ID_MOTIVO=' +  document.formPermiso.MOTIVO.value +  '&ID_PERMISO=' +  document.formPermiso.ID_PERMISO.value +'&ID_ANO=' + document.formPermiso.ID_ANO.value">
                                    </span></div></td>
                                  </tr>
                                  <tr>
                                    <td scope="row"><img src="../../../Produccion/imagen/numero_2.jpg" width="25" height="25"></td>
                                    <td colspan="3"><span class="Estilo5">Esperar el resultado de la operaci&oacute;n.. 
                                      
                                    </span></td>
                                  </tr>
                                </table>
</td>
                            </tr>
                          </form>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
    </table>    </td>   
  </tr>
</table>

</div>

</body>
</html>
<%
RSTIPO_PERMISO.close();
StatementRSTIPO_PERMISO.close();
ConnRSTIPO_PERMISO.close();
%>
