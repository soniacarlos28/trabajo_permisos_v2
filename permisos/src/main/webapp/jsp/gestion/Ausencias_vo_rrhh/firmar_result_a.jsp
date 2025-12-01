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

String PRFIRMA__V_ID_AUSENCIA = "0";
if(request.getParameter("ID_AUSENCIA") != null){ PRFIRMA__V_ID_AUSENCIA = (String)request.getParameter("ID_AUSENCIA");}

String PRFIRMA__V_ID_MOTIVO = "0";
if(request.getParameter("V_ID_MOTIVO") != null){ PRFIRMA__V_ID_MOTIVO = (String)request.getParameter("V_ID_MOTIVO");}

%>
<%
String RSTIPO_AUSENCIA__MMColParam2 = "0000";
if (request.getParameter("ID_ANO")    !=null) {RSTIPO_AUSENCIA__MMColParam2 = (String)request.getParameter("ID_ANO")   ;}
%>
<%
String RSTIPO_AUSENCIA__MMColParam3 = "00";
if (request.getParameter("ID_AUSENCIA")        !=null) {RSTIPO_AUSENCIA__MMColParam3 = (String)request.getParameter("ID_AUSENCIA")       ;}
%>
<%
Driver DriverRSTIPO_AUSENCIA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPO_AUSENCIA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPO_AUSENCIA = ConnRSTIPO_AUSENCIA.prepareStatement("SELECT a.id_ausencia,  a.id_ano,  a.id_funcionario,    a.id_tipo_ausencia,  to_char(a.id_estado) as ID_ESTADO,      TO_CHAR(a.fecha_MODI,'DD/MM/YYYY') as FECHA_SOLI,     to_char(nvl(a.firmado_js,'')) as firmado_js,     TO_CHAR(a.fecha_js,'DD/MM/YYYY') as FECHA_JS ,    to_char(nvl( a.firmado_ja,'')) as FIRMADO_JA,     to_char( a.fecha_ja,'DD/MM/YYYY') as FECHA_JA,      to_CHAR(nvl(a.firmado_rrhh,'')) AS FIRMADO_RRHH,      to_char(a.fecha_rrhh,'DD/MM/YYYY') as fecha_rrhh,       to_char(a.fecha_inicio,'DD/MM/YYYY') as fecha_inicio ,       to_char(a.fecha_fin,'DD/MM/YYYY') as fecha_fin,       substr(to_char(a.FECHA_INICIO,'DD/MM/YYYY HH24:MI'),12,5)  as hora_inicio,       substr(to_char(a.FECHA_FIN,'DD/MM/YYYY HH24:MI'),12,5)  as hora_fin,                a.observaciones,  a.anulado,         a.fecha_anulacion,         substr( B.DESC_TIPO_ausencia, 1,60) as DESC_TIPO_ausencia,         DESC_ESTADO_PERMISO,          INITCAP(NOMBRE) || ' '||INITCAP(APE1) || ' '|| INITCAP(APE2) as NOMBRE  FROM ausencia A, TR_TIPO_ausencia B,TR_ESTADO_PERMISO T,        personal_new pe  WHERE a.id_funcionario=pe.id_funcionario and                          ID_ANO ='" + RSTIPO_AUSENCIA__MMColParam2 + "'   AND ID_ausencia=" + RSTIPO_AUSENCIA__MMColParam3 + "          AND (A.ANULADO = 'NO' OR a.ANULADO IS NULL ) and               t.id_ESTADO_PERMISO=a.id_EStado             AND A.ID_TIPO_ausencia = B.ID_TIPO_ausencia  ORDER BY FECHA_INICIO DESC");
ResultSet RSTIPO_AUSENCIA = StatementRSTIPO_AUSENCIA.executeQuery();
boolean RSTIPO_AUSENCIA_isEmpty = !RSTIPO_AUSENCIA.next();
boolean RSTIPO_AUSENCIA_hasData = !RSTIPO_AUSENCIA_isEmpty;
Object RSTIPO_AUSENCIA_data;
int RSTIPO_AUSENCIA_numRows = 0;
%>
<%

Driver DriverPRFIRMA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPRFIRMA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PRFIRMA = ConnPRFIRMA.prepareCall("{ call VBUENO_AUSENCIA_RRHH(?,?,?,?,?,?)}");
PRFIRMA.setString(1,PRFIRMA__V_ID_FIRMA);
PRFIRMA.setString(2,PRFIRMA__V_ID_FUNCIONARIO_FIRMA);
PRFIRMA.setString(3,PRFIRMA__V_ID_AUSENCIA);
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
<title>Mis Gestiones - Firma Ausencia</title>
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
     <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
    </ul>
</div>
<div id="form"><div>
	  <ul id="subtabh">
		<li><a href="../../gestion/Permisos_vo_rrhh/index.jsp" >Permisos pendientes autorizar</a></li>
		<li><a href="../../gestion/Ausencias_vo_rrhh/index.jsp" id="current" >Ausencias pendientes autorizar</a></li>	
		<li><a href="../../gestion/Fichajes_vo_rrhh/index.jsp" >Fichajes pendientes autorizar</a></li>		
	  </ul>
	</div>
