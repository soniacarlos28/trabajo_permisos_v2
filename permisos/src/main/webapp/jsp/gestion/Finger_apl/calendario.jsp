<%@page language="java" import="java.util.Date,java.sql.*" %>
<%@ include file="../../../Connections/RRHH.jsp" %>

<%
String RSCONSULTA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSCONSULTA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSCONSULTA__MMColParam2 = "0000";
if (request.getParameter("PERIODO")           !=null) {RSCONSULTA__MMColParam2 = (String)request.getParameter("PERIODO")          ;}
%>


<%
Driver DriverRSCONSULTA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCONSULTA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCONSULTA = ConnRSCONSULTA.prepareStatement("select id_dia, c1 ||c2||c3||c4||c5||c6||c7  as d1   from (select  id_dia, max(id_funcionario),  min(columna1) as c1,         min(columna2) as c2, min(columna3) as c3, min(columna4) as c4, min(columna5) as c5, min(columna6) as c6, min(columna7) as c7 from CALENDARIO_COLUMNA_FICHAJE c   where   C.MES||C.ANO ='" + RSCONSULTA__MMColParam2 + "'  and id_funcionario in ('" + RSCONSULTA__MMColParam1 + "',0)    group by id_dia) order by id_dia");
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="100%" align="left" valign="top"> 
      <table cellspacing=0 cellpadding=3 width=100% border=0>
        <tr bgcolor=#eeeeee> 
         
          <td  align="right" valign="top" nowrap bgcolor="#eeeeee"><div align="center"><b> <a href="javascript:window.close()">Cerrar ventana</a></b></div></td>
        </tr>
      </table>
      <table cellspacing=0 cellpadding=3 width=100% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><font face=arial color=#ffffff size=+1><b>Calendario</b></font></td>
        </tr>
        </tbody> 
      </table>
      <table width="100%" border="1" cellpadding="3" cellspacing="1" bordercolor="#999999">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="1" cellpadding="3" cellspacing="1" bordercolor="#CCCCCC">
                    <tr>
    <th width="20%" bgcolor="#9999FF" scope="col"><div align="center">L</div></th>
    <th width="20%" bgcolor="#9999FF" scope="col"><div align="center">M</div></th>
    <th width="20%" bgcolor="#9999FF"  scope="col"><div align="center">X</div></th>
    <th width="20%" bgcolor="#9999FF" scope="col"><div align="center">J</div></th>
    <th width="20%" bgcolor="#9999FF" scope="col"><div align="center">V</div></th>
    <th width="20%" bgcolor="#FF6633" scope="col"><div align="center">S</div></th>
    <th width="20%" bgcolor="#FF6633" scope="col"><div align="center">D</div></th>
  </tr>
                        <% while ((RSCONSULTA_hasData)&&(Repeat1__numRows-- != 0)) { %>
						<%=(((RSCONSULTA_data = RSCONSULTA.getObject("D1"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%>                        <%  						                          
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
