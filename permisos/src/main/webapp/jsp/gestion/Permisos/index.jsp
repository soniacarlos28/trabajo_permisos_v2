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
String RSQUERY__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSQUERY__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSQUERY__MMColParam2 = "0000";
if (request.getParameter("PERIODO") !=null) {RSQUERY__MMColParam2 = (String)request.getParameter("PERIODO");}
%>
<%
String RSQUERY__MMColParam3 = "0";
if (request.getParameter("ID_ESTADO")  !=null) {RSQUERY__MMColParam3 = (String)request.getParameter("ID_ESTADO") ;}
%>
<%
java.util.Calendar cal_periodo = java.util.Calendar.getInstance();
Integer periodo = new Integer( cal_periodo.get(java.util.Calendar.YEAR) );
if (RSQUERY__MMColParam2.equals("0000")) { RSQUERY__MMColParam2 = periodo.toString(); }
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT  DECODE(a.JUSTIFICACION,'--','',CHEQUEA_ENLACE_FICHERO_JUS(a.ID_ANO,a.ID_FUNCIONARIO,ID_PERMISO,a.id_estado,'P',2)) as JUSTI_FICHERO,A.JUSTIFICACION, A.ID_PERMISO, A.ID_ANO,substr( B.DESC_TIPO_PERMISO, 1,20) as DESC_TIPO_PERMISO, A.FECHA_INICIO, A.FECHA_FIN, A.NUM_DIAS,DESC_ESTADO_PERMISO  FROM PERMISO A, TR_TIPO_PERMISO B,TR_ESTADO_PERMISO T  WHERE A.ID_FUNCIONARIO = '" + RSQUERY__MMColParam1 + "' AND A.ID_ANO = '" + RSQUERY__MMColParam2 + "'      AND (A.ANULADO = 'NO' OR a.ANULADO IS NULL ) and      t.id_ESTADO_permiso=a.id_EStado   AND A.ID_TIPO_PERMISO = B.ID_TIPO_PERMISO AND A.ID_ANO = B.ID_ANO  and ('" + RSQUERY__MMColParam3 + "'='0' or a.id_estado like '" + RSQUERY__MMColParam3 + "%')  ORDER BY FECHA_INICIO DESC");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT DISTINCT NVL(TO_CHAR(FECHA_INICIO,'YYYY'),'2020') AS PERIODO  FROM PERMISO where id_ano > 2015 order by 1 desc");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>
<%
String RSQUERY2__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSQUERY2__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSQUERY2__MMColParam2 = "0000";
if (request.getParameter("PERIODO")  !=null) {RSQUERY2__MMColParam2 = (String)request.getParameter("PERIODO") ;}
%>
<%
if (RSQUERY2__MMColParam2.equals("0000")) { RSQUERY2__MMColParam2 = periodo.toString(); }
%>
<%
Driver DriverRSQUERY2 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY2 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY2 = ConnRSQUERY2.prepareStatement("SELECT /*+ ORDERED*/ A.ID_TIPO_PERMISO,      DECODE(B.ID_TIPO_PERMISO,'01000', B.DESC_TIPO_PERMISO || ' - '||DECODE(A.ID_TIPO_DIAS,'N','Naturales','Laborales'),B.DESC_TIPO_PERMISO) as DESC_TIPO_PERMISO  ,  A.ID_ANO,    A.NUM_DIAS AS NUM_DIAS,    A.COMPLETO,    decode(SUM(C.NUM_DIAS),null,0,SUM(C.NUM_DIAS))+A.NUM_DIAS AS TOTAL,  DECODE(a.ID_TIPO_PERMISO,'15001', 6-A.NUM_DIAS, decode(SUM(C.NUM_DIAS),null,0,SUM(C.NUM_DIAS)))   AS DISFRUTADOS  FROM PERMISO_FUNCIONARIO A, TR_TIPO_PERMISO B,(select *  FROM PERMISO where id_estado not in ('30','31','32','40','41') ) C  WHERE A.UNICO = 'SI' AND A.ID_FUNCIONARIO = '" + RSQUERY2__MMColParam1 + "'   AND A.ID_ANO = '" + RSQUERY2__MMColParam2 + "' AND A.ID_TIPO_PERMISO = B.ID_TIPO_PERMISO   AND A.ID_ANO = B.ID_ANO         AND a.ID_ANO=C.id_ano(+)           AND A.ID_FUNCIONARIO=C.id_FUNCIONARIO(+)           AND A.ID_TIPO_PERMISO=C.id_TIPO_PERMISO(+)    AND   UPPER(DESC_TIPO_PERMISO) NOT LIKE '%ANTERIOR%'       and a.id_tipo_permiso not in ('01500')    and (      ( a.id_tipo_permiso not  in ('15001','03000')   and a.ID_funcionario not like '203%' ) OR ( a.id_tipo_permiso not  in ('15001','03000')   and a.ID_funcionario not like '201%'  )   OR (a.id_tipo_permiso in ('15001','03000')   and a.id_funcionario not like '203%' and a.id_funcionario not like '201%')      )       GROUP BY  A.ID_TIPO_PERMISO,      DECODE(B.ID_TIPO_PERMISO,'01000', B.DESC_TIPO_PERMISO || ' - '||DECODE(A.ID_TIPO_DIAS,'N','Naturales','Laborales'),B.DESC_TIPO_PERMISO) ,   A.ID_ANO,     A.NUM_DIAS ,     A.COMPLETO  ORDER BY total  desc,1");
ResultSet RSQUERY2 = StatementRSQUERY2.executeQuery();
boolean RSQUERY2_isEmpty = !RSQUERY2.next();
boolean RSQUERY2_hasData = !RSQUERY2_isEmpty;
Object RSQUERY2_data;
int RSQUERY2_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSQUERY_numRows += Repeat1__numRows;
%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RSQUERY2_numRows += Repeat2__numRows;
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
<script type="text/JavaScript">

