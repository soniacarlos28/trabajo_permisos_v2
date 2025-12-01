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
String PR_ORDEN = "ASC";
if(request.getParameter("ORDEN") != null){ PR_ORDEN  = (String)request.getParameter("ORDEN");}
%>
<% 
String PRCAMPO_ORDENA = "APE1 " ;
if(request.getParameter("CAMPO_ORDENA") != null){ PRCAMPO_ORDENA = (String)request.getParameter("CAMPO_ORDENA");}

PRCAMPO_ORDENA= PRCAMPO_ORDENA + " "+ PR_ORDEN +" , APE1 asc, APE2, nombres,fecha_inicio";
%>
<% 
    String CAMPO_ORDENA="";
    String ORDEN="";
%>
<%
Driver DriverRSCLAVE_FI = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCLAVE_FI = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCLAVE_FI = ConnRSCLAVE_FI.prepareStatement("select sec_permiso_vali_todos.nextval as CLAVE_FIRMA from dual");
ResultSet RSCLAVE_FI = StatementRSCLAVE_FI.executeQuery();
boolean RSCLAVE_FI_isEmpty = !RSCLAVE_FI.next();
boolean RSCLAVE_FI_hasData = !RSCLAVE_FI_isEmpty;
Object RSCLAVE_FI_data;
int RSCLAVE_FI_numRows = 0;
%>      
<%
Driver DriverRSPENDIENTE = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPENDIENTE = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPENDIENTE = ConnRSPENDIENTE.prepareStatement("SELECT distinct DECODE(JUSTIFICADO,'--','',CHEQUEA_ENLACE_FICHERO_JUS(pe.ID_ANO,pe.ID_FUNCIONARIO,pe.ID_AUSENCIA,pe.id_estado,'A',2)) as JUSTI_FICHERO,pe.id_Funcionario,                rownum as FILA,                pe.ID_ANO,         pe.FECHA_INICIO as FECHA_INI, pe.FECHA_FIN as FECHA_FINI,pe.id_tipo_ausencia as id_tipo_per,        ID_AUSENCIA  as ID_PERMISO,                ape1,                ape2,                initcap(Nombre) || ' ' || INITCAP(Ape1) || ' ' ||                INITCAP(Ape2) as NOMBRES,                to_char(pe.fecha_inicio, 'dd/mm/yyyy hh24:mi') as FECHA_INICIO,                to_char(pe.fecha_fin, 'dd/mm/yyyy hh24:mi') as FECHA_FIN,                trunc(pe.total_horas/60) || ':' || lpad(mod(pe.total_horas,60),2,'0')  as num_dias,                DEsc_tipo_ausencia as DESC_TIPO_PERMISO,                pe.JUSTIFICADO  as JUSTI            FROM AUSENCIA pe, personal_new p, tr_tipo_AUSENCIA tr             WHERE pe.id_funcionario = p.id_funcionario               and tr.id_tipo_AUSENCIA = pe.id_tipo_AUSENCIA               and id_Estado = '22'               and (anulado = 'NO' OR ANULADO IS NULL)   and tr.id_tipo_AUSENCIA <> '998' ORDER BY " + PRCAMPO_ORDENA+ "");
ResultSet RSPENDIENTE = StatementRSPENDIENTE.executeQuery();
boolean RSPENDIENTE_isEmpty = !RSPENDIENTE.next();
boolean RSPENDIENTE_hasData = !RSPENDIENTE_isEmpty;
Object RSPENDIENTE_data;
int RSPENDIENTE_numRows = 0;
%>
<%
int Repeat1__numRows = 250;
int Repeat1__index = 0;
RSPENDIENTE_numRows += Repeat1__numRows;
%>
<%
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

int RSPENDIENTE_first = 1;
int RSPENDIENTE_last  = 1;
int RSPENDIENTE_total = -1;

if (RSPENDIENTE_isEmpty) {
  RSPENDIENTE_total = RSPENDIENTE_first = RSPENDIENTE_last = 0;
}

//set the number of rows displayed on this page
if (RSPENDIENTE_numRows == 0) {
  RSPENDIENTE_numRows = 1;
}
%>
<%
// *** Recordset Stats: if we don't know the record count, manually count them

