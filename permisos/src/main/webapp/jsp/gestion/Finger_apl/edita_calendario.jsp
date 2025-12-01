<%@page language="java" import="java.util.Date,java.sql.*" %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<% String RSIMPAR="";
   String RSCOLOR="";
   String RSCALEN="";
   String RSCALEN_A="";
   String RSDIA="0";
%>
<%
String RSCALENDARIO__MMColParam1 = "0";
if (request.getParameter("ID_CALENDARIO")  !=null) {RSCALENDARIO__MMColParam1 = (String)request.getParameter("ID_CALENDARIO") ;}
%>
<%
Driver DriverRSCALENDARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCALENDARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCALENDARIO = ConnRSCALENDARIO.prepareStatement("select  t.id_calendario,        dia, DECODE(dia, 2,'Lunes', 3,'Martes', 4,'Miercoles', 5,'Jueves', 6,'Viernes',  7,'Sabado',  8,'Domingo') as  dia_semana,        to_char(horas_teoricas,'hh24:mi') as  horas_teoricas,        to_char(p1_obl_desde,'hh24:mi') as p1_obl_desde,        to_char(p1_obl_hasta,'hh24:mi') as p1_obl_hasta,        to_char(p1_fle_desde,'hh24:mi') as p1_fle_desde,        to_char(p1_fle_hasta,'hh24:mi') as p1_fle_hasta,        to_char(p2_obl_desde,'hh24:mi') as p2_obl_desde,        to_char(p2_obl_hasta,'hh24:mi') as p2_obl_hasta,        to_char(p2_fle_desde,'hh24:mi') as p2_fle_desde,        to_char(p2_fle_hasta,'hh24:mi') as p2_fle_hasta,        to_char(p3_obl_desde,'hh24:mi') as p3_obl_desde,        to_char(p3_obl_hasta,'hh24:mi') as p3_obl_hasta,        to_char(p3_fle_desde,'hh24:mi') as p3_fle_desde,        to_char(p3_fle_hasta,'hh24:mi') as p3_fle_hasta,        turno,        horas_semanales,        DESC_CALENDARIO,       to_char(t.fecha_inicio,'dd/mm/yyyy') as fecha_inicio, to_char(t.fecha_fin,'dd/mm/yyyy') as fecha_fin         from FICHAJE_CALENDARIO_JORNADA t,FICHAJE_CALENDARIO  FC where t.id_calendario= '" + RSCALENDARIO__MMColParam1 + "'         and t.fecha_fin is  null          and fc.fecha_fin is  null          and t.id_calendario=fc.id_calendario                  order by dia");
ResultSet RSCALENDARIO = StatementRSCALENDARIO.executeQuery();
boolean RSCALENDARIO_isEmpty = !RSCALENDARIO.next();
boolean RSCALENDARIO_hasData = !RSCALENDARIO_isEmpty;
Object RSCALENDARIO_data;
int RSCALENDARIO_numRows = 0;
%> 
<%
int Repeat1__numRows = 100;
int Repeat1__index = 0;
RSCALENDARIO_numRows += Repeat1__numRows;
%>
<%
String RSCALENDARIO_HIST__MMColParam1 = "0";
if (request.getParameter("ID_CALENDARIO")  !=null) {RSCALENDARIO__MMColParam1 = (String)request.getParameter("ID_CALENDARIO") ;}
%>
<%
Driver DriverRSCALENDARIO_HIST = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCALENDARIO_HIST = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCALENDARIO_HIST = ConnRSCALENDARIO_HIST.prepareStatement("select distinct  to_char(t.id_calendario)  || to_char(t.FECHA_INICIO,'DDmmyyyy') as ID_CALEN,to_char(t.id_calendario) as  ID_CALENDARIO,       dia,to_char(dia) as  dia_texto,       DECODE(dia,              2,              'Lunes',              3,              'Martes',              4,              'Miercoles',              5,              'Jueves',              6,              'Viernes',              7,              'Sabado',              8,              'Domingo') as dia_semana,       to_char(horas_teoricas, 'hh24:mi') as horas_teoricas,       to_char(p1_obl_desde, 'hh24:mi') as p1_obl_desde,       to_char(p1_obl_hasta, 'hh24:mi') as p1_obl_hasta,       to_char(p1_fle_desde, 'hh24:mi') as p1_fle_desde,       to_char(p1_fle_hasta, 'hh24:mi') as p1_fle_hasta,       to_char(p2_obl_desde, 'hh24:mi') as p2_obl_desde,       to_char(p2_obl_hasta, 'hh24:mi') as p2_obl_hasta,       to_char(p2_fle_desde, 'hh24:mi') as p2_fle_desde,       to_char(p2_fle_hasta, 'hh24:mi') as p2_fle_hasta,       to_char(p3_obl_desde, 'hh24:mi') as p3_obl_desde,       to_char(p3_obl_hasta, 'hh24:mi') as p3_obl_hasta,       to_char(p3_fle_desde, 'hh24:mi') as p3_fle_desde,       to_char(p3_fle_hasta, 'hh24:mi') as p3_fle_hasta,       turno,       horas_semanales,       DESC_CALENDARIO,       to_char(t.fecha_inicio,'dd/mm/yyyy') as fecha_inicio, t.fecha_inicio as fecha_inicio_ord,     to_char( t.fecha_fin,'dd/mm/yyyy') as fecha_fin  from FICHAJE_CALENDARIO_JORNADA t, FICHAJE_CALENDARIO FC where t.id_calendario= '" + RSCALENDARIO__MMColParam1 + "' and  fc.id_calendario<>0   and t.id_calendario = fc.id_calendario order by FECHA_INICIO_ORD desc,dia");
ResultSet RSCALENDARIO_HIST = StatementRSCALENDARIO_HIST.executeQuery();
boolean RSCALENDARIO_HIST_isEmpty = !RSCALENDARIO_HIST.next();
boolean RSCALENDARIO_HIST_hasData = !RSCALENDARIO_HIST_isEmpty;
Object RSCALENDARIO_HIST_data;
int RSCALENDARIO_HIST_numRows = 0;
%> 

