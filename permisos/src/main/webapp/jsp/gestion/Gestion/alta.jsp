<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%
 String RSID_FUNCIONARIO="";
   String RSID_FUNCIONARIO_NOMBRE=""; 
   String RSID_AUSENCIA=""; 

   String RSENERO_H_T=""; 
   String RSENERO_M_T=""; 
   String RSENERO_H_U=""; 
   String RSENERO_M_U=""; 

   String RSFEBRERO_H_T=""; 
   String RSFEBRERO_M_T=""; 
   String RSFEBRERO_H_U=""; 
   String RSFEBRERO_M_U=""; 

   String RSMARZO_H_T=""; 
   String RSMARZO_M_T=""; 
   String RSMARZO_H_U=""; 
   String RSMARZO_M_U=""; 

   String RSABRIL_H_T=""; 
   String RSABRIL_M_T=""; 
   String RSABRIL_H_U=""; 
   String RSABRIL_M_U=""; 

    String RSMAYO_H_T=""; 
   String RSMAYO_M_T=""; 
   String RSMAYO_H_U=""; 
   String RSMAYO_M_U=""; 

   String RSJUNIO_H_T=""; 
   String RSJUNIO_M_T=""; 
   String RSJUNIO_H_U=""; 
   String RSJUNIO_M_U=""; 

   String RSJULIO_H_T=""; 
   String RSJULIO_M_T=""; 
   String RSJULIO_H_U=""; 
   String RSJULIO_M_U=""; 

   String RSAGOSTO_H_T=""; 
   String RSAGOSTO_M_T=""; 
   String RSAGOSTO_H_U=""; 
   String RSAGOSTO_M_U=""; 

   String RSSEPTIEMBRE_H_T=""; 
   String RSSEPTIEMBRE_M_T=""; 
   String RSSEPTIEMBRE_H_U=""; 
   String RSSEPTIEMBRE_M_U=""; 

   String RSOCTUBRE_H_T=""; 
   String RSOCTUBRE_M_T=""; 
   String RSOCTUBRE_H_U=""; 
   String RSOCTUBRE_M_U=""; 

   String RSNOVIEMBRE_H_T=""; 
   String RSNOVIEMBRE_M_T=""; 
   String RSNOVIEMBRE_H_U=""; 
   String RSNOVIEMBRE_M_U=""; 

   String RSDICIEMBRE_H_T=""; 
   String RSDICIEMBRE_M_T=""; 
   String RSDICIEMBRE_H_U=""; 
   String RSDICIEMBRE_M_U="";  
 %>