if (RSPENDIENTE_total == -1) {

  // count the total records by iterating through the recordset
    for (RSPENDIENTE_total = 1; RSPENDIENTE.next(); RSPENDIENTE_total++);

  // reset the cursor to the beginning
  RSPENDIENTE.close();
  RSPENDIENTE = StatementRSPENDIENTE.executeQuery();
  RSPENDIENTE_hasData = RSPENDIENTE.next();

  // set the number of rows displayed on this page
  if (RSPENDIENTE_numRows < 0 || RSPENDIENTE_numRows > RSPENDIENTE_total) {
    RSPENDIENTE_numRows = RSPENDIENTE_total;
  }

  // set the first and last displayed record
  RSPENDIENTE_first = Math.min(RSPENDIENTE_first, RSPENDIENTE_total);
  RSPENDIENTE_last  = Math.min(RSPENDIENTE_first + RSPENDIENTE_numRows - 1, RSPENDIENTE_total);
}
%>


<%
String thisPage = request.getRequestURI();
%>
<script>


function MM_goToURL() { //v3.0
	  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
	  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
	}

function c_ordenar(id)
	{
      
   var ordena;
   var campo_ordenar;
   
   if	(document.Sindicales.ORDEN.value == "ASC")
            {	 
		       ordena = "DESC";
		   
            }
   else  {
               ordena = "ASC";
	     }
   document.Sindicales.ORDEN.value =  ordena;
    if (id == 1)
         {
    	document.Sindicales.ID_CAMPO_ORDENA.value="ID_ANO";
        }

    if (id == 2)
       {
	    document.Sindicales.ID_CAMPO_ORDENA.value="ID_FUNCIONARIO";
         }

    if (id == 3)
       {
	    document.Sindicales.ID_CAMPO_ORDENA.value="APE1";
       }

    if (id == 4)
    {
	    document.Sindicales.ID_CAMPO_ORDENA.value="ID_TIPO_PER";
    }

    if (id == 5)
    {
	    document.Sindicales.ID_CAMPO_ORDENA.value="FECHA_INI";
    }

    if (id == 6)
    {
	    document.Sindicales.ID_CAMPO_ORDENA.value="FECHA_FINI";
    }

    if (id == 7)
    {
	    document.Sindicales.ID_CAMPO_ORDENA.value="JUSTIFI";
    }
                
    url="index.jsp?CAMPO_ORDENA=" +  document.Sindicales.ID_CAMPO_ORDENA.value + "&ORDEN=" +document.Sindicales.ORDEN.value;
    MM_goToURL('self',url);
	 
	}

function envia_unavez(firma)
{


 if (document.Sindicales.AUTO.disabled==false) 
	  {
			 document.Sindicales.AUTO.disabled=true;
			 document.Sindicales.DENI.disabled=true;
			 
		
	     for (x = 1; x <=  <%=(RSPENDIENTE_total)%>; x++)
         {
          if (document.getElementById('AP'+x).checked == true)  
               {
       	   document.Sindicales.TODO_T.value=  ";"+ document.getElementById('PER'+x).value + document.Sindicales.TODO_T.value;
                }
        }   
	       document.Sindicales.TODO_T.value=  document.Sindicales.TODO_T.value+ ";";
		   document.Sindicales.ID_AUTORIZA.value=firma;
		  
		   document.Sindicales.submit(); 
	 }  
	   
       
}
// -->
</script>
<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><body OnLoad="carga_final()">
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp" id="current">Autorizar</a></li>
    
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
     <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

    </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
<div id="form"><div>
	  <ul id="subtabh">
		<li><a href="../../gestion/Permisos_vo_rrhh/index.jsp" >Permisos pendientes autorizar</a></li>
		<li><a href="../../gestion/Ausencias_vo_rrhh/index.jsp" id="current" >Ausencias pendientes autorizar</a></li>	
		<li><a href="../../gestion/Fichajes_vo_rrhh/index.jsp" >Fichajes pendientes autorizar</a></li>		
	  </ul>
	</div>
<div id="subform">

