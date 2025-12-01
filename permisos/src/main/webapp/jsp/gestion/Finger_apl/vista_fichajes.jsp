<%@page language="java" import="java.util.Date,java.sql.*" %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
Driver DriverRSCONSULTA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCONSULTA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCONSULTA = ConnRSCONSULTA.prepareStatement("SELECT denom,To_char(t.HOra,'HH24:MI:ss') as hora,Apellidos || ','|| nombre as nombre ,ENTRADA_SALIDA(PIN) as ENTRADA,PIN  FROM transacciones t ,persona p, relojes r  WHERE t.pin=p.numtarjeta and  t.numero=r.numero and  t.fecha=to_DATE(to_char(sysdate,'DD/MM/YYYY'),'DD/MM/YYYY')  and tipotrans<>23 and t.numserie<>0 and t.pin<>'0000'  ORDER BY hora desc");
ResultSet RSCONSULTA = StatementRSCONSULTA.executeQuery();
boolean RSCONSULTA_isEmpty = !RSCONSULTA.next();
boolean RSCONSULTA_hasData = !RSCONSULTA_isEmpty;
Object RSCONSULTA_data;
int RSCONSULTA_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSCONSULTA_numRows += Repeat1__numRows;
%>

<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>FINGER - Vistas de Fichajes</title>
<meta http-equiv="REFRESH" content="15"> 
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<body>
<table width="830" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="100%" align="left" valign="top"> 
      <table cellspacing=0 cellpadding=3 width=100% border=0>
        <tr bgcolor=#eeeeee> 
          <td width="25%" nowrap bgcolor="#eeeeee"><b></b></td>
          <td width="53%" bgcolor="#eeeeee">&nbsp;</td>
          <td width="4%" align="right" valign="top" nowrap bgcolor="#eeeeee"><b><a href="javascript:window.print()">Imprimir</a></b></td>
          <td width="15%" align="right" valign="top" nowrap bgcolor="#eeeeee"><div align="center"><b> <a href="javascript:window.close()">Cerrar ventana</a></b></div></td>
        </tr>
      </table>
      <table cellspacing=0 cellpadding=3 width=100% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><font face=arial color=#ffffff size=+1><b>Recursos Humanos - Finger  </b></font></td>
        </tr>
        </tbody> 
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="1">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td bgcolor="#E0E0E0"><table width="100%" border="0" cellpadding="4" cellspacing="1">
                        <tr>
                          <td width="15%" bgcolor="#E0E0E0"><strong>Pto. Fichaje </strong></td>
                          <td width="40%" bgcolor="#E0E0E0"><strong>Nombre</strong></td>
                          <td width="10%" bgcolor="#E0E0E0">&nbsp;</td>
                          <td width="15%" bgcolor="#E0E0E0"><div align="center"><strong>Hora</strong></div></td>
                          <td width="25%" bgcolor="#E0E0E0"><div align="center"><strong>Pin</strong></div></td>
                        </tr>
                        <% while ((RSCONSULTA_hasData)&&(Repeat1__numRows-- != 0)) { %>
						 <% if (Repeat1__index%2 == 0) { %>
                          <tr>
                            <td width="15%" bgcolor="#FFFFFF"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("DENOM"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                            <td width="40%" bgcolor="#FFFFFF"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("NOMBRE"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                            <td width="10%" bgcolor="#FFFFFF"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("ENTRADA"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                            <td width="15%" bgcolor="#FFFFFF"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("HORA"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                            <td width="25%" bgcolor="#FFFFFF"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("PIN"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                          </tr>
						    <% } else { %>
                         
<tr>
                          <td bgcolor="#F2F2F2"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("DENOM"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                          <td width="40%" bgcolor="#F2F2F2"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("NOMBRE"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                          <td width="10%" bgcolor="#F2F2F2"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("ENTRADA"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                          <td width="15%" bgcolor="#F2F2F2"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("HORA"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                          <td width="25%" bgcolor="#F2F2F2"><%=(((RSCONSULTA_data = RSCONSULTA.getObject("PIN"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%></td>
                        </tr>
						 <% }
  Repeat1__index++;
  RSCONSULTA_hasData = RSCONSULTA.next();
}
%>
                      </table></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  
    <td class="Estilo12"></td>
  </tr>
</table>
</body>
</html>
<%
RSCONSULTA.close();
StatementRSCONSULTA.close();
ConnRSCONSULTA.close();
%>
