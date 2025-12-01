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
Driver DriverRSTR_HORA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTR_HORA =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTR_HORA = ConnRSTR_HORA.prepareStatement("select ID_HORA,VALOR from rrhh.tr_hora_con order by to_number(ID_HORA) ");
ResultSet RSTR_HORA = StatementRSTR_HORA.executeQuery();
boolean RSTR_HORA_isEmpty = !RSTR_HORA.next();
boolean RSTR_HORA_hasData = !RSTR_HORA_isEmpty;
Object RSTR_HORA_data;
int RSTR_HORA_numRows = 0;
%>


<%
Driver DriverRSTR_MINUTO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTR_MINUTO =DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTR_MINUTO = ConnRSTR_MINUTO.prepareStatement("select ID_MINUTO,VALOR from rrhh.tr_MINUTO order by 1 ");
ResultSet RSTR_MINUTO = StatementRSTR_MINUTO.executeQuery();
boolean RSTR_MINUTO_isEmpty = !RSTR_MINUTO.next();
boolean RSTR_MINUTO_hasData = !RSTR_MINUTO_isEmpty;
Object RSTR_MINUTO_data;
int RSTR_MINUTO_numRows = 0;

int Repeat1__index = 0;
int Repeat2__index = 0;
%>
<%
String BOLSA_FUN__JS = "";
if (session.getAttribute("MM_ID_FUNCIONARIO")           !=null) {BOLSA_FUN__JS = (String)session.getAttribute("MM_ID_FUNCIONARIO")          ;}
%>
<%
String BOLSA_FUN__JS_NOMBRE = "";
if (request.getParameter("ID_JS_NOMBRE")           !=null) {BOLSA_FUN__JS_NOMBRE = (String)request.getParameter("ID_JS_NOMBRE")          ;}
%>
<%
String MOV_SAL__MMColParam2 = "";
if (request.getParameter("ID_REGISTRO")           !=null) {MOV_SAL__MMColParam2 = (String)request.getParameter("ID_REGISTRO")          ;}
%>



<%
Driver DriverMOV_SAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnMOV_SAL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementMOV_SAL = ConnMOV_SAL.prepareStatement("SELECT id_funcionario,TRUNC(EXCESO/60) as HORA,decode(sign(exceso),1, lpad(EXCESO-TRUNC(EXCESO/60)*60,2,'0'),  lpad(EXCESO*-1-(TRUNC(EXCESO*-1/60)*60),2,'0') ) as MINUTO,    to_char(FECHA_MOVIMIENTO, 'DD/MM/YYYY') as FECHA_MOVIMIENTO,       Observaciones,              to_char(FECHA_MOVIMIENTO, 'YYYY') PERIODO   FROM BOLSA_CONCILIA_MOV WHERE id_registro = " + MOV_SAL__MMColParam2 + "");

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

 if (document.formBolsa.Guardar.disabled==false) 
  {
   document.formBolsa.Guardar.disabled=true;
   document.formBolsa.PERIODO.value=document.formBolsa.FECHA_MOVIMIENTO.value.substring(10,6);
   document.formBolsa.submit();
  }
}
</script>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Bolsa conciliación</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../imagen/calendario.js"></script>
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


