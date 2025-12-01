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
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("select id_sancion, id_funcionario,    fecha_aviso,   fecha_sancion,       tipo_permiso,       desc_permiso,       nombre || ' ' ||       ape1   || ' ' ||       ape2   as nombres,       anulado,       fecha_modi,       id_permiso_san,       num_dias,       horas  from permisos_sancion_sinjusti t  order by ape1,ape2");
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
<div id="apliweb-tabform">
<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados" id="current">Sin Justificar</a></li>     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li> 
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp">Proceso Bolsa</a></li>    
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>  
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
    </ul>
   </div>
  <div id="form">
    <div>
	  <ul id="subtabh">		
		<li><a href="index.jsp">Permisos sin Justificar</a></li>
		<li><a href="index_ausencias.jsp" >Ausencias sin Justificar</a></li>		
		<li><a href="index_sancionados.jsp" id="current">Sancionados</a></li>		
	  </ul>
	</div> 

<table width="100%" border="1" cellspacing="3" cellpadding="4">
                                      <tr bgcolor="#CCFFCC"> 
                                        <td colspan="6" align="center"><b>Recordatorio de permiso y ausencias</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                           
                                       
                                       
                                      </tr>
                                     
                                      <tr> 
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Funcionario</span></td>
                                        <td width="35%" bgcolor="#CCCCCC" align="center"><span class="va10b">Nombre Apellidos</span></td>
                                        <td width="30%" bgcolor="#CCCCCC" align="center"><span class="va10b">Permiso</span></td>
                                        <td width="20%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Sancion</span></td>
                                     
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
                                      
                                      
                                        <td <%= RSCOLOR %>  align="center" width="5%"><%= "" + (((RSQUERY_data = RSQUERY.getObject("TIPO_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + (((RSQUERY_data = RSQUERY.getObject("TIPO_PER"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + (((RSQUERY_data = RSQUERY.getObject("ID_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE1=" + (((RSQUERY_data = RSQUERY.getObject("APE1"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE2=" + (((RSQUERY_data = RSQUERY.getObject("APE2"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&NOMBRE=" + (((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'>" %><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                                                                     
                                        <td <%= RSCOLOR %> width="35%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRES"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="30%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("DESC_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                    <td <%= RSCOLOR %> width="20%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_SANCION"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                      
                                      </tr>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat2__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                                    </table></div>
</body>
</html>



<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>