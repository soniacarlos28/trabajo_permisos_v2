<%@page language="java" import="java.util.Date,java.sql.*" errorPage="error.jsp"%>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%

String PERMI__V_ID_ANO = "0000";
if(request.getParameter("ID_ANO") != null){ PERMI__V_ID_ANO = (String)request.getParameter("ID_ANO");}

String PERMI__V_ID_FUNCIONARIO = "0";
if(request.getParameter("ID_FUNCIONARIO") != null){ PERMI__V_ID_FUNCIONARIO = (String)request.getParameter("ID_FUNCIONARIO");}

String PERMI__V_ID_TIPO_FUNCIONARIO = "0";
if(request.getParameter("ID_TIPO_FUNCIONARIO") != null){ PERMI__V_ID_TIPO_FUNCIONARIO = (String)request.getParameter("ID_TIPO_FUNCIONARIO");}

String PERMI__V_ID_TIPO_PERMISO = "0";
if(request.getParameter("ID_TIPO_PERMISO") != null){ PERMI__V_ID_TIPO_PERMISO = (String)request.getParameter("ID_TIPO_PERMISO");}

String PERMI__V_ID_ESTADO_PERMISO = "0";
if(request.getParameter("ID_ESTADO_PERMISO") != null){ PERMI__V_ID_ESTADO_PERMISO = (String)request.getParameter("ID_ESTADO_PERMISO");}

String PERMI__V_ID_TIPO_DIAS = "0";
if(request.getParameter("TIPO_DIAS") != null){ PERMI__V_ID_TIPO_DIAS = (String)request.getParameter("TIPO_DIAS");}

String PERMI__V_FECHA_INICIO = "01/01/2000";
if(request.getParameter("FECHA_INICIO") != null){ PERMI__V_FECHA_INICIO = (String)request.getParameter("FECHA_INICIO");}

String PERMI__V_FECHA_FIN = "01/01/2000";
if(request.getParameter("FECHA_FIN") != null){ PERMI__V_FECHA_FIN = (String)request.getParameter("FECHA_FIN");}

String PERMI__V_HORA_INICIO = "";
if(request.getParameter("HORA_INICIO") != null){ PERMI__V_HORA_INICIO = (String)request.getParameter("HORA_INICIO");}

String PERMI__V_HORA_FIN = "";
if(request.getParameter("HORA_FIN") != null){ PERMI__V_HORA_FIN = (String)request.getParameter("HORA_FIN");}

String PERMI__V_ID_GRADO = "";
if(request.getParameter("ID_GRADO") != null){ PERMI__V_ID_GRADO = (String)request.getParameter("ID_GRADO");}

String PERMI__V_DPROVINCIA = "";
if(request.getParameter("DPROVINCIA") != null){ PERMI__V_DPROVINCIA = (String)request.getParameter("DPROVINCIA");}

String PERMI__V_JUSTIFICACION = "--";
if(request.getParameter("ID_JUSTIFICACION") != null){ PERMI__V_JUSTIFICACION = (String)request.getParameter("ID_JUSTIFICACION");}

String PERMI__V_UNICO = "";
if(request.getParameter("ID_UNICO") != null){ PERMI__V_UNICO = (String)request.getParameter("ID_UNICO");}

String PERMI__V_IP = "";
if(request.getParameter("IP") != null){ PERMI__V_IP = (String)request.getParameter("IP");}

String PERMI__V_ID_USUARIO = "";
if(request.getParameter("ID_USUARIO") != null){ PERMI__V_ID_USUARIO = (String)request.getParameter("ID_USUARIO");}

String PERMI__V_OBSERVACIONES = "";
if(request.getParameter("OBSERVACIONES") != null){ PERMI__V_OBSERVACIONES = (String)request.getParameter("OBSERVACIONES");}

