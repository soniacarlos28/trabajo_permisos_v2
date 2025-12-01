<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%> 
<script language="Javascript" >
function show_finger()
{
 	var URL = "gestion/Finger/vista_fichajes.jsp";
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
<html>
<head>
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li id="active"><a href="index.jsp" id="current">Permisos/Ausencias</a></li>
     <li><a href="gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>    
     <li><a href="gestion/Finger_apl/index.jsp"  class="ah12b">Finger</a></li>
     <li><a href="gestion/Listados" id="current">Sin Justificar</a></li>     
    <li><a href="gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li> 
    <li><a href="gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
   <li><a href="gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>  
   <li><a href="gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
    <li><a href="gestion/Informes/index_informes.jsp" >Informes</a></li>
   </ul>
  </div>
  <div id="form">
  <table width="95%" border="0" cellspacing="0" cellpadding="2">
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                <tr bgcolor="#FFFFFF"> 
                                  <td rowspan="4" width="70%"> 
                                    <form name="formConsulta" method="GET" action="gestion/result.jsp">
                                      <table border="0" cellspacing="0" cellpadding="3" width="100%">
                                      <tr bgcolor="#eef4f2"> 
                                          <td align="Center" colspan=2 width="0%"></td>
                                          
                                        </tr>
                                      <tr bgcolor="#eef4f2"> 
                                          <td align="Center" colspan=2 width="0%"><b>Busqueda de Funcionario</b></td>                                          
                                        </tr>
                                        <tr bgcolor="#eef4f2"> 
                                          <td align="Center" colspan=2 width="0%"><br><br></td>
                                          
                                        </tr>
                                        <tr bgcolor="#eef4f2"> 
                                          <td align="right" width="20%"></td>
                                          <td> 
                                            <input type="text" name="ID_USUARIO" size="45"><input type="submit" name="Buscar2" value="Buscar">
                                          </td>
                                        </tr>
                                        <tr bgcolor="#eef4f2"> 
                                          <td align="Center" colspan=2 width="0%"><br></td>
                                          </tr>
                                        <tr bgcolor="#eef4f2"> 
                                          <td align="Center" colspan=2 width="0%">Busqueda por cualquier campo incluido el tipo de funcionario(Policia, Bombero)</td>
                                          </tr>
                                             <tr bgcolor="#eef4f2"> 
                                          <td align="Center" colspan=2 width="0%"><br></td>
                                          </tr>
                                        
                                        
                                            </table><table width="100%" border="0" cellspacing="0" cellpadding="2">
                                              <tr> 
                                                <td align="center" bgcolor="#FFFFFF"> 
                                                  <input type="hidden" name="PAGINA" value="A">                                                  </td>
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                        
                                      </table>
                                    </form>
                                  </td>
                                  <td rowspan="4" align="center" width="30%" valign="top"> 
                                  
                                    <p><img src="imagen/buscar_funcionario.png" width="301" height="140"></p>
                                  </td>
                                </tr>
                                <tr bgcolor="#FFFFFF"> </tr>
                                <tr bgcolor="#FFFFFF"> </tr>
                                <tr bgcolor="#FFFFFF"> </tr>
                              </table>
                            </td>
                          </tr>
                        </table> </div>
</body>
</html>
