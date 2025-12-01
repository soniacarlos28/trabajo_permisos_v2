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
String RSQUERY__Busqueda = "";
if (request.getParameter("CAMPO")   !=null) {RSQUERY__Busqueda = (String)request.getParameter("CAMPO")  ;}
%>
<%
Driver DriverRSCALENDARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCALENDARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCALENDARIO = ConnRSCALENDARIO.prepareStatement("select to_char(t.id_calendario) as  ID_CALENDARIO,       dia,to_char(dia) as  dia_texto,       DECODE(dia,              2,              'Lunes',              3,              'Martes',              4,              'Miercoles',              5,              'Jueves',              6,              'Viernes',              7,              'Sabado',              8,              'Domingo') as dia_semana,       to_char(horas_teoricas, 'hh24:mi') as horas_teoricas,       to_char(p1_obl_desde, 'hh24:mi') as p1_obl_desde,       to_char(p1_obl_hasta, 'hh24:mi') as p1_obl_hasta,       to_char(p1_fle_desde, 'hh24:mi') as p1_fle_desde,       to_char(p1_fle_hasta, 'hh24:mi') as p1_fle_hasta,       to_char(p2_obl_desde, 'hh24:mi') as p2_obl_desde,       to_char(p2_obl_hasta, 'hh24:mi') as p2_obl_hasta,       to_char(p2_fle_desde, 'hh24:mi') as p2_fle_desde,       to_char(p2_fle_hasta, 'hh24:mi') as p2_fle_hasta,       to_char(p3_obl_desde, 'hh24:mi') as p3_obl_desde,       to_char(p3_obl_hasta, 'hh24:mi') as p3_obl_hasta,       to_char(p3_fle_desde, 'hh24:mi') as p3_fle_desde,       to_char(p3_fle_hasta, 'hh24:mi') as p3_fle_hasta,       turno,       horas_semanales,       DESC_CALENDARIO,       t.fecha_inicio,       t.fecha_fin  from FICHAJE_CALENDARIO_JORNADA t, FICHAJE_CALENDARIO FC where t.fecha_fin is null   and fc.fecha_fin is null and fc.id_calendario<>0   and t.id_calendario = fc.id_calendario order by DESC_CALENDARIO,dia");
ResultSet RSCALENDARIO = StatementRSCALENDARIO.executeQuery();
boolean RSCALENDARIO_isEmpty = !RSCALENDARIO.next();
boolean RSCALENDARIO_hasData = !RSCALENDARIO_isEmpty;
Object RSCALENDARIO_data;
int RSCALENDARIO_numRows = 0;
%> 
<%
int Repeat1__numRows = 1000;
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

  <div id="form">
  
  <table width="95%" border="0" cellspacing="0" cellpadding="2">
  	 <form name="FINGER" method="POST">
<tr bgcolor="#CCFFCC"> 
                                        <td colspan="7" align="center"><b> Calendarios de Jornadas laborables</td>
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
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="15%">Fecha_inicio</td>
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="5%">Asignar</td>
                      <td class="va10b" bgcolor="#f2f2f2" width="2%" align="center"> 
                      
	 </td>
                    </tr>
                    <%         
                    RSCALEN_A="";          	  
							  	  %> 
                   <% while ((RSCALENDARIO_hasData)&&(Repeat1__numRows-- != 0)) { %>
                    <%  RSCALEN =  (String) (((RSCALENDARIO_data = RSCALENDARIO.getObject("ID_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data);                            	   
                     if (!RSCALEN.equals(RSCALEN_A ) ) { %>
                              <tr bgcolor="#FFFFFF"> 
                                <td id="Vc<%= Repeat1__index %>"  align="center" width="5%">
                                                
                                <a href="javascript:ver('c<%= Repeat1__index %>');"><img
		          	                  src="../../imagen/ver.gif" alt="Ver calendario" width="20" height="20" border="0"></a></td>
		          	             <td id="Oc<%= Repeat1__index %>" align="center" width="5%" style="DISPLAY:none">
                                                
                                <a href="javascript:ocultar('c<%= Repeat1__index %>');"><img
		          	                  src="../../imagen/delete.png" alt="Oculatar calendario" width="20" height="20" border="0"></a></td>                                                                                     
        				             <td  width="5%" align="center"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("ID_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>                                       
                    				 <td  width="30%"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("DESC_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>                     
                                     <td  align="center" width="5%"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("TURNO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>
                                     <td  align="center" width="15%"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("HORAS_SEMANALES"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>
                                     <td  Align="center" width="15%"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("FECHA_INICIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></td>
                                     <td  align="center" width="5%">                   <A HREF='#' onClick='window.opener.document.getElementById("<%= RSQUERY__Busqueda %>").value=<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("ID_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>;  
                                                                                                            window.opener.document.getElementById("<%= RSQUERY__Busqueda %>_DES").value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("DESC_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>";                     
                    window.close()';><img src="../../imagen/flecha.jpg" alt="Editar" width="20" height="20" border="0"> </A></td>                      
                              </tr> 
                           <td colspan=16 id="c<%= Repeat1__index %>" style="DISPLAY:none"> 
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
                				        
                                           <td   width="10%"  align="center"><span class="va10b"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("DIA_SEMANA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></span></td>
                                          <td  nowrap width="15%" align="center" colspan=2> 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> -
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>
                                         </td>
                                         <td  nowrap width="15%"  align="center" colspan=2>
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                             
                                        </td>
                                        <td   nowrap width="15%"  align="center" colspan=2> 
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> -
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>
                                        </td>
                                        <td  nowrap width="15%"  align="center" colspan=2>
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                             
                                        </td>                                    
                                         <td nowrap width="15%"   align="center" colspan=2> 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>
                                        </td>
                                        <td  nowrap width="15%"  align="center" colspan=2>
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                             
                                        </td>    
                                         <td  nowrap width="15%"  align="center" colspan=2>
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("HORAS_TEORICAS"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                                                                      
                                        </td>     
                                      </tr>  
                              <%  } else { %> 	                   
        
			                         <tr>
                				        
                                           <td   width="10%"  align="center"><span class="va10b"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("DIA_SEMANA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></span></td>
                                          <td  nowrap width="15%" align="center" colspan=2> 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> -
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>
                                         </td>
                                         <td  nowrap width="15%"  align="center" colspan=2>
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                             
                                        </td>
                                        <td   nowrap width="15%"  align="center" colspan=2> 
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> -
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>
                                        </td>
                                        <td  nowrap width="15%"  align="center" colspan=2>
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                             
                                        </td>                                    
                                         <td nowrap width="15%"   align="center" colspan=2> 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>
                                        </td>
                                        <td  nowrap width="15%"  align="center" colspan=2>
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                             
                                        </td>    
                                         <td  nowrap width="15%"  align="center" colspan=2>
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("HORAS_TEORICAS"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                                                                      
                                        </td>     
                                      </tr>  
                              <%  RSDIA =  (String) (((RSCALENDARIO_data = RSCALENDARIO.getObject("DIA_TEXTO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data);                             	   
                                 if (RSDIA.equals("8") )  {  %> 
                                  </table>
                                  </td>
                                    
                                     
                                            
                                 
                    <%  } }
                     RSCALEN_A=RSCALEN;
                     
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
                          	 </form>
                        </table>
                        
   		
								
	
</div>
	</div>
</body>
</html>


