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
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("select distinct p.ID_FUNCIONARIO as ID_FUNCIONARIO,     p.Ape1 || ' ' || p.ape2 || ' ' || p.NOMBRE as NOMBREs, pe.fecha_inicio as finc,  p.Ape1,     p.ape2, p.NOMBRE,   tr.DESC_TIPO_AUSENCIA as TIPO_PERMISO, pe.id_ausencia as ID_PERMISO,   to_char(pe.FECHA_INICIO, 'dd/mm/yyyy hh24:mi') as FECHA_INICIO, to_char(pe.FECHA_FIN, 'dd/mm/yyyy hh24:mi') AS FECHA_FIN,  1 as NUM_DIAS,  DECODE(a.id_funcionario, NULL, 'NO', 'SI') as INCIDENCIA,to_char(a.FECHA_AVISO,'dd/mm/yyyy') as FECHA_AVISO  from ausencia pe, tr_tipo_ausencia tr, PERMISOS_AVISOS_SINJUSTI A,personal_new p   where pe.id_estado = 80  and pe.JUSTIFICADO = 'NO'   and tr.id_tipo_ausencia = pe.id_tipo_ausencia  and pe.id_tipo_ausencia < 500  and pe.id_tipo_ausencia <> '090'  and pe.id_tipo_ausencia <> '105'  and pe.id_funcionario = p.id_funcionario  and pe.id_funcionario = a.id_funcionario(+)   and pe.id_ausencia = a.id_permiso(+)  and pe.fecha_inicio between to_date('01/05/2018', 'dd/mm/yyyy') and sysdate-7   and (pe.ANULADO = 'NO' OR pe.anulado is null)  and a.valido(+)=1   order by finc desc ");
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
<script language="Javascript" >


function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->



function show_confirm(id, description, url)
{
   var text = "�Realmente desea eliminar: '" + description + "'?";
   var r = confirm(text);
   if (r==true) { 
      MM_goToURL('self',url + id);
   }
   else { 
      alert("Operaci�n cancelada!"); 
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
     <li><a href="../../gestion/Listados" id="current">Sin Justificar</a></li>     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li> 
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp">Proceso Bolsa</a></li>    
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>  
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
    </ul>
   <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
    <div>
	  <ul id="subtabh">		
		<li><a href="index.jsp">Permisos sin Justificar</a></li>
		<li><a href="index_ausencias.jsp" id="current"">Ausencias sin Justificar</a></li>		
		<li><a href="index_sancionados.jsp">Sancionados</a></li>		
	  </ul>
	</div> 

<table width="100%" border="1" cellspacing="3" cellpadding="4">
                                      <tr bgcolor="#CCFFCC"> 
                                        <td colspan="7" align="center"><b>Ausencias sin Justificar</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                           
                                       
                                       
                                      </tr>
                                     
                                      <tr> 
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Funcionario</span></td>
                                        <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Nombre Apellidos</span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Inicio</span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Fin</span></td>
                                        <td width="30%" bgcolor="#CCCCCC" align="center"><span class="va10b">Permiso</span></td>
                                        <td width="20%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Aviso</span></td>
                                                <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Acciones</span></td>
                             
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
                                      
                                      
                                        <td <%= RSCOLOR %>  align="center" width="5%"><%= "<a href='../Ausencias/editar.jsp?ID_FUNCIONARIO=" + (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&ID_AUSENCIA=" + (((RSQUERY_data = RSQUERY.getObject("ID_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE1=" + (((RSQUERY_data = RSQUERY.getObject("APE1"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE2=" + (((RSQUERY_data = RSQUERY.getObject("APE2"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&NOMBRE=" + (((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'>" %><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                                                                      
                                        <td <%= RSCOLOR %> width="25%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRES"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="15%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_INICIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="15%" align="right" bgcolor="#FFFFFF"><%=  (((RSQUERY_data = RSQUERY.getObject("FECHA_FIN"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="30%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("TIPO_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                    <td <%= RSCOLOR %> width="20%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_AVISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                      <td <%= RSCOLOR %> width="20%" align="center" bgcolor="#FFFFFF">  <a href="javascript:show_confirm('<%=(((RSQUERY_data = RSQUERY.getObject("ID_PERMISO")) == null || RSQUERY
							.wasNull()) ? "" : RSQUERY_data)%>','<%=(((RSQUERY_data = RSQUERY.getObject("ID_PERMISO")) == null || RSQUERY
							.wasNull()) ? "" : RSQUERY_data)%>','eliminar.jsp?ID_TIPO=A&ID_PERMISO=')"><img	src="../../imagen/eliminar.gif" alt="Eliminar" width="20" height="20" border="0">							
                      </a> </td>
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
