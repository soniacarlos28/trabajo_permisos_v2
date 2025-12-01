<%@page language="java" import="java.util.Date,java.sql.*,javax.swing.JOptionPane" %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>

<%
String RSQUEYBOLSA__MMColParam8 = "E";
if (request.getParameter("ID_TIPO_OPERACION")  !=null) {RSQUEYBOLSA__MMColParam8 = (String)request.getParameter("ID_OPERACION") ;}
%>

<%
String RSQUEYBOLSA__MMColParam1 = "00";
if (request.getParameter("ID_REGISTRO")  !=null) {RSQUEYBOLSA__MMColParam1 = (String)request.getParameter("ID_REGISTRO") ;}
%>
<%
String RSQUEYBOLSA__MMColParam2 = "A";
if (request.getParameter("PERIODO")  !=null) {RSQUEYBOLSA__MMColParam2 = (String)request.getParameter("PERIODO") ;}
%>
<%
String RSQUEYBOLSA__MMColParam3 = "A";
if (request.getParameter("ID_TIPO_MOVIMIENTO")  !=null) {RSQUEYBOLSA__MMColParam3 = (String)request.getParameter("ID_TIPO_MOVIMIENTO")   ;}
%>
<%
String RSQUEYBOLSA__MMColParam4 = "A";
if (request.getParameter("FECHA_MOVIMIENTO")    !=null) {RSQUEYBOLSA__MMColParam4 = (String)request.getParameter("FECHA_MOVIMIENTO")   ;}
%>
<%
String RSQUEYBOLSA__MMColParam5 = "A";
if (request.getParameter("EXCESOS_EN_HORAS")    !=null) {RSQUEYBOLSA__MMColParam5 = (String)request.getParameter("EXCESOS_EN_HORAS")   ;}
%>
<%
String RSFUNCIONARIO__MMColParam6 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO") !=null) {RSFUNCIONARIO__MMColParam6 = (String)session.getValue("MM_ID_FUNCIONARIO");}
%>
<%
String RSQUEYBOLSA__MMColParam7 = "A";
if (request.getParameter("EXCESOS_EN_MINUTOS")    !=null) {RSQUEYBOLSA__MMColParam7 = (String)request.getParameter("EXCESOS_EN_MINUTOS")   ;}
%>
<%
String RSQUEYBOLSA__MMColParam9 = "";
if (request.getParameter("OBSERVACIONES")    !=null) {RSQUEYBOLSA__MMColParam9 = (String)request.getParameter("OBSERVACIONES")   ;}
%>

<%
Driver DriverRSPERIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIO = ConnRSPERIO.prepareStatement("SELECT ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo ,mes ||  ano as per FROM  webperiodo  WHERE ano>2013 and  ano ||mes <= to_char(sysdate,'YYYYMM')  ORDER BY ano,MES");
ResultSet RSPERIO = StatementRSPERIO.executeQuery();
boolean RSPERIO_isEmpty = !RSPERIO.next();
boolean RSPERIO_hasData = !RSPERIO_isEmpty;
Object RSPERIO_data;
int RSPERIO_numRows = 0;
%>

<%
Driver DriverTIPO_BOLSA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnTIPO_BOLSA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementTIPO_BOLSA = ConnTIPO_BOLSA.prepareStatement("select lpad(id_tipo_movimiento,2,'0') as id_tipo_movimiento ,  desc_tipo_movimiento  from BOLSA_TIPO_MOVIMIENTO where id_tipo_movimiento in (3,4,6,7) order by 2 ");
ResultSet TIPO_BOLSA = StatementTIPO_BOLSA.executeQuery();
boolean TIPO_BOLSA_isEmpty = !TIPO_BOLSA.next();
boolean TIPO_BOLSA_hasData = !TIPO_BOLSA_isEmpty;
Object TIPO_BOLSA_data;
int TIPO_BOLSA_numRows = 0;
%>
<%
int TIPO_BOLSA__numRows = -1;
int TIPO_BOLSA__index = 0;
TIPO_BOLSA_numRows += TIPO_BOLSA__numRows;
%>

