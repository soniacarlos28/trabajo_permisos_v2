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
String RSCABECERA__MMColParam1 = "2021";
if (request.getParameter("ID_ANO")          !=null) {RSCABECERA__MMColParam1 = (String)request.getParameter("ID_ANO")         ;}
%>
<%
String RSQUERY__MMColParam1 = "101217";
if (request.getParameter("ID_FUNCIONARIO")            !=null) {RSQUERY__MMColParam1 = (String)request.getParameter("ID_FUNCIONARIO")           ;}
%>
<%
Driver DriverRSCABECERA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCABECERA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCABECERA = ConnRSCABECERA.prepareStatement("SELECT distinct DECODE(COMPENSABLE,'NO','',COMPENSABLE) AS COMPES,  observacion,     DECODE(to_char(ID_DIA, 'mm'), '01','Enero','02','Febrero', '03','Marzo', '04','Abril','05','Mayo', '06','Junio',  '07','Julio', '08','Agosto', '09','Septiembre', '10','Octubre','11','Noviembre', '12','Diciembre', '') as MES, to_char(id_dia, 'mm') as ID_MES,  ID_DIA, DECODE(to_char(ID_DIA, 'dd'),              '01',              DECODE(to_char(ID_DIA, 'dd/mm'), '01/01', '<tr>', '<tr>') ||              DECODE(to_char(ID_DIA, 'd'),                     7,                     ' <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>     <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>   <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>    <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>',                     6,                     ' <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>    <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>      <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>',                     5,                     ' <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>    <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>',                     4,                     ' <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>',                     3,                     ' <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td>',                     2,                     ' <td width=4% bgcolor=#FFFFFF ><div align=center>  </div></td> ',                     '') ||                     laboral_dia('" + RSQUERY__MMColParam1 + "',id_dia)             ||              DECODE(to_char(ID_DIA, 'd'), 7, '</tr><tr>', ''),              laboral_dia('" + RSQUERY__MMColParam1 + "',id_dia)||                                                              DECODE(to_char(ID_DIA, 'd'), 7, '</tr><tr>', '') ||              DECODE(last_day(id_dia), id_dia, '</tr>', '')) as COLUMNA_F,  DECODE(last_day(id_dia), id_dia, '1', '0') as ultimo_d  FROM rrhh.calendario_final  cl,  rrhh.permiso  p,   rrhh.tr_tipo_columna_calendario tc       WHERE p.id_funcionario(+)='" + RSQUERY__MMColParam1 + "' and cl.id_funcionario='" + RSQUERY__MMColParam1 + "'  and (p.anulado(+) = 'NO' OR p.anulado(+) is NULL)  and p.id_estado(+) in (80, 10, 20, 21, 22)   and p.id_tipo_permiso= tc.id_tipo_permiso(+)     and p.id_estado = tc.id_tipo_estado(+)     and cl.id_ano ='" + RSCABECERA__MMColParam1 + "'   and    cl.id_dia between p.fecha_inicio(+) and p.fecha_fin(+)  and ( ( p.id_tipo_permiso(+)='15000' and total_horas(+)>329) or (p.id_tipo_permiso(+)<>'15000') )  ORDER BY  ID_DIA");



ResultSet RSCABECERA = StatementRSCABECERA.executeQuery();
boolean RSCABECERA_isEmpty = !RSCABECERA.next();
boolean RSCABECERA_hasData = !RSCABECERA_isEmpty;
Object RSCABECERA_data;
int RSCABECERA_numRows = 0;
%>

<%
String RSTIPOPERMISO__MMColParam2 = "2021";
if (request.getParameter("ID_ANO")      !=null) {RSTIPOPERMISO__MMColParam2 = (String)request.getParameter("ID_ANO")     ;}
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
<%
Driver DriverRSQUE_TOTAL = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUE_TOTAL = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUE_TOTAL = ConnRSQUE_TOTAL.prepareStatement("select distinct fc.id_funcionario as ID_FUNCIONARIO,    fc.NOMBRE || ' ' || Ape1 || ' ' || Ape2 as nombre,  TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,1," + RSTIPOPERMISO__MMColParam2  + ") as ENERO_T,  TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,2," + RSTIPOPERMISO__MMColParam2  + ") as FEBRERO_T,        TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,3," + RSTIPOPERMISO__MMColParam2  + ") as MARZO_T   ,     TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,4," + RSTIPOPERMISO__MMColParam2  + ") as ABRIL_T    ,    TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,5," + RSTIPOPERMISO__MMColParam2  + ") as MAYO_T      ,  TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,6," + RSTIPOPERMISO__MMColParam2  + ") as JUNIO_T      ,   TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,7," + RSTIPOPERMISO__MMColParam2  + ") as JULIO_T      ,  TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,8," + RSTIPOPERMISO__MMColParam2  + ") as AGOSTO_T      ,           TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,9," + RSTIPOPERMISO__MMColParam2  + ") as SEPTIEMBRE_T   ,     TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,10," + RSTIPOPERMISO__MMColParam2  + ") as OCTUBRE_T      ,  TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,11," + RSTIPOPERMISO__MMColParam2  + ") as NOVIEMBRE_T     ,           TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,12," + RSTIPOPERMISO__MMColParam2  + ") as DICIEMBRE_T      ,   TURNOS_TRABAJOS_MES(fc.id_funcionario,tipo_funcionario2,13," + RSTIPOPERMISO__MMColParam2  + ") as TOTAL_T      ,ape1 from  personal_new fc  where         (fecha_baja > sysdate or fecha_baja is null)  and fc.id_funcionario='" + RSQUERY__MMColParam1  + "'  order by ape1");
ResultSet RSQUE_TOTAL = StatementRSQUE_TOTAL.executeQuery();
boolean RSQUE_TOTAL_isEmpty = !RSQUE_TOTAL.next();
boolean RSQUE_TOTAL_hasData = !RSQUE_TOTAL_isEmpty;
Object RSQUE_TOTAL_data;
int RSQUE_TOTAL_numRows = 0;
%>
<% 
String RSCOMPENSA="";
String RSCOMPES="";
String RSOBSERVACION="";
String RSOBSERVA="";
String RSULTIMO="0";
String RSMES="01";
int id_mes_col=-1;
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
<script language="Javascript" >
var nTitulares = 0

