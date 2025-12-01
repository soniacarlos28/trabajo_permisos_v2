<%@page language="java" import="java.util.Date,java.sql.*,java.util.Calendar" %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<
<html>
<head>
    
    <title>Detalle de Solicitudes del Curso</title>
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
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
      <li><a href="../../gestion/Bolsa_proceso/index.jsp"  >Saldo Periodo</a></li> 
  
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
   <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
   <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li> 
   <li><a href="../../gestion/Formacion/index_formacion.jsp" id="current" >Formacion</a></li>
    </ul>
  <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>

<table width="85%" border="0" cellspacing="1" cellpadding="2">
    <tr bgcolor="#CCFFCC">
       <td colspan="10" align="center"><b>Detalle de Solicitudes del Curso></b> <input type="hidden" name="TODO_T" ID="TODO_T" size="122" >
      </tr>
     </table>
   


    <%
        String codicurs = request.getParameter("codicurs");
        if (codicurs == null || codicurs.isEmpty()) {
            out.println("Curso no encontrado.");
            return;
        }

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
              Driver DriverRSCURSO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
             con = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);           
             // Usamos la conexi�n que hemos creado
             // Consultamos las solicitudes de los empleados para este curso
             String query = " SELECT distinct s.codisoli as peticion_id, t.desc_curso as descripcion, e.nombre || ' '||  e.ape1 || ' ' || e.ape2  as nombre_empleado,e.id_funcionario as id_funcionario,s.estadosoli,fechasoli,to_char(FECHASOLI,'dd/mm/yyyy hh24:mi') as fechasolitxt FROM curso_savia_solicitudes s" +
                            " JOIN personal_new e ON s.codiempl = e.id_funcionario  " +
                            "JOIN curso_savia t ON t.id_curso =  s.codicur  " +
                            "WHERE s.codicur =" + codicurs + " order by fechasoli";
            stmt = con.prepareStatement(query);          
            rs = stmt.executeQuery();

            if (rs.next()) {
    %>
    <form method="post" action="procesar_denegacion.jsp">
        <table border="1">
            <thead>
                <tr>
                    <th>Seleccionar</th>
                    <th>ID de Petici�n</th>
                    <th>Descripci�n</th>
                    <th>ID de Funcionario</th>
                    <th>Nombre del Empleado</th>
                    <th>Fecha Solicitud</th>

                </tr>
            </thead>
            <tbody>
    <%
                // Usamos un contador para asegurarnos de tener identificadores �nicos
                int count = 0;
                do {
                    String peticionId = rs.getString("peticion_id");
                    String descripcion = rs.getString("descripcion");
                    String id_funcionario = rs.getString("id_funcionario");


                    String nombreEmpleado = rs.getString("nombre_empleado");
                    String fechasoli = rs.getString("fechasolitxt");


                    // Generamos un nombre �nico para cada checkbox basado en el ID de la petici�n
                    String checkboxName = "peticion_" + peticionId;
    %>
                    <tr>
                        <td><input type="checkbox" name="peticionesSeleccionadas" value="<%= peticionId %>"></td>
                        <td><%= peticionId %></td>
                        <td><%= descripcion %></td>
                        <td><%= id_funcionario %></td>
                        <td><%= nombreEmpleado %></td>
                        <td><%= fechasoli %></td>

                    </tr>
    <%
                } while (rs.next());
    %>
            </tbody>
        </table>
        <br>
        <input type="submit" value="Denegar Seleccionadas">
    </form>
    <%
           }
            rs.close();
             stmt.close();
            con.close(); 
    %>
</body>
</html>
