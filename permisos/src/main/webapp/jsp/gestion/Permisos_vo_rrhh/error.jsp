<%@page language="java" import="java.util.Date,java.sql.*" isErrorPage="true"%>

<% 
String mensaje = exception.getMessage();

%>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body>

<table width="760" border="0" cellspacing="0" cellpadding="1">
  <tr> 
    <td bgcolor="#000000"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr bgcolor="#FFFFFF"> 
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
                  <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr> 
                      <td valign="top" width="70%"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="va10w">&nbsp;                             </td>
                          </tr>
                          <tr> 
                            <td bgcolor="#E0E0E0"> 
                              <table width="100%" border="0" cellspacing="5" cellpadding="0">
                                <form name="formPermiso">
                                  <tr> 
                                    <td bgcolor="#E0E0E0" valign="top" colspan="2"><b>Mensaje 
                                      de error: </b><%= mensaje %> </td>
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
                </table></td>
              </tr>
            </table>
          </td>
          <td width="25%" align="left" valign="top"> 
          
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</body>
</html>

