<%@page language="java" import="java.util.Date,java.sql.*,java.util.Calendar"  import="permisos.*" %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
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

String mensaje ="";
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Actualizaci�n de Cursos</title>
<link href="../estilos.css" rel="stylesheet" type="text/css">
<link href="../esquema.css" rel="stylesheet" type="text/css">
<link href="../apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>

<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b" >Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" >Proceso Bolsa</a></li>   
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
   <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
   <li ><a href="../../gestion/Informes/index_informes.jsp"  >Informes</a></li>
   <li><a href="../../gestion/Formacion/index_formacion.jsp" id="current" >Formacion</a></li>
    </ul>
  <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">  

      <%
          actualiza_cursos actualiza= new actualiza_cursos();
          mensaje = actualiza.actualizarCursos();
      %>
    
    <table width="85%" border="0" cellspacing="1" cellpadding="2">
             <tr bgcolor="#CCFFCC">
                                <td colspan="10" align="center"><b>Actualizaci�n de Cursos</b> <input type="hidden" name="TODO_T" ID="TODO_T" size="122" >
                   <tr>                    
                <th><%= mensaje %></th>
                <th>  <br>
                  <a href="index_formacion.jsp">Volver a la lista de cursos</a></th>
            </tr>
        
        
    </table>
</body>
</html>