function verTitulares()
{
	var id = 0;
	while (id < 12) {
		eval('c' + id).style.display='';
		id = id + 1;
	}
	vt.style.display='none';
	ot.style.display='';
}

function ocultarTitulares()
{
	var id = 0;
	while (id < 12) {
		eval('c' + id).style.display='none';
		id = id + 1;
		
	}
	vt.style.display='';
	ot.style.display='none';
}

</script>
<script language="Javascript" >
var nTitulares = 0

function verCompesa()
{
	var id = 0;
	while (id < 12) {
		eval('t' + id).style.display='';
		id = id + 1;
	}
	vta.style.display='none';
	ota.style.display='';
}

function ocultarCompesa()
{
	var id = 0;
	while (id < 12) {
		eval('t' + id).style.display='none';
		id = id + 1;
		
	}
	vta.style.display='';
	ota.style.display='none';
}

</script>
<html>
<head>
<title>Mis Gestiones - Planificador</title>
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="calendario.js"></script>
<body>


<div id="form">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
<tr>
    <td width="3%"  bgcolor="#FFFFFF" class="Estilo11" scope="col"><div align="center">S</div></td>
    <td bgcolor="#f2f2f2" scope="col"><span class="Estilo4"> Pendiente Firma Jefe Seccion</span></td>
    <td width="3%" bgcolor="#FFFFFF" scope="col"><div align="center"><strong></strong>A</strong></div>      </div></td>
    <td bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Pendiente Firma J. Area </span></td>
    <td width="3%"  bgcolor="#FFFFFF" class="Estilo12" scope="col"><div align="center"><strong>R</strong></div></td>
    <td colspan="3" bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Pendiente V&ordm;B RRHH </span></td>
    </tr>
  <tr>
    <td width="3%"  bgcolor="#0099FF" class="Estilo13" scope="col">&nbsp;</td>
    <td bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Vacaciones</span></td>
    <td width="3%" bgcolor="#00CC66" class="Estilo12" scope="col"></strong></div></td>
    <td bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Asuntos Propios</span></td>
    <td width="3%"  bgcolor="#CCCCFF" class="Estilo12" scope="col">&nbsp;</td>
    <td bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Compensatorio</span></td>
    <td width="3%"  bgcolor="#CC3300" class="Estilo12" scope="col">&nbsp;</td>
    <td bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Otros</span></td>
  </tr>
<tr>
    <td width="3%"  bgcolor="#333333" class="Estilo13" scope="col">&nbsp;</td>
    <td bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Fallecimiento/Enfermedad Familiar</span></td>
    <td width="3%" bgcolor="#FFCC99" class="Estilo12" scope="col"></strong></div></td>
    <td bgcolor="#f2f2f2" class="Estilo12" scope="col"><span class="Estilo4">Cursos, Examenes,conferencias </span></td>
    <td bgcolor="#CCCC33" class="Estilo12" scope="col">&nbsp;</td>
    <td colspan="3" bgcolor="#f2f2f2" class="Estilo12" scope="col">Bajas</td>
    </tr>
 </table>   

