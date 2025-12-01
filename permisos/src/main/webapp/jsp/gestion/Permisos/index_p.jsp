<%@page language="java" import="java.util.Date,java.sql.*" errorPage="error.jsp"%> 
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%
java.util.Calendar cal_periodo = java.util.Calendar.getInstance();
Integer periodo = new Integer( cal_periodo.get(java.util.Calendar.YEAR) );
%>
<%
String RSQUERY2__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSQUERY2__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSQUERY2__MMColParam2 = "0000";
if (request.getParameter("PERIODO")  !=null) {RSQUERY2__MMColParam2 = (String)request.getParameter("PERIODO") ;}
%>
<%
if (RSQUERY2__MMColParam2.equals("0000")) { RSQUERY2__MMColParam2 = periodo.toString(); }
%>
<%
Driver DriverRSQUERY2 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY2 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY2 = ConnRSQUERY2.prepareStatement("SELECT /*+ ORDERED*/    B.ID_TIPO_PERMISO, B.DESC_TIPO_PERMISO,    A.ID_ANO,    A.NUM_DIAS AS NUM_DIAS,    A.COMPLETO as completo ,a.ID_FUNCIONARIO  FROM RRHH.PERMISO_FUNCIONARIO A, RRHH.TR_TIPO_PERMISO B  WHERE A.UNICO = 'SI' AND A.ID_FUNCIONARIO = '" + RSQUERY2__MMColParam1 + "' AND A.ID_ANO = '" + RSQUERY2__MMColParam2 + "' AND A.ID_TIPO_PERMISO = B.ID_TIPO_PERMISO AND A.ID_ANO = B.ID_ANO and desc_tipo_permiso not like '%anterior%'  ORDER BY B. ID_TIPO_PERMISO");
ResultSet RSQUERY2 = StatementRSQUERY2.executeQuery();
boolean RSQUERY2_isEmpty = !RSQUERY2.next();
boolean RSQUERY2_hasData = !RSQUERY2_isEmpty;
Object RSQUERY2_data;
int RSQUERY2_numRows = 0;
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT DISTINCT TO_CHAR(FECHA_INICIO,'YYYY') AS PERIODO  FROM RRHH.PERMISO  union select '2008' as periodo  FROM dual");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSQUERY2_numRows += Repeat1__numRows;
%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RSQUERY2_numRows += Repeat2__numRows;
%>
<%
Driver driver = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection connection = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
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
                      <td class="va10w"> 
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td bgcolor="#e0e0e0"> 
                              <table width="430" border="0" cellpadding="3" cellspacing="1">
                                <tr bgcolor="#e0e0e0"> 
                                  <td bgcolor="#AAAAAA"><a href="../Datos" class="ah12b">Datos 
                                    personales&nbsp;</a></td>
                                  <td bgcolor="#E0E0E0"><a href="../Permisos" class="ah12b"><b>Permisos</b></a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Ausencias" class="ah12b">Ausencias</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Bajas" class="ah12b">Bajas</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Horas" class="ah12b">Horas 
                                    extras</a>&nbsp;</td>
                                  <td bgcolor="#AAAAAA"><a href="../Historial/index.jsp" class="ah12b">Historial
                                     </a></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td class="va10w" align="right"> 
                        <table border="0" cellspacing="0" cellpadding="4">
                          <tr bgcolor="#e0e0e0"> 
                            <td bgcolor="#FFFFFF" align="right"><a href="../../index.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E0E0E0" colspan="2"> 
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                          <tr> 
                            <td bgcolor="#E0E0E0" valign="top"> 
                              <table border="0" cellspacing="0" cellpadding="2">
                                <form name="formBotonera" method=post action="index.jsp">
                                  <tr> 
                                    <td> 
                                      <input type="button" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp?ID_ANO=<%= RSQUERY2__MMColParam2 %>'" >
                                    </td>
                                    <td> 
                                      <input type="button" value="Guardar" name="Guardar" disabled="yes">
                                    </td>
                                    <td><input type="button" value="Genera per" name="Genera" onClick="window.location='genera.jsp'"></td>
                                    <td class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;</td>
                                  </tr>
                                </form>
                              </table>
                            </td>
                            <td bgcolor="#E0E0E0" valign="top" align="right"> 
                              <table border="0" cellspacing="0" cellpadding="2" width="100">
                                <form name="formPeriodo" method=post action="index_p.jsp">
                                  <tr> 
                                    <td>A&ntilde;o:&nbsp;</td>
                                    <td> 
                                      <select name="PERIODO">
                                        <% while (RSPERIODO_hasData) {
%>
                                        <%= "<option value='" %><%= (((RSPERIODO_data = RSPERIODO.getObject("PERIODO"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data) %><%= "'>" %> <%= RSPERIODO_data= RSPERIODO.getObject("PERIODO") %> <%= "</option>" %> 
                                        <%  RSPERIODO_hasData = RSPERIODO.next();
}
RSPERIODO.close();
RSPERIODO = StatementRSPERIODO.executeQuery();
RSPERIODO_hasData = RSPERIODO.next();
RSPERIODO_isEmpty = !RSPERIODO_hasData;
%>
                                      </select>
                                    </td>
                                    <td> 
                                      <input type="submit" value="Ver" name="submit">
                                    </td>
                                  </tr>
                                </form>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                              <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                <tr bgcolor="#FFFFDD"> 
                                  <td colspan="5"><b>Editar Permisos de Usuarios </b></td>
                                </tr>
                                <tr> 
                                  <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">A&ntilde;o</span></td>
                                  <td colspan="2" align="center" bgcolor="#CCCCCC"><span class="va10b">Tipo permiso </span><span class="va10b"></span></td>
                                  <td width="12%" align="center" bgcolor="#CCCCCC"><span class="va10b">D&iacute;as  restan x disfrutar </span></td>
                                  <td width="3%" align="center" bgcolor="#CCCCCC">&nbsp;</td>
                                </tr>
                                <% while ((RSQUERY2_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                <tr> 
                                  <td width="5%" align="center" bgcolor="#FFFFFF"><%=(((RSQUERY2_data = RSQUERY2.getObject("ID_ANO"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data)%></td>
                                  <td width="5%" align="center" bgcolor="#FFFFFF"><%=(((RSQUERY2_data = RSQUERY2.getObject("ID_TIPO_PERMISO"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data)%></td>
                                  <td width="75%" align="center" bgcolor="#FFFFFF"><div align="left"><%=(((RSQUERY2_data = RSQUERY2.getObject("DESC_TIPO_PERMISO"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data)%></div></td>
                                  <td width="12%" bgcolor="#FFFFFF"><div align="center"><%=(((RSQUERY2_data = RSQUERY2.getObject("NUM_DIAS"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data)%></div></td>
                                  <td width="3%" bgcolor="#FFFFFF"><%="<a href='editar_p.jsp?PERIODO="+(((RSQUERY2_data = RSQUERY2.getObject("ID_ANO"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data) + "&ID_TIPO_PERMISO="  + (((RSQUERY2_data = RSQUERY2.getObject("ID_TIPO_PERMISO"))==null || RSQUERY2.wasNull())?"":RSQUERY2_data) +"'><img src='../../imagen/editar.gif' width='16' height='16' border='0' alt='Editar'></a>" %></td>
                                </tr>
                                <%
  Repeat1__index++;
  RSQUERY2_hasData = RSQUERY2.next();
}
%>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" colspan="2">&nbsp; </td>
                          </tr>
                          <tr> 
                            <td valign="top" colspan="2">&nbsp;                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" colspan="2"> 
                              <script language="JavaScript">
<%= "document.formPeriodo.PERIODO.value = " + RSQUERY2__MMColParam2 %>
</script>
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
    </td>    
  </tr>
</table>
</body>
</html>
<%
RSQUERY2.close();
ConnRSQUERY2.close();
%>
<%
RSPERIODO.close();
StatementRSPERIODO.close();
ConnRSPERIODO.close();
%>
