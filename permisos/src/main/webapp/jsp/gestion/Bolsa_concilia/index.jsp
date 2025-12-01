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
    String v_actualizar  = "";
    String v_borrado  = "";  
%>

<%
String BOLSA_FUN__MMColParam1 = "000000";
if (session.getAttribute("MM_ID_FUNCIONARIO")           !=null) {BOLSA_FUN__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")          ;}
%>


<%
String BOLSA_FUN__MMColParam2 = "2025";
if (request.getParameter("PERIODO") !=null) {BOLSA_FUN__MMColParam2 = (String)request.getParameter("PERIODO");}
%>
<%
Driver DriverBOLSA_FUN = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnBOLSA_FUN = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementBOLSA_FUN = ConnBOLSA_FUN.prepareStatement("select  '50 horas' as limite,nvl(devuelve_min_fto_hora(nvl(decode(sign(utilizadas-exceso_jornada), -1, 0, 1, utilizadas-exceso_jornada) ,0)),'0 Horas') as falta_recuperar, nvl(devuelve_min_fto_hora(nvl(utilizadas,0)), '0 Horas') as utilizadas, nvl(devuelve_min_fto_hora(nvl(exceso_jornada,0)), '0 Horas') as exceso_jornada,    devuelve_min_fto_hora(3000-utilizadas) as disponibles  from BOLSA_CONCILIA  WHERE  id_funcionario = '" + BOLSA_FUN__MMColParam1 + "' and id_ano = DECODE('" + BOLSA_FUN__MMColParam2 + "' ,'00', to_char(sysdate-45, 'yyyy'),'" + BOLSA_FUN__MMColParam2 + "')     ");
ResultSet BOLSA_FUN = StatementBOLSA_FUN.executeQuery();
boolean BOLSA_FUN_isEmpty = !BOLSA_FUN.next();
boolean BOLSA_FUN_hasData = !BOLSA_FUN_isEmpty;
Object BOLSA_FUN_data;
int BOLSA_FUN_numRows = 0;
%>

<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT DISTINCT id_ANO AS PERIODO  from bolsa_concilia order by 1 desc");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>

<%
int RSPERIODO__numRows = -1;
int RSPERIODOL__index = 0;
RSPERIODO_numRows += RSPERIODO__numRows;
%>

<%
int BOLSA_FUN__numRows = -1;
int BOLSA_FUN__index = 0;
BOLSA_FUN_numRows += BOLSA_FUN__numRows;
%>


<%
Driver DriverMOV_SAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnMOV_SAL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementMOV_SAL = ConnMOV_SAL.prepareStatement("select id_REGISTRO,to_char(fecha_movimiento,'dd/mm/yyyy') as fecha,       anulado,       nvl(devuelve_min_fto_hora(exceso),0) as exceso ,      DECODE(id_TIPO_MOV,1,'EXCESO SALDO','PERMISO')   as movimiento       from BOLSA_CONCILIA_MOV   WHERE  (ANULADO IS NULL OR ANULADO='0') and id_funcionario = '" + BOLSA_FUN__MMColParam1+ "' and id_ano = DECODE('" + BOLSA_FUN__MMColParam2 + "' ,'00', to_char(sysdate-45, 'yyyy'),'" + BOLSA_FUN__MMColParam2 + "')     ");

ResultSet MOV_SAL = StatementMOV_SAL.executeQuery();
boolean MOV_SAL_isEmpty = !MOV_SAL.next();
boolean MOV_SAL_hasData = !MOV_SAL_isEmpty;
Object MOV_SAL_data;
int MOV_SAL_numRows = 0;
%>
<%
int MOV_SAL__numRows = -1;
int MOV_SAL__index = 0;
MOV_SAL_numRows += MOV_SAL_numRows;
%>
<%
String thisPage = request.getRequestURI();
%>
<%!
public String DoDateTime(java.lang.Object aObject,int nNamedFormat,java.util.Locale aLocale) throws Exception{	
if ((aObject != null) && (aObject instanceof java.util.Date)){
   if (aLocale!=null){
		java.text.DateFormat df = java.text.DateFormat.getDateInstance(nNamedFormat,aLocale);
			return df.format(aObject);
	}
	else{
		java.text.DateFormat df = java.text.DateFormat.getDateInstance(nNamedFormat);
			return df.format(aObject);
	 }
 }
return "";
}
%>
<script language="Javascript" >


function busqueda()
{
	    c1.style.display='none';
		c2.style.display='none';
 		splashWin = window.open('index_busqueda_funcionario.jsp?CAMPO=ID_JS&POLI=21' ,'ventana1','height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');
  		splashWin.opener = self;
	  	splashWin.focus();
	  	
}

function envia_unavez()
{

	c1.style.display='';
	c2.style.display='';
     document.formPeriodo.submit();

}
</script>

<html>
<head>
<title>Gesti&oacute;n de Permisos - BOLSA CONCILIACION</title>
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
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

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

  <form name="formPeriodo" method=post action="index.jsp">
<table width="740" border="0" cellspacing="5" cellpadding="0">
   <tr>
      <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="4"> 								
			 <tr>
			    <td><b><%= session.getValue("MM_ID_FUNCIONARIO") %>--<%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>
			    </td>
                <td colspan="6"  align="right">						 
				 
                    <label>Seleccione el a&ntilde;o:
                      <select name="PERIODO">
                            <%
                              while (RSPERIODO_hasData) {   %><option value="<%=((RSPERIODO.getObject("PERIODO")!=null)?RSPERIODO.getObject("PERIODO"):"")%>" <%=(((RSPERIODO.getObject("PERIODO")).toString().equals((((request.getParameter("PERIODO")!=null)?request.getParameter("PERIODO"):"")).toString()))?"selected=\"selected\"":"")%> ><%=((RSPERIODO.getObject("PERIODO")!=null)?RSPERIODO.getObject("PERIODO"):"")%></option>
                            <%
                              RSPERIODO_hasData = RSPERIODO.next();
                                                        }
                              RSPERIODO.close();
                              RSPERIODO = StatementRSPERIODO.executeQuery();
                              RSPERIODO_hasData = RSPERIODO.next();
							  RSPERIODO_isEmpty = !RSPERIODO_hasData;
                             %>
                      </select>
                  </label>
                 
                  <input type="submit" value="Consultar" name="Consultar" onClick="javascript:envia_unavez();">
                
                 </td>
              </tr>
       </table>
       </form>     
      </td>
     </tr>
     <tr>
       <td>  
       
       
        <div id="c1" style="DISPLAY:''"> 
	    <table width="50%" border="0" cellspacing="1" cellpadding="4">	
	    <% if (!BOLSA_FUN_isEmpty ) { %>  
	                                  <tr>  <td width="80%" nowrap  align="Right">Bolsa:</td>
                                            <td align="center" nowrap ><div align="left"><strong><font color="#000000"><%=(((BOLSA_FUN_data = BOLSA_FUN.getObject("LIMITE"))==null || BOLSA_FUN.wasNull())?"":BOLSA_FUN_data)%></font></strong></div></td>
                                       </tr>	
                                        <tr>
									        <td width="40%" nowrap  align="Right">Utilizado por pemiso:</td>
                                            <td align="center" nowrap ><div align="left"><strong><font color="#000000"><%=(((BOLSA_FUN_data = BOLSA_FUN.getObject("UTILIZADAS"))==null || BOLSA_FUN.wasNull())?"":BOLSA_FUN_data)%></font></strong></div></td>
                                       </tr>			 
									   <tr>
									        <td width="80%" nowrap  align="Right">Recuperado:</td>
                                            <td align="center" nowrap ><div align="left"><strong><font color="#000000"><%=(((BOLSA_FUN_data = BOLSA_FUN.getObject("EXCESO_JORNADA"))==null || BOLSA_FUN.wasNull())?"":BOLSA_FUN_data)%></font></strong></div></td>
                                       </tr>
                                       <tr>
									        <td width="80%" nowrap  align="Right">Faltan recuperar:</td>
                                            <td align="center" nowrap ><div align="left"><strong><font color="#000000"><%=(((BOLSA_FUN_data = BOLSA_FUN.getObject("FALTA_RECUPERAR"))==null || BOLSA_FUN.wasNull())?"":BOLSA_FUN_data)%></font></strong></div></td>
                                       </tr>
									  
                                       <tr>
									        <td width="40%" nowrap  align="Right">Disponible:</td>
                                            <td align="center" nowrap ><div align="left"><strong><font color="#000000"><%=(((BOLSA_FUN_data = BOLSA_FUN.getObject("DISPONIBLES"))==null || BOLSA_FUN.wasNull())?"":BOLSA_FUN_data)%></font></strong></div></td>
                                       </tr>
                          <% } %>   
         </table> 
         </div>
          <div id="c2" style="DISPLAY:''"> 
          <%   if (!BOLSA_FUN_isEmpty ) { %>  
         <table width="100%" border="0" cellspacing="1" cellpadding="3">
                <tr> 
				   <td nowrap bgcolor="#FFFFDD" class="va10b"><b class="ah12b">Movimientos</b></td>
                   <td colspan="1" nowrap bgcolor="#FFFFDD" class="va10b">&nbsp;</td>
                   <td colspan="3" valign="middle" nowrap bgcolor="#FFFFDD" class="va10b">
                      <form name="form2" method="post" action="alta_movimiento.jsp">
                            <div align="right">
                                  <input type="submit" name="Submit3" value="Añadir Jornada de Recuperación">                                 
                            </div>
                      </form>
                   </td>
                 </tr>
                 
                 <tr> 
                    <td align="center" bgcolor="#CCCCCC" class="va10b" width="3%">Fecha</td>                                    
                    <td width="14%" align="center" nowrap bgcolor="#CCCCCC" class="va10b">Horas y minutos </td>
                    <td align="center" bgcolor="#CCCCCC" class="va10b" width="43%">Movimiento</td>
                    <td align="center" bgcolor="#CCCCCC" class="va10b" width="6%">&nbsp;</td>
                </tr>
                 <% while ((MOV_SAL_hasData)&&(MOV_SAL__numRows-- != 0) ) { %>
                   <tr> 
                     <td  align="center" bgcolor="#FFFFFF"><b><%=(((MOV_SAL_data = MOV_SAL.getObject("FECHA"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data)%></b></td>
                     <td width="14%" align="center" nowrap bgcolor="#FFFFFF"><b><%=(((MOV_SAL_data = MOV_SAL.getObject("EXCESO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data)%></b></td>
                     <td bgcolor="#FFFFFF"><%=(((MOV_SAL_data = MOV_SAL.getObject("MOVIMIENTO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data)%></td>
                     <td bgcolor="#FFFFFF" align="right"">
                            <a href="edita_movimiento.jsp?ID_REGISTRO=<%=(((MOV_SAL_data = MOV_SAL.getObject("ID_REGISTRO")) == null || MOV_SAL.wasNull()) ? "" : MOV_SAL_data)%>"><img src="../../imagen/editar.gif" alt="Editar" width="20" height="20" border="0"></a>       
                            <a href="borra_movimiento.jsp?ID_REGISTRO=<%=(((MOV_SAL_data = MOV_SAL.getObject("ID_REGISTRO")) == null || MOV_SAL.wasNull()) ? "" : MOV_SAL_data)%>"><img src="../../imagen/delete.png" alt="Borrar" width="20" height="20" border="0"></a>
                     </td>
                   </tr>
                 <%
                                      MOV_SAL__index++;
                                      MOV_SAL_hasData = MOV_SAL.next();
                     }%>
                                                   
                  <tr> 
                    <td align="center" colspan="7" class="va10b"><div align="right"></div></td>
                  </tr>
                   </table>                                
                    <% } %>   
		         <%   if ((BOLSA_FUN_isEmpty ) ) { %>   
		               <table width="100%" border="0" cellspacing="1" cellpadding="3">
							<tr bgcolor="#FFFFDD"> 
                                <td><b>SIN BOLSA</b>  <%= BOLSA_FUN__MMColParam2 %>                                        </td>
                                <td colspan="7"><form name="form1" method="post" action="alta_movimiento.jsp">
                                          <input type="submit" name="Submit" value="Crear Bolsa">
                                               </form>
                                </td>
                             </tr>
                        </table>     
									  <% } %>
								
      </table>
      </div>    
         
         
       
     
     
      
</body>
</html>

<%
RSPERIODO.close();
ConnRSPERIODO.close();
%>
<%
BOLSA_FUN.close();
ConnBOLSA_FUN.close();
%>
