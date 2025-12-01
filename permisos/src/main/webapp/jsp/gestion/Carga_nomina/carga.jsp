<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subida de Nóminas</title>
</head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body>

<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    
<li><a href="../../gestion/Carga_nomina/carga.jsp"  id="current">Carga Nominas</a></li>

 </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
 
<h2>Subida de Nóminas por Entidad</h2>
<script>
  function openProgressWindow(form) {
    // 1. Abrimos la ventana vacía (la iremos redirigiendo con el sendRedirect del servlet)
    window.open('', 'progressWindow', 'width=600,height=400');
    // 2. Hacemos que el form se envíe hacia esa ventana
    form.target = 'progressWindow';
    return true;  // permite el submit
  }
</script> 
<form method="post" action="/permisos/upload" enctype="multipart/form-data"   onsubmit="return openProgressWindow(this)">


    <label for="mes">Mes:</label>
    <select name="mes" id="mes">
    <%
        String[] meses = {
            "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
        };
        for (int i = 0; i < 12; i++) {
            String mesNum = (i + 1 < 10 ? "0" : "") + (i + 1);
    %>
        <option value="<%=mesNum%>"><%=meses[i]%></option>
    <%
        }
    %>
</select>

    <label for="anio">Año:</label>
    <select name="anio" id="anio">
        <% int currentYear = java.time.Year.now().getValue();
           for (int i = currentYear; i >= currentYear - 10; i--) {
        %>
        <option value="<%=i%>"><%=i%></option>
        <% } %>
    </select>

    <br/><br/>

    <label for="nominasPDF">Selecciona uno o más ficheros PDF:</label><br/>
    <input type="file" name="nominasPDF" id="nominasPDF" multiple accept=".pdf" />

    <br/><br/>
    <input type="submit" value="Procesar Nóminas" />
</form>

</body>
</html>

