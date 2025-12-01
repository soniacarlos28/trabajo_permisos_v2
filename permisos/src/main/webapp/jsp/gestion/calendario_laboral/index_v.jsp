<%@page language="java" import="java.util.Date,java.sql.*" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%@ include file="../../../Connections/RRHH.jsp" %>

<% String bisiesto="";
String RSCABECERA__MMColParam1 = "2017";
if (request.getParameter("ID_ANO")          !=null) {RSCABECERA__MMColParam1 = (String)request.getParameter("ID_ANO")         ;}
%>
<%
String RSCABECERA__MMColParam2 = "01/04/2015";
if (request.getParameter("FECHA_INICIO")            !=null) {RSCABECERA__MMColParam2 = (String)request.getParameter("FECHA_INICIO")           ;}
%>
<%
Driver DriverRSCABECERA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCABECERA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCABECERA = ConnRSCABECERA.prepareStatement("SELECT distinct ID_DIA,to_char(mod(id_ano,4)) as bisiesto, DECODE(LABORAL,'SI','<td width=3  bgcolor=CCCCCC align=center><span class=Estilo5>','<td width=3  bgcolor=FF9E00 align=center><span class=Estilo5>') || DECODE(to_char(ID_DIA, 'd'), 1,'L', 2,'M', 3,'X', 4,'J', 5, 'V',6,'S', 7, 'D','O') || '</span></td>' as cabe_ini, DECODE(LABORAL,'SI', '<td width=3  bgcolor=CCCCCC align=center><span class=Estilo5>',                       '<td width=3  bgcolor=FF9E00 align=center><span class=Estilo5>') || '<a href=detalle_dia.jsp?ID_DIA=' || to_char(id_dia,'DD/MM/YYYY')  ||  '><div align=center>' ||   SUBSTR(ID_DIA, 1, 2) || '</a></span></td>' AS cabe_dia,  '' as nombre, '<td><span class=Estilo5>' || '</span></td>' as posicion,  DECODE(to_char(ID_DIA, 'd'),1,'',2,'<td colspan=1></td>',3,'<td colspan=2></td>',4,'<td colspan=3></td>',5,'<td colspan=4></td>',6,'<td colspan=5></td>', 7,'<td colspan=6></td>','') as posicion_f  ,to_char(id_dia,'MM') as id_mes   ,       laboral    FROM calendario_laboral cl WHERE id_ano ='" + RSCABECERA__MMColParam1 + "'    ORDER BY id_dia");



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
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li><a href="../../index_busqueda.jsp">Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>
    <li><a href="" onClick="show_finger()"  class="ah12b">Finger</a></li>
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" >Proceso Bolsa</a></li> 
    <li><a href="index.jsp" class="ah12b" id="current">Calendario Laboral</a></li>   
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
    
  </ul>
  <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>

<table width="95%" border="0" cellspacing="0" cellpadding="2">
                          <tr bgcolor="#FFFFDD"> 
                                        <td colspan="7"><b>Calendario Laboral A�o: <%= RSCABECERA__MMColParam1%></b></td>
                                      </tr>
                                              <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Enero: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="863" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=31; %>
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
    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Febrero: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>          <% bisiesto = (String) (((RSCABECERA_data = RSCABECERA.getObject("bisiesto"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data);
                                         if (bisiesto.equals("0")) 
                                           {                                           
                                             Repeat1__numRows=29;                                        	 
                                        }
                                          else
                                            {                                       
                                             Repeat1__numRows=28;                                        	                                         	 
                                            } %>              
  
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                 <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Marzo: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=31; %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Abril: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=30; %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Mayo: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=31; %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Junio: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=30; %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Julio: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=31; %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Agosto: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=31; %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Septiembre: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=30; %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Octubre: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=31; %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Noviembre: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=30; %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("POSICION_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>                                          
                          <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0)) { %>
                          <%=(((RSCABECERA_data = RSCABECERA.getObject("CABE_DIA"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                        <%
  Repeat1__index++;
  RSCABECERA_hasData = RSCABECERA.next();
}
%>
                          </tr>
  </table>                    <tr bgcolor="#FFFFFF" bordercolor="#333333"> 
                                                <td align="Left" width="15%">Diciembre: 
                                                </td>                                                                                      
                                              </tr>
                                                 <table width="100%" border="1" cellspacing="3" cellpadding="2">
                                  <tr >
                           
    						    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
   								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
  								<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
   								<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
    							<td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
	 							<td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
    							<td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
							    <td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">X</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">J</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">V</div></td>
    							<td width="2%" bgcolor="#DF0101" ><div align="center">S</div></td>
								<td width="2%" bgcolor="#DF0101" ><div align="center">D</div></td>
								 <td width="2%" bgcolor="#FFFFFF" ><div align="center">L</div></td>
							    <td width="2%" bgcolor="#FFFFFF" ><div align="center">M</div></td>
							  
  </tr>
    <tr>                     
   <% Repeat1__numRows=31; %>
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
                             
                                      
                                      </table>
                                    
                                 
                          
</div>
</body>
</html>

