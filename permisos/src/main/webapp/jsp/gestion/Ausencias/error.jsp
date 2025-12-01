<%@page language="java" import="java.util.Date,java.sql.*" isErrorPage="true"%>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<% 
String mensaje = exception.getMessage();
int inicio 	= 1;
int fin 	= 1;
inicio 		= mensaje.indexOf('*') + 1;
if (inicio < 0) { inicio = 1; }
fin 		= mensaje.indexOf('*',inicio);
if (fin < 0) { fin = 1; }
%>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body>
<table width="760" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="75%" align="left" valign="top">       
      <table cellspacing=0 cellpadding=3 width=98% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><font face=arial color=#ffffff size=+1><b>Administraci&oacute;n 
            de RRHH - Gesti&oacute;n de permisos</b></font></td>
        </tr>
        </tbody> 
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr> 
          <td> 
            <% if (exception.getMessage().substring(0,9).equals("ORA-20001")) { %>
			<table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="va10w"> 
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#e0e0e0"> 
                              <table border="0" cellspacing="1" cellpadding="3">
                                <tr bgcolor="#e0e0e0"> 
                                  <td bgcolor="#e0e0e0"><a href="../Datos" class="ah12b"><b>Datos 
                                    personales</b>&nbsp;</a></td>
                                  <td bgcolor="#AAAAAA"><a href="../Permisos" class="ah12b">Permisos</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Ausencias" class="ah12b">Ausencias</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Bajas" class="ah12b">Bajas</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Horas" class="ah12b">Horas 
                                    extras</a>&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td align="right"> 
                        <table border="0" cellspacing="0" cellpadding="4" width="106">
                          <tr bgcolor="#e0e0e0"> 
                            <td bgcolor="#FFFFFF" align="right"><a href="../index.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formPermiso">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"><b>Mensaje 
                                de error:</b> <%= mensaje.substring(inicio,fin) %> </td>
                            </tr>
                            <tr>
                              <td bgcolor="#E0E0E0" valign="top" colspan="2" align="center"> 
                                <p>&nbsp;</p>
                                <p><a href="javascript:history.back();">Volver</a></p>
                                <p>&nbsp;</p>
                                </td>
                            </tr>
                          </form>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
			<% } else if (exception.getMessage().substring(0,9).equals("ORA-20002")) { %>
			<table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="va10w"> 
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#e0e0e0"> 
                              <table border="0" cellspacing="1" cellpadding="3">
                                <tr bgcolor="#e0e0e0"> 
                                  <td bgcolor="#AAAAAA"><a href="../Datos" class="ah12b">Datos 
                                    personales&nbsp;</a></td>
                                  <td bgcolor="#E0E0E0"><a href="../Permisos" class="ah12b"><b>Permisos</b></a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Ausencias" class="ah12b">Ausencias</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Bajas" class="ah12b">Bajas</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Horas" class="ah12b">Horas 
                                    extras</a>&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td align="right"> 
                        <table border="0" cellspacing="0" cellpadding="4" width="106">
                          <tr bgcolor="#e0e0e0"> 
                            <td bgcolor="#FFFFFF" align="right"><a href="../index.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formPermiso">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"><b>Mensaje 
                                de error: </b><%= mensaje.substring(inicio,fin) %> 
							  </td>
                            </tr>
                            <tr>
                              <td bgcolor="#E0E0E0" valign="top" colspan="2" align="center"> 
                                <p>&nbsp;</p>
                                <p><a href="javascript:history.back();">Volver</a></p>
                                <p>&nbsp;</p>
                                </td>
                            </tr>
                          </form>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
			<% } else if (exception.getMessage().substring(0,9).equals("ORA-20003")) { %>
			<table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="va10w"> 
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#e0e0e0"> 
                              <table border="0" cellspacing="1" cellpadding="3">
                                <tr bgcolor="#e0e0e0"> 
                                  <td bgcolor="#AAAAAA"><a href="../Datos" class="ah12b">Datos 
                                    personales&nbsp;</a></td>
                                  <td bgcolor="#AAAAAA"><a href="../Permisos" class="ah12b">Permisos</a>&nbsp;</td>
                                  <td bgcolor="#E0E0E0"><a href="../Ausencias" class="ah12b"><b>Ausencias</b></a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Bajas" class="ah12b">Bajas</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Horas" class="ah12b">Horas 
                                    extras</a>&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td align="right"> 
                        <table border="0" cellspacing="0" cellpadding="4" width="106">
                          <tr bgcolor="#e0e0e0"> 
                            <td bgcolor="#FFFFFF" align="right"><a href="../index.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formPermiso">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"><b>Mensaje 
                                de error: </b><%= mensaje.substring(inicio,fin) %> </td>
                            </tr>
                            <tr>
                              <td bgcolor="#E0E0E0" valign="top" colspan="2" align="center"> 
                                <p>&nbsp;</p>
                                <p><a href="javascript:history.back();">Volver</a></p>
                                <p>&nbsp;</p>
                                </td>
                            </tr>
                          </form>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
			<% } else if (exception.getMessage().substring(0,9).equals("ORA-20004")) { %>
			<table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="va10w"> 
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#e0e0e0"> 
                              <table border="0" cellspacing="1" cellpadding="3">
                                <tr bgcolor="#e0e0e0"> 
                                  <td bgcolor="#AAAAAA"><a href="../Datos" class="ah12b">Datos 
                                    personales&nbsp;</a></td>
                                  <td bgcolor="#AAAAAA"><a href="../Permisos" class="ah12b">Permisos</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Ausencias" class="ah12b">Ausencias</a>&nbsp;</td>
                                  <td bgcolor="#E0E0E0"><a href="../Bajas" class="ah12b"><b>Bajas</b></a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Horas" class="ah12b">Horas 
                                    extras</a>&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td align="right"> 
                        <table border="0" cellspacing="0" cellpadding="4" width="106">
                          <tr bgcolor="#e0e0e0"> 
                            <td bgcolor="#FFFFFF" align="right"><a href="../index.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formPermiso">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"><b>Mensaje 
                                de error:</b> <%= mensaje.substring(inicio,fin) %> </td>
                            </tr>
                            <tr>
                              <td bgcolor="#E0E0E0" valign="top" colspan="2" align="center"> 
                                <p>&nbsp;</p>
                                <p><a href="javascript:history.back();">Volver</a></p>
                                <p>&nbsp;</p>
                                </td>
                            </tr>
                          </form>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
			<% } else if (exception.getMessage().substring(0,9).equals("ORA-20005")) { %>
			<table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="va10w"> 
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#e0e0e0"> 
                              <table border="0" cellspacing="1" cellpadding="3">
                                <tr bgcolor="#e0e0e0"> 
                                  <td bgcolor="#AAAAAA"><a href="../Datos" class="ah12b">Datos 
                                    personales&nbsp;</a></td>
                                  <td bgcolor="#AAAAAA"><a href="../Permisos" class="ah12b">Permisos</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Ausencias" class="ah12b">Ausencias</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Bajas" class="ah12b">Bajas</a>&nbsp;</td>
                                  <td bgcolor="#E0E0E0"><a href="../Horas" class="ah12b"><b>Horas 
                                    extras</b></a>&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td align="right"> 
                        <table border="0" cellspacing="0" cellpadding="4" width="106">
                          <tr bgcolor="#e0e0e0"> 
                            <td bgcolor="#FFFFFF" align="right"><a href="../index.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formPermiso">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"><b>Mensaje 
                                de error: </b><%= mensaje.substring(inicio,fin) %> </td>
                            </tr>
                            <tr>
                              <td bgcolor="#E0E0E0" valign="top" colspan="2" align="center"> 
                                <p>&nbsp;</p>
                                <p><a href="javascript:history.back();">Volver</a></p>
                                <p>&nbsp;</p>
                                </td>
                            </tr>
                          </form>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
			<% } else { %>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="va10w"> 
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#e0e0e0"> 
                              <table border="0" cellspacing="1" cellpadding="3">
                                <tr bgcolor="#e0e0e0"> 
                                  <td bgcolor="#e0e0e0"><a href="../Datos" class="ah12b"><b>Datos 
                                    personales</b>&nbsp;</a></td>
                                  <td bgcolor="#AAAAAA"><a href="../Permisos" class="ah12b">Permisos</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Ausencias" class="ah12b">Ausencias</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Bajas" class="ah12b">Bajas</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Horas" class="ah12b">Horas 
                                    extras</a>&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td align="right"> 
                        <table border="0" cellspacing="0" cellpadding="4" width="106">
                          <tr bgcolor="#e0e0e0"> 
                            <td bgcolor="#FFFFFF" align="right"><a href="../index.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formPermiso">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"><b>Mensaje 
                                de error:</b> <%= mensaje %> </td>
                            </tr>
                            <tr>
                              <td bgcolor="#E0E0E0" valign="top" colspan="2" align="center"> 
                                <p>&nbsp;</p>
                                <p><a href="javascript:history.back();">Volver</a></p>
                                <p>&nbsp;</p>
                                </td>
                            </tr>
                          </form>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
			<% } %>
          </td>
        </tr>
      </table>
    </td>    
  </tr>
</table>
</body>
</html>

