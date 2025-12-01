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
String RSTIPOPERMISO__MMColParam2 = "2021";
if (request.getParameter("ID_ANO")      !=null) {RSTIPOPERMISO__MMColParam2 = (String)request.getParameter("ID_ANO")     ;}
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("select distinct fc.id_funcionario as ID_FUNCIONARIO,    fc.NOMBRE || ' ' || Ape1 || ' ' || Ape2 as nombre, HORAS_TRAJADAS_MES(fc.id_funcionario,23,1,  " + RSTIPOPERMISO__MMColParam2  + ") as ENERO,  HORAS_TRAJADAS_MES(fc.id_funcionario,23,2,  " + RSTIPOPERMISO__MMColParam2  + ") as FEBRERO,     HORAS_TRAJADAS_MES(fc.id_funcionario,23,3,  " + RSTIPOPERMISO__MMColParam2  + ") as MARZO, HORAS_TRAJADAS_MES(fc.id_funcionario,23,4,  " + RSTIPOPERMISO__MMColParam2  + ") as ABRIL,  HORAS_TRAJADAS_MES(fc.id_funcionario,23,5,  " + RSTIPOPERMISO__MMColParam2  + ") as MAYO,     HORAS_TRAJADAS_MES(fc.id_funcionario,23,6,  " + RSTIPOPERMISO__MMColParam2  + ") as JUNIO, HORAS_TRAJADAS_MES(fc.id_funcionario,23,7,  " + RSTIPOPERMISO__MMColParam2  + ") as JULIO,   HORAS_TRAJADAS_MES(fc.id_funcionario,23,8,  " + RSTIPOPERMISO__MMColParam2  + ") as AGOSTO,  HORAS_TRAJADAS_MES(fc.id_funcionario,23,9,  " + RSTIPOPERMISO__MMColParam2  + ") as SEPTIEMBRE, HORAS_TRAJADAS_MES(fc.id_funcionario,23,10,  " + RSTIPOPERMISO__MMColParam2  + ") as OCTUBRE,     HORAS_TRAJADAS_MES(fc.id_funcionario,23,11,  " + RSTIPOPERMISO__MMColParam2  + ") as NOVIEMBRE,       HORAS_TRAJADAS_MES(fc.id_funcionario,23,12,  " + RSTIPOPERMISO__MMColParam2  + ") as DICIEMBRE,    HORAS_TRAJADAS_MES(fc.id_funcionario,23,13,  " + RSTIPOPERMISO__MMColParam2  + ") as TOTAL,ape1 from  personal_new fc  where         (fecha_baja > sysdate or fecha_baja is null) and         fc.tipo_funcionario2=23 order by ape1");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>

<%
Driver DriverRSANOCALENDARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSANOCALENDARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSANOCALENDARIO = ConnRSANOCALENDARIO.prepareStatement("SELECT DISTINCT ID_ANO FROM RRHH.CALENDARIO_LABORAL where id_ano > 2019  ORDER BY ID_ANO DESC");
ResultSet RSANOCALENDARIO = StatementRSANOCALENDARIO.executeQuery();
boolean RSANOCALENDARIO_isEmpty = !RSANOCALENDARIO.next();
boolean RSANOCALENDARIO_hasData = !RSANOCALENDARIO_isEmpty;
Object RSANOCALENDARIO_data;
int RSANOCALENDARIO_numRows = 0;
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
  response.setHeader("Content-Disposition", "attachment; filename=" + "Saldos bomberos.xls");
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
<div id="apliweb-tabform">
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
    </ul>
  </div>
   <div id="form">
     <div>
	  <ul id="subtabh">		
		<li><a href="index.jsp">SNP</a></li>
		<li><a href="index_policias.jsp" >Policias</a></li>					
		<li><a href="index_bomberos.jsp" id="current">Bomberos</a></li>
	  </ul>
	</div>  
<% }  %>  
  
     
<form name="formListado" method="GET" action="index.jsp">
<table width="78%" border="1" cellspacing="3" cellpadding="4">
                                      <tr bgcolor="#CCFFCC"> 
                                        <td colspan="13" align="center"><b>Saldos Bomberos</b></td>
                                        <td align="left" nowrap class="destacado">Año: <select name="ID_ANO" id="ID_ANO" onchange="location.href='index_bomberos.jsp?ID_ANO='+this.value">

          <% while (RSANOCALENDARIO_hasData) {
%><option value="<%=((RSANOCALENDARIO.getObject("ID_ANO")!=null)?RSANOCALENDARIO.getObject("ID_ANO"):"")%>" <%=(((RSANOCALENDARIO.getObject("ID_ANO")).toString().equals((RSTIPOPERMISO__MMColParam2).toString()))?"selected=\"selected\"":"")%> ><%=((RSANOCALENDARIO.getObject("ID_ANO")!=null)?RSANOCALENDARIO.getObject("ID_ANO"):"")%></option>
            <%
  RSANOCALENDARIO_hasData = RSANOCALENDARIO.next();
}
RSANOCALENDARIO.close();
RSANOCALENDARIO = StatementRSANOCALENDARIO.executeQuery();
RSANOCALENDARIO_hasData = RSANOCALENDARIO.next();
RSANOCALENDARIO_isEmpty = !RSANOCALENDARIO_hasData;
%>   
</select></td>                                      
                                        <td  align="right"><a href='index_bomberos.jsp?ID_EXCEL=1&ID_ANO=<%= RSTIPOPERMISO__MMColParam2%>'><img	src="../../imagen/excel.jpg" alt="Excel" width="20" height="20" border="0"></a></td> 
                                      </tr>
                                      <tr> 
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Funcionario</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Nombre Apellidos</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Enero</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Febrero</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Marzo</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Abril</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Mayo</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Junio</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Julio</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Agosto</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Septiembre</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Octubre</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Noviembre</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Diciembre</span></td>
                                        <td width="3%" bgcolor="#CCCCCC" align="center"><span class="va10b">Total</span></td>
                                        
                                      </tr>
                                      <% while ((RSQUERY_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                      <% if (!RSQUERY_isEmpty ) 
                                        {                       
                                    	  
                                    	   if (Repeat2__numRows%2==0)   
                                    	   	    RSCOLOR="";                     	
                                    	    else 	                   
                                    	        RSCOLOR="bgcolor=\"#E7E9F1\"";   
                                    	  
		                            	       %> 
   
		                                      <tr >
		                                        <td <%= RSCOLOR %>  align="center" width="5%"><%= "<a href='mi_calendario.jsp?ID_FUNCIONARIO=" + (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'  target='_blank' >" %><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> width="15%" align="left" bgcolor="#FFFFFF" nowrap><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("ENERO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
		                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FEBRERO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
		                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("MARZO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("ABRIL"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("MAYO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("JUNIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("JULIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("AGOSTO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                                                             
		                                        <td <%= RSCOLOR %> width="4%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("SEPTIEMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> width="4%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("OCTUBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> width="4%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("NOVIEMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>  
		                                        <td <%= RSCOLOR %> width="4%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("DICIEMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
		                                        <td <%= RSCOLOR %> nowrap width="4%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("TOTAL"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>		                                       
		                                      </tr>
                                   
                                      <% 		} /* end !RSQUERY_isEmpty */ %>

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