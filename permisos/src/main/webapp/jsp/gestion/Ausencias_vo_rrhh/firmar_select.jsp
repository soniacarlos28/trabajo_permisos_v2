<%@page language="java" import="java.util.Date,java.sql.*" %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<% String RSIMPAR="";
   String RSCOLOR="";

%>
<%

String PRFIRMA__V_ID_FIRMA = "0";
if(request.getParameter("ID_AUTORIZA") != null){ PRFIRMA__V_ID_FIRMA = (String)request.getParameter("ID_AUTORIZA");}

String PRFIRMA__V_ID_FUNCIONARIO_FIRMA = "0";
if(session.getValue("MM_ID_USUARIO") != null){ PRFIRMA__V_ID_FUNCIONARIO_FIRMA = (String)session.getValue("MM_ID_USUARIO");}

String PRFIRMA__V_TODO_T = "";
if(request.getParameter("TODO_T") != null){ PRFIRMA__V_TODO_T = (String)request.getParameter("TODO_T");}

String PRFIRMA__V_TIPO_T = "C";
if(request.getParameter("TIPO_T") != null){ PRFIRMA__V_TIPO_T = (String)request.getParameter("TIPO_T");}

String PRFIRMA__V_ID_MOTIVO = "";
if(request.getParameter("ID_MOTIVO_DENEGA") != null){ PRFIRMA__V_ID_MOTIVO = (String)request.getParameter("ID_MOTIVO_DENEGA");}

String PRFIRMA__V_CLAVE_FIRMA = "";
if(request.getParameter("ID_CLAVE_FIRMA") != null){ PRFIRMA__V_CLAVE_FIRMA = (String)request.getParameter("ID_CLAVE_FIRMA");}
%>

<%

Driver DriverPRFIRMA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPRFIRMA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PRFIRMA = ConnPRFIRMA.prepareCall("{ call VBUENO_VARIOS(?,?,?,?,?,?)}");
PRFIRMA.setString(1,PRFIRMA__V_TIPO_T);
PRFIRMA.setString(2,PRFIRMA__V_ID_FUNCIONARIO_FIRMA);
PRFIRMA.setString(3,PRFIRMA__V_TODO_T);
PRFIRMA.setString(4,PRFIRMA__V_ID_FIRMA);
PRFIRMA.setString(5,PRFIRMA__V_ID_MOTIVO);
PRFIRMA.setString(6,PRFIRMA__V_CLAVE_FIRMA);
Object PRFIRMA_data;
PRFIRMA.execute();
%>
<%
Driver DriverRSPENDIENTE = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPENDIENTE = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPENDIENTE = ConnRSPENDIENTE.prepareStatement("SELECT distinct a.id_ausencia as ID_PERMISO,       a.id_ano,       a.id_funcionario,       a.id_tipo_ausencia as ID_TIPO_PERMISO,       to_char(a.id_estado) as ID_ESTADO,             to_char(a.fecha_inicio, 'DD/MM/YYYY hh24:mi') as fecha_inicio,       to_char(a.fecha_fin, 'DD/MM/YYYY hh24:mi') as fecha_fin,      trunc(a.total_horas/60) || ':' || lpad(mod(a.total_horas,60),2,'0')  as num_dias,       a.JUSTIFICADO AS JUSTI,       a.fecha_anulacion,       B.DESC_TIPO_ausencia as DESC_TIPO_PERMISO,       INITCAP(NOMBRE) || ' ' || INITCAP(APE1) || ' ' || INITCAP(APE2) as NOMBRES,       MENSAJE,DECODE(RESULTADO,0,'0','1') as RESULTADO ,DECODE(RESULTADO,0,'OK','ERROR') as RESULTADOS ,DECODE(ID_OPERACION,0,'Denegaci�n','Autorizado') as OPERA FROM ausencia A, TR_TIPO_ausencia B, TR_ESTADO_PERMISO T, personal_new pe,PERMISO_VALIDACION_TODOS PV WHERE a.id_funcionario = pe.id_funcionario   AND A.ID_ausencia = PV.ID_PERMISO   AND PV.CLAVE_FIRMA= '"+  PRFIRMA__V_CLAVE_FIRMA   +"'   AND PV.TIPO_PERMISO='A'   AND (A.ANULADO = 'NO' OR a.ANULADO IS NULL)   and t.id_ESTADO_PERMISO = a.id_EStado   AND A.ID_TIPO_ausencia = B.ID_TIPO_ausencia ORDER BY FECHA_INICIO DESC");
ResultSet RSPENDIENTE = StatementRSPENDIENTE.executeQuery();
boolean RSPENDIENTE_isEmpty = !RSPENDIENTE.next();
boolean RSPENDIENTE_hasData = !RSPENDIENTE_isEmpty;
Object RSPENDIENTE_data;
int RSPENDIENTE_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSPENDIENTE_numRows += Repeat1__numRows;
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

