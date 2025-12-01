<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%@ include file="../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
try {
    es.aytosalamanca.http.controller.session.SessionManager.touchSession(request);
} catch (Throwable _ignore) {
    // SessionManager library may be missing in this environment — ignore.
}
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT '(' || count(*) || ')' as contador  FROM permiso  WHERE id_Estado='22' and (anulado='NO' OR ANULADO IS NULL)");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
Driver DriverRSAUSENCIA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSAUSENCIA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSAUSENCIA = ConnRSAUSENCIA.prepareStatement("SELECT '(' || count(*) || ')' as contador  FROM ausencia  WHERE id_Estado='22' and (anulado='NO' OR ANULADO IS NULL)");
ResultSet RSAUSENCIA = StatementRSAUSENCIA.executeQuery();
boolean RSAUSENCIA_isEmpty = !RSAUSENCIA.next();
boolean RSAUSENCIA_hasData = !RSAUSENCIA_isEmpty;
Object RSAUSENCIA_data;
int RSAUSENCIA_numRows = 0;
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
<!-- Bootstrap CSS (CDN) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- App styles -->
<link href="/css/theme-blue.css" rel="stylesheet" type="text/css">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<header class="app-header d-flex align-items-center justify-content-between">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <h4 class="mb-0">Administraci&oacute;n de RRHH</h4>
      </div>
    </div>
  </div>
</header>
<div class="container-fluid mt-3">
  <div class="row">
    <nav class="col-md-3 col-lg-2 app-sidebar">
      <h5 class="text-white">Navegación</h5>
      <a href="#" class="active">Permisos/Ausencias</a>
      <a href="gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a>
      <a href="gestion/Finger_apl/index.jsp">Finger</a>
      <a href="gestion/Gestion/index.jsp">Horas Sindicales</a>
      <a href="gestion/Bolsa_proceso/index.jsp">Proceso Bolsa</a>
      <a href="gestion/calendario_laboral/index.jsp">Calendario Laboral</a>
      <a href="gestion/Bajas/index.jsp">Bajas Fichero</a>
      <a href="gestion/Informes/index_informes.jsp">Informes</a>
    </nav>
    <main class="col-md-9 col-lg-10">
      <div class="content-card">
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
                        </table>
        </div>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
<%
RSAUSENCIA.close();
StatementRSAUSENCIA.close();
ConnRSAUSENCIA.close();
%>
