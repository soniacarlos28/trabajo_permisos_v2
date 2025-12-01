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
String P_C_OPERA = "0";
if(request.getParameter("P_C_OPERA") != null){ P_C_OPERA = (String)request.getParameter("P_C_OPERA");}
%>

<%
String P_C_FIRMA = "0";
if(request.getParameter("C_FIRMA") != null){ P_C_FIRMA = (String)request.getParameter("C_FIRMA");}
%>

<%
String P_ID_FUNCIONARIO = "000000";
if(request.getParameter("ID_FUNCIONARIO") != null){  P_ID_FUNCIONARIO = (String)request.getParameter("ID_FUNCIONARIO");}
%>

<%
String P_ID_FUNCIONARIO_FIRMA = "000000";
if(request.getParameter("ID_FUNCIONARIO_FIRMA") != null){ P_ID_FUNCIONARIO_FIRMA = (String)request.getParameter("ID_FUNCIONARIO_FIRMA");}
%>

<%
Driver DriverRS1 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS1 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS1 = ConnRS1.prepareStatement("select p.id_funcionario as ID_FUNCIONARIO,nombre,ape1,ape2,departamento from funcionario_firma f,personal_new p, apliweb_usuario u where ( (  id_js='" + P_ID_FUNCIONARIO_FIRMA + "'  and '" + P_C_FIRMA + "'='1' ) OR(  id_delegado_js='" + P_ID_FUNCIONARIO_FIRMA + "'  and '" + P_C_FIRMA + "'='2' ) OR (  id_ja='" + P_ID_FUNCIONARIO_FIRMA + "'  and '" + P_C_FIRMA + "'='3' ) OR (  id_ver_plani_1='" + P_ID_FUNCIONARIO_FIRMA + "'  and '" + P_C_FIRMA + "'='4' ) OR (  id_ver_plani_2='" + P_ID_FUNCIONARIO_FIRMA + "'  and '" + P_C_FIRMA + "'='5' ) OR(  id_ver_plani_3='" + P_ID_FUNCIONARIO_FIRMA + "'  and '" + P_C_FIRMA + "'='6' ) ) and f.id_funcionario=p.id_funcionario and (p.fecha_baja is null or p.fecha_baja> sysdate) and u.id_funcionario=p.id_funcionario and f.id_funcionario=u.id_funcionario order by departamento, p.ape1,p.ape2");
ResultSet RS1 = StatementRS1.executeQuery();
boolean RS1_isEmpty = !RS1.next();
boolean RS1_hasData = !RS1_isEmpty;
Object RS1_data;
int RS1_numRows = 0;
%>

<%
Driver DriverRS2 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS2 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS2 = ConnRS2.prepareStatement("select p.id_funcionario as ID_FUNCIONARIO,p.nombre,p.ape1,p.ape2,u.departamento from funcionario_firma f,personal_new p, apliweb_usuario u where  rownum < 150 and (  p.id_funcionario='" + P_ID_FUNCIONARIO + "'  ) and f.id_funcionario=p.id_funcionario and (p.fecha_baja is null or p.fecha_baja> sysdate) and u.id_funcionario=p.id_funcionario order by u.departamento, p.ape1,p.ape2");
ResultSet RS2 = StatementRS2.executeQuery();
boolean RS2_isEmpty = !RS2.next();
boolean RS2_hasData = !RS2_isEmpty;
Object RS2_data;
int RS2_numRows = 0;
%>

<%
Driver DriverRS3 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS3 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS3 = ConnRS3.prepareStatement("select p.id_funcionario,p.nombre,p.ape1,p.ape2,departamento from funcionario_firma f,personal_new p, apliweb_usuario u where                        f.id_funcionario= '" + P_ID_FUNCIONARIO_FIRMA + "' and  f.id_funcionario=p.id_funcionario and                      (p.fecha_baja is null or p.fecha_baja> sysdate) and                        u.id_funcionario=p.id_funcionario                   order by departamento, p.ape1,p.ape2");
ResultSet RS3 = StatementRS3.executeQuery();
boolean RS3_isEmpty = !RS3.next();
boolean RS3_hasData = !RS3_isEmpty;
Object RS3_data;
int RS3_numRows = 0;
%>

<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RS1_numRows += Repeat1__numRows;
%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RS2_numRows += Repeat2__numRows;
%>
<%
int Repeat3__numRows = -1;
int Repeat3__index = 0;
RS3_numRows += Repeat3__numRows;
%>
<%
String thisPage = request.getRequestURI();
%>
<script language="Javascript">
function mostrarOcultar() 
{ 
   document.getElementById('UNO').style.display=''; 
   document.getElementById('TODOS').style.display='none'; 
   
   if (document.form1.TIPO.value== "1") 
   {
	    document.getElementById('UNO').style.display='none'; 
      	document.getElementById('TODOS').style.display=''; 
	
    }
} 
function carga_final(){

	   document.getElementById('UNO').style.display=''; 
	   document.getElementById('TODOS').style.display='none';
	   document.getElementById('DELEGA').style.display='none';  
	   document.getElementById('DELEGA2').style.display='none';  
	   if (document.form1.P_C_FIRMA_D.value == "2") 
	   {
	      	document.getElementById('DELEGA').style.display='';	
	      	document.getElementById('DELEGA2').style.display='';	
	    }
	
}