<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
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
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
<div id="form"><div>
	  <ul id="subtabh">
		<li><a href="../../gestion/Permisos_vo_rrhh/index.jsp" >Permisos pendientes autorizar</a></li>
		<li><a href="../../gestion/Ausencias_vo_rrhh/index.jsp" id="current" >Ausencias pendientes autorizar</a></li>
		<li><a href="../../gestion/Fichajes_vo_rrhh/index.jsp" >Fichajes pendientes autorizar</a></li>			
	  </ul>
	</div>
<div id="subform">

<table width="90%" border="0" cellspacing="1" cellpadding="2">
  <form name="Sindicales" method="POST" action="firma_select.jsp">
                                     <tr bgcolor="#CCFFCC">
                                         <td colspan="9" align="center"><b>Resultado - Firma de Ausencias</b> 
                                                   </td>
                                      </tr>
                                       <tr>                                         
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">A�o</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Funcio</span></td>
                                        <td width="32%" bgcolor="#CCCCCC" align="center"><span class="va10b">Nombre </span></td>
                                        <td width="32%" bgcolor="#CCCCCC" align="center"><span class="va10b">Permiso</span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Inicio</span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Fin</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Total Horas</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Justificado</span></td>  
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Firma</span></td>   
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Operaci�n</span></td>                                     
                                                                   
                                      </tr>
                                      
                                <% while ((RSPENDIENTE_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                <% if (!RSPENDIENTE_isEmpty ) { %>
                                 <%   RSIMPAR =  (String) (((RSPENDIENTE_data = RSPENDIENTE.getObject("RESULTADO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data); 
                            	     if (RSIMPAR.equals("1") )  
                                     	 RSCOLOR="bgcolor=\"#FAD2D2\"";                     	
    				               else 	                   
                                          RSCOLOR="";   
							  	  
							  	  %> 
                                                                              
                                  <tr>
                                         <td align="center" <%= RSCOLOR %>><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_ANO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>                                      
                                        <td align="left" <%= RSCOLOR %>><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_FUNCIONARIO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                        <td align="left" <%= RSCOLOR %> ><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("NOMBRES"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                        <td align="left" <%= RSCOLOR %> ><%= "<a href='firmar_solicitud_a.jsp?ID_AUSENCIA=" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_PERMISO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "&ID_ANO=" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_ANO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "'>" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("DESC_TIPO_PERMISO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "</a>" %></td>
                                        <td align="left" <%= RSCOLOR %>><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FECHA_INICIO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                        <td align="left" <%= RSCOLOR %>><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FECHA_FIN"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>                                        
                                        <td align="center" <%= RSCOLOR %>><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("NUM_DIAS"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                        <td align="center" <%= RSCOLOR %>><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("JUSTI"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                               <td align="center" <%= RSCOLOR %>><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("RESULTADOS"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                               <td align="center" <%= RSCOLOR %>><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("OPERA"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                    </tr>
                                <% } /* end !RSPENDIENTE_isEmpty */ %>
                                <%
  Repeat1__index++;
  RSPENDIENTE_hasData = RSPENDIENTE.next();
}
%>
                         
            
   </form>
</table>

</div>



</body>
</html>
<%
RSPENDIENTE.close();
StatementRSPENDIENTE.close();
ConnRSPENDIENTE.close();
%>

<%
ConnPRFIRMA.close();
%>

