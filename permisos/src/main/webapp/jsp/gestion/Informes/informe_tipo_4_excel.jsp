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
String RS_DIA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO_NOMBRE")    !=null) {RS_DIA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO_NOMBRE")   ;}
String RS_DIA__MMColParam2 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO_APE1")    !=null) {RS_DIA__MMColParam2 = (String)session.getValue("MM_ID_FUNCIONARIO_APE1")   ;}
String RS_DIA__MMColParam3 = "000000";
if (request.getParameter("PERIODO")             !=null) {RS_DIA__MMColParam3 = (String)request.getParameter("PERIODO")            ;}

%>
<%
 String RS_INFORME = "0";
if (request.getParameter("ID_EJECUCION")             !=null) {RS_INFORME = (String)request.getParameter("ID_EJECUCION")            ;}
%>
<%
Driver DriverRSCABECERA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCABECERA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCABECERA = ConnRSCABECERA.prepareStatement("select to_char(sysdate,'dd/mm/yyyy hh24:mi') as FECHA_INFORME, DECODE(id_tipo_informe,2,1,id_tipo_informe) as id_tipo_informe, campo1, campo2, campo3, campo4, campo5, campo6, campo7, campo8, campo9, campo10, campo11, campo12, campo13, campo14, campo15, campo16, campo17, campo18, campo19, campo20 from fichaje_informe_cabecera where id_tipo_informe= 4");
ResultSet RSCABECERA = StatementRSCABECERA.executeQuery();
boolean RSCABECERA_isEmpty = !RSCABECERA.next();
boolean RSCABECERA_hasData = !RSCABECERA_isEmpty;
Object RSCABECERA_data;
int RSCABECERA_numRows = 0;
%>

<%
Driver DriverRSINFORME = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSINFORME = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSINFORME = ConnRSINFORME.prepareStatement("select titulo,    filtro_1_txt,       filtro_2_txt  ,to_char(ID_TIPO_INFORME) as  ID_TIPO_INFORME       from FICHAJE_INFORME t where ID_EJECUCION='"+ RS_INFORME +"'  ");
ResultSet RSINFORME = StatementRSINFORME.executeQuery();
boolean RSINFORME_isEmpty = !RSINFORME.next();
boolean RSINFORME_hasData = !RSINFORME_isEmpty;
Object RSINFORME_data;
int RSINFORME_numRows = 0;
String RSTIPO_INFORME="";
%>

 
<%
Driver DriverRSDATOS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSDATOS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSDATOS = ConnRSDATOS.prepareStatement("select id_col,to_char(mod(id_col, 2)) as impar, campo1, campo2,campo3, campo31, campo4, campo5, campo6, campo7, campo8, campo9, campo10, campo11, campo12, campo13, campo14, campo15,  campo16, campo17, campo18, campo19, campo20 from fichaje_informe_campo where ID_EJECUCION="+ RS_INFORME +" ORDER BY  id_col");
ResultSet RSDATOS = StatementRSDATOS.executeQuery();
boolean RSDATOS_isEmpty = !RSDATOS.next();
boolean RSDATOS_hasData = !RSDATOS_isEmpty;
Object RSDATOS_data;
int RSDATOS_numRows = 0;
%>


<%

String RS_EXCEL = "0";
if (request.getParameter("ID_EXCEL")             !=null) {RS_EXCEL  = (String)request.getParameter("ID_EXCEL")            ;}

if (RS_EXCEL.equals("1") )
{  
  response.setContentType("application/vnd.ms-excel");
	 if (!RSINFORME_isEmpty ) {
        response.setHeader("Content-Disposition", "attachment; filename=" + "JORNADA_"+  (((RSINFORME_data = RSINFORME.getObject("FILTRO_1_TXT"))==null || RSINFORME.wasNull())?"":RSINFORME_data) + "_"  +  (((RSINFORME_data = RSINFORME.getObject("FILTRO_2_TXT"))==null || RSINFORME.wasNull())?"":RSINFORME_data) +".xls");
      } else { 
           response.setHeader("Content-Disposition", "attachment; filename=" + "JORNADA_"+".xls");
      }
	 
	 

}
if (RS_EXCEL.equals("1") )
{  
%>
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<% } 
%>
<%
String RSIMPAR = ""; 
String RSCOLOR = "";
String RSCOLOR_old = "";
String RSFuncionario="";
String RSDIA="";
String RSFuncionario_old="FD";
String RSDIA_old="TR";

%>

<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSDATOS_numRows += Repeat1__numRows;
%>


<%
String valor_acumulado;
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Informes Fichajes- Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->

</script>

<style type="text/css">
<!--
.Estilo1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body>

	
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
   <th colspan="14" align=center bgcolor="#E6E6E6">Jornada de Trabajo</th>                                             
               
 </tr>  