function validaVacio(valor) {
    valor = valor.replace("&nbsp;", "");
    valor = valor == undefined ? "" : valor;
    if (!valor || 0 === valor.trim().length) {
        return true;
        }
    else {
        return false;
        }
    }

function validarfor(){


var coment = document.getElementsByName("ID_JS_NOMBRE")[0].value;



if (validaVacio(coment.value)) {  //COMPRUEBA CAMPOS VACIOS
    alert("Busque persona para cambiar firma");
    return false;
}
return true;
}

function envia_unavez()
{
	var n=0;
	 miCampoTexto = document.getElementById("ID_JS").value;
	
	//la condición
    if (miCampoTexto.length == 0) {
    	alert("Campo CAMBIO POR esta vacío");
        return false;
    }
	
     
    
	       
	   if (document.form1.Guardar.disabled==false ) 
	      {
		   document.form1.Guardar.disabled=true;
		   document.form1.submit();
	     } 	
	
}
</script>

<html>
<head>
<title>Gesti&oacute;n de RRHH - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body OnLoad="carga_final()">
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
  <li><a href="gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
  </ul>
</div>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas" id="current">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
	</div>
	<div id="subform">
	<form name="form1" method="POST" action="cambia_firma_result.jsp">
	<table width="50%"  cellpadding="2" cellspacing="1" border="0" width="100%">
                          <tr bgcolor="#f2f2f2">
                                             <tr bgcolor="#f2f2f2">
        <th align="center" colspan=6>
         <% if (P_C_OPERA.equals("1") )    {  %>
            Inserta Firma para
         <% } if (P_C_OPERA.equals("8") )    {  %>
            Cambio de Firma para
         <% } %>
        <% if (P_C_FIRMA.equals("1") )    {  %>
           JEFE DE SERVICIO
        <%  } if (P_C_FIRMA.equals("2") )  {     %>
           SUPLENTE JEFE DE SERVICIO
        <% } if (P_C_FIRMA.equals("3") )    {  %>
              JEFE DE AREA
        <% } if (P_C_FIRMA.equals("4") )   {  %>
            Permiso para ver PLANIFICADOR Persona 1 
        <% } if (P_C_FIRMA.equals("5") )  {   %>
          Permiso para ver PLANIFICADOR Persona 2
        <% } if (P_C_FIRMA.equals("6")  ) {     %>
           Permiso para ver PLANIFICADOR Persona 3
         <% } %>
        </th>
      </tr> 
                           <tr>
        <th align="right"  width="10%">Tipo</th>
        <td><select name="TIPO" size="1" id="TIPO"   onChange="mostrarOcultar(this)">
            <option value="0"  selected>Indivual solo para este usuario</option>
           <% if (P_C_OPERA.equals("8") )    {  %> 
            <option value="1">Masiva para todas las personas que firma </option>
            <% } %>
        </select></td>
      </tr>
     <% if (P_C_OPERA.equals("8") )    {  %> 
      <tr>
        <th align="right">Cambiar a:</th>
        <td width="40%"><% if (RS3_hasData) 
	  { %>
		  <%=(((RS3_data = RS3.getObject("ID_FUNCIONARIO"))==null || RS3.wasNull())?"":RS3_data)%>  --
		  <%=(((RS3_data = RS3.getObject("NOMBRE"))==null || RS3.wasNull())?"":RS3_data)%> --
		  <%=(((RS3_data = RS3.getObject("APE1"))==null || RS3.wasNull())?"":RS3_data)%> --
		  <%=(((RS3_data = RS3.getObject("APE2"))==null || RS3.wasNull())?"":RS3_data)%>		  			
	   <% } %>  </td>
      </tr>
     <% } %>
      <tr>
        <th align="right">Por:</th>
        <td>
          <input type="text" disabled="yes" ID="ID_JS_ID" size="8"   value="" >
      <input type="text" " ID="ID_JS_NOMBRE" disabled="yes" size="35"   value="" >
      <input type="hidden" name="ID_JS" ID="ID_JS" size="25" value=""><input type="button" name="" value="Buscar"
      onClick="javascript:window.open('../Busqueda/index_busqueda_funcionario.jsp?CAMPO=ID_JS' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');"      >
      </td>
       <td ID="DELEGA">
        DELEGACIÓN:
            <select name="ID_DELEGADO_FIRMA" size="1" id="ID_DELEGADO_FIRMA" >
		        <option value="0"  selected>NO</option>
		        <option value="1" >SI</option>
		    </select>           
        </td>
      </tr>
      <tr ID="DELEGA2">
    <td  colspan="3" bgcolor="#CCCCFF" scope="col"><div align="center">Los Suplentes con Delegación pueden autorizar permisos, aunque el Jefe no este de vacaciones o baja.</div></td>
    </tr> 
   </p>
     <% if (P_C_OPERA.equals("8") )    {  %> 
    <tr>
      <td align="center"  colspan=5  bgcolor="#ffffff" ><input type="button" value="Aplicar cambio de Firma" name="Guardar" onClick="javascript:envia_unavez();"> </tr>
    <tr>
      <% } if (P_C_OPERA.equals("1") )    {  %> 
   <tr>
      <td align="center"  colspan=5  bgcolor="#ffffff" ><input type="button" value="Insertar Firma" name="Guardar" onClick="javascript:envia_unavez();"> </tr>
    <tr>
      <% } %>
