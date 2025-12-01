<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo  FROM  webperiodo  WHERE ano>2014  ORDER BY ano,MES");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>
<html>
<head>
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
    <li><a href="#" id="current">Listados Generales</a></li>
    <li><a href="" onClick="../Finger">Finger</a></li>
    <li><a href="../Gestion" >Horas Sindicales</a></li>   
      <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
      <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
 <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
 </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
<div id="form">
<table width="95%" border="0" cellspacing="0" cellpadding="2">
                          <tr> 
                            <td> 
                              <table border="0" cellspacing="0" cellpadding="2" width="100%">
                                <tr bgcolor="#FFFFFF"> 
                                  <td rowspan="4" bgcolor="#FFFFFF" valign="top"> 
                                    <form name="formListado" method="GET" action="result.jsp">
                                      <table border="0" cellspacing="0" cellpadding="4">
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="right">A&ntilde;o: </td>
                                          <td colspan="3"> 
                                            <select name="ANNO">
                                              <option value="2017">2017</option>
                                                 <option value="2016">2016</option>
                                            </select>
                                          </td>
                                        </tr>
                                        <tr bgcolor="#f2f2f2"> 
                                          <td align="right">C&oacute;digo: </td>
                                          <td colspan="3"> 
                                            <select name="TIPOPERMISO" maxlength="100">
                                              <option value="TT" selected>Todas </option>
                                              <option value="TP">Todos los Permisos sin justificar</option>
                                              <option value="TA">Todas las Ausencias sin justificar</option>
                                            </select>
                                          </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td nowrap align="right">Periodo: </td>
                                          <td align="left"><select name="PERIODO" maxlength="100">
                                            <%
while (RSPERIODO_hasData) {
%>
                                            <option value="<%=((RSPERIODO.getObject("MES")!=null)?RSPERIODO.getObject("MES"):"")%>"><%=((RSPERIODO.getObject("PERIODO")!=null)?RSPERIODO.getObject("PERIODO"):"")%></option>
                                            <%
  RSPERIODO_hasData = RSPERIODO.next();
}
RSPERIODO.close();
RSPERIODO = StatementRSPERIODO.executeQuery();
RSPERIODO_hasData = RSPERIODO.next();
RSPERIODO_isEmpty = !RSPERIODO_hasData;
%>
                                                                                    </select></td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF" align="center"> 
                                          <td colspan="2"> 
                                            <table border="0" cellspacing="0" cellpadding="0" width="50%">
                                              <tr> 
                                                <td align="right" bgcolor="#FFFFFF"> 
                                                  <input type="reset" name="Limpiar2" value="Limpiar">
                                                </td>
                                                <td bgcolor="#FFFFFF" width="5%">&nbsp; 
                                                </td>
                                                <td bgcolor="#FFFFFF"> 
                                                  <input type="submit" name="Buscar2" value="Buscar">
                                                </td>
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                      </table>
                                    </form>
                                  </td>
                                  <td rowspan="4" align="center" valign="top" bgcolor="#FFFFFF" width="30%"> 
                                    <p>&nbsp;</p>
                                    <p><img src="../../imagen/notebook5.jpg" width="101" height="108"></p>
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
</body>
</html>



<%
RSPERIODO.close();
StatementRSPERIODO.close();
ConnRSPERIODO.close();
%>

