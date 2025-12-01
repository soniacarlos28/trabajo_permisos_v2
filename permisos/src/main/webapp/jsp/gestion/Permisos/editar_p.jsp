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
String RSQUERY__MMColParam1 = "1";
if (session.getValue("MM_ID_FUNCIONARIO")     !=null) {RSQUERY__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")    ;}
%>
<%
String RSQUERY__MMColParam2 = "2";
if (request.getParameter("PERIODO")   !=null) {RSQUERY__MMColParam2 = (String)request.getParameter("PERIODO")  ;}
%>
<%
String RSQUERY__MMColParam3 = "3";
if (request.getParameter("ID_TIPO_PERMISO")   !=null) {RSQUERY__MMColParam3 = (String)request.getParameter("ID_TIPO_PERMISO")  ;}
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT /*+ ORDERED*/    B.ID_TIPO_PERMISO, B.DESC_TIPO_PERMISO,    A.ID_ANO,    A.NUM_DIAS AS NUM_DIAS,    A.COMPLETO as completo ,a.ID_FUNCIONARIO  FROM RRHH.PERMISO_FUNCIONARIO A, RRHH.TR_TIPO_PERMISO B  WHERE A.UNICO = 'SI' AND A.ID_FUNCIONARIO = '" + RSQUERY__MMColParam1 + "' AND A.ID_ANO = '" + RSQUERY__MMColParam2 + "' AND A.ID_TIPO_PERMISO = B.ID_TIPO_PERMISO AND A.ID_ANO = B.ID_ANO and desc_tipo_permiso not like '%anterior%' and  a.id_tipo_permiso='" + RSQUERY__MMColParam3 + "'  ORDER BY B. ID_TIPO_PERMISO");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSQUERY_numRows += Repeat1__numRows;
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
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
</head>
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
                          <form name="formPermiso" action='guardar_p.jsp'>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table border="0" cellspacing="0" cellpadding="2">
                                  <tr> 
                                    <td> 
                                      <input type="button" disabled="yes" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp'">
                                    </td>
                                    <td> 
                                      <input type="button" value="Guardar" name="Guardar" onClick="document.formPermiso.submit();">
                                    </td>
                                    <td>&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                  </tr>
                                </table>
                              </td>
                              <td bgcolor="#E0E0E0" valign="top" align="right"> 
                                <input type="hidden" name="PERIODO" value="<%=(((RSQUERY_data = RSQUERY.getObject("ID_ANO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%>" size="32">
                                <input type="hidden" name="ID_FUNCIONARIO" value="<%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%>" size="32">
                                <input type="hidden" name="ID_TIPO_PERMISO" value="<%=(((RSQUERY_data = RSQUERY.getObject("ID_TIPO_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%>" size="32">
                                <input type="hidden" name="ID_USUARIO" size="32">
                              <b>Formulario de Edici&oacute;n</b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                <table align="center" width="100%" border="0" cellspacing="1" cellpadding="2">
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%" bgcolor="#f2f2f2">A&ntilde;o:</td>
                                    <td colspan="2"><%=(((RSQUERY_data = RSQUERY.getObject("ID_ANO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%> 
                                    </td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%" bgcolor="#f2f2f2">Tipo 
                                      de permiso:</td>
                                    <td colspan="2" bgcolor="#f2f2f2"><%=(((RSQUERY_data = RSQUERY.getObject("ID_TIPO_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%> <%=(((RSQUERY_data = RSQUERY.getObject("DESC_TIPO_PERMISO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                  </tr>
                                  <tr valign="baseline" bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%" bgcolor="#f2f2f2">D&iacute;as:</td>
                                    <td width="30%"> 
                                      <input type="text" name="NUM_DIAS" value="<%=(((RSQUERY_data = RSQUERY.getObject("NUM_DIAS"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%>" size="5" maxlength="5">
                                    </td>
                                    <td align="right">&nbsp;</td>
                                  </tr>
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
RSQUERY.close();
ConnRSQUERY.close();
%>
