<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>


<script language="Javascript">

function validarSiNumero(numero){
    if (!/^([0-9])*$/.test(numero))
      alert("El valor " + numero + " no es un número");
  }

function Valida(campo,mes) {

  if ((campo.length == 0) ) 
	  {
      alert('Falta información. ' + mes );
      return false
      }   
  if (!isNaN(parseInt(campo.value))) 
	  {
      alert('El campo debe ser un número. '+ mes);
      return false;
      }  
    return true
  
}

function envia_unavez()
{
	

	
	        
	
 if (document.Sindicales.Guardar.disabled==false) 
  {
   document.Sindicales.Guardar.disabled=true;

	  
   document.Sindicales.submit();
  }
}


</script>

<html>
<head>
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
</head>
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li ><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>  
    <li id="active" ><a href="index.jsp" id="current">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
  </ul>
</div>
<div id="form">
<div>
	 <ul id="subtabh">
		<li id="active"><a href="index.jsp" >Horas</a></li>	
		<li id="active"><a href="index_listado.jsp" id="current">Listado Horas</a></li>			
	  </ul>
  </div> 

<table width="95%" border="0" cellspacing="0" cellpadding="2">
 <form name="formSindical" method=post action="listado_horas.jsp">
   <tr bgcolor="#CCFFCC"> 
       <td colspan="5" align="center"><b> Horas Sindicales informe a Excel </b></td>
       
   </tr>
  <tr > 
       <td colspan="5" align="center">Seleccione Año:
        <select name="ID_AÑO">
                                              <option value="2018">2018</option>
                                              <option value="2017">2017</option>
                                              <option value="2016">2016</option>
                                              <option value="2015">2015</option>
                                              <option value="2014">2014</option>
                                              <option value="2013">2013</option>
                                              <option value="2021">2012</option>                                              
                                            </select>
                                            
   </tr>
    <tr > 
       <td colspan="5" align="center"> <input type="submit" value="Generar Informe" name="submit"></td>
   </tr>
   </form>
  
</table>
</div>
</body>
</html>

