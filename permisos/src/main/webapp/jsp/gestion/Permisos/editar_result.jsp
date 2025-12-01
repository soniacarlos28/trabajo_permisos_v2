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

String PERMI__V_FECHA_FIN = "01/01/2017";
if(request.getParameter("B_FECHA_FIN") != null){ PERMI__V_FECHA_FIN = (String)request.getParameter("B_FECHA_FIN");}

String PERMI__V_OBSERVACIONES = "0";
if(request.getParameter("OBSERVACIONES") != null){ PERMI__V_OBSERVACIONES = (String)request.getParameter("OBSERVACIONES");}

String PERMI__V_ID_PERMISO = "0";
if(request.getParameter("ID_PERMISO") != null){ PERMI__V_ID_PERMISO = (String)request.getParameter("ID_PERMISO");}

String PERMI__V_ID_ESTADO_PERMISO = "--";
if(request.getParameter("ID_ESTADO_PERMISO") != null){ PERMI__V_ID_ESTADO_PERMISO = (String)request.getParameter("ID_ESTADO_PERMISO");}

String PERMI__V_JUSTIFICACION = "--";
if(request.getParameter("ID_JUSTIFICACION") != null){ PERMI__V_JUSTIFICACION = (String)request.getParameter("ID_JUSTIFICACION");}

String PERMI__V_ID_USUARIO = "0";
if(request.getParameter("ID_USUARIO") != null){ PERMI__V_ID_USUARIO = (String)request.getParameter("ID_USUARIO");}

String PERMI__V_DESCUENTO_BAJAS = "";
if(request.getParameter("DESCUENTO_BAJAS") != null){ PERMI__V_DESCUENTO_BAJAS = (String)request.getParameter("DESCUENTO_BAJAS");}

String PERMI__V_DESCUENTO_DIAS = "";
if(request.getParameter("DESCUENTO_DIAS") != null){ PERMI__V_DESCUENTO_DIAS = (String)request.getParameter("DESCUENTO_DIAS");}


%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call PERMISOS_EDITA_RRHH_NEW(?,?,?,?,?,?,?,?,?,?)}");
PERMI.setString(1,PERMI__V_OBSERVACIONES);
PERMI.setString(2,PERMI__V_ID_PERMISO);
PERMI.setString(3,PERMI__V_ID_ESTADO_PERMISO);
PERMI.setString(4,PERMI__V_JUSTIFICACION);
PERMI.setString(5,PERMI__V_ID_USUARIO);
PERMI.registerOutParameter(6,Types.LONGVARCHAR);
PERMI.registerOutParameter(7,Types.LONGVARCHAR);
PERMI.setString(8,PERMI__V_FECHA_FIN);
PERMI.setString(9,PERMI__V_DESCUENTO_BAJAS);
PERMI.setString(10,PERMI__V_DESCUENTO_DIAS);
Object PERMI_data;
PERMI.execute();
%>
<%
String RSTIPODIAS__MMColParam1 = "N";
if (request.getParameter("TIPO_DIAS") !=null) {RSTIPODIAS__MMColParam1 = (String)request.getParameter("TIPO_DIAS");}
%>
<%
Driver DriverRSTIPODIAS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPODIAS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPODIAS = ConnRSTIPODIAS.prepareStatement("SELECT DESC_TIPO_DIAS  FROM tr_tipo_dias  WHERE id_tipo_dias='" + RSTIPODIAS__MMColParam1 + "'");
ResultSet RSTIPODIAS = StatementRSTIPODIAS.executeQuery();
boolean RSTIPODIAS_isEmpty = !RSTIPODIAS.next();
boolean RSTIPODIAS_hasData = !RSTIPODIAS_isEmpty;
Object RSTIPODIAS_data;
int RSTIPODIAS_numRows = 0;
%>
<%
String RSGRADO__MMColParam1 = "0";
if (request.getParameter("ID_GRADO") !=null) {RSGRADO__MMColParam1 = (String)request.getParameter("ID_GRADO");}
%>
<%
Driver DriverRSGRADO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSGRADO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSGRADO = ConnRSGRADO.prepareStatement("SELECT desc_grado  FROM tr_grado  WHERE id_grado='" + RSGRADO__MMColParam1 + "'");
ResultSet RSGRADO = StatementRSGRADO.executeQuery();
boolean RSGRADO_isEmpty = !RSGRADO.next();
boolean RSGRADO_hasData = !RSGRADO_isEmpty;
Object RSGRADO_data;
int RSGRADO_numRows = 0;
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
<body>
<table width="760" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="75%" align="left" valign="top">      
      <table cellspacing=0 cellpadding=3 width=98% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><div align="left"><font face=arial color=#ffffff size=+1><b>Recursos Humanos - Solicitud 
            de Permisos </b></font></div></td>
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
                                <br>
<table width="100%"  border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="3"><div align="left"></div>      
      <p class="Estilo5">Resultado de la operaci&oacute;n:</p></td>
    </tr>
 <% String v_id_todook  = (String)  (((PERMI_data = PERMI.getObject(6))==null || PERMI.wasNull())?"":PERMI_data);%>
 <% if ( v_id_todook.equals("0") ){ %>
 <tr>
    <td width="5%" valign="middle" scope="row"><img src="../../imagen/ok.jpg" width="25" height="25"></td>
    <td colspan="2" valign="middle" nowrap><span class="Estilo9"><%= (((PERMI_data = PERMI.getObject(7))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
    </tr>
<tr>
  <td valign="middle" scope="row">&nbsp;</td>
    <td colspan="2">
      <div align="center">
        <input type="button" name="button" value="Volver" onClick="window.location='index.jsp'">
      </div></td>
  
  <%  } else { %>
    <tr>
    <td valign="middle" scope="row"><img src="../../imagen/mal_rojo.jpg" width="25" height="25"></td>
    <td colspan="2" nowrap><span class="Estilo11 Estilo6"><%= (((PERMI_data = PERMI.getObject(7))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
  </tr>
<tr>
  <td valign="middle" scope="row">&nbsp;</td>
    <td colspan="2">
      <div align="center">
        <input type="button" name="button" value="Volver" onClick="window.location='index.jsp'">
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
RSTIPODIAS.close();
StatementRSTIPODIAS.close();
ConnRSTIPODIAS.close();
%>
<%
RSGRADO.close();
StatementRSGRADO.close();
ConnRSGRADO.close();
%>
<%
ConnPERMI.close();
%>