<%
String RSSINDICAL__MMColParam1 = "2025";
if (request.getParameter("PERIODO")   !=null) {RSSINDICAL__MMColParam1 = (String)request.getParameter("PERIODO")  ;}
%>
<%
String RSSINDICAL__MMColParam2 = "2";
if (request.getParameter("ID_TIPO_AUSENCIA")  !=null) {RSSINDICAL__MMColParam2 = (String)request.getParameter("ID_TIPO_AUSENCIA") ;}
%>
<%
String RSSINDICAL__MMColParam3 = "NO";
if (request.getParameter("EDITAR")  !=null) {RSSINDICAL__MMColParam3 = (String)request.getParameter("EDITAR") ;}
%>
<%
String RSSINDICAL__MMColParam4 = "";
if (request.getParameter("ID_FUNCIONARIO")   !=null) {RSSINDICAL__MMColParam4 = (String)request.getParameter("ID_FUNCIONARIO")  ;}
%>
<%
Driver DriverRSDETALLE = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSDETALLE = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSDETALLE = ConnRSDETALLE.prepareStatement("select to_char(trunc(e_total / 60)) as e_total_h,       to_char(mod(e_total, 60)) as e_total_m,       to_char(trunc(e_utilizadas / 60)) as e_utilizadas_h,       to_char(mod(e_utilizadas, 60)) as e_utilizadas_m,       to_char(trunc(f_total / 60)) as f_total_h,       to_char(mod(f_total, 60)) as f_total_m,       to_char(trunc(f_utilizadas / 60)) as f_utilizadas_h,       to_char(mod(f_utilizadas, 60)) as f_utilizadas_m,       to_char(trunc(m_total / 60)) as m_total_h,       to_char(mod(m_total, 60)) as m_total_m,       to_char(trunc(m_utilizadas / 60)) as m_utilizadas_h,       to_char(mod(m_utilizadas, 60)) as m_utilizadas_m,       to_char(trunc(a_total / 60)) as a_total_h,       to_char(mod(a_total, 60)) as a_total_m,       to_char(trunc(a_utilizadas / 60)) as a_utilizadas_h,       to_char(mod(a_utilizadas, 60)) as a_utilizadas_m,       to_char(trunc(ma_total / 60)) as ma_total_h,       to_char(mod(ma_total, 60)) as ma_total_m,       to_char(trunc(ma_utilizadas / 60)) as ma_utilizadas_h,       to_char(mod(ma_utilizadas, 60)) as ma_utilizadas_m,       to_char(trunc(j_utilizadas / 60)) as j_utilizadas_h,       to_char(mod(j_utilizadas, 60)) as j_utilizadas_m,       to_char(trunc(j_total / 60)) as j_total_h,       to_char(mod(j_total, 60)) as j_total_m,       to_char(trunc(ju_utilizadas / 60)) as ju_utilizadas_h,       to_char(mod(ju_utilizadas, 60)) as ju_utilizadas_m,       to_char(trunc(ju_total / 60)) as ju_total_h,       to_char(mod(ju_total, 60)) as ju_total_m,       to_char(trunc(ag_utilizadas / 60)) as ag_utilizadas_h,       to_char(mod(ag_utilizadas, 60)) as ag_utilizadas_m,       to_char(trunc(ag_total / 60)) as ag_total_h,       to_char(mod(ag_total, 60)) as ag_total_m,       to_char(trunc(s_utilizadas / 60)) as s_utilizadas_h,       to_char(mod(s_utilizadas, 60)) as s_utilizadas_m,       to_char(trunc(s_total / 60)) as s_total_h,       to_char(mod(s_total, 60)) as s_total_m,       to_char(trunc(n_utilizadas / 60)) as n_utilizadas_h,       to_char(mod(n_utilizadas, 60)) as n_utilizadas_m,       to_char(trunc(n_total / 60)) as n_total_h,       to_char(mod(n_total, 60)) as n_total_m,       to_char(trunc(o_utilizadas / 60)) as o_utilizadas_h,       to_char(mod(o_utilizadas, 60)) as o_utilizadas_m,       to_char(trunc(o_total / 60)) as o_total_h,       to_char(mod(o_total, 60)) as o_total_m,       to_char(trunc(d_utilizadas / 60)) as d_utilizadas_h,       to_char(mod(d_utilizadas, 60)) as d_utilizadas_m,       to_char(trunc(d_total / 60)) as d_total_h,       to_char(mod(d_total, 60)) as d_total_m  from horas_sindicales_totales where id_funcionario = '" +RSSINDICAL__MMColParam4+ "'   and id_ano = '" + RSSINDICAL__MMColParam1 + "' ");
ResultSet RSDETALLE = StatementRSDETALLE.executeQuery();
boolean RSDETALLE_isEmpty = !RSDETALLE.next();
boolean RSDETALLE_hasData = !RSDETALLE_isEmpty;
Object RSDETALLE_data;
int RSDETALLE_numRows = 0;
%>

<%
Driver DriverRSPERIODO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIODO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIODO = ConnRSPERIODO.prepareStatement("SELECT DISTINCT id_ANO AS PERIODO  from Hora_sindical order by 1 desc");
ResultSet RSPERIODO = StatementRSPERIODO.executeQuery();
boolean RSPERIODO_isEmpty = !RSPERIODO.next();
boolean RSPERIODO_hasData = !RSPERIODO_isEmpty;
Object RSPERIODO_data;
int RSPERIODO_numRows = 0;
%>

<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("select TO_CHAR(max(id_tipo_ausencia)+1) as NUM_AUSENCIA from tr_tipo_ausencia  where id_tipo_ausencia< 950");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>

