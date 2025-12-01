<%@page language="java" import="java.util.Date,java.sql.*,java.util.Calendar" %>
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
%>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Procesar Denegación de Solicitudes</title>
<link href="../estilos.css" rel="stylesheet" type="text/css">
<link href="../esquema.css" rel="stylesheet" type="text/css">
<link href="../apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
      <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
      <li><a href="../../gestion/Bolsa_proceso/index.jsp"  >Saldo Periodo</a></li> 
  
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
   <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
   <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li> 
   <li><a href="../../gestion/Formacion/index_formacion.jsp" id="current" >Formacion</a></li>
    </ul>
  </div>
   <table width="85%" border="0" cellspacing="1" cellpadding="2">
    <tr bgcolor="#CCFFCC">
       <td colspan="10" align="center"><b>Procesar Denegación de Solicitudes</b> <input type="hidden" name="TODO_T" ID="TODO_T" size="122" >
      </tr>
     </table>                              
   
    <%
        // Recuperar las solicitudes seleccionadas del formulario
        String[] peticionesSeleccionadas = request.getParameterValues("peticionesSeleccionadas");

        if (peticionesSeleccionadas != null && peticionesSeleccionadas.length > 0) {
            // Conectar a la base de datos
            Connection con = null;
            PreparedStatement stmt = null;

           
            	  Driver DriverRSCURSO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
                  con = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
                

                // Iniciar una transacción
                con.setAutoCommit(false);
                
                // Actualizar el estado de las solicitudes seleccionadas
                String updateQuery = "UPDATE curso_savia_solicitudes SET estadosoli='DE' WHERE codisoli = ?";
                stmt = con.prepareStatement(updateQuery);

                for (String peticionId : peticionesSeleccionadas) {
                    stmt.setString(1, peticionId);
                    stmt.addBatch();  // Añadimos la actualización al lote
                }

                // Ejecutar el lote
                int[] result = stmt.executeBatch();
                
                // Confirmar la transacción
                con.commit();

                out.println("Las solicitudes seleccionadas se han denegado correctamente.");
         
                // Cerrar recursos
                if (stmt != null)  { stmt.close(); }
                if (con != null) { con.close(); } 
            }
        else {
            out.println("No se seleccionaron solicitudes.");
        }
    %>
    <br>
    <a href="index_formacion.jsp">Volver a la lista de cursos</a>
</body>
</html>