<div id="subform">

<table width="760" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="75%" align="left" valign="top">       
      <table cellspacing=0 cellpadding=3 width=98% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><div align="left"><font face=arial color=#ffffff size=+1><b>Recursos Humanos - Firma de Ausencias</b></font></div></td>
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
                                    <td colspan="7" align="right" bgcolor="#E0E0E0"><div align="left"> </div>
                                        <div align="left" class="Estilo5"> Detalle del Ausencia Solicitado: </div></td>
                                  </tr>
                                  <tr  bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Solicitado:</strong></div></td>
                                    <td colspan="4" bgcolor="#E0E0E0" class="Estilo15"><%=(((RSTIPO_AUSENCIA_data = RSTIPO_AUSENCIA.getObject("NOMBRE"))==null || RSTIPO_AUSENCIA.wasNull())?"":RSTIPO_AUSENCIA_data)%> </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0"></td>
                                    <td nowrap bgcolor="#E0E0E0"><div align="right"><strong> Ausencia:</strong></div></td>
                                    <td colspan="4" bgcolor="#E0E0E0"> <span class="Estilo15"><%=(((RSTIPO_AUSENCIA_data = RSTIPO_AUSENCIA.getObject("DESC_TIPO_AUSENCIA"))==null || RSTIPO_AUSENCIA.wasNull())?"":RSTIPO_AUSENCIA_data)%></span><span class="Estilo5">
                                      <input name="ID_AUSENCIA" type="hidden" value="<%= RSTIPO_AUSENCIA__MMColParam3 %>" >
                                      <input name="ID_ANO" type="hidden" value="<%= RSTIPO_AUSENCIA__MMColParam2 %>" >
                                      <input name="FECHA_INICIO" type="hidden" value="<%=(((RSTIPO_AUSENCIA_data = RSTIPO_AUSENCIA.getObject("FECHA_INICIO"))==null || RSTIPO_AUSENCIA.wasNull())?"":RSTIPO_AUSENCIA_data)%>" >
                                      <input name="FECHA_FIN" type="hidden" value="<%=(((RSTIPO_AUSENCIA_data = RSTIPO_AUSENCIA.getObject("FECHA_FIN"))==null || RSTIPO_AUSENCIA.wasNull())?"":RSTIPO_AUSENCIA_data)%>" >
                                    </span> </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td valign="middle" nowrap bgcolor="#E0E0E0">
                                      <div align="left"></div>
                                      <div align="right"><strong>Fecha Inicio:</strong></div></td>
                                    <td width="276" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left" class="Estilo15"><%=(((RSTIPO_AUSENCIA_data = RSTIPO_AUSENCIA.getObject("FECHA_INICIO"))==null || RSTIPO_AUSENCIA.wasNull())?"":RSTIPO_AUSENCIA_data)%> </div></td>
                                    <td width="77" align="left" valign="middle" nowrap bgcolor="#E0E0E0"><div align="right"><strong>Fecha Fin:</strong></div></td>
                                    <td width="188" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left" class="Estilo15"><%=(((RSTIPO_AUSENCIA_data = RSTIPO_AUSENCIA.getObject("FECHA_FIN"))==null || RSTIPO_AUSENCIA.wasNull())?"":RSTIPO_AUSENCIA_data)%></div></td>
                                    <td align="left" valign="middle" nowrap bgcolor="#E0E0E0"><div align="left"></div></td>
                                  </tr>
                                  <tr id="COMPE" bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Hora Inicio:</strong></div></td>
                                    <td bgcolor="#E0E0E0" class="Estilo15"><%=(((RSTIPO_AUSENCIA_data = RSTIPO_AUSENCIA.getObject("HORA_INICIO"))==null || RSTIPO_AUSENCIA.wasNull())?"":RSTIPO_AUSENCIA_data)%></td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Hora Fin: </strong></div></td>
                                    <td bgcolor="#E0E0E0" class="Estilo15"><%=(((RSTIPO_AUSENCIA_data = RSTIPO_AUSENCIA.getObject("HORA_FIN"))==null || RSTIPO_AUSENCIA.wasNull())?"":RSTIPO_AUSENCIA_data)%></td>
                                    <td bgcolor="#E0E0E0">&nbsp;</td>
                                  </tr>
                                  <tr id="VACION" bgcolor="#FFFFFF">
                                    <td colspan="7" align="right"><div align="right">
                                        <p>&nbsp;</p>
                                    </div></td>
                                  </tr>
                                </table>
                                <br>
                                <table width="100%"  border="0" cellspacing="0" cellpadding="4">
                                  
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
                                </table></td>
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
RSTIPO_AUSENCIA.close();
StatementRSTIPO_AUSENCIA.close();
ConnRSTIPO_AUSENCIA.close();
%>
<%
ConnPRFIRMA.close();
%>
