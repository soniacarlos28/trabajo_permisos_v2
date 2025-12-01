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

String PERMI__V_ID_ANO = "0000";
if(request.getParameter("ID_ANO") != null){ PERMI__V_ID_ANO = (String)request.getParameter("ID_ANO");}

String PERMI__V_ID_FUNCIONARIO = "0";
if(request.getParameter("ID_FUNCIONARIO") != null){ PERMI__V_ID_FUNCIONARIO = (String)request.getParameter("ID_FUNCIONARIO");}

String PERMI__V_ID_TIPO_FUNCIONARIO = "0";
if(request.getParameter("ID_TIPO_FUNCIONARIO") != null){ PERMI__V_ID_TIPO_FUNCIONARIO = (String)request.getParameter("ID_TIPO_FUNCIONARIO");}

String PERMI__V_ID_TIPO_AUSENCIA = "0";
if(request.getParameter("ID_TIPO_AUSENCIA") != null){ PERMI__V_ID_TIPO_AUSENCIA = (String)request.getParameter("ID_TIPO_AUSENCIA");}

String PERMI__V_ID_ESTADO_AUSENCIA = "0";
if(request.getParameter("ID_ESTADO_AUSENCIA") != null){ PERMI__V_ID_ESTADO_AUSENCIA = (String)request.getParameter("ID_ESTADO_AUSENCIA");}

String PERMI__V_FECHA_INICIO = "01/01/2000";
if(request.getParameter("FECHA_INICIO") != null){ PERMI__V_FECHA_INICIO = (String)request.getParameter("FECHA_INICIO");}

String PERMI__V_FECHA_FIN = "01/01/2000";
if(request.getParameter("FECHA_FIN") != null){ PERMI__V_FECHA_FIN = (String)request.getParameter("FECHA_FIN");}
if (! PERMI__V_ID_TIPO_AUSENCIA.substring(0,1).equals("5")) { 
 PERMI__V_FECHA_FIN = PERMI__V_FECHA_INICIO;
    }

String PERMI__V_HORA_INICIO = "0";
if(request.getParameter("HORA_INICIO") != null){ PERMI__V_HORA_INICIO = (String)request.getParameter("HORA_INICIO");}

String PERMI__V_HORA_FIN = "0";
if(request.getParameter("HORA_FIN") != null){ PERMI__V_HORA_FIN = (String)request.getParameter("HORA_FIN");}

String PERMI__V_JUSTIFICACION = "0";
if(request.getParameter("JUSTIFICACION") != null){ PERMI__V_JUSTIFICACION = (String)request.getParameter("JUSTIFICACION");}

String PERMI__V_OBSERVACIONES = "";
if(request.getParameter("OBSERVACIONES") != null){ PERMI__V_OBSERVACIONES = (String)request.getParameter("OBSERVACIONES");}

String PERMI__V_IP = "0";
if(request.getParameter("IP") != null){ PERMI__V_IP = (String)request.getParameter("IP");}

