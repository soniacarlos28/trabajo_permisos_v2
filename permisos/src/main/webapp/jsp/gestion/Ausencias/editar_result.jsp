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

String PERMI__V_ID_AUSENCIA = "1";
if(request.getParameter("ID_AUSENCIA") != null){ PERMI__V_ID_AUSENCIA = (String)request.getParameter("ID_AUSENCIA");}

String PERMI__V_ID_ESTADO_AUSENCIA = "0";
if(request.getParameter("ID_ESTADO_AUSENCIA") != null){ PERMI__V_ID_ESTADO_AUSENCIA = (String)request.getParameter("ID_ESTADO_AUSENCIA");}

String PERMI__V_JUSTIFICACION = "0";
if(request.getParameter("JUSTIFICACION") != null){ PERMI__V_JUSTIFICACION = (String)request.getParameter("JUSTIFICACION");}

String PERMI__V_OBSERVACIONES = "";
if(request.getParameter("OBSERVACIONES") != null){ PERMI__V_OBSERVACIONES = (String)request.getParameter("OBSERVACIONES");}

%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call AUSENCIAS_EDITA_RRHH(?,?,?,?,?,?)}");
PERMI.setString(1,PERMI__V_ID_AUSENCIA);
PERMI.setString(2,PERMI__V_ID_ESTADO_AUSENCIA);
PERMI.setString(3,PERMI__V_JUSTIFICACION);
PERMI.setString(4,PERMI__V_OBSERVACIONES);
PERMI.registerOutParameter(5,Types.LONGVARCHAR);
PERMI.registerOutParameter(6,Types.LONGVARCHAR);
Object PERMI_data;
PERMI.execute();
%>
<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.Estilo5 {
	color: #003399;
	font-weight: bold;
	font-size: 14px;
}
.Estilo6 {color: #FF0000}
.Estilo9 {
	color: #009966;
	font-weight: bold;
}
.Estilo11 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
<body>
<table width="760" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="75%" align="left" valign="top">       
      <table cellspacing=0 cellpadding=3 width=98% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><div align="left"><font face=arial color=#ffffff size=+1><b>Recursos Humanos - Solicitud 
            de Ausencias </b></font></div></td>
        </tr>
        </tbody> 
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
                    <tr> 
                      <td class="va10w">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                      </td>
                      <td align="right"> 
                      <b>                      </b>                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#E0E0E0">
                          <form name="formPermiso">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                
<table width="100%"  border="0" cellspacing="0" cellpadding="4">
  <tr bgcolor="#FFFFFF">
    <th width="5%" scope="col">&nbsp;</th>
    <th width="36%" scope="col">&nbsp;</th>
    <th scope="col">&nbsp;</th>
    </tr>
  <tr>
    <td colspan="3"><div align="left"></div>      
      <p class="Estilo5">Resultado de la operaci&oacute;n:
        <% String v_id_todook  = (String)  (((PERMI_data = PERMI.getObject(6))==null || PERMI.wasNull())?"":PERMI_data);%>
      </p></td>
    </tr>
 
 <% if ( v_id_todook.equals("0") ){ %>
 <tr>
    <td valign="middle" scope="row"><img src="../../imagen/ok.jpg" width="25" height="25"></td>
    <td colspan="2" valign="middle"><span class="Estilo9"><%= (((PERMI_data = PERMI.getObject(5))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
    </tr>
<tr>
  <td valign="middle" scope="row">&nbsp;</td>
    <td colspan="2">
      <div align="center">    <input type="button" name="button" value="Inicio" onClick="window.location='index.jsp'">  </div></td>
  
  <%  } else { %>
    <tr>
    <td valign="middle" scope="row"><img src="../../imagen/mal_rojo.jpg" width="25" height="25"></td>
    <td colspan="2"><span class="Estilo11 Estilo6"><%= (((PERMI_data = PERMI.getObject(5))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
  </tr>
<tr>
    <td colspan="3">
      <div align="center">
        <input type="button" name="button" value="Volver solicitud" onClick="window.location='editar.jsp?ID_AUSENCIA=' + <%= PERMI__V_ID_AUSENCIA%>  

+'' ">
      </div></td>
    </tr>
  <% } %>
    
  
  
</table>                              </td>
                            </tr>
                          </form>
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

</body>
</html>
<%
ConnPERMI.close();
%>