<%
int Repeat2__numRows = 100;
int Repeat2__index = 0;
RSCALENDARIO_HIST_numRows += Repeat1__numRows;
%>

<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<script type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->

</script>
<script language="Javascript" >
function Valida(campo,dia) {

	  
	 str=campo.value;
	
if ((str.length > 0) ) 	
 {	
      str=campo.value;
	  pos = str.indexOf(":");
	  
	  Horas = str.substring(0,pos);
	  Minutos=str.substring(pos+1,str.length);
	  
              
  if (isNaN(parseInt(Horas))) 
	  {
      alert('Dia ' + dia + '\nEl campo: '+ campo.id + ' valor: ' + campo.value + '\nDebe ser HORAS. Ejemplo 08:00' );
      campo.focus();
      return false;
      }  
    
    
  if (isNaN(parseInt(Minutos))) 
	  {
	   alert('Dia ' + dia + '\nEl campo: '+ campo.id + ' valor: ' + campo.value +  '\nDebe ser HORAS. Ejemplo 08:00' );
	   campo.focus();
      return false;
      }  

  
 if  ( Horas > 23   || Horas < 0)
      {
	   alert('Dia ' + dia + '\nEl campo: '+ campo.id + ' valor: ' + campo.value +    '\nHoras debe estar entre  0 y 23.' );
	   campo.focus();
      return false;
      }  
      
  if  ( Minutos > 59   || Minutos < 0)
      {
	  alert('Dia ' + dia + '\nEl campo: '+ campo.id + ' valor: ' + campo.value +   '\nMinutos debe estar entre  0 y 59.' );
	  campo.focus(); 
      return false;
      }       
 }
   
   return true; 
     
}
function envia_unavez()
{
 
     for (x = 0; x <= 6 ; x++)
	    {
	          switch (x) 
			  {
               case 0:
                 day = "Lunes"; 
                 break;
               case 1:
                 day = "Martes";        
                 break;
               case 2:
                 day = "Miercoles";        
                 break;
               case 3:
                 day = "Jueves";       
                 break;
               case 4:
                 day = "Viernes";        
                 break;
               case 5:
                 day = "Sabado";               
                 break;
               case 6:
                 day = "Domingo";
                 break;
               }
              
		        
               for (y = 1; y <= 3 ; y++)	  
                {
                     if (!Valida(document.getElementById('P'+ y + '_OBL_DESDE_'+x),day))	
			          {
		              return;
                      }
					  
					 if (!Valida(document.getElementById('P'+ y + '_OBL_HASTA_'+x),day))	
			          {
		              return;
                      }
					  
					 if (!Valida(document.getElementById('P'+ y + '_FLE_DESDE_'+x),day))	
			          {
		              return;
                      } 
					 
                     if (!Valida(document.getElementById('P'+ y + '_FLE_HASTA_'+x),day))	
			          {
		              return;
                      }					 
						 	  					  					 
                    document.FINGER.TODO_T.value = document.FINGER.TODO_T.value +					
						x + "P"+ y + "OMD" + document.getElementById('P'+ y + '_OBL_DESDE_'+x).value +  ";" +
						x + "P"+ y + "OMH" + document.getElementById('P'+ y + '_OBL_HASTA_'+x).value +  ";" +
						x + "P"+ y + "FMD" + document.getElementById('P'+ y + '_FLE_DESDE_'+x).value +  ";" +
						x + "P"+ y + "FMH" + document.getElementById('P'+ y + '_FLE_HASTA_'+x).value +  ";" + "";
				}	
				    document.FINGER.TODO_T.value = document.FINGER.TODO_T.value +	
						x + "HORAS" + document.getElementById('HORAS_' +x).value +  ";" +  "";
	  } 
 
    if (document.FINGER.Guardar.disabled==false) 
        {
             document.FINGER.Guardar.disabled=true;
             document.FINGER.submit();
	    }		 
  }
  
