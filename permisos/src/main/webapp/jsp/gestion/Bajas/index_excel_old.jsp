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
response.setContentType("application/vnd.ms-excel");

String RSQUERY__MMColParam1 = "0";
if (request.getParameter("ID_TODO")  !=null) {RSQUERY__MMColParam1 = (String)request.getParameter("ID_TODO") ;}
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("select distinct ID_BAJA,b.FECHA_MODI,DECODE(to_char(b.FECHA_MODI,'DD/mm/yyyy'),to_char(sysdate,'DD/mm/yyyy') ,'SI','NO') AS INCIDENCIA,to_char(sysdate,'DD/mm/yyyy') as hoy,b.id_funcionario ,  ape1 || ' '|| ape2 || ' '|| nombre as nombre,fecha_nacimiento,FECHA_ANTIGUEDAD,NVL(DESC_UNIDAD,'No esta en RPT') as UNIDAD,max(telefono) AS TELEFONO,max(dni||dni_letra) AS DNI_LETRA,  to_char(b.fecha_inicio,'dd/mm/yyyy') as fecha_inicio,to_char(b.fecha_fin,'dd/mm/yyyy') as fecha_fin,DECODE(ID_tipo_baja,'AL','ACCIDENTE LABORAL','AR','ACCIDENTE LABORAL RECAIDA','AN','ACCIDENTE NO LABORAL','EC','ENFERMEDAD COMUN','') AS tipo_baja ,OBSERVACIONES from BAJAS_ILT  b, personal_new p,PERSONAL_RPT_VIGENTE pe where b.id_funcionario=p.id_funcionario  and p.id_funcionario=pe.id_funcionario(+) AND (  ('" + RSQUERY__MMColParam1 + "'='0'   AND    to_char(b.FECHA_MODI,'DD/mm/yyyy')=to_char(sysdate,'DD/mm/yyyy')  )     OR       ('" + RSQUERY__MMColParam1 + "'='1')  ) group by ID_BAJA,b.FECHA_MODI,DECODE(to_char(b.FECHA_MODI,'DD/mm/yyyy'),to_char(sysdate,'DD/mm/yyyy') ,'SI','NO'),to_char(sysdate,'DD/mm/yyyy'),b.id_funcionario , ape1 , ape2 , nombre ,fecha_nacimiento,FECHA_ANTIGUEDAD,NVL(DESC_UNIDAD,'No esta en RPT'),  to_char(b.fecha_inicio,'dd/mm/yyyy') ,to_char(b.fecha_fin,'dd/mm/yyyy') ,DECODE(ID_tipo_baja,'AL','ACCIDENTE LABORAL','AR','ACCIDENTE LABORAL RECAIDA','AN','ACCIDENTE NO LABORAL','EC','ENFERMEDAD COMUN',''),OBSERVACIONES union select distinct p.id_permiso as ID_BAJA,p.FECHA_MODI,DECODE(to_char(p.FECHA_MODI,'DD/mm/yyyy'),to_char(sysdate,'DD/mm/yyyy') ,'SI','NO') AS INCIDENCIA,to_char(sysdate,'DD/mm/yyyy') as hoy,p.id_funcionario , ape1 || ' '|| ape2 || ' '|| nombre as nombre,fecha_nacimiento,FECHA_ANTIGUEDAD,NVL(DESC_UNIDAD,'No esta en RPT') as UNIDAD,max(telefono) AS TELEFONO,max(dni||dni_letra) AS DNI_LETRA, to_char(p.fecha_inicio,'dd/mm/yyyy') as fecha_inicio,to_char(p.fecha_fin,'dd/mm/yyyy') as fecha_fin,DESC_TIPO_PERMISO AS tipo_baja,OBSERVACIONES  from permiso p, personal_new pe,TR_TIPO_PERMISO t,PERSONAL_RPT_VIGENTE pert where p.id_ano = to_char(sysdate,'YYYY') and p.id_tipo_permiso=t.id_tipo_permiso and  p.id_ano=t.id_ano    and p.id_tipo_permiso in ('11000', '11100') and p.id_funcionario=pe.id_funcionario and pe.id_funcionario=pert.id_funcionario(+)     and id_Estado=80 and (anulado='NO' OR ANULADO is null )  AND (  ('" + RSQUERY__MMColParam1 + "'='0'   AND    to_char(p.FECHA_MODI,'DD/mm/yyyy')=to_char(sysdate,'DD/mm/yyyy')  )     OR       ('" + RSQUERY__MMColParam1 + "'='1')  ) group by p.id_permiso ,p.FECHA_MODI,DECODE(to_char(p.FECHA_MODI,'DD/mm/yyyy'),to_char(sysdate,'DD/mm/yyyy') ,'SI','NO'),to_char(sysdate,'DD/mm/yyyy'),p.id_funcionario ,  ape1 , ape2 , nombre, fecha_nacimiento,FECHA_ANTIGUEDAD,NVL(DESC_UNIDAD,'No esta en RPT') , to_char(p.fecha_inicio,'dd/mm/yyyy') ,to_char(p.fecha_fin,'dd/mm/yyyy'),DESC_TIPO_PERMISO ,OBSERVACIONES   order by INCIDENCIA DESC, nombre ");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<% String RSIMPAR="";
   String RSCOLOR="";

%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RSQUERY_numRows += Repeat2__numRows;
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
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>

  <div id="form">
     

<table width="100%" border="1" cellspacing="3" cellpadding="4">
                                      <tr bgcolor="#CCFFCC"> 
                                        <td colspan="11" align="center"><b>FECHA INFORME</b> <%=(((RSQUERY_data = RSQUERY.getObject("HOY"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %>   </td>
         
                                      </tr>
                                     
                                      <tr> 
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Funcionario</span></td>
                                        <td width="20%" bgcolor="#CCCCCC" align="center"><span class="va10b">Nombre Apellidos</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">DNI</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Nacimiento</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Antiguedad</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Unidad</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Telefono</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Inicio</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Fin</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Tipo Baja</span></td>
                                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Observaciones</span></td>                                                                      
                                      </tr>
                                      <% while ((RSQUERY_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                      <% if (!RSQUERY_isEmpty ) { 
                                      RSIMPAR =  (String) (((RSQUERY_data = RSQUERY.getObject("INCIDENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data); 
                            	     if (RSIMPAR.equals("SI") )  
                                     	 RSCOLOR="bgcolor=\"#FAD2D2\"";                     	
    				     else 	                   
                                          RSCOLOR="";   							  	  
							  	       %> 							  	                                             
                                      <tr >       
                                                                                                           
                                        <td <%= RSCOLOR %> width="5%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                                                                  
                                        <td <%= RSCOLOR %> width="20%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("DNI_LETRA"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_NACIMIENTO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_ANTIGUEDAD"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="15%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("UNIDAD"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("TELEFONO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>                                        
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA_INICIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="5%" align="right" bgcolor="#FFFFFF"><%=  (((RSQUERY_data = RSQUERY.getObject("FECHA_FIN"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                        <td <%= RSCOLOR %> width="15%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("TIPO_BAJA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                        
                                        <td <%= RSCOLOR %> width="15%" align="right" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("OBSERVACIONES"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                                      
                                      </tr>
                                      <% } /* end !RSQUERY_isEmpty */ %>

                                      <%
  Repeat2__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                                    </table><%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
</body>
</html>



<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
