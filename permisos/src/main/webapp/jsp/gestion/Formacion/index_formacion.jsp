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
  
    <title>Lista de Cursos</title>
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
   
 <table width="85%" border="0" cellspacing="1" cellpadding="2"> 
   <tr>
   <th>
    <form method="get" action="index_formacion.jsp">
        <label for="anio">Seleccionar A�o:</label>
        <input type="number" id="anio" name="anio" value="<%= Calendar.getInstance().get(Calendar.YEAR) %>" min="2000" max="2099">
        <input type="submit" value="Filtrar">
    </form>
    
    
    </th> <td>
  <button onclick="window.location.href='actualizar_curso.jsp'">Actualizar Curso</button>
    </td>
    </tr>
    </table>
    
  
    
   <table width="85%" border="0" cellspacing="1" cellpadding="2">          
        <thead>
         <tr bgcolor="#CCFFCC">
                                <td colspan="10" align="center"><b>Lista de Cursos - A�o <%= Calendar.getInstance().get(Calendar.YEAR) %></b> <input type="hidden" name="TODO_T" ID="TODO_T" size="122" >
    
            <tr>
                <th>Nombre del Curso</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
            <%
                int anioSeleccionado = Calendar.getInstance().get(Calendar.YEAR);
                String anioParam = request.getParameter("anio");
                if (anioParam != null && !anioParam.isEmpty()) {
                    try {
                        anioSeleccionado = Integer.parseInt(anioParam);
                    } catch (NumberFormatException e) {
                        out.println("A�o inv�lido");
                    }
                }

                // Consultar los cursos para el a�o seleccionado
                Connection con = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

             
                
                try {
                    Driver DriverRSCURSO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
                    con = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
                    String query = "select id_curso,desc_curso,estado_convocatoria as estado from curso_savia where substr(id_curso,1,4)=" +  anioSeleccionado + " order by id_curso";
                    stmt = con.prepareStatement(query);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        String nombreCurso = rs.getString("desc_curso");
                        String estado = rs.getString("estado");
                        String codicurs = rs.getString("id_curso");
            %>
                        <tr>
                            <td align="left"><a href="detalle_curso.jsp?codicurs=<%= codicurs %>"><%= nombreCurso %></a></td>
                            <td><%= estado %></td>
                        </tr>
            <%
                    }
                } catch (SQLException e) {
                    out.println("Error al cargar los cursos: " + e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
                    if (con != null) try { con.close(); } catch (SQLException e) { }
                }
            %>
        </tbody>
    </table>
</body>
</html>




