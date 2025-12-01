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

%>

<%
Driver DriverRSCALENDARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCALENDARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCALENDARIO = ConnRSCALENDARIO.prepareStatement("select distinct to_char(mod(rownum, 2)) as impar,                t.id_calendario,                turno,                'Ma�ana O: '|| lpad(to_char( p1_obl_desde,'hh24:mi'),5,' ') ||' a '|| lpad( to_char(p1_obl_hasta,'hh24:mi'),5,' ') ||                '-Ma F: '|| lpad(to_char( p1_fle_desde,'hh24:mi'),5,' ') ||' a '|| lpad( to_char(p1_fle_hasta,'hh24:mi'),5,' ') ||                DECODE(p2_fle_desde,NULL,'',                                '* Tarde O: '|| lpad(to_char( p2_obl_desde,'hh24:mi'),5,' ') ||' a '|| lpad( to_char(p2_obl_hasta,'hh24:mi'),5,' ') ||                '-Ta F: '|| lpad(to_char( p2_fle_desde,'hh24:mi'),5,' ') ||' a '|| lpad( to_char(p2_fle_hasta,'hh24:mi'),5,' '))                ||                DECODE(p3_fle_desde,NULL,'',                                '* Noche O: '|| lpad(to_char( p3_obl_desde,'hh24:mi'),5,' ') ||' a '|| lpad( to_char(p3_obl_hasta,'hh24:mi'),5,' ') ||                '-N F: '|| lpad(to_char( p3_fle_desde,'hh24:mi'),5,' ') ||' a '|| lpad( to_char(p3_fle_hasta,'hh24:mi'),5,' '))                as horarios,                horas_semanales,                DESC_CALENDARIO,                to_char(t.fecha_inicio, 'dd/mm/yyyy') as FECHA_INICIO  from FICHAJE_CALENDARIO t , FICHAJE_CALENDARIO_JORNADA jt  where t.fecha_fin is null and jt.fecha_fin is null       and  t.id_calendario= jt.id_calendario and dia=2   and t.id_calendario <> '0' order by id_calendario ");
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
<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
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

</script>
<script language="Javascript" >
function show_calendario()
{
 	var URL = "calendario.jsp?PERIODO=" + document.getElementById("PERIODO").value ;
	var WNAME = "Calendario";
	var windowW = 230;
	var windowH = 200;
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
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>

<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b" id="current">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" >Proceso Bolsa</a></li>   
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
   <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
   <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
   
    </ul>
  <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
<div>
	 <ul id="subtabh">
		<li id="active"><a href="../Finger_apl/index.jsp" >Incidencias diarias</a></li>	
		<li id="active"><a href="" onClick="show_finger()">Fichajes on line</a></li>
		<li id="active"><a href="../Finger_apl/chequea_relojes.jsp" >Chequeo de Relojes</a></li>	
		<li id="active"><a href="../Finger_apl/index_calendario.jsp" id="current">Calendarios</a></li>
	   	
	  </ul>
  </div> 
  <table width="95%" border="0" cellspacing="0" cellpadding="2">
<tr bgcolor="#CCFFCC"> 
                                        <td colspan="7" align="center"><b> Calendarios de Horarios laborables</td>
                                      </tr>
                          <tr> 
                            <td> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#f2f2f2"> 
                  <table width="100%" border="0" cellspacing="1" cellpadding="2">
                    <tr bgcolor="#CCCCCC"> 
                      <td class="va10b" align="center" width="5%">ID</td>                     
                      <td class="va10b" width="10%">Nombre</td>
                       <td class="va10b" width="40%">Horarios</td>
                        <td class="va10b" align="center" width="5%">Turno</td>
                         <td class="va10b" bgcolor="#CCCCCC" align="center" width="5%">Horas Semanales</td>
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="5%">Fecha_inicio</td>
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="5%">Acciones</td>
                      <td class="va10b" bgcolor="#f2f2f2" width="2%" align="center">  <a href="edita_calendario.jsp"><img src="../../imagen/new.png" alt="Nuevo"	width="20" height="20" border="0"></a>
	 </td>
                    </tr>
                   <% while ((RSCALENDARIO_hasData)&&(Repeat1__numRows-- != 0)) { %>
                    <%   RSIMPAR =  (String) (((RSCALENDARIO_data = RSCALENDARIO.getObject("IMPAR"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data); 
                            	     if (RSIMPAR.equals("1") )  
                                     	 RSCOLOR="bgcolor=\"#FAD2D2\"";                     	
    				               else 	                   
                                          RSCOLOR="";   
							  	  
							  	  %> 
                                        
                    <tr bgcolor="#FFFFFF"> 
                     <td <%= RSCOLOR %> width="5%" align="center"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("ID_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>                                       
                    <td <%= RSCOLOR %> width="10%"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("DESC_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>
                      <td <%= RSCOLOR %> align="left" width="40%"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("HORARIOS"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>
                                        
                      <td <%= RSCOLOR %> align="center" width="5%"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("TURNO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>
                       <td <%= RSCOLOR %> align="center" width="5%"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("HORAS_SEMANALES"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>
                      <td <%= RSCOLOR %> align="center" width="5%"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("FECHA_INICIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>
                   
                      <td <%= RSCOLOR %> align="center" width="5%">
                       <a href="edita_calendario.jsp?ID_CALENDARIO=<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("ID_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>"><img
		          	src="../../imagen/edit.png" alt="Editar" width="20" height="20" border="0"></a>
      
                        	</td>
                      
                    </tr>
                    <%
                    Repeat1__index++;
                    RSCALENDARIO_hasData = RSCALENDARIO.next();
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



