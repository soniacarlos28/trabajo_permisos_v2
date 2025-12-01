<%@page language="java" import="java.util.Date,java.sql.*" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
String RSNAVFECHA__MMColParam1 = "01/04/2015";
if (request.getParameter("FECHA_INICIO")          !=null) {RSNAVFECHA__MMColParam1 = (String)request.getParameter("FECHA_INICIO")         ;}
%>

<%
Driver DriverRSNAVFECHA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSNAVFECHA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSNAVFECHA = ConnRSNAVFECHA.prepareStatement("SELECT to_char(to_date('" + RSNAVFECHA__MMColParam1 + "','DD/mm/yyyy')-1,'dd/mm/yyyy') as dia_ant, to_char(to_date('" + RSNAVFECHA__MMColParam1 + "','DD/mm/yyyy')-31,'dd/mm/yyyy') as mes_ant,      to_char(to_date('" + RSNAVFECHA__MMColParam1 + "','DD/mm/yyyy')+1,'dd/mm/yyyy') as dia_pos,  to_char( to_date('" + RSNAVFECHA__MMColParam1 + "','DD/mm/yyyy')+31,'dd/mm/yyyy') as mes_pos  FROM dual");
ResultSet RSNAVFECHA = StatementRSNAVFECHA.executeQuery();
boolean RSNAVFECHA_isEmpty = !RSNAVFECHA.next();
boolean RSNAVFECHA_hasData = !RSNAVFECHA_isEmpty;
Object RSNAVFECHA_data;
int RSNAVFECHA_numRows = 0;
%>
<%
String RSCABECERA__MMColParam1 = "01/04/2015";
if (request.getParameter("ID_ANO")          !=null) {RSCABECERA__MMColParam1 = (String)request.getParameter("ID_ANO")         ;}
%>
<%
String RSCABECERA__MMColParam2 = "01/04/2015";
if (request.getParameter("FECHA_INICIO")            !=null) {RSCABECERA__MMColParam2 = (String)request.getParameter("FECHA_INICIO")           ;}
%>
<%
Driver DriverRSCABECERA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCABECERA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCABECERA = ConnRSCABECERA.prepareStatement("SELECT distinct ID_DIA, DECODE(LABORAL,'SI','<td width=3  bgcolor=CCCCCC align=center><span class=Estilo5>','<td width=3  bgcolor=FF9E00 align=center><span class=Estilo5>') || DECODE(to_char(ID_DIA, 'd'), 1,'L', 2,'M', 3,'X', 4,'J', 5, 'V',6,'S', 7, 'D','O') || '</span></td>' as cabe_ini, DECODE(LABORAL,'SI','<td width=3  bgcolor=CCCCCC align=center><span class=Estilo5>', '<td width=3  bgcolor=FF9E00 align=center><span class=Estilo5>') ||  SUBSTR(ID_DIA, 1, 2) || '</span></td>' AS cabe_dia, '' as nombre, '<td><span class=Estilo5>' || '</span></td>' as posicion,   DECODE(to_char(id_dia,'dd'),'01','<td colspan='  || to_number(DECODE(to_char(ID_DIA, 'd'), 1,'0', 2,'1', 3,'2', 4,'3', 5, '4',6,'5',7, '6','0'))  ||'></td>','' ) as posicion_f    ,to_char(id_dia,'MM') as id_mes          laboral    FROM calendario_laboral cl WHERE id_ano ='" + RSCABECERA__MMColParam1 + "'    ORDER BY id_dia");



ResultSet RSCABECERA = StatementRSCABECERA.executeQuery();
boolean RSCABECERA_isEmpty = !RSCABECERA.next();
boolean RSCABECERA_hasData = !RSCABECERA_isEmpty;
Object RSCABECERA_data;
int RSCABECERA_numRows = 0;
%>

<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSCABECERA_numRows += Repeat1__numRows;
%>

<%
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

int RSCABECERA_first = 1;
int RSCABECERA_last  = 1;
int RSCABECERA_total = -1;

if (RSCABECERA_isEmpty) {
  RSCABECERA_total = RSCABECERA_first = RSCABECERA_last = 0;
}

//set the number of rows displayed on this page
if (RSCABECERA_numRows == 0) {
  RSCABECERA_numRows = 1;
}
%>

<%
// *** Recordset Stats: if we don't know the record count, manually count them

if (RSCABECERA_total == -1) {

  // count the total records by iterating through the recordset
    for (RSCABECERA_total = 1; RSCABECERA.next(); RSCABECERA_total++);

  // reset the cursor to the beginning
  RSCABECERA.close();
  RSCABECERA = StatementRSCABECERA.executeQuery();
  RSCABECERA_hasData = RSCABECERA.next();

  // set the number of rows displayed on this page
  if (RSCABECERA_numRows < 0 || RSCABECERA_numRows > RSCABECERA_total) {
    RSCABECERA_numRows = RSCABECERA_total;
  }

  // set the first and last displayed record
  RSCABECERA_first = Math.min(RSCABECERA_first, RSCABECERA_total);
  RSCABECERA_last  = Math.min(RSCABECERA_first + RSCABECERA_numRows - 1, RSCABECERA_total);
}
%>

<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Mis Gestiones - Planificador</title>
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="calendario.js"></script>
<body>

<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li ><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
    <li><a href="../Listados" >Listados Generales</a></li>
    <li><a href="" onClick="../Finger">Finger</a></li>
    <li id="active" ><a href="#" id="current">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>   
  </ul>
</div>
<div id="form">
<table width="95%" border="0" cellspacing="0" cellpadding="2">
                          <tr> 
                            <td> 
                              <table border="0" cellspacing="0" cellpadding="2" width="100%">
                                <tr bgcolor="#FFFFFF"> 
                                  <td bgcolor="#FFFFFF" valign="top"> 
                                    <form name="form" method=post action="index.jsp">
                                      <table border="0" cellspacing="0" cellpadding="4">
                                        <tr bgcolor="#FFFFFF"> 
                                          <td colspan="4"> 
                                           
                                          </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td colspan="4"> 
                                            <table border="0" cellspacing="0" cellpadding="2">
                                              <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td colspan="2"> 
                                                
                                                </td>
                                                <td colspan="2">                                             
                                                </td>
                                              </tr>
                                              
                                              <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="right" width="15%">Enero: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
  </tr>
    <tr>                     
    Repeat1__numRows=31;
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                                      
                                          </td>
                                        </tr>
                                      </table>
                                    </form>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
</div>