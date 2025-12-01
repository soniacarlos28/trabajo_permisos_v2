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
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("select count(*) as NUME,'NO' AS INCIDENCIA,to_char(sysdate,'DD/mm/yyyy') as HOY,nombre_fichero,audit_usuario,nombre || ' ' || ape1 || ' ' || ape2 as NOMBRES,to_char(fecha_creacion,'DD/mm/yyyy') as FECHA_CREACION2,fecha_creacion from FICHERO_BAJAS  f,personal_new p where audit_usuario=p.id_funcionario group by nombre_fichero,audit_usuario, nombre || ' ' || ape1 || ' ' || ape2,to_char(fecha_creacion,'DD/mm/yyyy') ,fecha_creacion,'NO',to_char(sysdate,'DD/mm/yyyy') order by fecha_creacion desc");
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

<script language="Javascript">


// -->
function envia_unavez()
{

 if (document.form.Guardar.disabled==false) 
  {
   document.form.Guardar.disabled=true;
   document.form.submit();
  }
}
</script>
<html>
<head>
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
      <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp">Proceso Bolsa</a></li>    
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>  
    <li><a href="../../gestion/Bajas/index.jsp" id="current" >Bajas Fichero</a></li>
     <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
    </ul>
   <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
     <div>
	  <ul id="subtabh">		
		<li><a href="index.jsp" >Bajas A�o</a></li>
		<li><a href="index_fichero_bajas.jsp" id="current">Historico Ficheros de Bajas</a></li>					
	  </ul>
	</div>   

<table width="100%" border="1" cellspacing="3" cellpadding="4">
  <form name="formPermiso" method="get" action="crea_fichero.jsp">
                                      <tr bgcolor="#CCFFCC"> 
                                        <td colspan="3" align="center"><b>Crear Fichero</b>                                                                                 
                                          </td>
                                            <td colspan="2" align="center">
                                               <input type="submit" value="Crear Fichero" name="Guardar" onClick="javascript:envia_unavez();">
                                            </td>
                                      </tr>
                                     
                                      <tr> 
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Nombre Fichero</span></td>
                                        <td width="35%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha creacion</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Numero de Baja</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Creado por</span></td>
                                        <td width="30%" bgcolor="#CCCCCC" align="center"><span class="va10b">Excel</span></td>
                                        
                                     
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
                                      
                                      
                                         <td <%= RSCOLOR %> width="35%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE_FICHERO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="center" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_CREACION2"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=  (((RSQUERY_data = RSQUERY.getObject("NUME"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="30%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRES"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                         <td <%= RSCOLOR %>  align="center" width="5%"><%= "<a href='../Bajas/index_excel.jsp?ID_NOMBRE=" + (((RSQUERY_data = RSQUERY.getObject("NOMBRE_FICHERO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'>" %>Ver</td>
                                    
                                      </tr>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat2__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
</form>
                                    </table></div>
</body>
</html>



<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