<%
String MOV_SAL__MMColParam2 = "00";
if (request.getParameter("ID_REGISTRO")   !=null) {MOV_SAL__MMColParam2 = (String)request.getParameter("ID_REGISTRO")  ;}
%>
<%
Driver DriverMOV_SAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnMOV_SAL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementMOV_SAL = ConnMOV_SAL.prepareStatement("SELECT DECODE(bm.ID_TIPO_MOVIMIENTO,3,'A',4,'A',6,'A',7,'A','B') as ID_ACT,DECODE(bm.ID_TIPO_MOVIMIENTO,3,'A',6,'A',7,'A','B') as ID_BOR,bm.id_registro as id_registro, lpad(EXCESO_EN_HORAS,3,'0') as EXCESO_EN_HORAS,lpad(EXCESOS_EN_MINUTOS,3,'0') as EXCESOS_EN_MINUTOS , lpad(bm.ID_TIPO_MOVIMIENTO,2,'0') as ID_TIPO_MOVIMIENTO,lpad(PERIODO,2,'0') || ID_ANO as PERM,to_char(FECHA_MOVIMIENTO,'DD/MM/YYYY') as FECHA_MOVIMIENTO ,DECODE(sign((EXCESO_en_horas*60+EXCESOs_en_minutos)),-1,'<font color=\"#FF0000\">' || '-' ||  lpad( trunc((abs(EXCESO_en_horas)*60+abs(EXCESOs_en_minutos))/60,0),2,'0') || ':' ||  lpad( mod((abs(EXCESO_en_horas)*60+abs(EXCESOs_en_minutos)),60),2,'0')   || '</font>' , '<font color=\"#000000\">'  ||  lpad( trunc((EXCESO_en_horas*60+EXCESOs_en_minutos)/60,0),2,'0') || ':' ||  lpad( mod((EXCESO_en_horas*60+EXCESOs_en_minutos),60),2,'0')   || '</font>'   )    as h_mov  , ID_FUNCIONARIO,Observaciones,desc_tipo_movimiento,PERIODO FROM BOLSA_MOVIMIENTO BM,bolsa_tipo_MOVIMIENTO BT WHERE  bm.id_registro =" + MOV_SAL__MMColParam2 + "  and  BM.ID_TIPO_MOVIMIENTO=BT.ID_TIPO_MOVIMIENTO order by id_funcionario, periodo,fecha_movimiento");

ResultSet MOV_SAL = StatementMOV_SAL.executeQuery();
boolean MOV_SAL_isEmpty = !MOV_SAL.next();
boolean MOV_SAL_hasData = !MOV_SAL_isEmpty;
Object MOV_SAL_data;
int MOV_SAL_numRows = 0;
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
<script language="Javascript">

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
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<body>


