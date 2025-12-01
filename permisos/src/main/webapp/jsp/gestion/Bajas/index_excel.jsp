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
String RSQUERY__MMColParam1 = "0";
if (request.getParameter("ID_NOMBRE")  !=null) {RSQUERY__MMColParam1 = (String)request.getParameter("ID_NOMBRE") ;}


response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment; filename="+ RSQUERY__MMColParam1 + "");



%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("select 'NO' AS INCIDENCIA,to_char(sysdate,'dd/mm/yyyy') as hoy,id_se_fichero,id_baja,nombre_fichero,audit_usuario,to_char(audit_fecha,'DD/mm/yyyy') as audit_fecha,to_char(fecha_creacion,'DD/mm/yyyy') as fecha_creacion,id_funcionario,nombre_ape,dni,to_char(fecha_nacimiento,'DD/mm/yyyy') as fecha_nacimiento, to_char(fecha_antiguedad,'DD/mm/yyyy') as fecha_antiguedad,unidad,telefono,DECODE(to_char(fecha_inicio,'DD/mm/yyyy'),'01/01/1900','',to_char(fecha_inicio,'DD/mm/yyyy')) as  fecha_inicio,DECODE(to_char(fecha_fin,'DD/mm/yyyy'),'01/01/1900','',to_char(fecha_fin,'DD/mm/yyyy')) as  fecha_fin,DECODE(tipo_baja,'01/01/1900','',tipo_baja) as TIPO_BAJA,DECODE(observaciones,'01/01/1900','',observaciones) as observaciones from FICHERO_BAJAS where  UPPER('" + RSQUERY__MMColParam1 + "') = upper(nombre_fichero) order by nombre_ape,fecha_inicio");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<% String RSIMPAR="";
   String RSCOLOR="";

%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RSQUERY_numRows += Repeat2__numRows;
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
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>

  <div id="form">
     

<table width="100%" border="1" cellspacing="3" cellpadding="4">
                                      <tr bgcolor="#CCFFCC"> 
                                        <td colspan="11" align="center"><b>FECHA INFORME</b> <%=(((RSQUERY_data = RSQUERY.getObject("HOY"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %>   </td>
         
                                      </tr>
                                     
                                      <tr> 
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Funcionario</span></td>
                                        <td width="20%" bgcolor="#CCCCCC" align="center"><span class="va10b">Nombre Apellidos</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">DNI</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Nacimiento</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Antiguedad</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Unidad</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Telefono</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Inicio</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Fin</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Tipo Baja</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Observaciones</span></td>                                                                      
                                      </tr>
                                      <% while ((RSQUERY_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                      <% if (!RSQUERY_isEmpty ) { 
                                      RSIMPAR =  (String) (((RSQUERY_data = RSQUERY.getObject("INCIDENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data); 
                            	     if (RSIMPAR.equals("SI") )  
                                     	 RSCOLOR="bgcolor=\"#FAD2D2\"";                     	
    				     else 	                   
                                          RSCOLOR="";   							  	  
							  	       %> 							  	                                             
                                      <tr >       
                                                                                                           
                                        <td <%= RSCOLOR %> width="5%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                                                                  
                                        <td <%= RSCOLOR %> width="20%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE_APE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("DNI"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_NACIMIENTO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_ANTIGUEDAD"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="15%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("UNIDAD"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("TELEFONO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>                                        
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_INICIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=  (((RSQUERY_data = RSQUERY.getObject("FECHA_FIN"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="15%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("TIPO_BAJA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                        
                                        <td <%= RSCOLOR %> width="15%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("OBSERVACIONES"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                      
                                      </tr>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat2__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                                    </table><%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
</body>
</html>



<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