<%
Driver DriverRSFUNCIONARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFUNCIONARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFUNCIONARIO = ConnRSFUNCIONARIO.prepareStatement("SELECT DISTINCT pe.aPE1 as APE1,                pe.APE2 as APE2,                pe.NOMBRE AS NOMBRE,                DECODE(substr(desc_tipo_ausencia, 1, 5),                       'HS CC',                       1,                       'HS UG',                       2,                       'HS CS',                       3,                       'HS SP',                       4,                       5) as ordena,                DECODE(substr(desc_tipo_ausencia, 1, 5),                       'HS CC',                       substr(desc_tipo_ausencia, 1, 9),                       'HS UG',                       substr(desc_tipo_ausencia, 1, 7),                       'HS CS',                       substr(desc_tipo_ausencia, 1, 9),                       'HS SP',                       substr(desc_tipo_ausencia, 1, 10),                       5) as ordena2,                substr(desc_tipo_ausencia,                       instr(desc_tipo_ausencia, ' ', 1, 1) + 1,                       instr(desc_tipo_ausencia, ' ', 1, 2) -                       instr(desc_tipo_ausencia, ' ', 1, 1) - 1) as SINDICATO,                INITCAP(pe.nombre) || ' ' || INITCAP(pe.ape1) || ' ' ||                INITCAP(pe.ape2) as nombres,                tr.ID_TIPO_AUSENCIA ID_TIPO_AUSENCIA,                tr.ID_TIPO_AUSENCIA || '--' ||                SUBSTR((DESC_TIPO_AUSENCIA), 1, 40) as DESC_TIPO_AUSENCIA,                DECODE(nvl(FECHA_BAJA - sysdate, 0), '0', '0', '1') as ESTADO_BAJA,                TO_CHAR(h.id_funcionario) as ID_FUNCIONARIO                 FROM RRHH.TR_TIPO_AUSENCIA tr, hora_sindical h, personal_new pe WHERE tr.ID_TIPO_AUSENCIA between '500' and '800'   and tr.ID_TIPO_AUSENCIA = h.ID_TIPO_AUSENCIA   and h.id_funcionario = pe.id_funcionario      and pe.id_funcionario = '" +RSSINDICAL__MMColParam4+ "'    and  h.id_ano = '" + RSSINDICAL__MMColParam1 + "'    and tr.TR_ANULADO = 'NO' ORDER BY ordena, ordena2");
ResultSet RSFUNCIONARIO = StatementRSFUNCIONARIO.executeQuery();
boolean RSFUNCIONARIO_isEmpty = !RSFUNCIONARIO.next();
boolean RSFUNCIONARIO_hasData = !RSFUNCIONARIO_isEmpty;
Object RSFUNCIONARIO_data;
int RSFUNCIONARIO_numRows = 0;
%>

<script language="Javascript">

function validarSiNumero(numero){
    if (!/^([0-9])*$/.test(numero))
      alert("El valor " + numero + " no es un número");
  }

function Valida(campo,mes) {

  if ((campo.length == 0) ) 
	  {
      alert('Falta información. ' + mes );
      return false
      }   
  if (!isNaN(parseInt(campo.value))) 
	  {
      alert('El campo debe ser un número. '+ mes);
      return false;
      }  
    return true
  
}

function envia_unavez()
{
	if ( document.Sindicales.ID_FUNCIONARIO.length == 0 )
		{
		alert("No hay funcionario seleccionado.");	
		  return;
		}

	

	
	if (!Valida("document.Sindicales.ID_HORA_1","Horas Mes Enero"))	
		  return;
	if (!Valida("document.Sindicales.ID_HORA_2","Horas Mes Febrero"))	
		  return;  
	if (!Valida("document.Sindicales.ID_HORA_3","Horas Mes Marzo"))	
		  return;
	if (!Valida("document.Sindicales.ID_HORA_4","Horas Mes Abril"))	
		  return;
	if (!Valida("document.Sindicales.ID_HORA_5","Horas Mes Mayo"))	
		  return;
	if (!Valida("document.Sindicales.ID_HORA_6","Horas Mes Junio"))	
		  return;
	if (!Valida("document.Sindicales.ID_HORA_7","Horas Mes Julio"))	
		  return;
	if (!Valida("document.Sindicales.ID_HORA_8","Horas Mes Agosto"))	
		  return;
	if (!Valida("document.Sindicales.ID_HORA_9","Horas Mes Septiembre"))	
		  return;
	if (!Valida("document.Sindicales.ID_HORA_10","Horas Mes Octubre"))	
		  return;        
	if (!Valida("document.Sindicales.ID_HORA_11","Horas Mes Noviembre"))	
		  return;        
	if (!Valida("document.Sindicales.ID_HORA_12","Horas Mes Diciembre"))	
		  return;        
	          

	
 if (document.Sindicales.Guardar.disabled==false) 
  {
   document.Sindicales.Guardar.disabled=true;

   document.Sindicales.TODO_T.value = 

	  "AH"  +document.Sindicales.ID_HORA_1.value + ";AM" +document.Sindicales.ID_MINUTO_1.value +
	  ";BH" +document.Sindicales.ID_HORA_2.value + ";BM" +document.Sindicales.ID_MINUTO_2.value +
	  ";CH" +document.Sindicales.ID_HORA_3.value + ";CM" +document.Sindicales.ID_MINUTO_3.value +
	  ";DH" +document.Sindicales.ID_HORA_4.value + ";DM" +document.Sindicales.ID_MINUTO_4.value +
	  ";EH" +document.Sindicales.ID_HORA_5.value + ";EM" +document.Sindicales.ID_MINUTO_5.value +
	  ";FH" +document.Sindicales.ID_HORA_6.value + ";FM" +document.Sindicales.ID_MINUTO_6.value +
	  ";GH" +document.Sindicales.ID_HORA_7.value + ";GM" +document.Sindicales.ID_MINUTO_7.value +
	  ";HH" +document.Sindicales.ID_HORA_8.value + ";HM" +document.Sindicales.ID_MINUTO_8.value +
	  ";IH" +document.Sindicales.ID_HORA_9.value + ";IM" +document.Sindicales.ID_MINUTO_9.value +
	  ";JH" +document.Sindicales.ID_HORA_10.value + ";JM" +document.Sindicales.ID_MINUTO_10.value +
	  ";KH" +document.Sindicales.ID_HORA_11.value + ";KM" +document.Sindicales.ID_MINUTO_11.value +
	  ";LH" +document.Sindicales.ID_HORA_12.value + ";LM" +document.Sindicales.ID_MINUTO_12.value + ";";
	  
   document.Sindicales.submit();
  }
}