<table width="740" border="0" cellspacing="5" cellpadding="0">
     <tr> 
         <td bgcolor="#E0E0E0" valign="top" colspan="2">
            <table width="100%" border="0" cellspacing="1" cellpadding="4">
                        <form name="formBolsa" method="post" action="movimiento_result.jsp"> 						
                             <tr bgcolor="#FFFFDD">                                      
                               <td colspan="8" align="center"> <strong>Borrar Movimiento </strong></td>                                        
                             </tr>
                              <tr valign="baseline" bgcolor="#f2f2f2"> 
                              
                                    <td nowrap align="right" width="28%">Fecha:<input type="hidden" name="ID_FUNCIONARIO" ID="ID_FUNCIONARIO" size="6" value="<%= (((MOV_SAL_data = MOV_SAL.getObject("ID_FUNCIONARIO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data) %>" ></td>
                                    <td> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td> 
                                            <%= "<input type='hidden' name='ID_USUARIO' value='" + session.getValue("MM_ID_USUARIO") + "'>" %> 
                                            <input type="text" name="FECHA_MOVIMIENTO" value="<%= (((MOV_SAL_data = MOV_SAL.getObject("FECHA_MOVIMIENTO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data) %>" size="15" maxlength="10">   
                                             <input type="hidden" name="ID_REGISTRO" value="<%=  MOV_SAL__MMColParam2 %>" size="15" maxlength="10">
                                             <input type="hidden" name="PERIODO" value="" size="15" maxlength="10">  
                                                  <input type="hidden"  ID="ID_JS_NOMBRE" name="ID_JS_NOMBRE" value="<%= BOLSA_FUN__JS_NOMBRE %>" size="45" >    
                                                <input type="hidden"  ID="ID_TIPO_OPERACION" name="ID_TIPO_OPERACION" value="B" size="45" >
                                                                                   </td>
                                          <td><a href="javascript:show_Calendario('formBolsa.FECHA_MOVIMIENTO');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>                                    </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%">Exceso Jornada en                                       Horas y Minutos:</td>
                                    <td> 
                                      <select id="TR_HORA_<%= Repeat1__index %>"  name="TR_HORA_<%= Repeat1__index %>" >
                                           <%  while (RSTR_HORA_hasData) { %>
                                       <option value="<%=((RSTR_HORA.getObject("ID_HORA")!=null)?RSTR_HORA.getObject("ID_HORA"):"")%>"  
  <%=(((RSTR_HORA.getObject("ID_HORA")).toString().equals(((((MOV_SAL_data = MOV_SAL.getObject("HORA"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data)).toString()))?"SELECTED":"")%> >    
  <%=((RSTR_HORA.getObject("ID_HORA")!=null)?RSTR_HORA.getObject("ID_HORA"):"")%></option>
                                       <%   RSTR_HORA_hasData = RSTR_HORA.next();
                                            Repeat1__index++;
                                           }
										   RSTR_HORA.close();
										   RSTR_HORA = StatementRSTR_HORA.executeQuery();
										   RSTR_HORA_hasData = RSTR_HORA.next();
										   RSTR_HORA_isEmpty = !RSTR_HORA_hasData;
										   
									  %>
                                     </select>
								     <select id="TR_MINUTO_<%= Repeat2__index %>" name="TR_MINUTO_<%= Repeat2__index %>" >
                                        <% while (RSTR_MINUTO_hasData) { %>
                                          <option value="<%=((RSTR_MINUTO.getObject("ID_MINUTO")!=null)?RSTR_MINUTO.getObject("ID_MINUTO"):"")%>"  
  <%=(((RSTR_MINUTO.getObject("ID_MINUTO")).toString().equals(((((MOV_SAL_data = MOV_SAL.getObject("MINUTO"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data)).toString()))?"SELECTED":"")%> >    
  <%=((RSTR_MINUTO.getObject("ID_MINUTO")!=null)?RSTR_MINUTO.getObject("ID_MINUTO"):"")%></option>  <%   RSTR_MINUTO_hasData = RSTR_MINUTO.next();
                                            Repeat2__index++;
                                           }
										   RSTR_MINUTO.close();
										   RSTR_MINUTO = StatementRSTR_MINUTO.executeQuery();
										   RSTR_MINUTO_hasData = RSTR_MINUTO.next();
										   RSTR_MINUTO_isEmpty = !RSTR_MINUTO_hasData;
                                      %>
                                     </select>
                                      </td>
                                  </tr>
                                 
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="28%" bgcolor="#f2f2f2" valign="middle">Descripci&oacute;n 
                                      :</td>
                                    <td> 
                                      <textarea name="OBSERVACIONES" cols="60" rows="5" id="OBSERVACIONES" value=""><%=  (((MOV_SAL_data = MOV_SAL.getObject("OBSERVACIONES"))==null || MOV_SAL.wasNull())?"":MOV_SAL_data) %></textarea>                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
									   <tr>
									        <td colspan="8" align="center" bgcolor="#66CCFF"><input type="button" value="Borrar Movimiento" ID="Guardar" name="Guardar" onClick="javascript:envia_unavez();"></td>
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

