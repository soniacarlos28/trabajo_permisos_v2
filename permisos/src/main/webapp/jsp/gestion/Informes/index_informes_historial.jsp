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

String RSQUERY__MMColParam1 = null;
if(request.getParameter("ID_INFORME") != null){ RSQUERY__MMColParam1 = (String)request.getParameter("ID_INFORME");}

%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("select distinct fc.id_ejecucion,                t.id_secuencia_informe as ID_INFORME,                fc.ID_TIPO_INFORME,                to_char(t.audit_FECHA, 'dd/mm/yyyy') as Fecha,                Titulo as nombre,                to_char(fecha_ejecucion, 'dd/mm/yyyy hh24:mi') as FECHA_ULT_EJECU,                fecha_ult_ejec as FECHA_u,                FILTRO_1_TXT,                FILTRO_2_TXT,                fecha_ejecucion  from FICHAJE_INFORME t,fichaje_tr_tipo_informe TI,FICHAJE_INFORME_campo fc where t.id_ejecucion(+) = fc.id_ejecucion      and TI.id_tipo_informe= fc.id_tipo_informe      and fc.id_secuencia_informe = '"+ RSQUERY__MMColParam1 +"' order by fecha_ejecucion desc");
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
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSQUERY_numRows += Repeat1__numRows;
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
function show_finger()
{
 	var URL = "vista_fichajes.jsp";
	var WNAME = "FICHAJES";
	var windowW = 830;
	var windowH = 700;
	var windowX = Math.ceil( (window.screen.width  - windowW) / 2 );
	var windowY = Math.ceil( (window.screen.height - windowH) / 2 );
	DIMENSION=",width="+windowW+",height="+windowH;

	splashWin = window.open( URL , WNAME, "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0"+DIMENSION);
	//splashWin.opener = self;
	splashWin.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
	splashWin.focus();
}
function nuevo_informe()
{
 	var URL = "generar_informes.jsp";
	var WNAME = "INFORMES";
	var windowW = 730;
	var windowH = 300;
	var windowX = Math.ceil( (window.screen.width  - windowW) / 2 );
	var windowY = Math.ceil( (window.screen.height - windowH) / 2 );
	DIMENSION=",width="+windowW+",height="+windowH;

	splashWin = window.open( URL , WNAME, "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0"+DIMENSION);
	//splashWin.opener = self;
	splashWin.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
	splashWin.focus();
}
function show_confirm(id, description, url)
{
   var text = "¿Realmente desea eliminar: '" + description + "'?";
   var r = confirm(text);
   if (r==true) { 
      MM_goToURL('self',url + id);
   }
   else { 
      alert("Operación cancelada!"); 
   }
}
</script>
<script language="Javascript" >
function show_calendario()
{
 	var URL = "calendario.jsp?PERIODO=" + document.getElementById("PERIODO").value ;
	var WNAME = "Calendario";
	var windowW = 230;
	var windowH = 400;
	var windowX = Math.ceil( (window.screen.width  - windowW) / 2 );
	var windowY = Math.ceil( (window.screen.height - windowH) / 2 );
	DIMENSION=",width="+windowW+",height="+windowH;

	splashWin = window.open( URL , WNAME, "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0"+DIMENSION);
	//splashWin.opener = self;
	splashWin.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
	splashWin.focus();
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
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b" id="current">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" >Proceso Bolsa</a></li>   
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
   <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
   <li ><a href="../../gestion/Informes/index_informes.jsp" id="current" >Informes</a></li>
    </ul>
  </div>
  <div id="form">
<div>
	 <ul id="subtabh">
		<li id="active"><a href="../Finger_apl/index.jsp" >Incidencias diarias</a></li>	
		<li id="active"><a href="" onClick="show_finger()">Fichajes on line</a></li>
		<li id="active"><a href="../Finger_apl/chequea_relojes.jsp" >Chequeo de Relojes</a></li>	
		<li id="active"><a href="../Finger_apl/index_calendario.jsp" >Calendarios</a></li>
	   					
	  </ul>
  </div> 
<table width="95%" border="0" cellspacing="0" cellpadding="2">

                          <tr> 
                            <td> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#f2f2f2"> 
                  <table width="100%" border="0" cellspacing="1" cellpadding="2">
                    <tr bgcolor="#CCCCCC"> 
                      <td class="va10b" align="center" width="5%">Fecha</td>                     
                      <td class="va10b" width="30%">Nombre--HISTORIAL</td>
                        <td class="va10b" align="center" width="5%">Seleccion Personal</td>
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="15%">Seleccion Fechas</td>
                        <td class="va10b" bgcolor="#CCCCCC" align="center" width="15%">Fecha Ultima Ejecución</td>
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="5%">Acciones</td>
                      <td class="va10b" bgcolor="#f2f2f2" width="2%" align="center"> 
                      </td>
                    </tr>
                    <% while ((RSQUERY_hasData)&&(Repeat1__numRows-- != 0)) { %>
                     <% if (Repeat1__index%2 == 0) 
                                 { 
                                 	 RSCOLOR="bgcolor=\"#FAD2D2\"";
                                 }        
    				               else {	                   
                                          RSCOLOR="";
                                   } 
                      RSCOLOR="";
							  	 %> 
                                        
                    <tr bgcolor="#FFFFFF"> 
                     <td <%= RSCOLOR %> width="5%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                       
                     <td <%= RSCOLOR %> width="30%"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                     
                     <td <%= RSCOLOR %> align="center" width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("FILTRO_1_TXT"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                       <td <%= RSCOLOR %> align="center" width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("FILTRO_2_TXT"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                    <td <%= RSCOLOR %> align="center" width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_ULT_EJECU"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                  
                      <td <%= RSCOLOR %> nowrap align="center" width="5%">
                       <a href='informe_tipo_<%= (((RSQUERY_data = RSQUERY.getObject("ID_TIPO_INFORME"))==null || RSQUERY.wasNull())?"":RSQUERY_data)  %>_excel.jsp?ID_EXCEL=0&ID_EJECUCION=<%= (((RSQUERY_data = RSQUERY.getObject("ID_EJECUCION"))==null || RSQUERY.wasNull())?"":RSQUERY_data)  %>' target="_blank" >
                       <img	src="../../imagen/ver.gif" alt="Ver Informe" width="20" height="20" border="0"></a>
                       <a href='informe_tipo_<%= (((RSQUERY_data = RSQUERY.getObject("ID_TIPO_INFORME"))==null || RSQUERY.wasNull())?"":RSQUERY_data)  %>_excel.jsp?ID_EXCEL=1&ID_EJECUCION=<%= (((RSQUERY_data = RSQUERY.getObject("ID_EJECUCION"))==null || RSQUERY.wasNull())?"":RSQUERY_data)  %>' >
                       <img	src="../../imagen/excel.jpg" alt="Excel" width="20" height="20" border="0"></a>                      
                      <a href="javascript:show_confirm('<%=(((RSQUERY_data = RSQUERY.getObject("ID_INFORME")) == null || RSQUERY
							.wasNull()) ? "" : RSQUERY_data)%>','<%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE")) == null || RSQUERY
							.wasNull()) ? "" : RSQUERY_data)%>','eliminar_informes.jsp?ID_INFORME=')"><img	src="../../imagen/eliminar.gif" alt="Eliminar" width="20" height="20" border="0">							
                      </a>
                     
                     
                     </td>
                      
                    </tr>
                    <%
  Repeat1__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                  </table>
                </td>
              </tr>
            </table>    
                              </td>
                          </tr>
                        </table>
                     
	

</body>
</html>