<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
      
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
     <li><a href="../../gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
      <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
       <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
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
                                     
                                        <tr>
                                          <td>&nbsp;</td>
                                      </tr>
                                       
                                    </table>
                                  </div>                                  </tr>
                                <tr> 
                                  <td bgcolor="#E0E0E0" valign="top" colspan="2">
								       
                                    <table width="100%" border="0" cellspacing="1" cellpadding="4">
                        <form name="formBolsa" method="post" action="movimiento_result.jsp"> 						
                                      <tr bgcolor="#FFFFDD">                                      
                                        <td colspan="8"><div align="center"> <strong>Modificaci&oacute;n de Movimiento </strong></div>                                          
                                          <div align="right"></div></td>                                        
                          </tr>
                                      <a name="bolsa" id="bolsa"></a> 
									<tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                <table align="center" cellpadding="2" cellspacing="1" border="0" width="100%">
                                  
								  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Periodo:</td>
                                    <td><% if ( RSQUEYBOLSA__MMColParam2.equals("A") )	  { %>
	 <%	  RSQUEYBOLSA__MMColParam2  = (String)  (((MOV_SAL_data = MOV_SAL.getObject("PERM"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data); %>
									 <%   }  %> 







									<select name="PERIODO" maxlength="100">
                                                  <%
while (RSPERIO_hasData) {
%>
                                                    <option value="<%=((RSPERIO.getObject("PER")!=null)?RSPERIO.getObject("PER"):"")%>"<%=((RSQUEYBOLSA__MMColParam2.toString().equals((((RSPERIO_data = RSPERIO.getObject("PER"))==null || RSPERIO.wasNull())?"":RSPERIO_data)))?"selected=\"selected\"":"")%>><%=((RSPERIO.getObject("PERIODO")!=null)?RSPERIO.getObject("PERIODO"):"")%></option>
                                                    <%
  RSPERIO_hasData = RSPERIO.next();
}
RSPERIO.close();
RSPERIO = StatementRSPERIO.executeQuery();
RSPERIO_hasData = RSPERIO.next();
RSPERIO_isEmpty = !RSPERIO_hasData;
%>
                                      </select>
									 

                                      <input type="hidden" name="ID_FUNCIONARIO" value="<%= session.getAttribute("MM_ID_FUNCIONARIO") %>" size="6" maxlength="4">
                                      <input type="hidden" name="ID_TIPO_OPERACION" value="E" size="6" maxlength="4">
                                      <input type="hidden" name="ID_REGISTRO" value="<%= RSQUEYBOLSA__MMColParam1%>" size="6" maxlength="4"></td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Tipo:</td>
                                    <td>
									<% if ( RSQUEYBOLSA__MMColParam3.equals("A") )	  { %>
                                      <%	  RSQUEYBOLSA__MMColParam3  = (String)  (((MOV_SAL_data = MOV_SAL.getObject("ID_TIPO_MOVIMIENTO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data); %>
                                      <%   }  %>     
									
									<select name="ID_TIPO_MOVIMIENTO" >
                                        <%





while (TIPO_BOLSA_hasData) {
%>
                                       <option value="<%=((TIPO_BOLSA.getObject("ID_TIPO_MOVIMIENTO")!=null)?TIPO_BOLSA.getObject("ID_TIPO_MOVIMIENTO"):"")%>"<%=((RSQUEYBOLSA__MMColParam3.toString().equals((((TIPO_BOLSA_data = TIPO_BOLSA.getObject("ID_TIPO_MOVIMIENTO"))==null || TIPO_BOLSA.wasNull())?"":TIPO_BOLSA_data)))?"selected=\"selected\"":"")%>><%=((TIPO_BOLSA.getObject("DESC_TIPO_MOVIMIENTO")!=null)?TIPO_BOLSA.getObject("DESC_TIPO_MOVIMIENTO"):"")%></option>
                                        <%
  TIPO_BOLSA_hasData = TIPO_BOLSA.next();
}
TIPO_BOLSA.close();
TIPO_BOLSA = StatementTIPO_BOLSA.executeQuery();
TIPO_BOLSA_hasData = TIPO_BOLSA.next();
TIPO_BOLSA_isEmpty = !TIPO_BOLSA_hasData;
%>
                                      </select>                                  </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Fecha:</td>
                                    <td> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td>
										 <% if ( RSQUEYBOLSA__MMColParam4.equals("A") )	  { %>
                                      <%	  RSQUEYBOLSA__MMColParam4  = (String)  (((MOV_SAL_data = MOV_SAL.getObject("FECHA_MOVIMIENTO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data); %>
                                      <%   }  %>   
										  
										  <input type="text" name="FECHA_MOVIMIENTO" value="<%= RSQUEYBOLSA__MMColParam4 %>" size="15" maxlength="10"></td>
                                          <td><a href="javascript:show_Calendario('formBolsa.FECHA_MOVIMIENTO');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>                                    </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Excesos                                      Horas:</td>
                                    <td> 
									  <% if ( RSQUEYBOLSA__MMColParam5.equals("A") )	  { %>
                                      <%	  RSQUEYBOLSA__MMColParam5  = (String)  (((MOV_SAL_data = MOV_SAL.getObject("EXCESO_EN_HORAS"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data); %>
                                      <%   }  %>   
									 									 
                                      <input name="EXCESOS_EN_HORAS" type="text" id="EXCESOS_EN_HORAS" size="2" maxlength="3" value="<%= RSQUEYBOLSA__MMColParam5 %>">
                                      <% if ( RSQUEYBOLSA__MMColParam7.equals("A") )	  { %>
                                      <%	  RSQUEYBOLSA__MMColParam7  = (String)  (((MOV_SAL_data = MOV_SAL.getObject("EXCESOS_EN_MINUTOS"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data); %>
                                      <%   }  %>   
									  <input name="EXCESOS_EN_MINUTOS" type="text" id="EXCESOS_EN_MINUTOS" size="2" maxlength="3" value="<%= RSQUEYBOLSA__MMColParam7 %>">
									  &nbsp;Minutos</td>
                                  </tr>
                                 
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%" bgcolor="#f2f2f2" valign="middle">Descripci&oacute;n 
                                      :</td>
                                    <td> 
                                      <textarea name="OBSERVACIONES" cols="60" rows="3" id="OBSERVACIONES" value=""><%=  (((MOV_SAL_data = MOV_SAL.getObject("OBSERVACIONES"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data) %></textarea>                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
									   <tr>
									        <td colspan="8" align="center" bgcolor="#66CCFF"><input type="submit" value="Guardar Movimiento" name="Guardar" onClick="javascript:envia_unavez();"></td>
                          </tr> 
											
								   </form>  
                                    </table>  
	                              </td>
                                </tr>
                               
								  
      </table>
    </div>
</div>
</body>
</html>


<%
TIPO_BOLSA.close();
ConnTIPO_BOLSA.close();
%>
<%
RSPERIO.close();
StatementRSPERIO.close();
ConnRSPERIO.close();
%>
<%
MOV_SAL.close();
ConnMOV_SAL.close();
%>