%>
<%
Driver DriverPERMI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnPERMI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
CallableStatement PERMI = ConnPERMI.prepareCall("{ call PERMISOS_ALTA_RRHH(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
PERMI.setString(1,PERMI__V_ID_ANO);
PERMI.setString(2,PERMI__V_ID_FUNCIONARIO);
PERMI.setString(3,PERMI__V_ID_TIPO_FUNCIONARIO);
PERMI.setString(4,PERMI__V_ID_TIPO_PERMISO);
PERMI.setString(5,PERMI__V_ID_ESTADO_PERMISO);
PERMI.setString(6,PERMI__V_ID_TIPO_DIAS);
PERMI.setString(7,PERMI__V_FECHA_INICIO);
PERMI.setString(8,PERMI__V_FECHA_FIN);
PERMI.setString(9,PERMI__V_HORA_INICIO);
PERMI.setString(10,PERMI__V_HORA_FIN);
PERMI.setString(11,PERMI__V_ID_GRADO);
PERMI.setString(12,PERMI__V_DPROVINCIA);
PERMI.setString(13,PERMI__V_JUSTIFICACION);
PERMI.setString(14,PERMI__V_UNICO);
PERMI.setString(15,PERMI__V_IP);
PERMI.registerOutParameter(16,Types.LONGVARCHAR);
PERMI.registerOutParameter(17,Types.LONGVARCHAR);
PERMI.setString(18,PERMI__V_ID_USUARIO);
PERMI.setString(19,PERMI__V_OBSERVACIONES);
Object PERMI_data;
PERMI.execute();
%>
<%
String RSTIPO_PERMISO__MMColParam1 = "0";
if (request.getParameter("ID_ANO") !=null) {RSTIPO_PERMISO__MMColParam1 = (String)request.getParameter("ID_ANO");}
%>
<%
String RSTIPO_PERMISO__MMColParam2 = "0";
if (request.getParameter("ID_TIPO_PERMISO") !=null) {RSTIPO_PERMISO__MMColParam2 = (String)request.getParameter("ID_TIPO_PERMISO");}
%>
<%
String RSTIPO_PERMISO__MMColParam3 = "0";
if (request.getParameter("NUM_DIAS")  !=null) {RSTIPO_PERMISO__MMColParam3 = (String)request.getParameter("NUM_DIAS") ;}
%>
<%
Driver DriverRSTIPO_PERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPO_PERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPO_PERMISO = ConnRSTIPO_PERMISO.prepareStatement("SELECT DESC_TIPO_PERMISO  FROM tr_tipo_permiso  WHERE ID_ANO=" + RSTIPO_PERMISO__MMColParam1 + " and ID_TIPO_PERMISO=" + RSTIPO_PERMISO__MMColParam2 + " and (  1=1 OR '" + RSTIPO_PERMISO__MMColParam3 + "'='1')");
ResultSet RSTIPO_PERMISO = StatementRSTIPO_PERMISO.executeQuery();
boolean RSTIPO_PERMISO_isEmpty = !RSTIPO_PERMISO.next();
boolean RSTIPO_PERMISO_hasData = !RSTIPO_PERMISO_isEmpty;
Object RSTIPO_PERMISO_data;
int RSTIPO_PERMISO_numRows = 0;
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
                          <form name="formPermiso" action="alta_result3.jsp" METHOD="POST" >
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bordercolor="#FFFFFF">
                                  <tr bgcolor="#f2f2f2"> 
                                    <td colspan="13" align="right" bgcolor="#E0E0E0"><div align="left"> </div>                                      <div align="left" class="Estilo5"> Permiso Solicitado:
                                        <% String v_id_todook  = (String)  (((PERMI_data = PERMI.getObject(17))==null || PERMI.wasNull())?"":PERMI_data);%>
                                     </div></td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0"></td>
                                    <td nowrap bgcolor="#E0E0E0"><div align="right"><strong>
  Tipo de Permiso:</strong></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0"><%=(((RSTIPO_PERMISO_data = RSTIPO_PERMISO.getObject("DESC_TIPO_PERMISO"))==null || RSTIPO_PERMISO.wasNull())?"":RSTIPO_PERMISO_data)%>                                        
</td>
                                  </tr>
                                  <tr id="VACA" bgcolor="#f2f2f2">
                                    <td align="right" nowrap bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Tipo dias:</strong></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0"><%=(((RSTIPODIAS_data = RSTIPODIAS.getObject("DESC_TIPO_DIAS"))==null || RSTIPODIAS.wasNull())?"":RSTIPODIAS_data)%> </td>
                                  </tr>
   								<% if ( PERMI__V_ID_TIPO_PERMISO.equals("04500")  || PERMI__V_ID_TIPO_PERMISO.equals("04000")) { %>
                           <tr id="GRAD" bgcolor="#f2f2f2">
                                    <td align="right" nowrap bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"><strong>Grado:                                     </strong></div></td>
                                    <td colspan="3"  bgcolor="#E0E0E0"><div align="left"><%=(((RSGRADO_data = RSGRADO.getObject("DESC_GRADO"))==null || RSGRADO.wasNull())?"":RSGRADO_data)%>
                                    </div></td>
                                    <td width="30" bgcolor="#E0E0E0"><div align="right"><strong>D/P</strong></div></td>
                                    <td bgcolor="#E0E0E0"><%=PERMI__V_DPROVINCIA%></td>
                           </tr>
                                <% } %>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td align="right" nowrap bgcolor="#E0E0E0">&nbsp;</td>
                                    <td width="114" valign="middle" nowrap bgcolor="#E0E0E0">                                    <div align="left"></div>                                    
                                      <div align="right"><strong>Fecha Inicio:</strong></div></td>
                                    <td width="130" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left"><%=PERMI__V_FECHA_INICIO%>
                                      </div></td>
                                    <td width="100" align="left" valign="middle" bgcolor="#E0E0E0"><div align="right"><strong>Fecha Fin:</strong></div></td>
                                    <td width="8" align="left" valign="middle" bgcolor="#E0E0E0"><%=PERMI__V_FECHA_FIN%></td>
                                    <td width="7" align="left" valign="middle" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td align="left" valign="middle" bgcolor="#E0E0E0"><strong>N D&iacute;as:</strong> <%=RSTIPO_PERMISO__MMColParam3%></td>
                                    <td align="left" valign="middle" bgcolor="#E0E0E0"><div align="right">
</div></td>
                                    <td width="0" colspan="4" align="left" valign="middle" bgcolor="#E0E0E0"><div align="left"></div></td>
                                  </tr>
                                 <% if ( PERMI__V_ID_TIPO_DIAS.equals("04500") ) { %>
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
                                <% } else if (PERMI__V_JUSTIFICACION.equals("NO")) { %>
								<tr id="JUST" bgcolor="#f2f2f2">
                                    <td align="right" bgcolor="#E0E0E0">&nbsp;</td>
                                    <td bgcolor="#E0E0E0"><div align="right"></div></td>
                                    <td colspan="10" bgcolor="#E0E0E0">* <span class="Estilo12">Este permiso necesita justificante. Llevelo a RRHH.</span></td>
                                  </tr>
                                 <% } else { %>								
                                 <tr id="VACION" bgcolor="#f2f2f2">
                                    <td colspan="13" align="right" bgcolor="#E0E0E0"><div align="right"></div></td>
                                  </tr>
                                 <% } %>
                                  
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
    <td valign="middle" scope="row"><img src="../../imagen/ok.jpg" width="25" height="25"></td>
    <td colspan="2" valign="middle"><span class="Estilo9"><%= (((PERMI_data = PERMI.getObject(16))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
    </tr>
<tr>
  <td valign="middle" scope="row">&nbsp;</td>
    <td colspan="2">
      <div align="center">
        <input type="button" name="button" value="Inicio" onClick="window.location='index.jsp'">
      </div></td>
  
  <%  } else { %>
    <tr>
    <td valign="middle" scope="row"><img src="../../imagen/mal_rojo.jpg" width="25" height="25"></td>
    <td colspan="2"><span class="Estilo11 Estilo6"><%= (((PERMI_data = PERMI.getObject(16))==null || PERMI.wasNull())?"":PERMI_data)%></span></td>
  </tr>
<tr>
    <td colspan="3">      <div align="center">
        <input type="button" name="button" value="Volver solicitud" onClick="window.location='alta.jsp?ID_ANO=' + <%= PERMI__V_ID_ANO%>  +  '&ID_TIPO_PERMISO=' + '<%= PERMI__V_ID_TIPO_PERMISO%>'
+'&TIPO_DIAS=' + '<%= PERMI__V_ID_TIPO_DIAS%>'  
+'&FECHA_INICIO=' + '<%= PERMI__V_FECHA_INICIO%>'  
+'&FECHA_FIN=' + '<%= PERMI__V_FECHA_FIN%>'  
+'&HORA_INICIO=' + '<%= PERMI__V_HORA_INICIO%>'  
+'&HORA_FIN=' + '<%= PERMI__V_HORA_FIN%>'  
+'&ID_GRADO=' + '<%= PERMI__V_ID_GRADO%>'  
+'&DPROVINCIA=' + '<%= PERMI__V_DPROVINCIA%>'  
+'&ID_JUSTIFICACION=' + '<%= PERMI__V_JUSTIFICACION%>'  
+'&OBSERVACIONES=' + '<%= PERMI__V_OBSERVACIONES%>'
+'&ID_UNICO=' + '<%= PERMI__V_UNICO%>'
+'' ">
        <input type="submit" name="Submit" value="Enviar sin chequeos">
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
RSTIPO_PERMISO.close();
StatementRSTIPO_PERMISO.close();
ConnRSTIPO_PERMISO.close();
%>
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