<table width="95%" border="0" cellspacing="0" cellpadding="2">
<tr>
 <td colspan="1" align="left" class="destacado">Calendario del Año: <select name="ID_ANO" id="ID_ANO" onchange="location.href='mi_calendario.jsp?ID_ANO='+this.value + '&ID_FUNCIONARIO=<%= RSQUERY__MMColParam1 %>'" >

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
</select></td><th>
<% if (RSQUE_TOTAL_hasData) { %>
       <%= (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("ID_FUNCIONARIO"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data)%>--
       <%= (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("NOMBRE"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data)%>
          <%  } %>
</th>
</tr>
 <tr>
  
  <th colspan=3 bgcolor="#f2f2f2">
    
       
           Horas fichadas durante el año:
           
        <% if (RSQUE_TOTAL_hasData) { %>
          <%=(((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("TOTAL_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %>
         <%  } else   {%>
            0  
            <%  } %>
  </th>
 </tr>
  
        <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0) ) 
                               { %>
     <%   RSMES =  (String) (((RSCABECERA_data = RSCABECERA.getObject("ID_MES"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data);  %>
      <%       RSOBSERVA=""; 
               RSCOMPENSA=""; 
             %>                                     
          <%  if  ( RSMES.equals("01") ||  RSMES.equals("04") ||  RSMES.equals("07") ||  RSMES.equals("10")) 
              { %>                    
           <tr> 
             <%   }        %>                     
             <td width=33% valign="top">
            
            
            
            <table width="80%" border="0" cellspacing="1" cellpadding="1">                       
                              <tr bgcolor="#cccccc" bordercolor="#333333"> 
                                 <td align="center" width="15%"><%=(((RSCABECERA_data = RSCABECERA.getObject("MES"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                 </td>                                                                                      
                              </tr>                                            
                        <tr>
                         <td>                          
                        <table width="100%" border="1" cellspacing="1" cellpadding="1">
                               <tr >                           
    						    <td width="4%" bgcolor="#FFFFFF" ><div align="center">Lu</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Ma</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Mi</div></td>
    							<td width="4%" bgcolor="#FFFFFF" ><div align="center">Ju</div></td>
   								<td width="4%" bgcolor="#FFFFFF" ><div align="center">Vi</div></td>
   								<td width="4%" bgcolor="#F5A9A9" ><div align="center">Sa</div></td>
    							<td width="4%" bgcolor="#F5A9A9" ><div align="center">Do</div></td>
    						   </tr>
    							
    			              <% while ((RSCABECERA_hasData)&&(Repeat1__numRows-- != 0) && RSULTIMO.equals("0")) 
                               { %>
                                  <%=(((RSCABECERA_data = RSCABECERA.getObject("COLUMNA_F"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data)%>
                                   <%
                                     RSULTIMO =  (String) (((RSCABECERA_data = RSCABECERA.getObject("ULTIMO_D"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data);                                     
                                    RSOBSERVACION =  (String) (((RSCABECERA_data = RSCABECERA.getObject("OBSERVACION"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data);  
                                    RSCOMPES =  (String) (((RSCABECERA_data = RSCABECERA.getObject("COMPES"))==null || RSCABECERA.wasNull())?"":RSCABECERA_data);
                                    RSCOMPENSA=RSCOMPENSA+ RSCOMPES; 
                                    RSOBSERVA= RSOBSERVA + RSOBSERVACION;
                                     Repeat1__index++;
                                     RSCABECERA_hasData = RSCABECERA.next();
                                     
                                  }
                                    RSULTIMO="0";
                                    id_mes_col++;
                         %>
    							
    							 <%  if  (RSMES.equals("01")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("ENERO_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %>   
                                 <%  if  (RSMES.equals("02")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("FEBRERO_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %>
                                 <%  if  (RSMES.equals("03")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("MARZO_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %>
                                 <%  if  (RSMES.equals("04")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("ABRIL_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %>
                                 <%  if  (RSMES.equals("05")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("MAYO_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %>
                                 <%  if  (RSMES.equals("06")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("JUNIO_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %>
                                 <%  if  (RSMES.equals("07")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("JULIO_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %> 
                                 <%  if  (RSMES.equals("08")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("AGOSTO_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %> 
                                 <%  if  (RSMES.equals("09")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("SEPTIEMBRE_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %> 
                                 <%  if  (RSMES.equals("10")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("OCTUBRE_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %> 
                                 <%  if  (RSMES.equals("11")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("NOVIEMBRE_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %>
                                 <%  if  (RSMES.equals("12")) { %>     									 
                                       <tr  bgcolor="#EFF5FB"><td colspan=7><%=  (((RSQUE_TOTAL_data = RSQUE_TOTAL.getObject("DICIEMBRE_T"))==null || RSQUE_TOTAL.wasNull())?"":RSQUE_TOTAL_data) %></td></tr>
                                 <%   }    %> 
                           </table>
                           </tr>
                           </td>
              </table>              
             </td>     
            <%  if  (RSMES.equals("03") ||  RSMES.equals("06") ||  RSMES.equals("09") ||  RSMES.equals("12")) 
              { %>                    
           </tr> 
             <%   }        %>    
            
              
               <%   }        %>                
                                 
    
                 
                          
                        </table>
</div>

</body>
</html>



<%
RSCABECERA.close();
StatementRSCABECERA.close();
ConnRSCABECERA.close();
%>

<%
RSANOCALENDARIO.close();
StatementRSANOCALENDARIO.close();
ConnRSANOCALENDARIO.close();
%>