<table width="85%" border="0" cellspacing="1" cellpadding="2">
<form name="Sindicales" method="POST" action="firmar_select.jsp">
                                      <tr bgcolor="#CCFFCC">
                                         <td colspan="10" align="center"><b>Ausencias pendientes de V�B�</b> <input type="hidden" name="TODO_T" ID="TODO_T" size="122" >
                                        <input type="hidden" name="ID_AUTORIZA" ID="ID_AUTORIZA" size="1" value="" >
                                        <input type="hidden" name="TIPO_T" ID="TIPO_T" size="1" value="A" >
                                        <input type="hidden" name="ID_FIRMA_PERMISO" ID="ID_FIRMA_PERMISO" size="10" value="<%= session.getValue("MM_ID_USUARIO")%>" >
                                        <input type="hidden" name="ID_CLAVE_FIRMA"   ID="ID_CLAVE_FIRMA" size="15" value="<%=(((RSCLAVE_FI_data = RSCLAVE_FI.getObject("CLAVE_FIRMA"))==null || RSCLAVE_FI.wasNull())?"":RSCLAVE_FI_data)%>" >
                                        <input type="hidden" name="ID_CAMPO_ORDENA" ID="ID_CAMPO_ORDENA" size="10" value="<%= PRCAMPO_ORDENA %>" >
                                        <input type="hidden" name="ORDEN"   ID="ORDEN" size="15" value="<%= PR_ORDEN %>" > 
                                        
                                        </td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC" >
                                        <td colspan="3"> <input type="submit" value="Autorizar selecionados" ID="AUTO" name="AUTO"onClick="javascript:envia_unavez('1');"></td> 
                                        <td colspan="7" align="left"><input type="submit" value="Denegar selecionados" ID="DENI" name="DENI" onClick="javascript:envia_unavez('0');">                                       
                                         &nbsp;Motivo denegaci�n: &nbsp;<input type="tex" name="ID_MOTIVO_DENEGA" ID="ID_MOTIVO_DENEGA" size="55" value="" >
                                        
                                        </td>
                                      </tr>
                              <tr> 
                                        <td width="2%" bgcolor="#CCCCCC" align="center"><span class="va10b">Selecionar</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b"><a href="javascript:c_ordenar('1')">A�o</a></span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b"><a href="javascript:c_ordenar('2')">Funcio</a></span></td>
                                        <td width="32%" bgcolor="#CCCCCC" align="center"><span class="va10b"><a href="javascript:c_ordenar('3')">Nombre</a></span></td>
                                        <td width="32%" bgcolor="#CCCCCC" align="center"><span class="va10b"><a href="javascript:c_ordenar('4')">Permiso</a></span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b"><a href="javascript:c_ordenar('5')">Fecha Inicio</a></span></td>
                                        <td width="10%" bgcolor="#CCCCCC" align="center"><span class="va10b"><a href="javascript:c_ordenar('6')">Fecha Fin</a></span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Horas</span></td>
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b"><a href="javascript:c_ordenar('7')">Justificado</a></span></td>                                      
                                        <td width="5%" bgcolor="#CCCCCC" align="center"><span class="va10b">Fichero</span></td>                   
                                      </tr>
                                <% while ((RSPENDIENTE_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                <% if (!RSPENDIENTE_isEmpty ) { %>                                
                                  <tr>
                                        <td align="center" width="10%"> <input type="checkbox" name="AP<%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FILA"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%>"  id="AP<%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FILA"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%>" >
                                         <input type="hidden" name="PER<%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FILA"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%>"  id="PER<%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FILA"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%>"  value="<%= (((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_PERMISO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) %>" >
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_ANO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>                                      
                                        <td align="left" bgcolor="#FFFFFF"><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_FUNCIONARIO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                        <td align="left" bgcolor="#FFFFFF"><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("NOMBRES"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                        <td align="left" bgcolor="#FFFFFF"><%= "<a href='firmar_solicitud_a.jsp?ID_AUSENCIA=" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_PERMISO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "&ID_ANO=" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_ANO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "'>" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("DESC_TIPO_PERMISO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "</a>" %></td>
                                        <td align="left" bgcolor="#FFFFFF"><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FECHA_INICIO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                        <td align="left" bgcolor="#FFFFFF"><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FECHA_FIN"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>                                        
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("NUM_DIAS"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                        <td align="center" bgcolor="#FFFFFF"><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("JUSTI"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                                  <td align="center" bgcolor="#FFFFFF"><%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("JUSTI_FICHERO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%></td>
                               
                                    </tr>
                                <% } /* end !RSPENDIENTE_isEmpty */ %>
                                <%
  Repeat1__index++;
  RSPENDIENTE_hasData = RSPENDIENTE.next();
}
%>
                         
            
   </form>
</table>


</div>



</body>
</html>
<%
RSPENDIENTE.close();
StatementRSPENDIENTE.close();
ConnRSPENDIENTE.close();
%>
<%
RSCLAVE_FI.close();
StatementRSCLAVE_FI.close();
ConnRSCLAVE_FI.close();
%>