%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call AUSENCIAS_ALTA_RRHH(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
PERMI.setString(1,PERMI__V_ID_ANO);
PERMI.setString(2,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(3,PERMI__V_ID_TIPO_FUNCIONARIO);
PERMI.setString(4,PERMI__V_ID_TIPO_AUSENCIA);
PERMI.setString(5,PERMI__V_ID_ESTADO_AUSENCIA);
PERMI.setString(6,PERMI__V_FECHA_INICIO);
PERMI.setString(7,PERMI__V_FECHA_FIN);
PERMI.setString(8,PERMI__V_HORA_INICIO);
PERMI.setString(9,PERMI__V_HORA_FIN);
PERMI.setString(10,PERMI__V_JUSTIFICACION);
PERMI.setString(11,PERMI__V_OBSERVACIONES);
PERMI.setString(12,PERMI__V_IP);
PERMI.registerOutParameter(13,Types.LONGVARCHAR);
PERMI.registerOutParameter(14,Types.LONGVARCHAR);
Object PERMI_data;
PERMI.execute();
%>
<%
String RSTIPO_AUSENCIA__MMColParam2 = "0";
if (request.getParameter("ID_TIPO_AUSENCIA")  !=null) {RSTIPO_AUSENCIA__MMColParam2 = (String)request.getParameter("ID_TIPO_AUSENCIA") ;}
%>
<%
Driver DriverRSTIPO_AUSENCIA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPO_AUSENCIA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPO_AUSENCIA = ConnRSTIPO_AUSENCIA.prepareStatement("SELECT DESC_TIPO_AUSENCIA  FROM tr_tipo_ausencia  WHERE ID_TIPO_AUSENCIA=" + RSTIPO_AUSENCIA__MMColParam2 + "");
ResultSet RSTIPO_AUSENCIA = StatementRSTIPO_AUSENCIA.executeQuery();
boolean RSTIPO_AUSENCIA_isEmpty = !RSTIPO_AUSENCIA.next();
boolean RSTIPO_AUSENCIA_hasData = !RSTIPO_AUSENCIA_isEmpty;
Object RSTIPO_AUSENCIA_data;
int RSTIPO_AUSENCIA_numRows = 0;
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
                                <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bordercolor="#FFFFFF">
                                  <tr bgcolor="#f2f2f2"> 
                                    <td colspan="13" align="right" bgcolor="#E0E0E0"><div align="left"> </div>                                      <div align="left" class="Estilo5"> Ausencia Solicitada:
                                        <% String v_id_todook  = (String)  (((PERMI_data = PERMI.getObject(14))==null || PERMI.wasNull())?"":PERMI_data);%>
</div></td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0"></td>
                                    <td nowrap bgcolor="#E0E0E0"><div align="right"><strong>
  Tipo de Ausencia:</strong></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0"><%=(((RSTIPO_AUSENCIA_data = RSTIPO_AUSENCIA.getObject("DESC_TIPO_AUSENCIA"))==null || RSTIPO_AUSENCIA.wasNull())?"":RSTIPO_AUSENCIA_data)%>                                        
</td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td align="right" nowrap bgcolor="#E0E0E0">&nbsp;</td>
                                    <td width="114" valign="middle" nowrap bgcolor="#E0E0E0">                                    <div align="left"></div>                                    
                                      <div align="right"><strong>Fecha Inicio:</strong></div></td>
                                    <td width="130" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left"><%=PERMI__V_FECHA_INICIO%>
                                      </div></td>
                                    <td width="100" align="left" valign="middle" bgcolor="#E0E0E0"><div align="right"><strong>Fecha Fin:</strong></div></td>
                                    <td width="8" align="left" valign="middle" bgcolor="#E0E0E0"><%=PERMI__V_FECHA_FIN%></td>
                                    <td width="7" align="left" valign="middle" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td align="left" valign="middle" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td align="left" valign="middle" bgcolor="#E0E0E0"><div align="right">
</div></td>
                                    <td width="0" colspan="4" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left"></div></td>
                                  </tr>
                                  <tr id="COMPE" bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Hora Inicio:</strong></div></td>
                                    <td bgcolor="#E0E0E0"><%=PERMI__V_HORA_INICIO%></td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Hora Fin: </strong></div></td>
                                    <td bgcolor="#E0E0E0"><%=PERMI__V_HORA_FIN%></td>
                                    <td bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0">&nbsp;</td>
                                    <td colspan="5" bgcolor="#E0E0E0">&nbsp;</td>
                                  </tr>
								<tr id="JUST" bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0"><p class="Estilo6">* Esta ausencia necesita justificante. Llevelo a RRHH.</p>                                    </td>
                                  </tr>
                                
                                </table>
                                <br>
<table width="100%"  border="0" cellspacing="0" cellpadding="4">
  <tr bgcolor="#FFFFFF">
    <th width="5%" scope="col">&nbsp;</th>
    <th width="36%" scope="col">&nbsp;</th>
    <th scope="col">&nbsp;</th>
    </tr>
  <tr>
    <td colspan="3"><div align="left"></div>      
      <p class="Estilo5">Resultado de la operaci&oacute;n:</p></td>
    </tr>
 
 <% if ( v_id_todook.equals("0") ){ %>
 <tr>
    <td valign="middle" scope="row"><img src="../../../Produccion/imagen/ok.jpg" width="25" height="25"></td>
    <td colspan="2" valign="middle"><span class="Estilo9"><%= (((PERMI_data = PERMI.getObject(13))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
    </tr>
<tr>
  <td valign="middle" scope="row">&nbsp;</td>
    <td colspan="2">
      <div align="center">    <input type="button" name="button" value="Inicio" onClick="window.location='index.jsp'">  </div></td>
  
  <%  } else { %>
    <tr>
    <td valign="middle" scope="row"><img src="../../../Produccion/imagen/mal_rojo.jpg" width="25" height="25"></td>
    <td colspan="2"><span class="Estilo11 Estilo6"><%= (((PERMI_data = PERMI.getObject(13))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
  </tr>
<tr>
    <td colspan="3">
      <div align="center">
        <input type="button" name="button" value="Volver solicitud" onClick="window.location='alta.jsp?ID_ANO=' + <%= PERMI__V_ID_ANO%>  +  '&V_ID_TIPO_AUSENCIA=' + '<%= PERMI__V_ID_TIPO_AUSENCIA%>' 
+'&V_FECHA_INICIO=' + '<%= PERMI__V_FECHA_INICIO%>'  
+'&V_FECHA_FIN=' + '<%= PERMI__V_FECHA_FIN%>'  
+'&V_HORA_INICIO=' + '<%= PERMI__V_HORA_INICIO%>'  
+'&V_HORA_FIN=' + '<%= PERMI__V_HORA_FIN%>'  
+'&V_ID_JUSTIFICACION=' + '<%= PERMI__V_JUSTIFICACION%>'  
+'' ">
      </div></td>
    </tr>
  <% } %>
    
  
  
</table>
                                
                      
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
          </td>
        </tr>
      </table>
    </td>  
  </tr>
</table>
</body>
</html>
<%
RSTIPO_AUSENCIA.close();
StatementRSTIPO_AUSENCIA.close();
ConnRSTIPO_AUSENCIA.close();
%>
<%
ConnPERMI.close();
%>