<tr>
   <td colspan="8" align=center bgcolor="" >
    <%if (!RSINFORME_isEmpty ) { %>
     <%=(((RSINFORME_data = RSINFORME.getObject("TITULO"))==null || RSINFORME.wasNull())?"":RSINFORME_data)%>
    <% } %>
   </p></p> 							
   </td>
   <td colspan="8" align=center bgcolor="" >
  
      <%=(((RSCABECERA_data = RSCABECERA.getObject("FECHA_INFORME"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
   
   							
   </td>
  
 </tr>
 <tr>
   <th colspan="2" align=left bgcolor="" >Personal seleccionado:
   <%if (!RSINFORME_isEmpty ) { %>
    <%=(((RSINFORME_data = RSINFORME.getObject("FILTRO_1_TXT"))==null || RSINFORME.wasNull())?"":RSINFORME_data)%>
  <% } %>
   					
   </th>
 </tr>
 <tr>
   <th colspan="2" align=left bgcolor="" >	Periodo seleccionado:
   <%if (!RSINFORME_isEmpty ) { %> <%=(((RSINFORME_data = RSINFORME.getObject("FILTRO_2_TXT"))==null || RSINFORME.wasNull())?"":RSINFORME_data)%>
   <% } %>					
   </th>
 </tr>
 <tr>
  <td colspan=14>
 
    <table width="100%" border="1" cellspacing="1" cellpadding="1">
      <tr>
        <th colspan="2" align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO1"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>
         <th  align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO5"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>
   	    <th  align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO6"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>
        <th  align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO4"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>
        <th  align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO8"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>
        <th  align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO9"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>
        <th  align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO10"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>    
        <th  align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO11"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>
        <th  align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO12"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>
        <th  align=center bgcolor="#F2F2F2" ><%=(((RSCABECERA_data = RSCABECERA.getObject("CAMPO13"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%></th>
     
       </tr>
	<% if (!RSDATOS_isEmpty ) { %>
	   <% while ((RSDATOS_hasData)&&(Repeat1__numRows-- != 0)) { 

               	   RSFuncionario= (String) (((RSDATOS_data = RSDATOS.getObject("CAMPO1"))==null || RSDATOS.wasNull())?"":RSDATOS_data); 
              	   RSDIA= (String) (((RSDATOS_data = RSDATOS.getObject("CAMPO5"))==null || RSDATOS.wasNull())?"":RSDATOS_data); 
                      
              	  if (!RSDIA.equals(RSDIA_old ) )
              	  {
              		 if (RSCOLOR_old.equals(""))
              			 RSCOLOR="bgcolor=\"#d4efdf\"";  
              		 else 	 
              		      RSCOLOR="";		 
              	  }
              	  
              	     
					  	  %> 
		
					  	  
            <tr>
            
   	        	<td  colspan="2" align=center  >
   	            <%  if (!RSFuncionario.equals(RSFuncionario_old ) ) { %>	
   	        	
   	        	<%=(((RSDATOS_data = RSDATOS.getObject("CAMPO1"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%>-
   								<%=(((RSDATOS_data = RSDATOS.getObject("CAMPO2"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%><%   } %></td>
   								
   				<td  <%=RSCOLOR %>  align=center  ><%=(((RSDATOS_data = RSDATOS.getObject("CAMPO5"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%></td>
   				<td  <%=RSCOLOR %>  align=center  ><%=(((RSDATOS_data = RSDATOS.getObject("CAMPO6"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%></td>
   				<td  <%=RSCOLOR %> align=center  ><%=(((RSDATOS_data = RSDATOS.getObject("CAMPO4"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%></td>
   				<td  <%=RSCOLOR %> align=center  ><%=(((RSDATOS_data = RSDATOS.getObject("CAMPO8"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%></td>
   				<td  <%=RSCOLOR %> align=center  ><%=(((RSDATOS_data = RSDATOS.getObject("CAMPO9"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%></td>
   			    <td  <%=RSCOLOR %> align=center  ><%=(((RSDATOS_data = RSDATOS.getObject("CAMPO10"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%></td>
   			    <td  <%=RSCOLOR %> align=center  ><%=(((RSDATOS_data = RSDATOS.getObject("CAMPO11"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%></td>
   			    <td  <%=RSCOLOR %> align=center  ><%=(((RSDATOS_data = RSDATOS.getObject("CAMPO12"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%></td>
   			    <td  <%=RSCOLOR %> align=center  ><%=(((RSDATOS_data = RSDATOS.getObject("CAMPO13"))==null || RSDATOS.wasNull())?"":RSDATOS_data)%></td>
   				
   					</tr>
                              <%
  Repeat1__index++;
  RSDATOS_hasData = RSDATOS.next();
  
  RSFuncionario_old=RSFuncionario; 
  RSDIA_old=RSDIA; 
  RSCOLOR_old=RSCOLOR;
  
}
%>
                          <% } /* end !RSSALDO_isEmpty */ %>	
             </tr>    
           </table>           						
  
  
  </table>
	

	
</body>
</html>

<%
RSDATOS.close();
StatementRSDATOS.close();
ConnRSDATOS.close();
%>
<%
RSCABECERA.close();
StatementRSCABECERA.close();
ConnRSCABECERA.close();
%>