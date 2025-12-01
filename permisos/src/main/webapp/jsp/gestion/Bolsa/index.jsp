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
PreparedStatement StatementBOLSA_FUN = ConnBOLSA_FUN.prepareStatement("select 1 as BOLSA from bolsa_FUNCIONARIO WHERE  id_funcionario = '" + BOLSA_FUN__MMColParam1 + "' and id_ano = DECODE('" + BOLSA_FUN__MMColParam2 + "' ,'00', to_char(sysdate-35, 'yyyy'),'" + BOLSA_FUN__MMColParam2 + "')     ");
ResultSet BOLSA_FUN = StatementBOLSA_FUN.executeQuery();
boolean BOLSA_FUN_isEmpty = !BOLSA_FUN.next();
boolean BOLSA_FUN_hasData = !BOLSA_FUN_isEmpty;
Object BOLSA_FUN_data;
int BOLSA_FUN_numRows = 0;
%>
<%
String SALDO__MMColParam1 = "000000";
if (session.getAttribute("MM_ID_FUNCIONARIO")           !=null) {SALDO__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")          ;}
%>
<%
String SALDO__MMColParam2 = "2025";
if (request.getParameter("PERIODO") !=null) {SALDO__MMColParam2 = (String)request.getParameter("PERIODO");}
%> 
<%
Driver DriverSALDO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnSALDO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementSALDO = ConnSALDO.prepareStatement("select DECODE(sign(NVL(trunc(sum(HORAS_EXCESOS * 60 + horas_minutos) / 60), 0)),-1,'<font color=\"#FF0000\">' || trunc(sum(HORAS_EXCESOS * 60 + horas_minutos) / 60) || ' Horas ' || mod(sum(HORAS_EXCESOS * 60 + horas_minutos), 60) || ' Min</font>', DECODE(sign(NVL(mod(sum(HORAS_EXCESOS * 60 + horas_minutos), 60), 0)),-1,'<font color=\"#FF0000\">' ||  trunc(sum(HORAS_EXCESOS * 60 + horas_minutos) / 60) || ' Horas ' ||  mod(sum(HORAS_EXCESOS * 60 + horas_minutos), 60) || ' Min</font>','<font color=\"#000000\">' ||  trunc(sum(HORAS_EXCESOS * 60 + horas_minutos) / 60) ||' Horas ' || mod(sum(HORAS_EXCESOS * 60 + horas_minutos), 60) || ' Min</font>')) as saldo  from bolsa_saldo  WHERE id_funcionario = '" + SALDO__MMColParam1 + "' and   acumulador=1 and id_ano = DECODE('" + SALDO__MMColParam2 + "','00',to_char(sysdate-45, 'yyyy'),'" + SALDO__MMColParam2 + "')  ");
ResultSet SALDO = StatementSALDO.executeQuery();
boolean SALDO_isEmpty = !SALDO.next();
boolean SALDO_hasData = !SALDO_isEmpty;
Object SALDO_data;
int SALDO_numRows = 0;
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT DISTINCT id_ANO AS PERIODO  from bolsa_saldo order by 1 desc");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>
<%
String RSM_MOV__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RSM_MOV__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSM_MOV__MMColParam2 = "00";
if (request.getParameter("PERIODO")   !=null) {RSM_MOV__MMColParam2 = (String)request.getParameter("PERIODO")  ;}
%>
<%
Driver DriverRSM_MOV = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSM_MOV = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSM_MOV = ConnRSM_MOV.prepareStatement("select id_funcionario,id_ano, p_enero_sa, p_febrero_sa, p_marzo_sa, p_abril_sa, p_mayo_sa, p_junio_sa, p_julio_sa, p_agosto_sa, p_septiembre_sa, p_octubre_sa, p_noviembre_sa,  p_diciembre_sa, p_ene_mas_sa ,saldos_positivos,saldos_negativos from RESUMEN_SALDO_BOLSA WHERE id_funcionario = '" + RSM_MOV__MMColParam1+ "' and id_ano = DECODE('" + RSM_MOV__MMColParam2 + "','00', to_char(sysdate-35, 'yyyy'),'" + RSM_MOV__MMColParam2 + "')  order by id_funcionario");

ResultSet RSM_MOV = StatementRSM_MOV.executeQuery();
boolean RSM_MOV_isEmpty = !RSM_MOV.next();
boolean RSM_MOV_hasData = !RSM_MOV_isEmpty;
Object RSM_MOV_data;
int RSM_MOV_numRows = 0;
%>

<%
String MOV_BOL__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {MOV_BOL__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String MOV_BOL__MMColParam2 = "00";
if (request.getParameter("PERIODO")   !=null) {MOV_BOL__MMColParam2 = (String)request.getParameter("PERIODO")  ;}
%>
<%
Driver DriverMOV_BOL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnMOV_BOL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementMOV_BOL = ConnMOV_BOL.prepareStatement("select bf.id_funcionario,desc_motivo_acumular as tipo,ACUMULADOR,DECODE(penal_enero ,0,'NO','SI') as p_enero,DECODE(penal_febrero,0,'NO','SI') as p_febrero,DECODE(penal_marzo,0,'NO','SI') as p_marzo,DECODE(penal_abril,0,'NO','SI') as p_abril,DECODE(penal_mayo,0,'NO','SI') as p_mayo,DECODE(penal_julio,0,'NO','SI') as p_julio,DECODE(penal_agosto,0,'NO','SI') as p_agosto,DECODE(penal_septiembre,0,'NO','SI') as p_septiembre,DECODE(penal_octubre,0,'NO','SI') as p_octubre,DECODE(penal_noviembre,0,'NO','SI') as p_noviembre,DECODE(penal_diciembre,0,'NO','SI') as p_diciembre,DECODE(penal_junio,0,'NO','SI') as p_junio,maximo_alcanzado,tope_horas || ' Horas ' as TOPE_HORAS,exceso_en_horas|| ' Horas '|| excesos_en_minutos || ' Min ' as Horas_productividad,DECODE(ACUMULADOR,2,exceso_en_horas|| ' Horas '|| excesos_en_minutos || ' Min ',DECODE(tope_horas-excesos_en_minutos,60,tope_horas-exceso_en_horas-decode(excesos_en_minutos,0,0,1),tope_horas-exceso_en_horas-decode(excesos_en_minutos,0,0,1)) || ' Horas '||DECODE(tope_horas- sign(excesos_en_minutos)*excesos_en_minutos ,60,0,60-sign(excesos_en_minutos)*excesos_en_minutos)  || ' Min ' )as Puede_acumular  from bolsa_funcionario bf,bolsa_tipo_acumulacion  bt,bolsa_movimiento bm WHERE bf.id_funcionario = '" + MOV_BOL__MMColParam1+ "' and bf.id_ano = DECODE('" + MOV_BOL__MMColParam2 + "' ,'00', to_char(sysdate-45, 'yyyy'),'" + MOV_BOL__MMColParam2 + "')  and bf.id_acumulador=bt.id_acumulador and bf.id_funcionario = bm.id_funcionario(+) and bf.id_ano = bm.id_ano(+)  and bm.id_tipo_movimiento(+) = 4");
ResultSet MOV_BOL = StatementMOV_BOL.executeQuery();
boolean MOV_BOL_isEmpty = !MOV_BOL.next();
boolean MOV_BOL_hasData = !MOV_BOL_isEmpty;
Object MOV_BOL_data;
int MOV_BOL_numRows = 0;
%>

<%
String MOV_SAL__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {MOV_SAL__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>
<%
String MOV_SAL__MMColParam2 = "00";
if (request.getParameter("PERIODO")   !=null) {MOV_SAL__MMColParam2 = (String)request.getParameter("PERIODO")  ;}
%>
<%
Driver DriverMOV_SAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnMOV_SAL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementMOV_SAL = ConnMOV_SAL.prepareStatement("SELECT DECODE(bm.ID_TIPO_MOVIMIENTO,1,'A',3,'A',4,'A',6,'A',7,'A','B') as ID_ACT,DECODE(bm.ID_TIPO_MOVIMIENTO,3,'A',4,'A',6,'A',7,'A',1,'C','B') as ID_BOR,bm.id_registro as id_registro, lpad(periodo,2,'0') ||id_ano as PERI, to_char(FECHA_MOVIMIENTO,'DD/MM/YYYY') as FECHA_MOVIMIENTO ,DECODE(sign((EXCESO_en_horas*60+EXCESOs_en_minutos)),-1,'<font color=\"#FF0000\">' || '-' ||  lpad( trunc((abs(EXCESO_en_horas)*60+abs(EXCESOs_en_minutos))/60,0),2,'0') || ':' ||  lpad( mod((abs(EXCESO_en_horas)*60+abs(EXCESOs_en_minutos)),60),2,'0')   || '</font>' , '<font color=\"#000000\">'  ||  lpad( trunc((EXCESO_en_horas*60+EXCESOs_en_minutos)/60,0),2,'0') || ':' ||  lpad( mod((EXCESO_en_horas*60+EXCESOs_en_minutos),60),2,'0')   || '</font>'   )    as h_mov  , ID_FUNCIONARIO,desc_tipo_movimiento,            DECODE (bt.ID_TIPO_MOVIMIENTO, 1, '<a href=\"../Finger/index.jsp?PERIODO=' || lpad(DECODE(PERIODO,'13','01' || ID_ANO +1 ,PERIODO || ID_ANO),6,'0')        || '\">' ||PERIODO || '</a>'         , PERIODO) as PERIODO,periodo per FROM BOLSA_MOVIMIENTO BM,bolsa_tipo_MOVIMIENTO BT WHERE bm.id_funcionario = '" + MOV_SAL__MMColParam1+ "' and  bm.anulado(+)=0 and bm.id_ano =DECODE('" + MOV_SAL__MMColParam2 + "' ,'00', to_char(sysdate-45, 'yyyy'),'" + MOV_SAL__MMColParam2 + "' )   and  bm.anulado(+)=0 and BM.ID_TIPO_MOVIMIENTO=BT.ID_TIPO_MOVIMIENTO order by id_funcionario,per, periodo,fecha_movimiento");

ResultSet MOV_SAL = StatementMOV_SAL.executeQuery();
boolean MOV_SAL_isEmpty = !MOV_SAL.next();
boolean MOV_SAL_hasData = !MOV_SAL_isEmpty;
Object MOV_SAL_data;
int MOV_SAL_numRows = 0;
%>

<%
int RSPERIODO__numRows = -1;
int RSPERIODOL__index = 0;
RSPERIODO_numRows += RSPERIODO__numRows;
%>
<%
int MOV_BOL__numRows = -1;
int MOV_BOL__index = 0;
MOV_BOL_numRows += MOV_BOL__numRows;
%>

<%
int BOLSA_FUN__numRows = -1;
int BOLSA_FUN__index = 0;
BOLSA_FUN_numRows += BOLSA_FUN__numRows;
%>

<%
int RSM_MOV__numRows = -1;
int RSM_MOV__index = 0;
RSM_MOV_numRows += RSM_MOV__numRows;
%>
<%
int MOV_SAL__numRows = -1;
int MOV_SAL__index = 0;
MOV_SAL_numRows += MOV_SAL_numRows;
%>
<%
int SALDO__numRows = -1;
int SALDO__index = 0;
SALDO_numRows += SALDO__numRows;
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
</div>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa" id="current">Bolsa</a></li>
		<li><a href="../Bolsa_concilia" >Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" >Incidencias  Fichajes</a></li>
	  </ul>
  </div>
	<div id="subform">
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                                <tr>
                                  <td bgcolor="#E0E0E0" valign="top">
                                    <div align="right">
                                      <table border="0" cellspacing="0" cellpadding="2">
                                        <form name="formBotonera" method=post action="index.jsp">
                                          <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;</td>
                                          </tr>
                                        </form>
                                      </table>
                                  </div></td> 
                                  <td align="left" valign="top" bgcolor="#E0E0E0"><div align="right">
                                    <table border="0" cellspacing="0" cellpadding="2" width="100">
                                      <form name="formPeriodo" method=post action="index.jsp">
                                        <tr>
                                          <td>A&ntilde;o:&nbsp;</td>
                                            <td>
											
<select name="PERIODO" id="PERIODO" >

          <% while (RSPERIODO_hasData) {
%><option value="<%=((RSPERIODO.getObject("PERIODO")!=null)?RSPERIODO.getObject("PERIODO"):"")%>" <%=(((RSPERIODO.getObject("PERIODO")).toString().equals((SALDO__MMColParam2).toString()))?"selected=\"selected\"":"")%> ><%=((RSPERIODO.getObject("PERIODO")!=null)?RSPERIODO.getObject("PERIODO"):"")%></option>
            <%
  RSPERIODO_hasData = RSPERIODO.next();
}
RSPERIODO.close();
RSPERIODO = StatementRSPERIODO.executeQuery();
RSPERIODO_hasData = RSPERIODO.next();
RSPERIODO_isEmpty = !RSPERIODO_hasData;
%>   
</select>  
                                        </td>
                                            <td>
                                              <input type="submit" value="Ver" name="submit">                                            </td>
                                        </tr>
                                      </form>
                                    </table>
                                  </div>                                  </tr>
                                <tr> 
                                  <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                    <table width="100%" border="0" cellspacing="1" cellpadding="4">
									 <script language="JavaScript">
<%= "document.formPeriodo.PERIODO.value = " + BOLSA_FUN__MMColParam2 %>
</script>
									
                       <% if (!BOLSA_FUN_isEmpty) { %>
						                <form name="formPeriodo" method=post action="editar.jsp">
                                      <tr bgcolor="#FFFFDD">                                      
                                        <td>&nbsp;</td>                                        
                                        <td colspan="5"><div align="center"><strong>Saldo bolsa <font color="#000000"><%=(((SALDO_data = SALDO.getObject("SALDO"))==null || SALDO.wasNull())?"":SALDO_data)%></font></strong></div></td>
                                        <td colspan="2"><div align="right">
                                          <input type="submit" name="Submit2" value="Editar Bolsa">
                                        </div></td>
                                      </tr>
									  </form>
                                      <a name="bolsa" id="bolsa"></a> 
									  <tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center">Tipo</td>
                                            <td colspan="5" align="center" bgcolor="#CCCCCC"><div align="left"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("TIPO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
                                        <td colspan="2" align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                      </tr>
									   <tr>
									        <td width="5%" bgcolor="#66CCFF" align="center">Acumular </td>
                                            <td align="center" nowrap bgcolor="#66CCFF"><div align="left"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("PUEDE_ACUMULAR"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#66CCFF"><div align="right">Horas Productividad </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#66CCFF"><div align="left"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("HORAS_PRODUCTIVIDAD"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#66CCFF">Maximo</td>
                                         <td colspan="2" align="center" bgcolor="#66CCFF"><span class="va10b"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("TOPE_HORAS"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></span></td>
                                      </tr> <tr>
									        <td width="5%" bgcolor="#99FF99" align="center">Periodo</td>
                                            <td align="center" bgcolor="#99FF99">Horas y minutos</td>
                                            <td align="center" bgcolor="#99FF99">Penalizacion</td>
                                            <td align="center" bgcolor="#99FF99">&nbsp;</td>
                                            <td align="center" bgcolor="#99FF99">&nbsp;</td>
                                            <td colspan="2" align="center" bgcolor="#99FF99">Horas y minutos</td>
                                        <td width="4%" bgcolor="#99FF99" align="center">Penalizacion</td>
									  </tr>
						     <% if (!RSM_MOV_isEmpty) { %>
									  <tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">01 Enero </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_ENERO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_ENERO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">07 Julio </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_JULIO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_JULIO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
									  </tr><tr>
									        <td width="5%" align="center" nowrap bgcolor="#CCCCCC"><div align="left">02 Febrero </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_FEBRERO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_FEBRERO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">08 Agosto </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_AGOSTO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_AGOSTO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">03 Marzo </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_MARZO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_MARZO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">09 Septiembre </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_SEPTIEMBRE_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_SEPTIEMBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">04 Abril </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_ABRIL_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_ABRIL"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">10 Octubre</div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_OCTUBRE_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_OCTUBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">05 Mayo </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_MAYO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_MAYO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" nowrap bgcolor="#CCCCCC"><div align="left">11 Noviembre </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_NOVIEMBRE_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_NOVIEMBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center"><div align="left">06 Junio </div></td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_JUNIO_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td align="center" bgcolor="#CCCCCC"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_JUNIO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">12 Diciembre </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_DICIEMBRE_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_DICIEMBRE"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
									  </tr><tr>
									        <td width="5%" bgcolor="#CCCCCC" align="center">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td align="center" bgcolor="#CCCCCC"><div align="left">13 Enero +1 </div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000"><%=(((RSM_MOV_data = RSM_MOV.getObject("P_ENE_MAS_SA"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><div align="center"><strong><font color="#000000"><%=(((MOV_BOL_data = MOV_BOL.getObject("P_ENERO"))==null || MOV_BOL.wasNull())?"":MOV_BOL_data)%></font></strong></div></td>
									  </tr><tr>
									        <td colspan="2" align="center" bgcolor="#CCCC66"><div align="left">Total positivos<strong><font color="#000000">&nbsp;<%=(((RSM_MOV_data = RSM_MOV.getObject("SALDOS_POSITIVOS"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div></td>
                                            <td colspan="2" align="center" nowrap bgcolor="#CCCC66"><div align="left">Total negativos<strong><font color="#000000">&nbsp;<%=(((RSM_MOV_data = RSM_MOV.getObject("SALDOS_NEGATIVOS"))==null || RSM_MOV.wasNull())?"":RSM_MOV_data)%></font></strong></div>                                              <div align="right"></div></td>
                                            <td colspan="4" align="center" bgcolor="#CCCC66"><div align="right"><strong>Saldo  <font color="#000000"><%=(((SALDO_data = SALDO.getObject("SALDO"))==null || SALDO.wasNull())?"":SALDO_data)%></font></strong></div></td>
                                            </tr> <% } %>
                                    </table>                                  </td>
                                </tr>
                                <tr> 
                                  <td valign="top" colspan="2">&nbsp; </td>
                                </tr>
                                <tr> 
                                  <td valign="top" colspan="2"> 
                                    <table width="100%" border="0" cellspacing="1" cellpadding="3">
                                      <tr> 
									     <a name="movimientos" id="movimientos"></a> 
                                        <td nowrap bgcolor="#FFFFDD" class="va10b"><b class="ah12b">Movimientos
                                          
                                        </b></td>
                                        <td colspan="2" nowrap bgcolor="#FFFFDD" class="va10b">&nbsp;</td>
                                        <td colspan="3" valign="middle" nowrap bgcolor="#FFFFDD" class="va10b">
                                        <form name="form2" method="post" action="alta_movimiento.jsp">
                                          
                                          <div align="right">
                                            <input type="submit" name="Submit3" value="Añadir Movimientos">
                                          </div>
                                        </form></td>
                                      </tr>
                                      <tr> 
                                        <td align="center" bgcolor="#CCCCCC" class="va10b">Periodo</td>
                                        <td align="center" bgcolor="#CCCCCC" class="va10b" width="3%">Inicio</td>
                                        <td align="center" bgcolor="#CCCCCC" class="va10b" width="15%">Fin</td>
                                        <td width="14%" align="center" nowrap bgcolor="#CCCCCC" class="va10b">Horas y minutos </td>
                                        <td align="center" bgcolor="#CCCCCC" class="va10b" width="43%">Movimiento</td>
                                        <td align="center" bgcolor="#CCCCCC" class="va10b" width="6%">&nbsp;</td>
                                      </tr>
                                      <% while ((MOV_SAL_hasData)&&(MOV_SAL__numRows-- != 0)) { %>
                                      <tr> 
                                        <td align="center" bgcolor="#FFFFFF"><p><%=(((MOV_SAL_data = MOV_SAL.getObject("PERIODO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data)%></td>
                                        <td colspan="2" align="center" bgcolor="#FFFFFF"><b><%=(((MOV_SAL_data = MOV_SAL.getObject("FECHA_MOVIMIENTO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data)%></b></td>
                                        <td width="14%" align="center" nowrap bgcolor="#FFFFFF"><b><%=(((MOV_SAL_data = MOV_SAL.getObject("H_MOV"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data)%></b></td>
                                        <td bgcolor="#FFFFFF"><%=(((MOV_SAL_data = MOV_SAL.getObject("DESC_TIPO_MOVIMIENTO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data)%></td>
                                        <td bgcolor="#FFFFFF">
<%  v_actualizar  = (String)  (((MOV_SAL_data = MOV_SAL.getObject("ID_ACT"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data);
     v_borrado  = (String)  (((MOV_SAL_data = MOV_SAL.getObject("ID_BOR"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data);
    if ( v_actualizar.equals("A") )
      { 
 %>
    <a href="editar_movimiento.jsp?ID_REGISTRO=<%=(((MOV_SAL_data = MOV_SAL.getObject("ID_REGISTRO")) == null || MOV_SAL.wasNull()) ? "" : MOV_SAL_data)%>"><img src="../../imagen/edit.png" alt="Editar" width="20" height="20" border="0"></a>       
 <%   } 
   if ( v_borrado.equals("A") )
      { 
 %>
  <a href="borrar_movimiento.jsp?ID_REGISTRO=<%=(((MOV_SAL_data = MOV_SAL.getObject("ID_REGISTRO")) == null || MOV_SAL.wasNull()) ? "" : MOV_SAL_data)%>"><img src="../../imagen/delete.png" alt="Borrar" width="20" height="20" border="0"></a>
<%    } 
 %>
<%  
     v_borrado  = (String)  (((MOV_SAL_data = MOV_SAL.getObject("ID_BOR"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data);
  
     if ( v_borrado.equals("C") )
      { 
 %>
 
  
  
<a href="calcula_saldo.jsp?PERIODO=<%=(((MOV_SAL_data = MOV_SAL.getObject("PERI")) == null || MOV_SAL.wasNull()) ? "" : MOV_SAL_data)%>&ID_USUARIO=<%= session.getValue("MM_ID_USUARIO") %>&ID_FUNCIONARIO=<%= SALDO__MMColParam1 %>"  ><img src="../../imagen/calculator.png" alt="Carga Saldo" width="20" height="20" border="0"></a>
                                          <%    } 
 %></td>
                                      </tr>
                                      <%
                                      MOV_SAL__index++;
                                      MOV_SAL_hasData = MOV_SAL.next();
}
%>                              <tr> 
                                <td align="center" colspan="7" class="va10b"><div align="right"></div></td>
                              </tr>
                                    </table>                                  </td>
                                </tr>
								  <% } else  { %>
								<tr bgcolor="#FFFFDD"> 
                                        <td><b>SIN BOLSA</b>  <%= BOLSA_FUN__MMColParam2 %>                                        </td>
                                        <td colspan="7"><form name="form1" method="post" action="nuevo.jsp">
                                          <input type="submit" name="Submit" value="Crear Bolsa">
                                        </form></td>
      </tr>
									  <% } %>
									  <tr> 
                                 
                                </tr>
      </table>
	
    </div>
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
<%
SALDO.close();
ConnSALDO.close();
%>
<%
RSM_MOV.close();
ConnRSM_MOV.close();
%>
<%
MOV_BOL.close();
ConnMOV_BOL.close();
%>