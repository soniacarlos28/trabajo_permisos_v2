<%@page language="java" import="java.util.Date,java.sql.*" %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%
String RSPERI__MMColParam= "0";
if (request.getParameter("PERIODO") !=null) {RSPERI__MMColParam = (String)request.getParameter("PERIODO");}
%>
<%
Driver DriverRSCONSULTA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCONSULTA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCONSULTA = ConnRSCONSULTA.prepareStatement("SELECT  lpad(DECODE(" + RSPERI__MMColParam + ",0,mes-1,mes),2,'0') ||  ano as peri,ano,mes FROM  webperiodo  WHERE (to_char(sysdate,'yyyy')=ano and to_char(sysdate,'mm')=mes and "+  RSPERI__MMColParam   + "=0 ) or "+  RSPERI__MMColParam +"=mes||ano  order by ano desc,mes desc " );
ResultSet RSCONSULTA = StatementRSCONSULTA.executeQuery();
boolean RSCONSULTA_isEmpty = !RSCONSULTA.next();
boolean RSCONSULTA_hasData = !RSCONSULTA_isEmpty;
Object RSCONSULTA_data;
int RSCONSULTA_numRows = 0;
%>
<%
Driver DriverRSPERIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIO = ConnRSPERIO.prepareStatement("SELECT DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES) || ' de ' || ano as PER2,ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo ,mes ||  ano as per FROM  webperiodo  WHERE ano> to_number(To_char(sysdate,'yyyy'))-2 and  ano ||mes <= to_char(sysdate,'YYYYMM') ORDER BY ano,MES");
ResultSet RSPERIO = StatementRSPERIO.executeQuery();
boolean RSPERIO_isEmpty = !RSPERIO.next();
boolean RSPERIO_hasData = !RSPERIO_isEmpty;
Object RSPERIO_data;
int RSPERIO_numRows = 0;
%>
<% String RSPERI = (String)(((RSCONSULTA_data = RSCONSULTA.getObject("PERI"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data);%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT DISTINCT ID_FUNCIONARIO, NOMBRE, SALDO_REAL, SALDO_BOLSA,nvl(devuelve_min_fto_hora(saldo_final),'0 horas 0 minutos') as SALDO_FINAL, SALDO_FINAL as SALDO_FINAL2,DIAS_TRABAJADOS, INCIDENCIA,to_char(decode(SIN_JUSTIFICAR,0,'',SIN_JUSTIFICAR)) as SIN_JUSTIFICAR, devuelve_min_fto_hora(nvl(horas_tele,0)) as HORAS_TELE,devuelve_min_fto_hora(nvl(horas_aru,0)) as HORAS_ARU, devuelve_min_fto_hora(nvl(HORAS_CONC,0)) as HORAS_CONC,DECODE(INCIDENCIA_FICHAJE,0,'',INCIDENCIA_FICHAJE) as INCIDENCIA_FICHAJE, to_char(FECHA_CARGA,'DD/mm/YYYY hh24:MI') as FECHA_CARGA,   PERIODO,   ID_USUARIO,FECHA_MODI,ID_ANIO,TIPO_CARGA , PERIODO || ID_ANIO AS PER FROM BOLSA_CARGA_MENSUAL where PERIODO || ID_ANIO="+ RSPERI +" ORDER BY  INCIDENCIA DESC, SALDO_FINAL2,ID_FUNCIONARIO");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<% String RSIMPAR="";
   String RSSIN_JUSTIFICAR="";
   String RSCOLOR="";
   String RSCOLOR2="";
   String RSINCIDENCIA="";
   int sin_incidencia = 0;

%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RSQUERY_numRows += Repeat2__numRows;
%>
<%

String RS_EXCEL = "0";
if (request.getParameter("ID_EXCEL")             !=null) {RS_EXCEL  = (String)request.getParameter("ID_EXCEL")            ;}

if (RS_EXCEL.equals("1") )
{  
  response.setContentType("application/vnd.ms-excel");
  response.setHeader("Content-Disposition", "attachment; filename=" + "Proceso Mensual.xls");
}
     
%>
<%
String thisPage = request.getRequestURI();
%>
<%!
public String DoDateTime(java.lang.Object aObject,int nNamedFormat,java.util.Locale aLocale) throws Exception{	
if ((aObject != null) && (aObject instanceof java.util.Date)){
   if (aLocale!=null){
		java.text.DateFormat df = java.text.DateFormat.getDateInstance(nNamedFormat,aLocale);
			return df.format(aObject);
	}
	else{
		java.text.DateFormat df = java.text.DateFormat.getDateInstance(nNamedFormat);
			return df.format(aObject);
	 }
 }
return "";
}
%>
<script language="Javascript" >
var nTitulares = 0

function solos()
{
	var id = 0;
	while (id < nTitulares) {
		eval('c' + id).style.display='';
		id = id + 1;
	}
	vt.style.display='none';
	ot.style.display='';
}

function todos()
{
	var id = 0;
	while (id < nTitulares) {
		eval('c' + id).style.display='none';
		id = id + 1;
	}
	vt.style.display='';
	ot.style.display='none';
}
function envia_unavez()
{


   document.formListado.submit();
  
}
</script>
<html>
<head>
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<% if (RS_EXCEL.equals("0")){%>
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<% }  %>
</head>
<body>
<% if (RS_EXCEL.equals("0")){%>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
      <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
      <li><a href="../../gestion/Bolsa_proceso/index.jsp" id="current" >Saldo Periodo</a></li> 
  
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
   <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
   <li ><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

    </ul>
  <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
   <div id="form">
     <div>
	  <ul id="subtabh">		
		<li><a href="index.jsp" id="current">SNP</a></li>
		<li><a href="index_policias.jsp">Policias</a></li>					
		<li><a href="index_bomberos.jsp">Bomberos</a></li>
	  </ul>
	</div>  
<% }  %>  
  
     
<form name="formListado" method="GET" action="index.jsp">
<table width="78%" border="1" cellspacing="3" cellpadding="4">
                                      <tr bgcolor="#CCFFCC"> 
                                        <td colspan="8" align="center"><b>Proceso carga de bolsa</b></td>
                                        <td colspan="3" align="right">
                                        <div id="vt" style="DISPLAY: ">&nbsp; [<a href="javascript:solos();">Solo incidencias</a>]&nbsp;</div>
                                        <div id="ot" style="DISPLAY: none">&nbsp; [<a href="javascript:todos();">Mostrar todos</a>]&nbsp;</div>	</td>
                                        <td  align="right">
	  <a href='index.jsp?ID_EXCEL=1&'><img	src="../../imagen/excel.jpg" alt="Excel" width="20" height="20" border="0"></a>
	  </td> 
                                      </tr>
                                      <tr bgcolor="#FFFFDD"> 
                                        <td colspan="3">Periodo Cargado: 
                                           <select name="PERIODO" maxlength="100" onChange="javascript:envia_unavez();">
                                           <% while (RSPERIO_hasData) { %>
                                             <option value="<%=((RSPERIO.getObject("PER")!=null)?RSPERIO.getObject("PER"):"")%>" <%=(((RSPERIO.getObject("PER")).toString().equals(((((RSCONSULTA_data = RSCONSULTA.getObject("PERI"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)).toString()))?"SELECTED":"")%> ><%=((RSPERIO.getObject("PERIODO")!=null)?RSPERIO.getObject("PERIODO"):"")%>
                                             </option>
                                             <%
	  												RSPERIO_hasData = RSPERIO.next();
												}
												RSPERIO.close();
												RSPERIO = StatementRSPERIO.executeQuery();
												RSPERIO_hasData = RSPERIO.next();
												RSPERIO_isEmpty = !RSPERIO_hasData;
											 %>    
                                           </select>
                                        </td>
                                        <td colspan="9"><b>Fecha Carga:                                          
                                        <% if (!RSQUERY_isEmpty ) { %>
                                           <%=(((RSQUERY_data = RSQUERY.getObject("FECHA_CARGA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></b>
                                        <% } %>
                                        </td>
                                      </tr>
                                      <tr bgcolor="#FFFFDD">
                                         <td colspan="12"><b>Tipo Carga:
                                         <% if (!RSQUERY_isEmpty ) { %>
                                          <%=(((RSQUERY_data = RSQUERY.getObject("TIPO_CARGA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%> </b></td>
                                         <% } %>
                                      </tr>
                                      <tr> 
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Funcionario</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Nombre Apellidos</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Saldo Real</span></td>
                                        <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Saldo Bolsa</span></td>
                                        <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Dias Trabajados</span></td>
                                         <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Saldo Final</span></td>
                                         <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Permisos/Ausencias sin justificar</span></td>
                                         <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Horas Fichadas x Teletrabajo</span></td>
                                         
                                          <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Incidencia Entradas/Salidas</span></td>
                                                         <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Horas Concilia</span></td>
                                        <td width="4%" bgcolor="#CCCCCC" align="center"><span class="va10b">Incidencia</span></td>
                                        <td width="1%" bgcolor="#CCCCCC" align="center"><span class="va10b"> </span></td>
                                      </tr>
                                      <% while ((RSQUERY_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                      <% if (!RSQUERY_isEmpty ) { 
                                      RSIMPAR =  (String) (((RSQUERY_data = RSQUERY.getObject("INCIDENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data); 
                                      RSSIN_JUSTIFICAR =  (String) (((RSQUERY_data = RSQUERY.getObject("SIN_JUSTIFICAR"))==null || RSQUERY.wasNull())?"":RSQUERY_data); 
                                      RSINCIDENCIA="0";
                            	     if (RSIMPAR.equals("S�") ) 
                            	      { 
                                     	 RSCOLOR="bgcolor=\"#FAD2D2\"";
                                     	 RSINCIDENCIA="1";
                            	      }	 
    				                 else
    				                  {	 
                                          RSCOLOR="";
                                          RSINCIDENCIA="0"; 
    				                  }    
                            	     RSCOLOR2= RSCOLOR;
                            	     if  ( !RSSIN_JUSTIFICAR.equals("") )
                            	      {
                                     	 RSCOLOR2="bgcolor=\"#FD1504\"";
                                     	 RSINCIDENCIA="1"; 
                            	      }
                            	     
							  	        %> 
							  	      <% if  ( RSINCIDENCIA.equals("1") ) { %>
                                      <tr >
                                        <td <%= RSCOLOR2 %>  align="center" width="10%"><%= "<a href='../Finger/index.jsp?ID_FUNCIONARIO=" + (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&NOMBRE=" + (((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&PERIODO=" + (((RSQUERY_data = RSQUERY.getObject("PER"))==null || RSQUERY.wasNull())?"":RSQUERY_data)  + "'>" %><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="45%" align="left" bgcolor="#FFFFFF" nowrap><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("SALDO_REAL"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=  (((RSQUERY_data = RSQUERY.getObject("SALDO_BOLSA"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("DIAS_TRABAJADOS"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF" nowrap><%=(((RSQUERY_data = RSQUERY.getObject("SALDO_FINAL"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("SIN_JUSTIFICAR"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF" nowrap><%=(((RSQUERY_data = RSQUERY.getObject("HORAS_TELE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("INCIDENCIA_FICHAJE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("HORAS_CONC"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                                                             
                                        <td <%= RSCOLOR %> width="4%" align="center" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("INCIDENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="1%" align="center" bgcolor="#FFFFFF">
                                        <% if (RS_EXCEL.equals("0")){%>
                                          <a href="calcula_saldo.jsp?PERIODO=<%= (((RSQUERY_data = RSQUERY.getObject("PERIODO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%><%=(((RSQUERY_data = RSQUERY.getObject("ID_ANIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %>&ID_USUARIO=<%=  session.getValue("MM_ID_USUARIO") %>&ID_FUNCIONARIO=<%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)  %>" ><img src="../../imagen/calculator.png" alt="Carga Saldo" width="20" height="20" border="0"></a>
                                        <% } %>
                                        </td>
                                      </tr>
                                      <%  } else  {  %>
                                        <tr id="c<%= sin_incidencia %>" style="DISPLAY: " >
                                        <td <%= RSCOLOR2 %>  align="center" width="10%"><%= "<a href='../Finger/index.jsp?ID_FUNCIONARIO=" + (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&NOMBRE=" + (((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&PERIODO=" + (((RSQUERY_data = RSQUERY.getObject("PER"))==null || RSQUERY.wasNull())?"":RSQUERY_data)  + "'>" %><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="45%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("SALDO_REAL"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=  (((RSQUERY_data = RSQUERY.getObject("SALDO_BOLSA"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("DIAS_TRABAJADOS"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                            <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF" nowrap><%=(((RSQUERY_data = RSQUERY.getObject("SALDO_FINAL"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                    
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("SIN_JUSTIFICAR"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF" nowrap><%=(((RSQUERY_data = RSQUERY.getObject("HORAS_TELE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                          <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("INCIDENCIA_FICHAJE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("HORAS_CONC"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                                                             
                                        <td <%= RSCOLOR %> width="4%" align="center" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("INCIDENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                          <td <%= RSCOLOR %> width="1%" align="center" bgcolor="#FFFFFF">
                                        <% if (RS_EXCEL.equals("0")){%>
                                          <a href="calcula_saldo.jsp?PERIODO=<%= (((RSQUERY_data = RSQUERY.getObject("PERIODO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%><%=(((RSQUERY_data = RSQUERY.getObject("ID_ANIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %>&ID_USUARIO=<%=  session.getValue("MM_ID_USUARIO") %>&ID_FUNCIONARIO=<%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)  %>" ><img src="../../imagen/calculator.png" alt="Carga Saldo" width="20" height="20" border="0"></a>
                                        <% } %>
                                        </td>  </tr>
                                      <%    sin_incidencia++; }  %>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat2__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                                    </table></div>
</div></form>
</body>
</html>
<script language="JavaScript">
nTitulares = <%= sin_incidencia  %>
</script>


<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