<td colspan=6>

	<table id="UNO">
		
		<tr>
		  <th width="10%">Funcionario</th>
		  <th width="15%" bordercolor="#e0e8ef">Nombre</th>
		  <th width="15%">Ape1</th>
		  <th width="25%">Ape2</th>
		  <th width="25%">Departamento</th>    
		</tr>
	  <% while ((RS2_hasData)&&(Repeat2__numRows-- != 0) ) 
	  { %>
		  <tr>
		  <td width="10%" align="center"><%=(((RS2_data = RS2.getObject("ID_FUNCIONARIO"))==null || RS2.wasNull())?"":RS2_data)%></td>
		  <td width="10%" align="center"><%=(((RS2_data = RS2.getObject("NOMBRE"))==null || RS2.wasNull())?"":RS2_data)%></td>
		  <td width="10%" align="center"><%=(((RS2_data = RS2.getObject("APE1"))==null || RS2.wasNull())?"":RS2_data)%></td>
		  <td width="10%" align="center"><%=(((RS2_data = RS2.getObject("APE2"))==null || RS2.wasNull())?"":RS2_data)%></td>      
		  <td width="10%" align="center"><%=(((RS2_data = RS2.getObject("DEPARTAMENTO"))==null || RS2.wasNull())?"":RS2_data)%></td>
		</tr>
		  <%
	  Repeat2__index++;
	  RS2_hasData = RS2.next();
	   }
	   %>
	    <tr>
		  <th align="center" colspan=6>Personas afectadas por el cambio: <%= Repeat2__index%> </th>
		</tr>
	 </table>
	 <table id="TODOS">
		 
		<tr>
		  <th width="10%">Funcionario</th>
		  <th width="15%" bordercolor="#e0e8ef">Nombre</th>
		  <th width="15%">Ape1</th>
		  <th width="25%">Ape2</th>
		  <th width="25%">Departamento</th>    
		</tr>
	  <% while ((RS1_hasData)&&(Repeat1__numRows-- != 0)) 
	  { %>
		  <tr>
		  <td width="10%" align="center"><%=(((RS1_data = RS1.getObject("ID_FUNCIONARIO"))==null || RS1.wasNull())?"":RS1_data)%></td>
		  <td width="10%" align="center"><%=(((RS1_data = RS1.getObject("NOMBRE"))==null || RS1.wasNull())?"":RS1_data)%></td>
		  <td width="10%" align="center"><%=(((RS1_data = RS1.getObject("APE1"))==null || RS1.wasNull())?"":RS1_data)%></td>
		  <td width="10%" align="center"><%=(((RS1_data = RS1.getObject("APE2"))==null || RS1.wasNull())?"":RS1_data)%></td>      
		  <td width="10%" align="center"><%=(((RS1_data = RS1.getObject("DEPARTAMENTO"))==null || RS1.wasNull())?"":RS1_data)%></td>
		</tr>
		  <%
	  Repeat1__index++;
	  RS1_hasData = RS1.next();
	   }
	   %>
	   <tr>
		  <th align="center" colspan=6>Personas afectadas por el cambio: <%= Repeat1__index%> </th>
		    
      <input type="hidden" NAME="P_C_FIRMA_D" ID="P_C_FIRMA_D"       value="<%=  P_C_FIRMA %>" >   
      <input type="hidden" NAME="P_ID_FUNCIONARIO_C" ID="P_ID_FUNCIONARIO_C"   value="<%=  P_ID_FUNCIONARIO %>" >  
      <input type="hidden" NAME="P_ID_FUNCIONARIO_FIRMA" ID="P_ID_FUNCIONARIO_FIRMA"    value="<%=  P_ID_FUNCIONARIO_FIRMA %>" >  
      
		</tr>
	 </table>
  </td>
</tr>	 
      
                      </table>
	</form>
	</div>
	</div>
  