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
String RSPERIODO__MMColParam1 = "101217";
if (session.getValue("MM_ID_FUNCIONARIO")   !=null) {RSPERIODO__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")  ;}
%>
<%
String RSPERIODO__MMColParam2 = "0000";
if (request.getParameter("ANNO")           !=null) {RSPERIODO__MMColParam2 = (String)request.getParameter("ANNO")          ;}
%>
<%
String RSPERIODO__MMColParam3 = "00";
if (request.getParameter("PERIODO")           !=null) {RSPERIODO__MMColParam3 = (String)request.getParameter("PERIODO")          ;}
%>
<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT FECHA as F,to_CHAR(FECHA,'DD/MM/YY') AS FECHA, ENTRADA,SALIDA,horas_fichadas,horas_hacer,ROUND(diferencia_minutos) AS DmINUTOS,substr(observaciones,1,35) as observaciones FROM (        SELECT to_DATE(B.FECHA,'dd/mm/yyyy') AS FECHA,          to_char(B.HINICIO,'hh24:mi') AS ENTRADA,          to_char(B.HFIN,'hh24:mi') AS SALIDA,               to_char(b.hcomputablef,'hh24:mi') Horas_fichadas,         to_char(r.horteo,'hh24:mi')  horas_hacer,                 (to_date('30/12/1899' ||to_char(b.hcomputablef,'hh24:mi'),'DD/MM/YYYY HH24:MI') - DECODE( to_char(b.hcomputableo,'hh24:mi')                                                                                                 ,'00:00', b.hcomputableo                                                                                                 , r.horteo) )*60*24                               as diferencia_minutos,                  DECODE( substr(to_char(b.hcomputablef,'hh24:mi')  ,1,2)     ,                          '00',  DECODE( substr(to_char(b.hcomputablef,'hh24:mi')  ,4,2)     ,                                   '00','Posible Incidencia.Ficheje repetido.',                                   '01','Posible Incidencia.Ficheje repetido.',                                   '02','Posible Incidencia.Ficheje repetido.','')                       ,'')                     as observaciones  FROM            PRESENCI R,         PERSFICH B,          WEBPERIODO C,         PERSONA  P,         INTRANET.USUARIO U,         CALENDARIO_LABORAL CA           WHERE           lpad(r.codpers,6,'0')=lpad(u.id_fichaje,6,'0') and          r.fecha=CA.ID_DIA and          lpad(p.codigo,6,'0')=lpad(u.id_fichaje,6,'0') and          lpad(B.NPERSONAL,6,'0')=lpad(u.id_fichaje,6,'0') AND           u.id_usuario='" + RSPERIODO__MMColParam1 + "' and          C.ANO = DECODE('" + RSPERIODO__MMColParam2 + "','0000',to_char(sysdate,'yyyy'),'" + RSPERIODO__MMColParam2 + "') AND           C.MES = DECODE('" + RSPERIODO__MMColParam3 + "','00',lpad(to_char(sysdate,'mm'),2,'0'),'" + RSPERIODO__MMColParam3 + "') and           CA.id_ano=c.ANO AND          CA.ID_DIA BETWEEN C.INICIO AND C.FIN AND          CA.ID_DIA=B.FECHA   UNION    SELECT DISTINCT  to_DATE(id_dia,'dd/mm/yyyy') AS fecha ,                   A.hora_inicio AS entrADA ,                   A.hora_fin AS SALIDA ,                    '00:00' as horas_fichadas,                   '00:00' horas_hacer,                   total_horas,                   DESC_TIPO_PERMISO AS observaciones  FROM RRHH.PERMISO A,        RRHH.TR_TIPO_PERMISO B,       WEBPERIODO c,        PERSONA  P,       CALENDARIO_LABORAL CA,       INTRANET.USUARIO U         WHERE   lpad(a.id_funcionario,6,'0')= lpad(u.id_usuario,6,'0') and          lpad(p.codigo,6,'0')=lpad(u.id_fichaje,6,'0') and          u.id_usuario='" + RSPERIODO__MMColParam1 + "' and          C.ANO = DECODE('" + RSPERIODO__MMColParam2 + "','0000',to_char(sysdate,'yyyy'),'" + RSPERIODO__MMColParam2 + "') AND           C.MES = DECODE('" + RSPERIODO__MMColParam3 + "','00',lpad(to_char(sysdate,'mm'),2,'0'),'" + RSPERIODO__MMColParam3 + "') and           CA.id_ano=c.ANO AND          CA.ID_DIA BETWEEN C.INICIO AND C.FIN AND          a.id_tipo_permiso=b.id_tipo_permiso and          a.id_ano=b.id_ano and          a.id_ano=ca.id_ano and                ((A.FECHA_INICIO   BETWEEN C.INICIO AND C.FIN) or (A.FECHA_fin   BETWEEN C.INICIO AND C.FIN)) and        (id_dia BETWEEN A.FECHA_INICIO and A.FECHA_fin)   And ANULADO='NO'        UNION  SELECT  to_DATE(id_dia,'dd/mm/yyyy') AS fecha ,                   to_char(a.fecha_inicio,'hh24:mi') as entrADA ,                   to_char(a.fecha_fin,'hh24:mi') as SALIDA ,                    '00:00' as horas_fichadas,               '00:00' horas_hacer,                   0 total_horas,                   DESC_TIPO_ausencia AS observaciones  FROM RRHH.ausencia A,        RRHH.TR_TIPO_ausencia B,       WEBPERIODO c,        PERSONA  P,       CALENDARIO_LABORAL CA,       INTRANET.USUARIO U         WHERE   lpad(a.id_funcionario,6,'0')= lpad(u.id_usuario,6,'0') and          lpad(p.codigo,6,'0')=lpad(u.id_fichaje,6,'0') and          u.id_usuario='" + RSPERIODO__MMColParam1 + "' and          C.ANO = DECODE('" + RSPERIODO__MMColParam2 + "','0000',to_char(sysdate,'yyyy'),'" + RSPERIODO__MMColParam2 + "') AND   C.MES = DECODE('" + RSPERIODO__MMColParam3 + "','00',lpad(to_char(sysdate,'mm'),2,'0'),'" + RSPERIODO__MMColParam3 + "') and           CA.id_ano=c.ANO AND          CA.ID_DIA BETWEEN C.INICIO AND C.FIN AND          a.id_tipo_ausencia=b.id_tipo_ausencia and          a.id_ano=ca.id_ano and              ((A.FECHA_INICIO   BETWEEN C.INICIO AND C.FIN) or (A.FECHA_fin   BETWEEN C.INICIO AND C.FIN)) and        (to_date(id_dia,'dd/mm/yy') BETWEEN to_date(to_char(A.FECHA_INICIO,'DD/MM/yy'),'DD/MM/yy') and         to_date(to_char(A.FECHA_FIN,'DD/MM/yy'),'DD/MM/yy'))           And (ANULADO='NO' OR ANULADO IS NULL)            union    SELECT  to_DATE(id_dia,'dd/mm/yyyy') AS fecha ,                   to_char(f.hora,'hh24:mi') as entrADA ,                   '' as SALIDA ,                    '00:00' as horas_fichadas,                    '00:00' horas_hacer,                   0 total_horas,                   'FICHAJE ABIERTO' AS observaciones  FROM fichabie F,       WEBPERIODO c,        PERSONA  P,       CALENDARIO_LABORAL CA,       INTRANET.USUARIO U  WHERE lpad(p.codigo,6,'0')=lpad(u.id_fichaje,6,'0') and          lpad(F.Clave,6,'0')=lpad(u.id_fichaje,6,'0') and          u.id_usuario='" + RSPERIODO__MMColParam1 + "' and          C.ANO = DECODE('" + RSPERIODO__MMColParam2 + "','0000',to_char(sysdate,'yyyy'),'" + RSPERIODO__MMColParam2 + "') AND   C.MES = DECODE('" + RSPERIODO__MMColParam3 + "','00',lpad(to_char(sysdate,'mm'),2,'0'),'" + RSPERIODO__MMColParam3 + "') and           CA.id_ano=c.ANO AND          CA.ID_DIA BETWEEN C.INICIO AND C.FIN AND                    F.FECHA =CA.ID_DIA    )  ORDER BY 1");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>
<%
Driver DriverRSPERIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIO = ConnRSPERIO.prepareStatement("SELECT ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo  FROM  webperiodo  WHERE ano>2007  ORDER BY ano,MES");
ResultSet RSPERIO = StatementRSPERIO.executeQuery();
boolean RSPERIO_isEmpty = !RSPERIO.next();
boolean RSPERIO_hasData = !RSPERIO_isEmpty;
Object RSPERIO_data;
int RSPERIO_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSPERIODO_numRows += Repeat1__numRows;
%>
<%

String I_ID_FUNCIONARIO = "101216";
if(session.getValue("MM_ID_FUNCIONARIO") != null){ I_ID_FUNCIONARIO = (String)session.getValue("MM_ID_FUNCIONARIO");}

%>

<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
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
                        <table border="0" cellspacing="1" cellpadding="3">
                          <tr bgcolor="#e0e0e0">
                            <td bgcolor="#AAAAAA"><a href="../Datos" class="ah12b">Datos per.&nbsp;</a></td>
                            <td bgcolor="#AAAAAA"><a href="../Permisos" class="ah12b">Permisos</a>&nbsp;</td>
                            <td bgcolor="#AAAAAA"><a href="../Ausencias" class="ah12b">Ausencias</a>&nbsp;</td>
                            <td bgcolor="#AAAAAA"><a href="../Bajas" class="ah12b">Bajas</a>&nbsp;</td>
                            <td nowrap bgcolor="#AAAAAA"><a href="../Horas" class="ah12b">Horas ex.</a>&nbsp;</td>
                            <td bgcolor="#AAAAAA"><a href="../Firmas" class="ah12b">Firmas</a>&nbsp;</td>
                            <td bgcolor="#E0E0E0"><a href="../Finger" class="ah12b"><strong>Finger</strong></a>&nbsp;</td>
                          </tr>
                        </table></td>
                      <td class="va10w" align="right"> 
                        <table border="0" cellspacing="0" cellpadding="4">
                          <tr bgcolor="#e0e0e0"> 
                            <td align="right" nowrap bgcolor="#FFFFFF"><a href="../../index.jsp" class="ah12b">Nueva 
                              b&uacute;squeda </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr bgcolor="#E0E0E0"> 
                      <td colspan="2"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr align="right"> 
                      <th bgcolor="#003366"  class="ah12w"><div align="left">Fichajes por periodos y a&ntilde;o. </div></th>
                    </tr>     
                       <tr align="right"> 
                      <td bgcolor="#E0E0E0"  class="ah12w">
                        <table width="100%" border="0" cellpadding="2" cellspacing="0">
                          <tr bgcolor="#FFFFFF">
                            <td  bgcolor="#f2f2f2" valign="top">
                              <form name="formListado" method="GET" action="index.jsp">
                                
                                  
                                      <div align="right">
                                        <table border="0" cellpadding="4" cellspacing="0" bgcolor="#f2f2f2">
                                               
                                     <tr bgcolor="#FFFFFF">
                                                <td align="right" bgcolor="#f2f2f2">A&ntilde;o: </td>
                                                <td colspan="3" bgcolor="#F2F2F2">
                                                  <select name="ANNO">
                                                    <option value="2008">2008</option>
                                                  </select>
                                                </td>
                                                
                                    <td align="right" bgcolor="#f2f2f2">Periodo: </td>
                                                <td align="left" bgcolor="#f2f2f2"><select name="PERIODO" maxlength="100">
                                                  <%
while (RSPERIO_hasData) {
%>
                                                  <option value="<%=((RSPERIO.getObject("MES")!=null)?RSPERIO.getObject("MES"):"")%>" <%=(((RSPERIO.getObject("MES")).toString().equals((RSPERIODO__MMColParam3).toString()))?"SELECTED":"")%> ><%=((RSPERIO.getObject("PERIODO")!=null)?RSPERIO.getObject("PERIODO"):"")%></option>
                                                  <%
  RSPERIO_hasData = RSPERIO.next();
}
RSPERIO.close();
RSPERIO = StatementRSPERIO.executeQuery();
RSPERIO_hasData = RSPERIO.next();
RSPERIO_isEmpty = !RSPERIO_hasData;
%>
                                                </select></td>
                                                <td colspan="2" bgcolor="#f2f2f2">
                                                  <table border="0" cellspacing="0" cellpadding="0" width="50%">
                                                    <tr>
                                                      <td align="right" bgcolor="#f2f2f2">&nbsp; </td>
                                                      <td bgcolor="#f2f2f2" width="5%">&nbsp; </td>
                                                      <td bgcolor="#f2f2f2">
                                                        <input type="submit" name="Buscar2" value="Ver Fichajes">
</td>
                                                    </tr>
                                                </table></td>
                                          </tr>
                                        </table>
                                        </div>
                                      </div>
                              </form></td>
                          </tr>
                          <tr bgcolor="#FFFFFF"> </tr>
                          <tr bgcolor="#FFFFFF"> </tr>
                          
                        
                        </table>
                      </div></td>
                    </tr>
                       
                              <tr> 
                            <td bgcolor="#E0E0E0"><table width="100%"  border="0" cellspacing="1" cellpadding="1">
                              <tr>
                                <td width="10%" scope="col">Fecha</td>
                                <td width="10%" scope="col">Entrada</td>
                                <td width="10%" scope="col"> Salida</td>
                                <td width="10%" scope="col"> Fichadas</td>
                                <td width="10%" scope="col">H. Hacer</td>
                                <td width="10%" scope="col">Diferencia</td>
                                <td scope="col"><div align="center">Observaciones</div></td>
                                <td scope="col">&nbsp;</td>
                              </tr>
                              <% while ((RSPERIODO_hasData)&&(Repeat1__numRows-- != 0)) { %>
                              <tr>
                                  <th scope="row"><%=(((RSPERIODO_data = RSPERIODO.getObject("FECHA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></th>
                                  <td><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("ENTRADA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                  <td><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("SALIDA"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                  <td width="10%"><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("HORAS_FICHADAS"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                  <td><div align="center"><%=(((RSPERIODO_data = RSPERIODO.getObject("HORAS_HACER"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                  <td><div align="right"><%=(((RSPERIODO_data = RSPERIODO.getObject("DMINUTOS"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></div></td>
                                  <td><%=(((RSPERIODO_data = RSPERIODO.getObject("OBSERVACIONES"))==null || RSPERIODO.wasNull())?"":RSPERIODO_data)%></td>
                                  <td>&nbsp;</td>
                              </tr>
                              <%
  Repeat1__index++;
  RSPERIODO_hasData = RSPERIODO.next();
}
%>

                                                        </table></td>
                          </tr>
                      </table>                      </td>
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
RSPERIODO.close();
StatementRSPERIODO.close();
ConnRSPERIODO.close();
%>
<%
RSPERIO.close();
StatementRSPERIO.close();
ConnRSPERIO.close();
%>
