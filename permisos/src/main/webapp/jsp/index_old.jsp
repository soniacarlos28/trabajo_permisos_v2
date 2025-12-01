<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%@ include file="../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
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
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<table cellspacing=0 cellpadding=0 border=0 width="760">
  <tr bgcolor="#FFFFFF"> 
    <td valign=top>       
      <table cellspacing=0 cellpadding=3 width=98% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><font face=arial color=#ffffff size=+1><b>Administraci&oacute;n 
            de RRHH - Pantalla de b&uacute;squeda</b></font></td>
        </tr>
        </tbody> 
      </table>
      <br>
      <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="3%">&nbsp;</td>
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="va10w"> 
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#003366"> 
                              <table border="0" cellspacing="1" cellpadding="4">
                                <tr> 
                                  <td bgcolor="#003366"><a href="index.jsp" class="ah12w">Permisos/Ausencias&nbsp;</a></td>
                                  <td nowrap bgcolor="#FFFFFF"><a href="gestion/Listados" class="ah12b">Listados 
                                    Generales</a></td>
                                  <td bgcolor="#FFFFFF"><a href="" onClick="show_finger()"  class="ah12b">Finger</a></td>
                                  <td bgcolor="#FFFFFF"><a href="gestion/Gestion/index.jsp" class="ah12b">Horas 
                                    Sindicales</a></td>
                                     </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td > 
                        <table width="100%" border="1" cellpadding="2" cellspacing="0" bordercolor="#333333">
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                <tr bgcolor="#FFFFFF"> 
                                  <td  width="50%" valign="middle"> 
           
                                      <table border="0" cellspacing="0" cellpadding="4">
                                        <tr bgcolor="#F2F2F2">
                                          <td colspan="2"><b>B u s c a r&nbsp;  F u n c i o n a r i o</b></td>
                                        </tr>
                                        <tr bgcolor="#f2f2f2">
                                          <td align="center" bgcolor="#FFFFFF"><a href="index_busqueda.jsp"><img src="imagen/LicenciasPermiso.jpg" width="48" height="48" border="0"></a> </td>
                                          <td bgcolor="#FFFFFF"><a href="index_busqueda.jsp" class="ah12b"><font color="#000066">Permisos/Ausencias.</font></a></td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF">
                                          <td colspan="2">&nbsp;</td>
                                        </tr>
                                        <tr bgcolor="#F2F2F2">
                                          <td colspan="2"><b>Coincidencias entre Permisos y Bajas</b></td>
                                        </tr>
                                        <tr bgcolor="#f2f2f2">
                                          <td bgcolor="#FFFFFF" align="center"><a href="permisos_bajas.jsp"><img src="imagen/baja.gif" width="48" height="48" border="0"></a></td>
                                          <td bgcolor="#FFFFFF"><a href="gestion/permisos_bajas.jsp" class="ah12b"><font color="#000066">Coincidencias</font></a></td>
                                        </tr>
                                        
                                  </table>                                  </td>
                                  <td  align="center" width="50%" valign="middle">                                    <table border="0" cellspacing="0" cellpadding="4">
                                    <tr bgcolor="#F2F2F2">
                                      <td colspan="2"><b>P e r m i s o s&nbsp; P e n d i e n t e s &nbsp; V ºBº</b></td>
                                    </tr>
                                    <tr bgcolor="#f2f2f2">
                                      <td align="center" bgcolor="#FFFFFF"><a href="exp_ficheros.jsp"><img src="imagen/firma.gif" width="48" height="48" border="0"></a> </td>
                                      <td bgcolor="#FFFFFF"><a href="gestion/Permisos_vo_rrhh/firmar_index_p.jsp" class="ah12b"><font color="#000066"> Permisos pendientes de firmar<%=(((RSQUERY_data = RSQUERY.getObject("CONTADOR"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></font></a></td>
                                    </tr>
                                    <tr bgcolor="#FFFFFF">
                                      <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr bgcolor="#F2F2F2">
                                      <td colspan="2"><b>A u s e n c i a s&nbsp; P e n d i e n t es &nbsp; V ºBº</b></td>
                                    </tr>
                                    <tr bgcolor="#f2f2f2">
                                      <td bgcolor="#FFFFFF" align="center"><a href="exp_ficheros.jsp"><img src="imagen/firma.gif" width="48" height="48" border="0"></a></td>                                      
                                      <td bgcolor="#FFFFFF"><a href="gestion/Ausencias_vo_rrhh/firmar_index_a.jsp" class="ah12b"><font color="#000066"> Ausencias pendientes de firmar <%=(((RSAUSENCIA_data = RSAUSENCIA.getObject("CONTADOR"))==null || RSAUSENCIA.wasNull())?"":RSAUSENCIA_data)%></font></a></td>                                    
                                    </tr>
                                   
                                  </table>                                        </td>
                                </tr>
                                <tr bgcolor="#FFFFFF"> </tr>
                                <tr bgcolor="#FFFFFF"> </tr>
                                <tr bgcolor="#FFFFFF"> </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br>
    </td>    
  </tr>
</table>
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
