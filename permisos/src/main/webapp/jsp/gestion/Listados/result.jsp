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
String RSQUERYPER__MMColParam1 = "01";
if (request.getParameter("PERIODO")          !=null) {RSQUERYPER__MMColParam1 = (String)request.getParameter("PERIODO")         ;}
%>
<%
String RSQUERYPER__MMColParam2 = "2008";
if (request.getParameter("ANNO")        !=null) {RSQUERYPER__MMColParam2 = (String)request.getParameter("ANNO")       ;}
%>
<%
Driver DriverRSQUERYPER = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERYPER = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERYPER = ConnRSQUERYPER.prepareStatement("SELECT distinct pe.id_tipo_permiso,DESC_TIPO_PERMISO,pe.ID_FUNCIONARIO, NOMBRE , ape1 ,to_char(pe.fecha_inicio,'DD/MM/YYYY') as FECHA_INICIO  ,to_char(pe.fecha_fin,'DD/MM/YYYY') as FECHA_FIN  ,pe.JUSTIFICACION,OBSERVACIONES  FROM permiso pe,personal_new p, tr_tipo_permiso tp, webperiodo ow  WHERE pe.id_tipo_permiso=tp.id_tipo_permiso and   pe.id_estado=80 and pe.id_ano=tp.id_ano and  p.id_funcionario=pe.id_funcionario and  (pe.anulado is null OR pe.anulado='NO') and  (pe.JUSTIFICACION='NO')  and pe.id_ano=ow.ano  and  ow.ano='" + RSQUERYPER__MMColParam2 + "'  and       ow.mes=lpad('" + RSQUERYPER__MMColParam1 + "',2,'0')and      pe.fecha_inicio between  to_date(ow.inicio,'DD/MM/YY') and  to_date(ow.fin,'DD/MM/YY') and      pe.fecha_fin between  to_date(ow.inicio,'DD/MM/YY') and  to_date(ow.fin,'DD/MM/YY')    and pe.id_tipo_permiso<> '15000'      -- ow.fin  between pe.fecha_inicio and pe.fecha_fin  ORDER BY APE1, id_funcionario");
ResultSet RSQUERYPER = StatementRSQUERYPER.executeQuery();
boolean RSQUERYPER_isEmpty = !RSQUERYPER.next();
boolean RSQUERYPER_hasData = !RSQUERYPER_isEmpty;
Object RSQUERYPER_data;
int RSQUERYPER_numRows = 0;
%>
<%
String RSQUERYAUS__MMColParam2 = "2008";
if (request.getParameter("ANNO")      !=null) {RSQUERYAUS__MMColParam2 = (String)request.getParameter("ANNO")     ;}
%>
<%
String RSQUERYAUS__MMColParam1 = "07";
if (request.getParameter("PERIODO")        !=null) {RSQUERYAUS__MMColParam1 = (String)request.getParameter("PERIODO")       ;}
%>
<%
Driver DriverRSQUERYAUS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERYAUS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERYAUS = ConnRSQUERYAUS.prepareStatement("SELECT distinct pe.id_tipo_AUSENCIA,SUBSTR(DESC_TIPO_AUSENCIA,1,20) as DESC_TIPO_AUSENCIA,pe.ID_FUNCIONARIO, NOMBRE , ape1 ,pe.fecha_inicio    ,pe.fecha_fin,pe.JUSTIFICADO,OBSERVACIONES,    to_char(fecha_inicio,'DD/MM/YYYY') || '  ' || to_char(fecha_inicio,'hh24:mi')  || ' ' ||  DECODE (to_char(fecha_inicio,'DD/MM/YYYY'), to_char(fecha_fin,'DD/MM/YYYY'),'', to_char(fecha_fin,'DD/MM/YYYY'))  || '--' || to_char(fecha_fin,'hh24:mi') as FECHA_AUSENCIA  FROM ausencia pe,personal_new p, tr_tipo_ausencia tp, webperiodo ow  WHERE pe.id_tipo_ausencia=tp.id_tipo_ausencia and    pe.id_estado=80 and p.id_funcionario=pe.id_funcionario and  (pe.anulado is null OR pe.anulado='NO') and  (pe.JUSTIFICADO='NO')  and pe.id_ano=ow.ano  and   ow.ano='" + RSQUERYAUS__MMColParam2 + "'  and       ow.mes=lpad('" + RSQUERYAUS__MMColParam1 + "',2,'0') and      pe.fecha_inicio between  to_date(ow.inicio,'DD/MM/YY') and  to_date(ow.fin,'DD/MM/YY') and      pe.fecha_fin between  to_date(ow.inicio,'DD/MM/YY') and  to_date(ow.fin,'DD/MM/YY')    and pe.id_tipo_ausencia< '500'      -- ow.fin  between pe.fecha_inicio and pe.fecha_fin  ORDER BY APE1, id_funcionario    ,fecha_inicio ,pe.id_tipo_ausencia");
ResultSet RSQUERYAUS = StatementRSQUERYAUS.executeQuery();
boolean RSQUERYAUS_isEmpty = !RSQUERYAUS.next();
boolean RSQUERYAUS_hasData = !RSQUERYAUS_isEmpty;
Object RSQUERYAUS_data;
int RSQUERYAUS_numRows = 0;
%>
<%
String RSPERIODOS__MMColParam1 = "07";
if (request.getParameter("PERIODO")         !=null) {RSPERIODOS__MMColParam1 = (String)request.getParameter("PERIODO")        ;}
%>
<%
String RSPERIODOS__MMColParam2 = "2008";
if (request.getParameter("ANNO")       !=null) {RSPERIODOS__MMColParam2 = (String)request.getParameter("ANNO")      ;}
%>
<%
Driver DriverRSPERIODOS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODOS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODOS = ConnRSPERIODOS.prepareStatement("SELECT ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo  FROM  webperiodo  WHERE ano>2007 and ano='" + RSPERIODOS__MMColParam2 + "'  and       mes=lpad('" + RSPERIODOS__MMColParam1 + "',2,'0')  ORDER BY ano,MES");
ResultSet RSPERIODOS = StatementRSPERIODOS.executeQuery();
boolean RSPERIODOS_isEmpty = !RSPERIODOS.next();
boolean RSPERIODOS_hasData = !RSPERIODOS_isEmpty;
Object RSPERIODOS_data;
int RSPERIODOS_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSQUERYPER_numRows += Repeat1__numRows;
%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RSQUERYAUS_numRows += Repeat2__numRows;
%>
<%
String RSQUERY__TIPOPERMISO = "TT";
if (request.getParameter("TIPOPERMISO")      !=null) {RSQUERY__TIPOPERMISO = (String)request.getParameter("TIPOPERMISO")     ;}
%>