function show_confirmar(id)
{
   var text = "�Realmente desea eliminar Justificante?";
   var r = confirm(text);
   if (r==true) { 
                 //MM_goToURL('self',url + id);
    var url="../fichero/eliminarDoc.jsp?PERMISO=A&ID_ENLACE=" + id;	
    var param="top=0,left=100,height=600,width=940,scrollbars=yes,status=no,toolbar=no ,menubar=no,location=0,directories=no";			 
 	var win=window.open(url , "_blank" ,param);
   }
   else { 
      alert("Operaci�n cancelada!");  
   }
}
</script>
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
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

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
		<li><a href="../Bolsa_concilia" >Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" >Incidencias  Fichajes</a></li>
	  </ul>
	</div>
	<div id="subform">
	
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                                <tr>
                                  <td bgcolor="#E0E0E0" valign="top">
                                    <table border="0" cellspacing="0" cellpadding="2">
                                      <form name="formBotonera" method=post action="index.jsp">
                                        <tr>
                                          <td>
                                            <input type="button" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp?ID_ANO=<%= RSQUERY2__MMColParam2 %>'" >
                                          </td>
                                          <td>
                                            <input type="button" value="Modificar Dias" name="Guardar" onClick="window.location='index_p.jsp'">
                                          </td>
                                          <td><input type="button" value="Genera Permisos" name="Genera" onClick="window.location='genera.jsp'"></td>
                                          <td class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;</td>
                                          <td>   <a href="#" onClick="javascript:window.open('mi_calendario.jsp' ,null,'top=0,left=100,height=800,width=940,scrollbars=yes,status=no,toolbar=no ,menubar=no,location=0,directories=no');">Mostrar su Calendario</a></td>
                                        </tr>
                                      </form>
                                  </table></td> 
                                  <td align="left" valign="top" bgcolor="#E0E0E0"><table border="0" cellspacing="0" cellpadding="2" width="100">
                                    <form name="formPeriodo" method=post action="index.jsp">
                                      <tr>
                                        <td>A&ntilde;o:&nbsp;</td>
                                        <td>
                                          <select name="PERIODO">
                                            <% while (RSPERIODO_hasData) {
%>
                                            <%= "<option value='" %><%= (((RSPERIODO_data = RSPERIODO.getObject("PERIODO"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data) %><%= "'>" %> <%= RSPERIODO_data= RSPERIODO.getObject("PERIODO") %> <%= "</option>" %>
                                            <%  RSPERIODO_hasData = RSPERIODO.next();
}
RSPERIODO.close();
RSPERIODO = StatementRSPERIODO.executeQuery();
RSPERIODO_hasData = RSPERIODO.next();
RSPERIODO_isEmpty = !RSPERIODO_hasData;
%>
                                          </select>
                                        </td>
                                        <td>
                                          <input type="submit" value="Ver" name="submit">
                                        </td>
                                      </tr>
                                    </form>
                                  </table>                                  
                                </tr>
                                <tr> 
                                  <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                    <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                      <tr bgcolor="#FFFFDD"> 
                                        <td colspan="8"><b>Permisos Solicitados / Concedidos</b></td>
                                      </tr>
                                      <tr> 
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">A&ntilde;o</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha 
                                          Inicio</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha 
                                          Fin</span></td>
                                        <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Tipo 
                                          de Permiso</span></td>
                                        <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Estado</span></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><span class="va10b">Just.</span></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><span class="va10b">D&iacute;as</span></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fichero</span></td>
                                      </tr>
                                      <% while ((RSQUERY_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                      <% if (!RSQUERY_isEmpty ) { %>
                                      <tr>
                                        <td width="5%" align="center" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("ID_ANO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td width="15%" align="center" bgcolor="#FFFFFF"><%= DoDateTime((((RSQUERY_data = RSQUERY.getObject("FECHA_INICIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data), java.text.DateFormat.SHORT, java.util.Locale.UK) %></td>
                                        <td width="15%" align="center" bgcolor="#FFFFFF"><%= DoDateTime((((RSQUERY_data = RSQUERY.getObject("FECHA_FIN"))==null || RSQUERY.wasNull())?"":RSQUERY_data), java.text.DateFormat.SHORT, java.util.Locale.UK) %></td>
                                        <td width="25%" nowrap bgcolor="#FFFFFF"><%= "<a href='editar.jsp?ID_PERMISO=" + (((RSQUERY_data = RSQUERY.getObject("ID_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&ID_ANO=" + (((RSQUERY_data = RSQUERY.getObject("ID_ANO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'>" + (((RSQUERY_data = RSQUERY.getObject("DESC_TIPO_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "</a>" %></td>
                                        <td width="25%" nowrap bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("DESC_ESTADO_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td width="4%" align="center" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("JUSTIFICACION"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td width="4%" align="center" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("NUM_DIAS"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                      <td width="4%" align="center" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("JUSTI_FICHERO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                     
                                      </tr>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat1__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                                    </table>
                                  </td>
                                </tr>
                                <tr> 
                                  <td valign="top" colspan="2">&nbsp; </td>
                                </tr>
                                <tr> 
                                  <td valign="top" colspan="2"> 
                                    <table width="100%" border="0" cellspacing="1" cellpadding="3">
                                      <tr> 
                                        <td bgcolor="#FFFFDD" class="va10b" colspan="4"><b class="ah12b">Permisos 
                                          sin Disfrutar</b></td>
                                      </tr>
                                      <tr> 
                                        <td align="center" width="10%" class="va10b" bgcolor="#CCCCCC">A&ntilde;o</td>
                                        <td align="center" bgcolor="#CCCCCC" class="va10b" width="15%">Disfrutados</td>
                                        <td align="center" bgcolor="#CCCCCC" class="va10b" width="15%"> 
                                          Restan</td>
                                        <td align="center" bgcolor="#CCCCCC" class="va10b" width="65%">Tipo 
                                          de Permiso</td>
                                      </tr>
                                      <% while ((RSQUERY2_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                      <tr> 
                                        <td align="center" width="10%" bgcolor="#FFFFFF"><%=(((RSQUERY2_data = RSQUERY2.getObject("ID_ANO"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data)%></td>
                                        <td align="center" bgcolor="#FFFFFF" width="15%"><b><%=(((RSQUERY2_data = RSQUERY2.getObject("DISFRUTADOS"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data)%></b> d&iacute;as</td>
                                        <td align="center" bgcolor="#FFFFFF" width="15%"><b><%=(((RSQUERY2_data = RSQUERY2.getObject("NUM_DIAS"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data)%></b> d&iacute;as</td>
                                        <td bgcolor="#FFFFFF" width="65%"><%=(((RSQUERY2_data = RSQUERY2.getObject("DESC_TIPO_PERMISO"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data)%></td>
                                      </tr>
                                      <%
  Repeat2__index++;
  RSQUERY2_hasData = RSQUERY2.next();
}
%>                              <tr> 
                                <td align="center" colspan="5" class="va10b"><div align="right"><strong>*Cuando 
                                    las vacaciones se disfrutan por periodos corresponden 
                                    30 d&iacute;as</strong></div></td>                                   
                              </tr> <TR>
                                  <td align="center" colspan="5" class="va10b"><div align="right"><strong>(**) Las vacaciones del Personsal de Bomberos son 7 Guardias de 24 horas.</strong></div></td>
                                </TR>
                              
                              
                                    </table>
                                  </td>
                                </tr>
                                <tr> 
                                  <td valign="top" colspan="2"> 
                                    <script language="JavaScript">
<%= "document.formPeriodo.PERIODO.value = " + RSQUERY__MMColParam2 %>
</script>
                                  </td>
                                </tr>
                              </table>
	
	</div>
	</div>

</body>
</html>
<%
RSQUERY.close();
ConnRSQUERY.close();
%>
<%
RSPERIODO.close();
ConnRSPERIODO.close();
%>
<%
RSQUERY2.close();
ConnRSQUERY2.close();
%>
<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