function ver(capa)
{        
	
	eval(capa).style.display='';   

	eval('V' +capa).style.display='none';
	eval('O' +capa).style.display='';
}
function ocultar(capa)
{        
	
	eval(capa).style.display='none';
	eval('V' +capa).style.display='';
	eval('O' +capa).style.display='none';   
  
}
</script>
<style type="text/css">
<!--
.Estilo1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<div id="apliweb-tabform">

<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
       
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b" id="current">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" >Proceso Bolsa</a></li>   
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
   <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
   <li ><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
    </ul>
  </div>
  <div id="form">
<div>
	 <ul id="subtabh">
		<li id="active"><a href="../Finger_apl/index.jsp" >Incidencias diarias</a></li>	
		<li id="active"><a href="" onClick="show_finger()">Fichajes on line</a></li>
		<li id="active"><a href="../Finger_apl/chequea_relojes.jsp" >Chequeo de Relojes</a></li>	
		<li id="active"><a href="../Finger_apl/index_calendario.jsp" id="current">Calendarios</a></li>
	    				
	  </ul>
  </div> 
  
                                  
			<table width="95%"  border="1" cellspacing="1" cellpadding="4">
			 <form name="FINGER" method="POST" action="edita_result.jsp">
								<tr align="center"><td colspan=2><table width="100%" border="0" cellspacing="1" cellpadding="4">
								<tr bgcolor="#CCFFCC"> 
                                        <td colspan="16" align="center"><b>Editando Calendario de Horarios Actual</td>
                                      </tr>								     
                                      <tr bgcolor="#fffcf"> 
                                        <td colspan="4"><div align="center">
                                          <p><b>Calendario</b>:<b> <input type="text" name="NOMBRE_CALENDARIO" id="NOMBRE_CALENDARIO" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("DESC_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="55" maxlength="45"></b></p>
                                          <input type="hidden"  name="ID_CALENDARIO" id="ID_CALENDARIO" value="<%= RSCALENDARIO__MMColParam1%>" size="15" maxlength="15">
                                          </div></td>
                                          <td nowrap >Fecha Inicio
              <table border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                       <td> 
                           <input type="text" name="FECHA_INICIO" 
											      <%  if (!RSCALENDARIO_isEmpty ) {%>  value="<%= (((RSCALENDARIO_data = RSCALENDARIO.getObject("FECHA_INICIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)  %>" 
												  <% } %>
					     			  size="12" maxlength="12" onchange="javascript:cambio_jornada();" style=" height : 18px;">                                           
                       </td>
                       <td><a href="javascript:show_Calendario('FINGER.FECHA_INICIO');javascript:cambio_jornada();"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                    </tr>
              </table>
         </td>
         <td nowrap >Fecha Fin
                <table border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                         <td>                                             
                             <input type="text" name="FECHA_FIN" 
											    <%  if (!RSCALENDARIO_isEmpty ) {%>       value="<%= (((RSCALENDARIO_data = RSCALENDARIO.getObject("FECHA_FIN"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)  %>" 
												 <% } %>
												size="12" maxlength="12" onchange="javascript:cambio_jornada();">                                              
                         </td>
                         <td><a href="javascript:show_Calendario('FINGER.FECHA_FIN');javascript:cambio_jornada();"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                       </tr>
                 </table>                                        
          </td>             
 <td colspan="8"><div align="center">
                                          <p><b>Horas Semanales</b>:<b> <input type="text"  name="HORAS_SEMANALES" id="HORAS_SEMANALES" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("HORAS_SEMANALES"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5"></b></p>
                                          </div></td>
                                      </tr>                                      
                                       <tr> 
                                        <td width="10%" align="center"><span class="va10b">Turno</span>    
                                        <select name="TURNO" id="TURNO">
        <option value="NO" <%=(("NO".toString().equals((((RSCALENDARIO_data = RSCALENDARIO.getObject("TURNO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)))?"selected=\"selected\"":"")%>>NO</option>
        <option value="SI" <%=(("SI".toString().equals((((RSCALENDARIO_data = RSCALENDARIO.getObject("TURNO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)))?"selected=\"selected\"":"")%>>SI</option>
      </select></td>
                                        <td width="30%" colspan=4 bgcolor="#E5E7E9" align="center">Mañana</td>
                                        <td width="30%" colspan=4 bgcolor="#D7DBDD" align="center">Tarde</td>
                                        <td width="30%" colspan=4 bgcolor="#C7DBDD" align="center">Noche</td>
                                        <td width="30%" colspan=2  align="center"></td>
                                        
                                      </tr>
                                      <tr> 
                                        <td   width="10%" bgcolor="#CCCCCC" align="center">Día<span class="va10b"></span></td>
                                        <td width="15%" colspan=2 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="15%" colspan=2 bgcolor="#F2F3F4" align="center">Flexible</td>
                                        <td width="15%" colspan=2 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="15%" colspan=2 bgcolor="#F2F3F4" align="center">Flexible</td>    
                                         <td width="15%" colspan=2 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="15%" colspan=2 bgcolor="#F2F3F4" align="center">Flexible</td>                                          
                                        <td width="20%" colspan=1 bgcolor="#CCCCCC" align="center">Horas Jornada</td>
                                         
                                     
                                      </tr>
                                      
                                       <% while ((RSCALENDARIO_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                           
                                            
                                         <tr> 
                                          <td  width="10%"  align="center"><span class="va10b"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("DIA_SEMANA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></span></td>
                                          <td nowrap width="15%" colspan=2  align="center"> 
                                           <input type="text"  id="P1_OBL_DESDE_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5"> - 
                                           <input type="text"  id="P1_OBL_HASTA_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5">
                                         </td>
                                         <td nowrap width="15%" colspan=2  align="center">
                                           <input type="text"  id="P1_FLE_DESDE_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5"> - 
                                           <input type="text"  id="P1_FLE_HASTA_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5">                             
                                        </td>
                                        <td nowrap width="15%" colspan=2  align="center"> 
                                           <input type="text"  id="P2_OBL_DESDE_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5"> - 
                                           <input type="text"  id="P2_OBL_HASTA_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5">
                                        </td>
                                        <td nowrap width="15%" colspan=2  align="center">
                                          <input type="text"  id="P2_FLE_DESDE_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5"> - 
                                          <input type="text"  id="P2_FLE_HASTA_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5">                             
                                        </td>                                    
                                         <td nowrap width="15%" colspan=2  align="center"> 
                                           <input type="text"  id="P3_OBL_DESDE_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5"> - 
                                           <input type="text"  id="P3_OBL_HASTA_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5">
                                        </td>
                                        <td nowrap width="15%" colspan=2  align="center">
                                          <input type="text"  id="P3_FLE_DESDE_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5"> - 
                                          <input type="text"  id="P3_FLE_HASTA_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5">                             
                                        </td>    
                                         <td nowrap width="15%" colspan=2  align="center">
                                          <input type="text"  id="HORAS_<%= Repeat1__index %>" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("HORAS_TEORICAS"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>" size="5" maxlength="5">                                                                        
                                        </td>     
                                      </tr>
                                      
                                      <% 
                                            Repeat1__index++;
                                            RSCALENDARIO_hasData = RSCALENDARIO.next();
                                        }
                                       %>
                                      

                                 
                                       <tr bgcolor="#FFFFDD"> 
                                        <td colspan="16" bgcolor="#E5E7E9"><div align="center">
                                          <p><b> <input type="button" name="Guardar" value="Guardar Calendario" onClick="javascript:envia_unavez();">
                                            <input type="hidden" name="TODO_T" ID="TODO_T" value="" >
                                            <input type="hidden" name="ID_USUARIO" ID="ID_USUARIO" value="<%= session.getValue("MM_ID_USUARIO") %>" >
                                            
                                                </b></p>
                                          </div></td>
                                      </tr>                        
                                    </table>	</td>
								</tr>
									</form>
								</table> 
							<br>
							
		<table width="95%" border="1" cellspacing="0" cellpadding="2">
  	
<tr bgcolor="#E4EFFC"> 
                                        <td colspan="7" align="center"><b> Historial de este calendario</td>
                                      </tr>
                          <tr> 
                            <td> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#f2f2f2"> 
                  <table width="100%" border="0" cellspacing="1" cellpadding="2">
                    <tr bgcolor="#CCCCCC"> 
                      <td class="va10b" align="center" width="1%"></td>       
                      <td class="va10b" align="center" width="5%">ID</td>                     
                      <td class="va10b" width="30%">Nombre</td>
                        <td class="va10b" align="center" width="5%">Turno</td>
                         <td class="va10b" bgcolor="#CCCCCC" align="center" width="15%">Horas Semanales</td>
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="15%">Fecha Inicio</td>
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="5%">Fecha Fin</td>
                      
                      
	 
                    </tr>
                    <%         
                    RSCALEN_A="";          	  
							  	  %> 
                   <% while ((RSCALENDARIO_HIST_hasData)&&(Repeat2__numRows-- != 0)) { %>
                    <%  RSCALEN =  (String) (((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("ID_CALEN"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data);                            	   
                     if (!RSCALEN.equals(RSCALEN_A ) ) { %>
                              <tr bgcolor="#FFFFFF"> 
                                <td id="Vc<%= Repeat2__index %>"  align="center" width="5%">
                                                
                                <a href="javascript:ver('c<%= Repeat2__index %>');"><img
		          	                  src="../../imagen/ver.gif" alt="Ver calendario" width="20" height="20" border="0"></a></td>
		          	             <td id="Oc<%= Repeat2__index %>" align="center" width="5%" style="DISPLAY:none">
                                                
                                <a href="javascript:ocultar('c<%= Repeat2__index %>');"><img
		          	                  src="../../imagen/delete.png" alt="Oculatar calendario" width="20" height="20" border="0"></a></td>  
		          	                                                                                                     
        				             <td  width="5%" align="center"><%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("ID_CALENDARIO"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%></td>                                       
                    				 <td  width="30%"><%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("DESC_CALENDARIO"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%></td>                     
                                     <td  align="center" width="5%"><%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("TURNO"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%></td>
                                     <td  align="center" width="15%"><%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("HORAS_SEMANALES"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%></td>
                                     <td  Align="center" width="15%"><%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("FECHA_INICIO"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%></td>
                                     <td  align="center" width="5%"><%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("FECHA_FIN"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>                    
                              </tr> 
                           <td colspan=16 id="c<%= Repeat2__index %>" style="DISPLAY:none"> 
                           <table border=1>
                           
                                  <tr> 
                                        <td width="10%" bgcolor="#FFCCCC" align="center">Día<span class="va10b"></span></td>
                                        <td width="15%" colspan=2 bgcolor="#FFCCCC" align="center">Obligatorio Mañana</td>
                                        <td width="15%" colspan=2 bgcolor="#FFCCCC" align="center">Flexible Mañana</td>
                                        <td width="15%" colspan=2 bgcolor="#FFCCCC" align="center">Obligatorio Tarde</td>
                                        <td width="15%" colspan=2 bgcolor="#FFCCCC" align="center">Flexible Tarde</td>    
                                        <td width="15%" colspan=2 bgcolor="#FFCCCC" align="center">Obligatorio Noche</td>
                                        <td width="15%" colspan=2 bgcolor="#FFCCCC" align="center">Flexible Noche</td>                                          
                                        <td width="20%" colspan=1 bgcolor="#FFCCCC" align="center">Horas Jornada</td>                                                                              
                                      </tr>
                          
                              <tr>
                				        
                                           <td   width="10%"  align="center"><span class="va10b"><%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("DIA_SEMANA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%></span></td>
                                          <td  nowrap width="15%" align="center" colspan=2> 
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P1_OBL_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> -
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P1_OBL_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>
                                         </td>
                                         <td  nowrap width="15%"  align="center" colspan=2>
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P1_FLE_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> - 
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P1_FLE_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>                             
                                        </td>
                                        <td   nowrap width="15%"  align="center" colspan=2> 
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P2_OBL_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> -
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P2_OBL_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>
                                        </td>
                                        <td  nowrap width="15%"  align="center" colspan=2>
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P2_FLE_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> - 
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P2_FLE_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>                             
                                        </td>                                    
                                         <td nowrap width="15%"   align="center" colspan=2> 
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P3_OBL_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> - 
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P3_OBL_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>
                                        </td>
                                        <td  nowrap width="15%"  align="center" colspan=2>
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P3_FLE_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> - 
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P3_FLE_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>                             
                                        </td>    
                                         <td  nowrap width="15%"  align="center" colspan=2>
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("HORAS_TEORICAS"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>                                                                      
                                        </td>     
                                      </tr>  
                              <%  } else { %> 	                   
        
			                         <tr>
                				        
                                           <td   width="10%"  align="center"><span class="va10b"><%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("DIA_SEMANA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%></span></td>
                                          <td  nowrap width="15%" align="center" colspan=2> 
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P1_OBL_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> -
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P1_OBL_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>
                                         </td>
                                         <td  nowrap width="15%"  align="center" colspan=2>
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P1_FLE_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> - 
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P1_FLE_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>                             
                                        </td>
                                        <td   nowrap width="15%"  align="center" colspan=2> 
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P2_OBL_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> -
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P2_OBL_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>
                                        </td>
                                        <td  nowrap width="15%"  align="center" colspan=2>
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P2_FLE_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> - 
                                          <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P2_FLE_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>                             
                                        </td>                                    
                                         <td nowrap width="15%"   align="center" colspan=2> 
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P3_OBL_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> - 
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P3_OBL_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>
                                        </td>
                                        <td  nowrap width="15%"  align="center" colspan=2>
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P3_FLE_DESDE"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%> - 
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("P3_FLE_HASTA"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>                             
                                        </td>    
                                         <td  nowrap width="15%"  align="center" colspan=2>
                                           <%=(((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("HORAS_TEORICAS"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data)%>                                                                      
                                        </td>     
                                      </tr>  
                              <%  RSDIA =  (String) (((RSCALENDARIO_HIST_data = RSCALENDARIO_HIST.getObject("DIA_TEXTO"))==null || RSCALENDARIO_HIST.wasNull())?"":RSCALENDARIO_HIST_data);                             	   
                                 if (RSDIA.equals("8") )  {  %> 
                                  </table>
                                  </td>
                                    
                                     
                                            
                                 
                    <%  } }
                     RSCALEN_A=RSCALEN;
                     
                    Repeat2__index++;
                    RSCALENDARIO_HIST_hasData = RSCALENDARIO_HIST.next();
                       }
                   %>
                  </table>
                </td>
              </tr>
            </table>    
                              </td>
                          </tr>
                          	
                        </table>
                        						
	
</div>
	</div>
</body>
</html>