</script>

<html>
<head>
<title>Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
</head>
<body>
<div id="apliweb-tabform">
<div>
<ul id="tabh">
    <li ><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
     <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
     <li><a href="../../gestion/Listados">Sin Justificar</a></li>     
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>  
    <li id="active" ><a href="index.jsp" id="current">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
  </ul>
</div>
<div id="form">
<div>
	 <ul id="subtabh">
		<li id="active"><a href="index.jsp" id="current">Horas</a></li>	
		<li id="active"><a href="listado_horas.jsp">Listado Horas</a></li>			
	  </ul>
  </div> 

<table width="95%" border="0" cellspacing="0" cellpadding="2">
   <tr bgcolor="#CCFFCC"> 
       <td colspan="5" align="center"><b> Horas Sindicales </b></td>
   </tr>
   <tr> 
        <td> 
             <table border="0" cellspacing="0" cellpadding="2" width="100%">
                              
                                <tr bgcolor="#FFFFFF"> 
                                  <td  bgcolor="#FFFFFF" valign="top"> 
                             <% if (! RSFUNCIONARIO_isEmpty ) 
                                    {
                                      RSID_FUNCIONARIO =(String)(((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("ID_FUNCIONARIO"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data);
                                      RSID_FUNCIONARIO_NOMBRE =(String)(((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("NOMBRES"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data);
                                     }  
                                else 
                                     { 
                                      RSID_FUNCIONARIO ="";
                                      RSID_FUNCIONARIO_NOMBRE ="";
                                     }
                              %> 
                              <% if (!  RSFUNCIONARIO_isEmpty ) 
                                    {
                                      RSID_AUSENCIA =(String) (((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("ID_TIPO_AUSENCIA"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data);                                
                                    }  
                                 else 
                                    {
                                      RSID_AUSENCIA =(String) (((RSQUERY_data = RSQUERY.getObject("NUM_AUSENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data);
                                    }
                              %>    
                                    <form name="Sindicales" method="GET" action="alta_result.jsp">
                                   
                                      <tr > 
                                        <td colspan="12" align="center"><b>
                                        <%  if (RSSINDICAL__MMColParam3.equals("NO")) { %> 
                                        	A L T A                                          	
                                         <% } else { %>
                                            E D I T A R
                                          <% }  %>
                                        </b></td>
                                      </tr>
                                      <tr>
                                       <td align="center">Funcionario:</td>
                                          <td colspan="3"> 
                                                   <input type="text" disabled="yes" ID="ID_FUNCIONARIO_ID" size="8"   value="<%= RSID_FUNCIONARIO %>" >
      <input type="text" textcolor=#FFFFFF  ID="ID_FUNCIONARIO_NOMBRE" size="35"   value="<%= RSID_FUNCIONARIO_NOMBRE %>" >
      <input type="hidden" name="ID_FUNCIONARIO" ID="ID_FUNCIONARIO" size="6" value="<%= RSID_FUNCIONARIO %>" >
       <%  if (RSSINDICAL__MMColParam3.equals("NO")) { %> 
           <input type="button" name="" value="Buscar Funcionario"
           onClick="javascript:window.open('../Busqueda/index_busqueda_funcionario.jsp?CAMPO=ID_FUNCIONARIO' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');"      >
         <% } %>   
    <% if (!  RSDETALLE_isEmpty ) {

        RSENERO_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("E_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSENERO_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("E_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSENERO_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("E_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSENERO_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("E_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSFEBRERO_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("F_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSFEBRERO_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("F_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSFEBRERO_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("F_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSFEBRERO_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("F_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSMARZO_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("M_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSMARZO_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("M_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSMARZO_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("M_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSMARZO_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("M_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSABRIL_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("A_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSABRIL_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("A_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSABRIL_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("A_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSABRIL_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("A_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSMAYO_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("MA_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSMAYO_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("MA_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSMAYO_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("MA_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSMAYO_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("MA_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSJUNIO_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("J_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSJUNIO_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("J_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSJUNIO_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("J_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSJUNIO_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("J_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSJULIO_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("JU_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSJULIO_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("JU_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSJULIO_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("JU_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSJULIO_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("JU_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSAGOSTO_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("AG_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSAGOSTO_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("AG_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSAGOSTO_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("AG_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSAGOSTO_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("AG_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSSEPTIEMBRE_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("S_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSSEPTIEMBRE_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("S_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSSEPTIEMBRE_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("S_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSSEPTIEMBRE_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("S_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSOCTUBRE_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("O_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSOCTUBRE_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("O_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSOCTUBRE_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("O_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSOCTUBRE_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("O_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSNOVIEMBRE_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("N_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSNOVIEMBRE_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("N_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSNOVIEMBRE_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("N_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSNOVIEMBRE_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("N_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);

        RSDICIEMBRE_H_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("D_TOTAL_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSDICIEMBRE_M_T= (String) (((RSDETALLE_data = RSDETALLE.getObject("D_TOTAL_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSDICIEMBRE_H_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("D_UTILIZADAS_H"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);                                
        RSDICIEMBRE_M_U= (String) (((RSDETALLE_data = RSDETALLE.getObject("D_UTILIZADAS_M"))==null || RSDETALLE.wasNull())?"":RSDETALLE_data);
        }
       else 
       {

       
        RSENERO_H_T="";
        RSENERO_M_T="";
        RSENERO_H_U="";
        RSENERO_M_U="";

        RSFEBRERO_H_T="";
        RSFEBRERO_M_T="";
        RSFEBRERO_H_U="";
        RSFEBRERO_M_U="";
	
        RSMARZO_H_T="";
        RSMARZO_M_T="";
        RSMARZO_H_U="";
        RSMARZO_M_U="";
	
        RSABRIL_H_T="";
        RSABRIL_M_T="";
        RSABRIL_H_U="";
        RSABRIL_M_U="";
	
        RSMAYO_H_T="";
        RSMAYO_M_T="";
        RSMAYO_H_U="";
        RSMAYO_M_U="";
	
        RSJUNIO_H_T="";
        RSJUNIO_M_T="";
        RSJUNIO_H_U="";
        RSJUNIO_M_U="";
	
        RSJULIO_H_T="";
        RSJULIO_M_T="";
        RSJULIO_H_U="";
        RSJULIO_M_U="";
	
        RSAGOSTO_H_T="";
        RSAGOSTO_M_T="";
        RSAGOSTO_H_U="";
        RSAGOSTO_M_U="";
	
        RSSEPTIEMBRE_H_T="";
        RSSEPTIEMBRE_M_T="";
        RSSEPTIEMBRE_H_U="";
        RSSEPTIEMBRE_M_U="";

        RSOCTUBRE_H_T="";
        RSOCTUBRE_M_T="";
        RSOCTUBRE_H_U="";
        RSOCTUBRE_M_U="";
	
        RSNOVIEMBRE_H_T="";
        RSNOVIEMBRE_M_T="";
        RSNOVIEMBRE_H_U="";
        RSNOVIEMBRE_M_U="";
	
        RSDICIEMBRE_H_T="";
        RSDICIEMBRE_M_T="";
        RSDICIEMBRE_H_U="";
        RSDICIEMBRE_M_U="";


       }
%>
    
                                             </td>
                                      </tr>
                                      <tr > 
                                          <td align="right">Sindicato: </td>
                                          <td> 
                                           <% if (! RSFUNCIONARIO_isEmpty )  { %>
                                                <input type="text" disabled="yes" ID="ID_SINDICATO" size="8"   value="<%=(((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("SINDICATO"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data) %>" > 
                                            <% } else { %>
                                            <select name="ID_SINDICATO" ID="ID_SINDICATO">
                                              <option value="HS CCOO">HS CCOO</option>
                                              <option value="HS UGT">HS UGT</option>
                                              <option value="HS CSIF">HS CSIF</option>
                                              <option value="HS SPPME">HS SPPME</option>
                                              <option value="HS CGT">HS CGT</option>
                                              <option value="HS USO">HS USO</option>                                              
                                            </select>
                                            <% } %>
                                          </td>
                                          <td>Año: </td>
                                          <td> <select name="PERIODO" id="PERIODO"  onchange="location.href='alta.jsp?EDITAR=SI&ID_FUNCIONARIO=' + <%=RSSINDICAL__MMColParam4%> + '&ID_TIPO_AUSENCIA=' + <%=RSSINDICAL__MMColParam2%>  + '&PERIODO='+this.value   ">

          <% while (RSPERIODO_hasData) {
%><option value="<%=((RSPERIODO.getObject("PERIODO")!=null)?RSPERIODO.getObject("PERIODO"):"")%>" <%=(((RSPERIODO.getObject("PERIODO")).toString().equals((RSSINDICAL__MMColParam1).toString()))?"selected=\"selected\"":"")%> ><%=((RSPERIODO.getObject("PERIODO")!=null)?RSPERIODO.getObject("PERIODO"):"")%></option>
            <%
  RSPERIODO_hasData = RSPERIODO.next();
}
RSPERIODO.close();
RSPERIODO = StatementRSPERIODO.executeQuery();
RSPERIODO_hasData = RSPERIODO.next();
RSPERIODO_isEmpty = !RSPERIODO_hasData;
%>   
</select>  </td>
                                          </tr>
                                     <tr > 
                                          <td align="right">Num Ausencia: </td>
                                          <td> <input type="text" name="ID_AUSENCIA" ID="ID_AUSENCIA" size="4"  disabled="yes" maxlength="4"
                                          value="<%=RSID_AUSENCIA %>"
                                          ><input type="hidden" name="V_ID_AUSENCIA" ID="V_ID_AUSENCIA" size="4"   maxlength="4"
                                          value="<%=RSID_AUSENCIA %>"
                                          >
                                            
                                          </td>
                                          </tr>
                                          </td>
                                        </tr>
                                        <tr>
                                        <td>
                                         </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="right">Enero:</td>
                                          <td colspan="3"> 
                                            <input type="text" name="ID_HORA_1" ID="ID_HORA_1" size="3" maxlength="3" align="right"  
												onChange="document.Sindicales.ID_HORA_2.value=document.Sindicales.ID_HORA_1.value;
												          document.Sindicales.ID_HORA_3.value=document.Sindicales.ID_HORA_1.value;
          												  document.Sindicales.ID_HORA_4.value=document.Sindicales.ID_HORA_1.value; 
          												  document.Sindicales.ID_HORA_5.value=document.Sindicales.ID_HORA_1.value;
          												  document.Sindicales.ID_HORA_6.value=document.Sindicales.ID_HORA_1.value;
          												  document.Sindicales.ID_HORA_7.value=document.Sindicales.ID_HORA_1.value;
          											      document.Sindicales.ID_HORA_8.value=document.Sindicales.ID_HORA_1.value;
          												  document.Sindicales.ID_HORA_9.value=document.Sindicales.ID_HORA_1.value;
          												  document.Sindicales.ID_HORA_10.value=document.Sindicales.ID_HORA_1.value;
          												  document.Sindicales.ID_HORA_11.value=document.Sindicales.ID_HORA_1.value;
          												  document.Sindicales.ID_HORA_12.value=document.Sindicales.ID_HORA_1.value;validarSiNumero(this.value);"
          												  value="<%= RSENERO_H_T %>" > Horas
                                            <input type="text" name="ID_MINUTO_1" ID="ID_MINUTO_1" size="3" maxlength="3" align="right" 
                                            onChange="document.Sindicales.ID_MINUTO_2.value=document.Sindicales.ID_MINUTO_1.value;
												          document.Sindicales.ID_MINUTO_3.value=document.Sindicales.ID_MINUTO_1.value;
          												  document.Sindicales.ID_MINUTO_4.value=document.Sindicales.ID_MINUTO_1.value; 
          												  document.Sindicales.ID_MINUTO_5.value=document.Sindicales.ID_MINUTO_1.value;
          												  document.Sindicales.ID_MINUTO_6.value=document.Sindicales.ID_MINUTO_1.value;
          												  document.Sindicales.ID_MINUTO_7.value=document.Sindicales.ID_MINUTO_1.value;
          											      document.Sindicales.ID_MINUTO_8.value=document.Sindicales.ID_MINUTO_1.value;
          												  document.Sindicales.ID_MINUTO_9.value=document.Sindicales.ID_MINUTO_1.value;
          												  document.Sindicales.ID_MINUTO_10.value=document.Sindicales.ID_MINUTO_1.value;
          												  document.Sindicales.ID_MINUTO_11.value=document.Sindicales.ID_MINUTO_1.value;
          												  document.Sindicales.ID_MINUTO_12.value=document.Sindicales.ID_MINUTO_1.value;validarSiNumero(this.value);"
                                                          value="<%= RSENERO_M_T %>" 
                                            > 
                                             <% if (!  RSDETALLE_isEmpty ) { %>
                                                      Minutos. Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_1_U" ID="ID_HORAS_1_U" size="3" maxlength="3" align="right" value="<%= RSENERO_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_1_U" ID="ID_MINUTO_1_U" size="3" maxlength="3" align="right" value="<%= RSENERO_M_U %>">
                                             <%   }  else {                  %>  
                                                       Minutos (Rellenar primero)
                                                <%   }                  %>
                                          </td>
                                           <td align="right">Julio:</td>
                                          <td colspan="3"> 
                                              <input type="text" name="ID_HORA_7" ID="ID_HORA_7" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSJULIO_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_7" ID="ID_MINUTO_7" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSJULIO_M_T %>"                                              
                                                       > Minutos
                                            <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_7_U" ID="ID_HORAS_7_U" size="3" maxlength="3" align="right" value="<%= RSJULIO_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_7_U" ID="ID_MINUTO_7_U" size="3" maxlength="3" align="right" value="<%= RSJULIO_M_U %>">
                                             <%   }    %>           
                                              </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="right">Febrero:</td>
                                          <td colspan="3"> 
                                             <input type="text" name="ID_HORA_2" ID="ID_HORA_2" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSFEBRERO_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_2" ID="ID_MINUTO_2" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSFEBRERO_M_T %>"> Minutos
                                            <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_2_U" ID="ID_HORAS_2_U" size="3" maxlength="3" align="right" value="<%= RSFEBRERO_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_2_U" ID="ID_MINUTO_2_U" size="3" maxlength="3" align="right" value="<%= RSFEBRERO_M_U %>">
                                             <%   }    %>  
                                                   
                                            </td>
                                           <td align="right">Agosto:</td>
                                          <td colspan="3"> 
                                           <input type="text" name="ID_HORA_8" ID="ID_HORA_8" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSAGOSTO_H_T %>"> Horas
                                           <input type="text" name="ID_MINUTO_8" ID="ID_MINUTO_8" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSAGOSTO_M_T %>"> Minutos
                                           <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_8_U" ID="ID_HORAS_8_U" size="3" maxlength="3" align="right" value="<%= RSAGOSTO_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_8_U" ID="ID_MINUTO_8_U" size="3" maxlength="3" align="right" value="<%= RSAGOSTO_M_U %>">
                                             <%   }    %>
                                              </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="right">Marzo:</td>
                                          <td colspan="3"> 
                                            <input type="text" name="ID_HORA_3" ID="ID_HORA_3" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSMARZO_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_3" ID="ID_MINUTO_3" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSMARZO_M_T %>"> Minutos
                                           <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_3_U" ID="ID_HORAS_3_U" size="3" maxlength="3" align="right" value="<%= RSMARZO_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_3_U" ID="ID_MINUTO_3_U" size="3" maxlength="3" align="right" value="<%= RSMARZO_M_U %>">
                                             <%   }    %>   
                                          </td>
                                          <td align="right">Septiembre:</td>
                                          <td colspan="3"> 
                                            <input type="text" name="ID_HORA_9" ID="ID_HORA_9" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSSEPTIEMBRE_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_9" ID="ID_MINUTO_9" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSSEPTIEMBRE_M_T %>"> Minutos
                                            <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_9_U" ID="ID_HORAS_9_U" size="3" maxlength="3" align="right" value="<%= RSSEPTIEMBRE_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_9_U" ID="ID_MINUTO_9_U" size="3" maxlength="3" align="right" value="<%= RSSEPTIEMBRE_M_U %>">
                                             <%   }    %>
                                              </td>
                                        </tr><tr bgcolor="#FFFFFF"> 
                                          <td align="right">Abril:</td>
                                          <td colspan="3"> 
                                            <input type="text" name="ID_HORA_4" ID="ID_HORA_4" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSABRIL_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_4" ID="ID_MINUTO_4" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSABRIL_M_T %>"> Minutos
                                             <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_4_U" ID="ID_HORAS_4_U" size="3" maxlength="3" align="right" value="<%= RSABRIL_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_4_U" ID="ID_MINUTO_4_U" size="3" maxlength="3" align="right" value="<%= RSABRIL_M_U %>">
                                             <%   }    %>  
                                           </td>
                                          <td align="right">Octubre:</td>
                                          <td colspan="3"> 
                                            <input type="text" name="ID_HORA_10" ID="ID_HORA_10" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSOCTUBRE_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_10" ID="ID_MINUTO_10" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSOCTUBRE_M_T %>"> Minutos
                                            <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_10_U" ID="ID_HORAS_10_U" size="3" maxlength="3" align="right" value="<%= RSOCTUBRE_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_10_U" ID="ID_MINUTO_10_U" size="3" maxlength="3" align="right" value="<%= RSOCTUBRE_M_U %>">
                                             <%   }    %>
                                                   </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="right">Mayo:</td>
                                          <td colspan="3"> 
                                            <input type="text" name="ID_HORA_5" ID="ID_HORA_5" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSMAYO_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_5" ID="ID_MINUTO_5" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSMAYO_M_T %>"> Minutos
                                             <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_6_U" ID="ID_HORAS_6_U" size="3" maxlength="3" align="right" value="<%= RSMAYO_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_6_U" ID="ID_MINUTO_6_U" size="3" maxlength="3" align="right" value="<%= RSMAYO_M_U %>">
                                             <%   }    %>  
                                         </td>
                                          <td align="right">Noviembre:</td>
                                          <td colspan="3"> 
                                            <input type="text" name="ID_HORA_11" ID="ID_HORA_11" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSNOVIEMBRE_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_11" ID="ID_MINUTO_11" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSNOVIEMBRE_M_T %>"> Minutos
                                            <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_11_U" ID="ID_HORAS_11_U" size="3" maxlength="3" align="right" value="<%= RSNOVIEMBRE_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_11_U" ID="ID_MINUTO_11_U" size="3" maxlength="3" align="right" value="<%= RSNOVIEMBRE_M_U %>">
                                             <%   }    %>
                                            
                                         </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="right">Junio:</td>
                                          <td colspan="3"> 
                                              <input type="text" name="ID_HORA_6" ID="ID_HORA_6" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSJUNIO_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_6" ID="ID_MINUTO_6" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSJUNIO_M_T %>"> Minutos
                                             <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_6_U" ID="ID_HORAS_6_U" size="3" maxlength="3" align="right" value="<%= RSJUNIO_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_6_U" ID="ID_MINUTO_6_U" size="3" maxlength="3" align="right" value="<%= RSJUNIO_M_U %>">
                                             <%   }    %>                                           
                                            </td>
                                          <td align="right">Diciembre:</td>
                                          <td colspan="3"> 
                                              <input type="text" name="ID_HORA_12" ID="ID_HORA_12" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSDICIEMBRE_H_T %>"> Horas
                                            <input type="text" name="ID_MINUTO_12" ID="ID_MINUTO_12" size="3" maxlength="3" align="right" onChange="validarSiNumero(this.value);" value="<%= RSDICIEMBRE_M_T %>"> Minutos
                                            <% if (!  RSDETALLE_isEmpty ) { %>
                                                      . Horas utilizadas:  
                                                     <input type="text" disabled="yes" name="ID_HORAS_12_U" ID="ID_HORAS_12_U" size="3" maxlength="3" align="right" value="<%= RSDICIEMBRE_H_U %>">
                                                     <input type="text" disabled="yes" name="ID_MINUTO_12_U" ID="ID_MINUTO_12_U" size="3" maxlength="3" align="right" value="<%= RSDICIEMBRE_M_U %>">
                                             <%   }    %>
                                                                                     
                                          </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF"> 
                                         
                                        </tr>
                                                                             
                                        <tr bgcolor="#FFFFFF" align="center"> 
                                          <td colspan="14"> 
                                            <table border="0" cellspacing="0" cellpadding="0" width="50%">
                                              <tr> 
                                                                                              
                                                <td  colspan=10 align="center" bgcolor="#FFFFFF"> 
                                                  <input type="button" name="Guardar" value="Guardar" onClick="javascript:envia_unavez();">
                                                  <input type="hidden" name="TODO_T" ID="TODO_T" size="122" >
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
</body>
</html>


<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>

<%
RSFUNCIONARIO.close();
StatementRSFUNCIONARIO.close();
ConnRSFUNCIONARIO.close();
%>
<%
RSDETALLE.close();
StatementRSDETALLE.close();
ConnRSDETALLE.close();
%>

<%
RSPERIODO.close();
StatementRSPERIODO.close();
ConnRSPERIODO.close();
%>
