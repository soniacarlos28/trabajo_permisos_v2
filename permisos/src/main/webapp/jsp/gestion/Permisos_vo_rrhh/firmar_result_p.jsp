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

String PRFIRMA__V_ID_FIRMA = "0";
if(request.getParameter("V_ID_FIRMA") != null){ PRFIRMA__V_ID_FIRMA = (String)request.getParameter("V_ID_FIRMA");}

String PRFIRMA__V_ID_FUNCIONARIO_FIRMA = "0";
if(session.getValue("MM_ID_USUARIO") != null){ PRFIRMA__V_ID_FUNCIONARIO_FIRMA = (String)session.getValue("MM_ID_USUARIO");}

String PRFIRMA__V_ID_PERMISO = "0";
if(request.getParameter("ID_PERMISO") != null){ PRFIRMA__V_ID_PERMISO = (String)request.getParameter("ID_PERMISO");}

String PRFIRMA__V_ID_MOTIVO = "0";
if(request.getParameter("V_ID_MOTIVO") != null){ PRFIRMA__V_ID_MOTIVO = (String)request.getParameter("V_ID_MOTIVO");}

%>
<%
String RSTIPO_PERMISO__MMColParam2 = "0000";
if (request.getParameter("ID_ANO")    !=null) {RSTIPO_PERMISO__MMColParam2 = (String)request.getParameter("ID_ANO")   ;}
%>
<%
String RSTIPO_PERMISO__MMColParam3 = "00";
if (request.getParameter("ID_PERMISO")        !=null) {RSTIPO_PERMISO__MMColParam3 = (String)request.getParameter("ID_PERMISO")       ;}
%>
<%
Driver DriverRSTIPO_PERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPO_PERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPO_PERMISO = ConnRSTIPO_PERMISO.prepareStatement("SELECT a.id_permiso,  a.id_ano,  a.id_funcionario,  a.id_tipo_permiso,  to_char(a.id_estado) as ID_ESTADO,    TO_CHAR(a.fecha_soli,'DD/MM/YYYY') as FECHA_SOLI,  to_char(nvl(a.firmado_js,'')) as firmado_js,  TO_CHAR(a.fecha_js,'DD/MM/YYYY') as FECHA_JS ,to_char(nvl( a.firmado_ja,'')) as FIRMADO_JA, to_char( a.fecha_ja,'DD/MM/YYYY') as FECHA_JA,  to_CHAR(nvl(a.firmado_rrhh,'')) AS FIRMADO_RRHH,  to_char(a.fecha_rrhh,'DD/MM/YYYY') as fecha_rrhh,  to_char(a.fecha_inicio,'DD/MM/YYYY') as fecha_inicio ,  to_char(a.fecha_fin,'DD/MM/YYYY') as fecha_fin,  a.num_dias,  a.hora_inicio,  a.hora_fin,  d.DESC_tipo_dias,  a.dprovincia,  desc_grado,  a.justificacion,  a.observaciones,  a.anulado,  a.fecha_anulacion,  substr( B.DESC_TIPO_PERMISO, 1,20) as DESC_TIPO_PERMISO,  DESC_ESTADO_PERMISO,DES_TIPO_PERMISO_LARGA  FROM PERMISO A, TR_TIPO_PERMISO B,TR_ESTADO_PERMISO T,tr_tipo_dias d,TR_GRADO G  WHERE A.ID_GRADO=G.ID_GRADO(+)  AND               A.ID_TIPO_DIAS=D.ID_TIPO_DIAS AND A.ID_ANO = '" + RSTIPO_PERMISO__MMColParam2 + "'   AND ID_PERMISO=" + RSTIPO_PERMISO__MMColParam3 + "   AND (A.ANULADO = 'NO' OR a.ANULADO IS NULL ) and      t.id_ESTADO_permiso=a.id_EStado   AND A.ID_TIPO_PERMISO = B.ID_TIPO_PERMISO AND A.ID_ANO = B.ID_ANO  ORDER BY FECHA_INICIO DESC");
ResultSet RSTIPO_PERMISO = StatementRSTIPO_PERMISO.executeQuery();
boolean RSTIPO_PERMISO_isEmpty = !RSTIPO_PERMISO.next();
boolean RSTIPO_PERMISO_hasData = !RSTIPO_PERMISO_isEmpty;
Object RSTIPO_PERMISO_data;
int RSTIPO_PERMISO_numRows = 0;
%>
<%
Driver DriverPRFIRMA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPRFIRMA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PRFIRMA = ConnPRFIRMA.prepareCall("{ call VBUENO_PERMISO_RRHH(?,?,?,?,?,?)}");
PRFIRMA.setString(1,PRFIRMA__V_ID_FIRMA);
PRFIRMA.setString(2,PRFIRMA__V_ID_FUNCIONARIO_FIRMA);
PRFIRMA.setString(3,PRFIRMA__V_ID_PERMISO);
PRFIRMA.setString(4,PRFIRMA__V_ID_MOTIVO);
PRFIRMA.registerOutParameter(5,Types.LONGVARCHAR);
PRFIRMA.registerOutParameter(6,Types.LONGVARCHAR);
Object PRFIRMA_data;
PRFIRMA.execute();
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
          <td bgcolor=#003366><div align="left"><font face=arial color=#ffffff size=+1><b>Recursos Humanos - Solicitud 
            de Permisos </b></font></div></td>
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
                                  </tr>
                                  <tr bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0"></td>
                                    <td nowrap bgcolor="#E0E0E0"><div align="right"><strong>
   Permiso:</strong></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0">                                      <span class="Estilo15"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("DES_TIPO_PERMISO_LARGA"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%></span><span class="Estilo5">
                                      <% String v_id_tipo_permiso  = (String)  (((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("ID_TIPO_PERMISO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data);%>
                                      <% String v_id_justificado  = (String)(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("JUSTIFICACION"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data);%>
                                      <input name="ID_PERMISO" type="hidden" value="<%= RSTIPO_PERMISO__MMColParam3 %>" >
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
                                    <th width="5%" scope="col">&nbsp;</th>
                                    <th width="25%" scope="col">&nbsp;</th>
                                    <th colspan="2" scope="col">&nbsp;</th>
                                  </tr>
                                  <tr>
                                    <td colspan="4"><div align="left"></div>                                      
                                    
                                      <div align="left"><span class="Estilo5"> Resultado de la operaci&oacute;n: </span></div></td>
                                  </tr>
                                  <tr>
                                    <td colspan="4" scope="row"><div align="center"><strong><%= (((PRFIRMA_data = PRFIRMA.getObject(6))==null || PRFIRMA.wasNull())?"":PRFIRMA_data)%></strong></div></td>
                                  </tr>
                                  <tr>
                                    <td colspan="4" scope="row"><div align="center">
                                      <input type="button" name="button" value="Volver" onClick="window.location='index.jsp'">
                                    </div></td>
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
      </table>
    </td>  
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
<%
ConnPRFIRMA.close();
%>
