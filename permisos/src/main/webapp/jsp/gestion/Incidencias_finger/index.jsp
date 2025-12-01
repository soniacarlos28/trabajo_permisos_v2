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
String BOLSA_FUN__MMColParam1 = "000000";
if (session.getAttribute("MM_ID_FUNCIONARIO")           !=null) {BOLSA_FUN__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")          ;}
%>
<%
String RSPERI__MMColParamDIA = "0";
if (request.getParameter("ID_DIA") !=null) {RSPERI__MMColParamDIA = (String)request.getParameter("ID_DIA");}
%>
<%
String RSPERI__MMColParamPERI = "0";
if (request.getParameter("PERIODO") !=null) {RSPERI__MMColParamPERI = (String)request.getParameter("PERIODO");}
%>
<%
Driver DriverRSPERI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERI = ConnRSPERI.prepareStatement("SELECT ca.id_dia,DECODE('"+ RSPERI__MMColParamPERI +"',               '0',                 DECODE('"+ RSPERI__MMColParamDIA +"','0',                   to_char(sysdate - 1, 'dd/mm/yyyy'),'"+ RSPERI__MMColParamDIA +"' ),               DECODE('"+ RSPERI__MMColParamDIA +"',                      '0',                        '15/' || mes || '/' || ANO,'"+ RSPERI__MMColParamDIA +"')) as ID_DIA_SEL,        to_chaR(ca.id_dia, 'dd/mm/yyyy') aS PERIODO,        mes || ANO as PER, 		DECODE(max(DECODE(to_char(ID_DIA, 'DD/mm/yyyy'),                          DECODE('"+ RSPERI__MMColParamDIA +"',                                 '0',                               								   DECODE('"+ RSPERI__MMColParamPERI +"', 								    '0',to_char(sysdate - 1, 'dd/mm/yyyy'), 								         '15/' || mes || '/' || ANO),								                                 '"+ RSPERI__MMColParamDIA +"'),                          rownum,                          0)),               1,               '<tr><td><img src=\"../../imagen/tria.gif\" border=0 width=14 height=14></td></tr>',               '<tr><td colspan=' ||               to_number(max(DECODE(to_char(ID_DIA + 1, 'DD/mm/yyyy'),                                    DECODE('"+ RSPERI__MMColParamDIA +"',                                           '0',                                           DECODE('"+ RSPERI__MMColParamPERI +"', 								    '0',to_char(sysdate - 1, 'dd/mm/yyyy'), 								         '15/' || mes || '/' || ANO),                                           '"+ RSPERI__MMColParamDIA +"'),                                    rownum,                                    0))) ||               '></td><td><img src=\"../../imagen/tria.gif\" border=0 width=14 height=14></td></tr>') as ocupa             FROM WEBPERIODO C, CALENDARIO_LABORAL CA  WHERE                   (         (           to_date(DECODE('"+ RSPERI__MMColParamDIA +"',               '0',               to_char(sysdate - 1, 'dd/mm/yyyy'),               DECODE('"+ RSPERI__MMColParamDIA +"',                      '0',                      '15/' || mes || '/' || ANO,'"+ RSPERI__MMColParamDIA +"')),'dd/mm/yyyy') between inicio and fin          and   ('"+ RSPERI__MMColParamPERI +"' = '0' )          )                      OR          (                       DECODE('"+ RSPERI__MMColParamPERI +"',               '0',               lpad(to_char(sysdate, 'mm'), 2, '0') ||               to_char(sysdate, 'yyyy'),               '"+ RSPERI__MMColParamPERI + "') = c.mes||c.ano and               ('"+ RSPERI__MMColParamDIA +"' = '0' )          )   ) and ca.id_dia between inicio and fin  		  group by ca.id_dia,DECODE('"+ RSPERI__MMColParamPERI +"',                '0',                  DECODE('"+ RSPERI__MMColParamDIA +"','0',                    to_char(sysdate - 1, 'dd/mm/yyyy'),'"+ RSPERI__MMColParamDIA +"' ),                DECODE('"+ RSPERI__MMColParamDIA +"',                       '0',                         '15/' || mes || '/' || ANO,'"+ RSPERI__MMColParamDIA +"')),         to_chaR(ca.id_dia, 'dd/mm/yyyy'),         mes || ANO         order by 5 desc,1 asc       ");
ResultSet RSPERI = StatementRSPERI.executeQuery();
boolean RSPERI_isEmpty = !RSPERI.next();
boolean RSPERI_hasData = !RSPERI_isEmpty;
Object RSPERI_data;
int RSPERI_numRows = 0;
%>

<%
Driver DriverRSPERIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIO = ConnRSPERIO.prepareStatement("SELECT DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES) || ' de ' || ano as PER2,ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo ,mes ||  ano as per FROM  webperiodo  WHERE ano> to_number(To_char(sysdate,'yyyy'))-2 and  ano ||mes <= to_char(sysdate+30,'YYYYMM') ORDER BY ano,MES");
ResultSet RSPERIO = StatementRSPERIO.executeQuery();
boolean RSPERIO_isEmpty = !RSPERIO.next();
boolean RSPERIO_hasData = !RSPERIO_isEmpty;
Object RSPERIO_data;
int RSPERIO_numRows = 0;
%>

<%
String RSCONSULTA__MMColParam3 = (String) (((RSPERI_data = RSPERI.getObject("PER"))==null || RSPERI.wasNull())?"":RSPERI_data);
%>


<%
Driver DriverRSCONSULTA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCONSULTA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCONSULTA = ConnRSCONSULTA.prepareStatement("select peri,id_dia, replace(c1 || c2 || c3 || c4 || c5 || c6 || c7,'incidencia_dia','../Finger/detalle_dia') as d1  from (select  id_dia, max(id_funcionario),  min(d_columna1) as c1,         min(d_columna2) as c2, min(d_columna3) as c3, min(d_columna4) as c4, min(d_columna5) as c5, min(d_columna6) as c6, min(d_columna7) as c7,min(C.mes || C.ano) as peri from CALENDARIO_COLUMNA_FICHAJE c   where   C.MES||C.ANO =DECODE('" + RSCONSULTA__MMColParam3 + "','000000',lpad(to_char(sysdate, 'mm'), 2, '0') || to_char(sysdate, 'yyyy'),'" + RSCONSULTA__MMColParam3 + "')       group by id_dia) order by id_dia");
ResultSet RSCONSULTA = StatementRSCONSULTA.executeQuery();
boolean RSCONSULTA_isEmpty = !RSCONSULTA.next();
boolean RSCONSULTA_hasData = !RSCONSULTA_isEmpty;
Object RSCONSULTA_data;
int RSCONSULTA_numRows = 0;
%>
<%
int Repeat3__numRows = -1;
int Repeat3__index = 0;
RSCONSULTA_numRows += Repeat3__numRows;
%>
<%
Driver DriverRSFALTAN = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFALTAN = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFALTAN = ConnRSFALTAN.prepareStatement("select ca.ID_DIA ,        DECODE(r.fecha_incidencia,null, '<td width=\"2%\" bgcolor=\"#FFFFFF\" ><div align=\"center\"></div></td>','<td width=\"2%\" bgcolor=\"#FFEE58\" ><div align=\"center\">I</div></td>') AS CADENA                                   from fichaje_incidencia r  ,calendario_laboral ca,  webperiodo w         where                ca.id_dia =r.fecha_incidencia(+) and                ca.id_dia between w.inicio and w.fin and                                           w.mes ||w.ano =DECODE('" + RSCONSULTA__MMColParam3+ "','000000',lpad(to_char(sysdate, 'mm'), 2, '0')   || to_char(sysdate, 'yyyy'),'" + RSCONSULTA__MMColParam3 + "')   and r.id_funcionario(+) in ('" + BOLSA_FUN__MMColParam1  + "',0)    and ano > 2018     order by ca.id_dia");
ResultSet RSFALTAN = StatementRSFALTAN.executeQuery();
boolean RSFALTAN_isEmpty = !RSFALTAN.next();
boolean RSFALTAN_hasData = !RSFALTAN_isEmpty;
Object RSFALTAN_data;
int RSFALTAN_numRows = 0;
%>
<%
int Repeat13__numRows = -1;
int Repeat13__index = 0;
RSFALTAN_numRows += Repeat13__numRows;
%>

<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT fecha_incidencia,f.id_tipo_incidencia,f.id_funcionario,desc_tipo_incidencia as TI, to_char(fecha_incidencia,'dd/mm/yyyy') as fecha_inc,observaciones   FROM FICHAJE_INCIDENCIA f,tr_tipo_incidencia tr , webperiodo w  where id_funcionario= "+ BOLSA_FUN__MMColParam1 +" and f.id_tipo_incidencia= tr.id_tipo_incidencia  and (fecha_incidencia between inicio and fin) and w.mes||w.ano = '"+  RSPERI__MMColParamPERI +"' order by f.fecha_incidencia");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RSQUERY_numRows += Repeat2__numRows;
%>


<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../esquema.css" rel="stylesheet" type="text/css">
<link href="../apliweb.css" rel="stylesheet" type="text/css">
<script type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->

</script>
<script language="Javascript" >
function show_finger()
{
 	var URL = "vista_fichajes.jsp";
	var WNAME = "FICHAJES";
	var windowW = 830;
	var windowH = 700;
	var windowX = Math.ceil( (window.screen.width  - windowW) / 2 );
	var windowY = Math.ceil( (window.screen.height - windowH) / 2 );
	DIMENSION=",width="+windowW+",height="+windowH;

	splashWin = window.open( URL , WNAME, "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0"+DIMENSION);
	//splashWin.opener = self;
	splashWin.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
	splashWin.focus();
}

</script>
<script language="Javascript" >
function show_calendario()
{
 	var URL = "calendario.jsp?PERIODO=" + document.getElementById("PERIODO").value ;
	var WNAME = "Calendario";
	var windowW = 230;
	var windowH = 200;
	var windowX = Math.ceil( (window.screen.width  - windowW) / 2 );
	var windowY = Math.ceil( (window.screen.height - windowH) / 2 );
	DIMENSION=",width="+windowW+",height="+windowH;

	splashWin = window.open( URL , WNAME, "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0"+DIMENSION);
	//splashWin.opener = self;
	splashWin.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
	splashWin.focus();
}

function show_confirm(id, description, url)
{
   var text = "�Realmente desea eliminar: '" + description + "'?";
   var r = confirm(text);
   if (r==true) { 
      MM_goToURL('self',url + id);
   }
   else { 
      alert("Operaci�n cancelada!"); 
   }
}
function regenera(id, description, url)
{
   var text = "�Realmente desea regenerar : '" + description + "'?";
   var r = confirm(text);
   if (r==true) { 
      MM_goToURL('self',url + id);
   }
   else { 
      alert("Operaci�n cancelada!"); 
   }
}


function envia_unavez()
{


   document.formListado.submit();
  
}

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


<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
      <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>  
       <li><a href="gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
       <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
        <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
 </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" >Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger" >Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
		<li><a href="../Bolsa_concilia" >Bolsa Conciliacion</a></li>
		<li><a href="../Incidencias_finger" id="current">Incidencias  Fichajes</a></li>
	  </ul>
	</div>

  <table width="95%" border="0" cellspacing="0" cellpadding="0">
    <tr align="right"> 
    <td colspan="2" bgcolor="#E0E0E0"  class="ah12w" align="center">
         <table width="100%" border="0" cellpadding="2" cellspacing="0">
           <tr bgcolor="#FFFFFF">
           
           <td colspan="5" valign="top"  bgcolor="#f2f2f2">
           <b><%= session.getValue("MM_ID_FUNCIONARIO") %>--<%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>
	
              <form name="formListado" method="GET" action="index.jsp">
      	      <div align="center">
		      <% if ( (!RSPERIO_isEmpty) ) { %>
		      <table border="0" cellpadding="4" cellspacing="0" bgcolor="#f2f2f2">
			        <tr bgcolor="#FFFFFF">
			        
			        <td align="right" nowrap bgcolor="#f2f2f2">Calendario del Periodo: </td>
                    <td align="left" bgcolor="#f2f2f2">
                       <select name="PERIODO" onChange="javascript:envia_unavez();">
                            <%  while (RSPERIO_hasData) { %>
                             <option value="<%=((RSPERIO.getObject("PER")!=null)?RSPERIO.getObject("PER"):"")%>" <%=(((RSPERIO.getObject("PER")).toString().equals(((((RSCONSULTA_data = RSCONSULTA.getObject("PERI"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)).toString()))?"SELECTED":"")%> ><%=((RSPERIO.getObject("PERIODO")!=null)?RSPERIO.getObject("PERIODO"):"")%></option>
                                <%   RSPERIO_hasData = RSPERIO.next(); }
									 RSPERIO.close();
									 RSPERIO = StatementRSPERIO.executeQuery();
									 RSPERIO_hasData = RSPERIO.next();
									 RSPERIO_isEmpty = !RSPERIO_hasData;
								%>    
                       </select>
                    </td>
                    <td colspan="2" bgcolor="#f2f2f2">
                        <table border="0" cellspacing="0" cellpadding="0" width="50%">
                            <tr>
                            <td align="right" bgcolor="#f2f2f2">&nbsp; </td>
                            <td bgcolor="#f2f2f2" width="5%">&nbsp; </td>
                            <td bgcolor="#f2f2f2"></td>
                            </tr>
                        </table>
                    </td>
                    </tr>
			  </table>
			   <% }  %>
			  </div>
              </form>
            </td>
            </tr>
             
            <tr bgcolor="#FFFFFF">
                <table width="100%" border="1" cellspacing="3" cellpadding="2">
                    <tr>
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
				    <td width="2%" bgcolor="#FFFFFF"  ><div align="center">V</div></td>
    				<td width="2%" bgcolor="#FF9900" ><div align="center">S</div></td>
					<td width="2%" bgcolor="#FF9900" ><div align="center">D</div></td>
                    </tr>
  
                    <tr>
                        <% while ((RSCONSULTA_hasData)&&(Repeat3__numRows-- != 0)) { %>
						<%=(((RSCONSULTA_data = RSCONSULTA.getObject("D1"))==null || RSCONSULTA.wasNull())?"":RSCONSULTA_data)%>                        
						<%  						                          
  							Repeat3__index++;
  							RSCONSULTA_hasData = RSCONSULTA.next();
					      } %>
                    </tr>
                    <tr>
                        <% while ((RSFALTAN_hasData)&&(Repeat13__numRows-- != 0)) { %>
						<%=(((RSFALTAN_data = RSFALTAN.getObject("CADENA"))==null || RSFALTAN.wasNull())?"":RSFALTAN_data)%>                        
						<% Repeat13__index++;
						   RSFALTAN_hasData = RSFALTAN.next();              
                         }%>
                    </tr>      
               </table>
            </tr>
		
			<tr>			
            <td colspan="31" align="center" class="destacado">
               <table width="100%" border="1" cellspacing="3" cellpadding="4">
                      <tr bgcolor="#CCFFCC">           
                      <td colspan="3" align="center"><b>Incidencias</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                           
                      </td>
                      </tr>
                      
                      <tr>                                        
                        <td width="15%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fecha Incidencia</span></td>
                        <td width="25%" bgcolor="#CCCCCC" align="center"><span class="va10b">Tipo Incidencia</span></td>
                        <td width="35%" bgcolor="#CCCCCC" align="center"><span class="va10b">Observaciones</span></td>               
                      </tr>
                      
                      <% while ((RSQUERY_hasData)&&(Repeat2__numRows-- != 0)) { %>
                        <% if (!RSQUERY_isEmpty ) { %>
                         <tr>       
                         <td width="15%" align="left" bgcolor="#FFFFFF"><%=  (((RSQUERY_data = RSQUERY.getObject("FECHA_INC"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>                                    
                         <td width="25%" align="left" bgcolor="#FFFFFF"><%=  (((RSQUERY_data = RSQUERY.getObject("TI"))==null || RSQUERY.wasNull())?"":RSQUERY_data) %></td>
                         <td width="35%" align="left" bgcolor="#FFFFFF"><%=(((RSQUERY_data = RSQUERY.getObject("OBSERVACIONES"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                              
                         </tr>
                        <% } /* end !RSQUERY_isEmpty */ %>
                      <%  Repeat2__index++;
						  RSQUERY_hasData = RSQUERY.next();
                                         }
                                      %>
                 </table>
               </td>
               </tr>
            </table>   
           </td>
           </tr>
           
                     
	  </table>
</div>
	</div>
</body>
</html>

<%
RSPERIO.close();
StatementRSPERIO.close();
ConnRSPERIO.close();
%>

<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
<%
RSCONSULTA.close();
StatementRSCONSULTA.close();
ConnRSCONSULTA.close();
%>