<html>
<head>
<title>Resultados de la b&uacute;squeda - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.Estilo3 {font-size: 10px}
.Estilo4 {font-size: 10}
-->
</style>
</head>
<body>
<table cellspacing=0 border=0 cellpadding="0" width=760>
  <tr> 
    <td valign=top align="center"> 
      <table cellspacing=0 cellpadding=0 border=0 width="100%">
        <tr> 
          <td valign=top colspan="2"><img src="../../imagen/1x1.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td valign=top align="center" height="189">            
            <table cellspacing=0 cellpadding=4 width=100% border=0>
              <tr> 
                <td> 
                  <form name="form1" method="get" action="resultb.jsp">
                    <input type="hidden" name="ID_USUARIO">
                  </form>
                </td>
                <td>&nbsp;</td>
                <td class="va10w" align="right" valign="bottom"><font face=arial color=#ffffff><b><font face="Arial, Helvetica, sans-serif" size="3" color="#003366">Administraci&oacute;n 
                  de RRHH - Resultados de la b&uacute;squeda</font></b></font></td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th bgcolor="#f2f2f2"> <div align="center">Periodo correspondiente a <%=(((RSPERIODOS_data = RSPERIODOS.getObject("PERIODO"))==null || RSPERIODOS.wasNull())?"":RSPERIODOS_data)%></div></th>
            </tr>
              <tr> 
                <td bgcolor="#f2f2f2"> 
                  <% if (RSQUERY__TIPOPERMISO.substring(1,2).equals("P") || RSQUERY__TIPOPERMISO.equals("TT")) { %>
                  <table width="100%" border="0" cellspacing="1" cellpadding="4">
                    <tr align="right"> 
                      <td bgcolor="#003366" colspan="7" class="ah12w"><div align="left">Permisos sin Justificar  </div></td>
                    </tr>
                    <tr> 
                      <td colspan="2" align="center" bgcolor="#CCCCCC" class="va10b">Funcionario</td>
                      <td class="va10b" width="20%" align="center" bgcolor="#CCCCCC"> 
                        Permiso</td>
                      <td class="va10b" width="10%" align="center" bgcolor="#CCCCCC"> 
                        Inicio</td>
                      <td class="va10b" bgcolor="#CCCCCC" align="center" width="10%"> 
                        Fin</td>
                      <td align="center" bgcolor="#CCCCCC" class="va10b">                        Jus.</td>
                      <td class="va10b" align="center"  bgcolor="#CCCCCC">Observaciones</td>
                    </tr>
                    <% while ((RSQUERYPER_hasData)&&(Repeat1__numRows-- != 0)) { %>
                    <tr> 
                      <td width="5%" align="center" bgcolor="#FFFFFF"><span class="Estilo3"><%=(((RSQUERYPER_data = RSQUERYPER.getObject("ID_FUNCIONARIO"))==null || RSQUERYPER.wasNull())?"":RSQUERYPER_data)%></span></td>
                      <td width="20%" align="center" bgcolor="#FFFFFF"><span class="Estilo3"><%=(((RSQUERYPER_data = RSQUERYPER.getObject("NOMBRE"))==null || RSQUERYPER.wasNull())?"":RSQUERYPER_data)%></span>&nbsp;<span class="Estilo3"><%=(((RSQUERYPER_data = RSQUERYPER.getObject("APE1"))==null || RSQUERYPER.wasNull())?"":RSQUERYPER_data)%></span> </td>
                      <td width="20%" align="center" bgcolor="#FFFFFF"><span class="Estilo3"><%=(((RSQUERYPER_data = RSQUERYPER.getObject("DESC_TIPO_PERMISO"))==null || RSQUERYPER.wasNull())?"":RSQUERYPER_data)%></span></td>
                      <td width="5%" align="center" bgcolor="#FFFFFF" class="Estilo3"><%=(((RSQUERYPER_data = RSQUERYPER.getObject("FECHA_INICIO"))==null || RSQUERYPER.wasNull())?"":RSQUERYPER_data)%></td>
                      <td width="5%" align="center" bgcolor="#FFFFFF" class="Estilo3"><%=(((RSQUERYPER_data = RSQUERYPER.getObject("FECHA_FIN"))==null || RSQUERYPER.wasNull())?"":RSQUERYPER_data)%></td>
                      <td width="5%" align="center" bgcolor="#FFFFFF" class="Estilo3"><%=(((RSQUERYPER_data = RSQUERYPER.getObject("JUSTIFICACION"))==null || RSQUERYPER.wasNull())?"":RSQUERYPER_data)%></td>
                      <td width="40%"  align="center" bgcolor="#FFFFFF" class="Estilo3"><%=(((RSQUERYPER_data = RSQUERYPER.getObject("OBSERVACIONES"))==null || RSQUERYPER.wasNull())?"":RSQUERYPER_data)%></td>
                    </tr>
                    <%
  Repeat1__index++;
  RSQUERYPER_hasData = RSQUERYPER.next();
}
%>
                  </table>
                  <% } if (RSQUERY__TIPOPERMISO.substring(1,2).equals("A") || RSQUERY__TIPOPERMISO.equals("TT") ) { %>
                  <table width="100%" border="0" cellspacing="1" cellpadding="4">
                    <tr align="right"> 
                      <td colspan="6" bgcolor="#003366" class="ah12w"><div align="left">Ausencias sin Justificar </div></td>
                    </tr>
                    <tr> 
                      <td colspan="2" align="center" bgcolor="#CCCCCC" class="va10b">Funcionario</td>
                      <td class="va10b" width="20%" align="center" bgcolor="#CCCCCC"> 
                        Tipo Ausencia</td>
                      <td align="center" bgcolor="#CCCCCC" class="va10b">Fecha 
                        Ausencia</td>
                      <td class="va10b" align="center" width="5%" bgcolor="#CCCCCC">Ju.</td>
                      <td width="40%"  align="center" bgcolor="#CCCCCC" class="va10b">Observaciones</td>
                    </tr>
                    <% while ((RSQUERYAUS_hasData)&&(Repeat2__numRows-- != 0)) { %>
                    <tr bgcolor="#FFFFFF"> 
                      <td width="5%" align="center" class="Estilo3"><%=(((RSQUERYAUS_data = RSQUERYAUS.getObject("ID_FUNCIONARIO"))==null || RSQUERYAUS.wasNull())?"":RSQUERYAUS_data)%></td>
                      <td width="20%" nowrap><span class="Estilo3"><%=(((RSQUERYAUS_data = RSQUERYAUS.getObject("NOMBRE"))==null || RSQUERYAUS.wasNull())?"":RSQUERYAUS_data)%></span>&nbsp;<span class="Estilo3"><%=(((RSQUERYAUS_data = RSQUERYAUS.getObject("APE1"))==null || RSQUERYAUS.wasNull())?"":RSQUERYAUS_data)%></span></td>
                      <td width="20%" align="center" class="Estilo3"><%=(((RSQUERYAUS_data = RSQUERYAUS.getObject("DESC_TIPO_AUSENCIA"))==null || RSQUERYAUS.wasNull())?"":RSQUERYAUS_data)%></td>
                      <td width="10%" align="center" class="Estilo3"><%=(((RSQUERYAUS_data = RSQUERYAUS.getObject("FECHA_AUSENCIA"))==null || RSQUERYAUS.wasNull())?"":RSQUERYAUS_data)%></td>
                      <td width="5%" align="center" class="Estilo3"><%=(((RSQUERYAUS_data = RSQUERYAUS.getObject("JUSTIFICADO"))==null || RSQUERYAUS.wasNull())?"":RSQUERYAUS_data)%></td>
                      <td width="40%"  align="center" class="Estilo3"><%=(((RSQUERYAUS_data = RSQUERYAUS.getObject("OBSERVACIONES"))==null || RSQUERYAUS.wasNull())?"":RSQUERYAUS_data)%></td>
                    </tr>
                    <%
  Repeat2__index++;
  RSQUERYAUS_hasData = RSQUERYAUS.next();
}
%>
                  </table>
                   <% } %>
                </td>
              </tr>
              <tr> 
                <td colspan="9">&nbsp;                </td>
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
RSQUERYPER.close();
ConnRSQUERYPER.close();
%>
<%
RSQUERYAUS.close();
ConnRSQUERYAUS.close();
%>
<%
RSPERIODOS.close();
StatementRSPERIODOS.close();
ConnRSPERIODOS.close();
%>
