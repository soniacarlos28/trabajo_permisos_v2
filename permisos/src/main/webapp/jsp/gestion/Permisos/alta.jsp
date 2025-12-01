<%@page language="java" import="java.util.Date,java.sql.*" errorPage="error.jsp"%>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT ID_PERMISO, ID_ANO, ID_FUNCIONARIO, ID_TIPO_PERMISO ||'--'||JUSTIFICACION as ID_TIPO_PERMISO , FECHA_INICIO, FECHA_FIN, NUM_DIAS, ID_TIPO_DIAS, JUSTIFICACION, OBSERVACIONES, ANULADO, FECHA_ANULACION, ID_USUARIO, TO_char(sysdate,'DD/MM/YYYY')  AS FECHA_HOY ,FECHA_MODI  FROM PERMISO");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
String RSTIPOPERMISO__MMColParam1 = "2020";
if (request.getParameter("ID_ANO") !=null) {RSTIPOPERMISO__MMColParam1 = (String)request.getParameter("ID_ANO");}
%>
<%
Driver DriverRSTIPOPERMISO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPOPERMISO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPOPERMISO = ConnRSTIPOPERMISO.prepareStatement("SELECT ID_TIPO_PERMISO || '--' || DECODE(JUSTIFICACION,'SI','NO',JUSTIFICACION) || '--' || DECODE(TIPO_DIAS,'N','N','L')  AS ID_TIPO_PERMISO,   ID_TIPO_PERMISO AS ID_TIPO_PERMISO2,  DESC_TIPO_PERMISO || ' - (D�as:' ||  num_dias || ' )' as  DESC_TIPO_PERMISO,TIPO_DIAS              ,       DECODE(JUSTIFICACION,'SI','NO',JUSTIFICACION) as JUSTIFICACION  FROM TR_TIPO_PERMISO  WHERE ID_ANO = '" + RSTIPOPERMISO__MMColParam1 + "'  ORDER BY id_tipo_permiso");
ResultSet RSTIPOPERMISO = StatementRSTIPOPERMISO.executeQuery();
boolean RSTIPOPERMISO_isEmpty = !RSTIPOPERMISO.next();
boolean RSTIPOPERMISO_hasData = !RSTIPOPERMISO_isEmpty;
Object RSTIPOPERMISO_data;
int RSTIPOPERMISO_numRows = 0;
%>
<%
Driver DriverRS_FECHAHOY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_FECHAHOY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_FECHAHOY = ConnRS_FECHAHOY.prepareStatement("SELECT TO_CHAR(SYSDATE,'dd/MM/YYYY') AS fecha_hoy FROM DUAL");
ResultSet RS_FECHAHOY = StatementRS_FECHAHOY.executeQuery();
boolean RS_FECHAHOY_isEmpty = !RS_FECHAHOY.next();
boolean RS_FECHAHOY_hasData = !RS_FECHAHOY_isEmpty;
Object RS_FECHAHOY_data;
int RS_FECHAHOY_numRows = 0;
%>


<%
String RSQUEYFECHAS__MMColParam1 =(String)(((RS_FECHAHOY_data = RS_FECHAHOY.getObject("FECHA_HOY"))==null || RS_FECHAHOY.wasNull())?"":RS_FECHAHOY_data);
if (request.getParameter("FECHA_INICIO")  !=null) {RSQUEYFECHAS__MMColParam1 = (String)request.getParameter("FECHA_INICIO") ;}
%>
<%
String RSQUEYFECHAS__MMColParam2 = (String)(((RS_FECHAHOY_data = RS_FECHAHOY.getObject("FECHA_HOY"))==null || RS_FECHAHOY.wasNull())?"":RS_FECHAHOY_data);
if (request.getParameter("FECHA_FIN")  !=null) {RSQUEYFECHAS__MMColParam2 = (String)request.getParameter("FECHA_FIN") ;}
%>
<%
String RSQUEYFECHAS__MMColParam3 = "N";
if (request.getParameter("TIPO_DIAS")    !=null) {RSQUEYFECHAS__MMColParam3 = (String)request.getParameter("TIPO_DIAS")   ;}
%>
<%
String RSQUEYFECHAS__MMColParam4 = "01000";
if (request.getParameter("ID_TIPO_PERMISO")    !=null) {RSQUEYFECHAS__MMColParam4 = (String)request.getParameter("ID_TIPO_PERMISO")   ;}
%>
<%
String RSQUEYFECHAS__MMColParam5 = "--";
if (request.getParameter("ID_JUSTIFICACION")    !=null) {RSQUEYFECHAS__MMColParam5 = (String)request.getParameter("ID_JUSTIFICACION")   ;}
%>
<%
String RSFUNCIONARIO__MMColParam6 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO") !=null) {RSFUNCIONARIO__MMColParam6 = (String)session.getValue("MM_ID_FUNCIONARIO");}
%>
<%
String RSQUEYFECHAS__MMColParam7 = "08:00";
if (request.getParameter("HORA_INICIO")    !=null) {RSQUEYFECHAS__MMColParam7 = (String)request.getParameter("HORA_INICIO")   ;}
%>
<%
String RSQUEYFECHAS__MMColParam8 = "15:00";
if (request.getParameter("HORA_FIN")    !=null) {RSQUEYFECHAS__MMColParam8 = (String)request.getParameter("HORA_FIN")   ;}
%>
<%
String RSQUEYFECHAS__MMColParam9 = "";
if (request.getParameter("OBSERVACIONES")    !=null) {RSQUEYFECHAS__MMColParam9 = (String)request.getParameter("OBSERVACIONES")   ;}
%>
<%
String RSQUEYFECHAS__MMColParam10 = "";
if (request.getParameter("DPROVINCIA")    !=null) {RSQUEYFECHAS__MMColParam10 = (String)request.getParameter("DPROVINCIA")   ;}
%>
<%
String RSQUEYFECHAS__MMColParam11 = "";
if (request.getParameter("ID_GRADO")    !=null) {RSQUEYFECHAS__MMColParam11 = (String)request.getParameter("ID_GRADO")   ;}
%>
<%
String RSQUEYFECHAS__MMColParam12 = "AL";
if (request.getParameter("TIPO_BAJA")    !=null) {RSQUEYFECHAS__MMColParam12 = (String)request.getParameter("TIPO_BAJA")   ;}
%>

<% 
String RSQUEYFECHAS__MMColParam13 = "";
if(request.getParameter("DESCUENTO_BAJAS") != null){ RSQUEYFECHAS__MMColParam13 = (String)request.getParameter("DESCUENTO_BAJAS");}

String RSQUEYFECHAS__MMColParam14 = "";
if(request.getParameter("DESCUENTO_DIAS") != null){ RSQUEYFECHAS__MMColParam14 = (String)request.getParameter("DESCUENTO_DIAS");}
%>
<%
Driver DriverRSQUEYFECHAS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUEYFECHAS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUEYFECHAS = ConnRSQUEYFECHAS.prepareStatement("SELECT DECODE(CONTADOR,0,1,CONTADOR) as CONTADOR FROM (SELECT DECODE('" + RSQUEYFECHAS__MMColParam3 + "','N',0, Contador_laboral) +DECODE('" + RSQUEYFECHAS__MMColParam3 + "','L',0,contador_natural) as Contador   from  (SELECT count(*) as contador_laboral,0 contador_natural from calendario_laboral where id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')   and laboral='SI'   union  select 0 contador_laboral,count(*) as contador_natural  FROM calendario_laboral where id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')  )  WHERE (        DECODE('" + RSQUEYFECHAS__MMColParam3 + "','N',0, Contador_laboral) <> 0 OR                        DECODE('" + RSQUEYFECHAS__MMColParam3 + "','L',0,contador_natural) <> 0       ))");
%>
<%
Driver DriverRSFUNCIONARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFUNCIONARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFUNCIONARIO = ConnRSFUNCIONARIO.prepareStatement("SELECT * from    (select 1 orden ,nombre,ape1,ape2,to_char(tipo_funcionario2) as tipo_funcionario from personal_new where lpad(id_funcionario,6,'0')=lpad('" + RSFUNCIONARIO__MMColParam6 + "',6,'0')   union select 2 orden,'NO EXISTE FUNCIONARIO' nombre,''ape1,''ape2, '0' tipo_funcionario  FROM dual)  WHERE rownum <2");
ResultSet RSFUNCIONARIO = StatementRSFUNCIONARIO.executeQuery();
boolean RSFUNCIONARIO_isEmpty = !RSFUNCIONARIO.next();
boolean RSFUNCIONARIO_hasData = !RSFUNCIONARIO_isEmpty;
Object RSFUNCIONARIO_data;
int RSFUNCIONARIO_numRows = 0;
%>
<%
String RSPERMISO_TIPOS__MMColParam1 = "0000";
if (request.getParameter("ID_ANO")  !=null) {RSPERMISO_TIPOS__MMColParam1 = (String)request.getParameter("ID_ANO") ;}
%>
<%
String RSPERMISO_TIPOS__MMColParam2 = "01000";
if (request.getParameter("ID_TIPO_PERMISO")  !=null) {RSPERMISO_TIPOS__MMColParam2 = (String)request.getParameter("ID_TIPO_PERMISO") ;}
%>
<%
Driver DriverRSPERMISO_TIPOS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERMISO_TIPOS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERMISO_TIPOS = ConnRSPERMISO_TIPOS.prepareStatement("SELECT ID_TIPO_PERMISO || '--' || DECODE(JUSTIFICACION,'SI','NO',JUSTIFICACION)  || '--' || DECODE(TIPO_DIAS,'N','N','L')  AS ID_TIPO_PERMISO,   ID_TIPO_PERMISO AS ID_TIPO_PERMISO2,  DESC_TIPO_PERMISO,TIPO_DIAS              ,       JUSTIFICACION  FROM TR_TIPO_PERMISO  WHERE (id_ano=" + RSPERMISO_TIPOS__MMColParam1 + " ) and id_tipo_permiso ='" + RSPERMISO_TIPOS__MMColParam2 + "'");
ResultSet RSPERMISO_TIPOS = StatementRSPERMISO_TIPOS.executeQuery();
boolean RSPERMISO_TIPOS_isEmpty = !RSPERMISO_TIPOS.next();
boolean RSPERMISO_TIPOS_hasData = !RSPERMISO_TIPOS_isEmpty;
Object RSPERMISO_TIPOS_data;
int RSPERMISO_TIPOS_numRows = 0;
%>
<%
String RSHORAS__MMColParam1 = "1";
if (session.getValue("MM_ID_FUNCIONARIO")  !=null) {RSHORAS__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO") ;}
%>
<%
Driver DriverRSHORAS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSHORAS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSHORAS = ConnRSHORAS.prepareStatement("SELECT trunc((total-utilizadas)/60,0) || ':' || mod(total-utilizadas,60) as horas  FROM horas_Extras_ausencias  WHERE id_funcionario='" + RSHORAS__MMColParam1 + "'");
ResultSet RSHORAS = StatementRSHORAS.executeQuery();
boolean RSHORAS_isEmpty = !RSHORAS.next();
boolean RSHORAS_hasData = !RSHORAS_isEmpty;
Object RSHORAS_data;
int RSHORAS_numRows = 0;
%>


<%
String thisPage = request.getRequestURI();
%>
<script language="Javascript">
<!--
function carga_final(){

	 document.getElementById('JUST').style.display='none'; 
     document.getElementById('GRAD').style.display='none';   
     document.getElementById('BOMB').style.display='none';   
     document.getElementById('BOMB2').style.display='none'; 
     document.getElementById('BOMB3').style.display='none'; 
     document.getElementById('COMP').style.display='none';  
     document.getElementById('BAJA').style.display='none';  	

   document.formPermiso.MENU_TIPO_PERMISO.value="<%=(((RSPERMISO_TIPOS_data = RSPERMISO_TIPOS.getObject("ID_TIPO_PERMISO"))==null || RSPERMISO_TIPOS.wasNull())?"":RSPERMISO_TIPOS_data)%>";
   document.formPermiso.ID_TIPO_PERMISO.value="<%=RSQUEYFECHAS__MMColParam4%>";
   document.formPermiso.ID_JUSTIFICACION.value="<%=RSQUEYFECHAS__MMColParam5%>";
 <%  if ( RSQUEYFECHAS__MMColParam4.equals("01000")) { %>
     document.formPermiso.TIPO_DIAS.value="<%=RSQUEYFECHAS__MMColParam3%>";  
  <%} else { %>
     document.formPermiso.TIPO_DIAS.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(12,11);   
    <% RSQUEYFECHAS__MMColParam3=(String)(((RSPERMISO_TIPOS_data = RSPERMISO_TIPOS.getObject("TIPO_DIAS"))==null || RSPERMISO_TIPOS.wasNull())?"":RSPERMISO_TIPOS_data);%>
 <%}  %>


<%   if (request.getParameter("ID_FUNCIONARIO") !=null) {
      session.putValue("MM_ID_FUNCIONARIO", RSFUNCIONARIO__MMColParam6  );
      session.putValue("MM_ID_FUNCIONARIO_NOMBRE", (((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("NOMBRE"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data));
      session.putValue("MM_ID_FUNCIONARIO_APE1", (((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("APE1"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data));
	  session.putValue("MM_ID_FUNCIONARIO_APE2", (((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("APE2"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data)); 
        } 
	  StatementRSQUEYFECHAS = ConnRSQUEYFECHAS.prepareStatement("SELECT DECODE('" + RSQUEYFECHAS__MMColParam3 + "','N',0, Contador_laboral) +DECODE('" + RSQUEYFECHAS__MMColParam3 + "','L',0,contador_natural) as Contador   from  (SELECT count(*) as contador_laboral,0 contador_natural from calendario_laboral where id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')   and laboral='SI' union  select 0 contador_laboral,count(*) as contador_natural  FROM calendario_laboral where id_dia between To_date('" + RSQUEYFECHAS__MMColParam1 + "','DD/MM/YYYY') and To_date('" + RSQUEYFECHAS__MMColParam2 + "','DD/MM/YYYY')  )  WHERE (        DECODE('" + RSQUEYFECHAS__MMColParam3 + "','N',0, Contador_laboral) <> 0 OR                        DECODE('" + RSQUEYFECHAS__MMColParam3 + "','L',0,contador_natural) <> 0       )");
	  
	   ResultSet RSQUEYFECHAS = StatementRSQUEYFECHAS.executeQuery();
boolean RSQUEYFECHAS_isEmpty = !RSQUEYFECHAS.next();
boolean RSQUEYFECHAS_hasData = !RSQUEYFECHAS_isEmpty;
Object RSQUEYFECHAS_data;
int RSQUEYFECHAS_numRows = 0;
   %>
   
  
  mostrarOcultar();
}
// -->
function envia_unavez()
{

 if (document.formPermiso.Guardar.disabled==false) 
  {
   document.formPermiso.Guardar.disabled=true;
   document.formPermiso.submit();
  }
}

function cambio_hora()
{


	if (document.formPermiso.ID_TIPO_PERMISO.value=="02031") 
       {

		document.formPermiso.FECHA_FIN.value=document.formPermiso.FECHA_INICIO.value;
		
			cadena =document.formPermiso.HORA_INICIO.value;
			if  (cadena.length != 5 )
			{
	  			alert ("Formato Hora entrada incorrecto. Ej 08:00 ");	 
			}  else
				{

				 hora= document.formPermiso.HORA_INICIO.value.substring(0,2);
				 minuto= document.formPermiso.HORA_INICIO.value.substring(3,5);

				 var hora_3=parseInt(hora)+3;
				 if (hora_3 >= 21)
					 {
                      hora_3 = hora_3-24;  
                      sumaFecha(1, document.formPermiso.FECHA_INICIO.value,document.formPermiso.FECHA_FIN.value);                                                                
					 } 

				 cadena= hora_3.toString();
				   
				   if (cadena.length == 1)
					   cadena= "0" + cadena;

				   document.formPermiso.HORA_FIN.value = cadena + ":"+ minuto;	         
				   

				}



			
       }	
	
	//document.formPermiso.MENU_TIPO_PERMISO.value.substring(0,5);
	
	//document.formPermiso.hora_fin.value = 
	//document.formPermiso.hora_inicio.value=document.formPermiso.FECHA_INICIO.value;
	 
}

function Turnos(Turno)
{

var horas_sele=0;
document.formPermiso.AP1_1.value="0";
document.formPermiso.AP1_2.value="0";
document.formPermiso.AP1_3.value="0";



   if(document.formPermiso.AP1.checked == true) 
	   {
       horas_sele=horas_sele +1;
       document.formPermiso.FECHA_TURNO_1.value=document.formPermiso.FECHA_INICIO.value;
       document.formPermiso.AP1_1.value="1";
	   }  
   if(document.formPermiso.AP2.checked == true) 
       {  
       horas_sele=horas_sele +1;
        document.formPermiso.FECHA_TURNO_2.value=document.formPermiso.FECHA_INICIO.value;
        document.formPermiso.AP1_2.value="1";
       } 
   if(document.formPermiso.AP3.checked == true) 
	   {   
	   horas_sele=horas_sele +1;	  
	   document.formPermiso.AP1_3.value="1";
	   sumaFecha(1, document.formPermiso.FECHA_INICIO.value,document.formPermiso.FECHA_FIN.value);
	   } else  { 
		   document.formPermiso.FECHA_FIN.value= document.formPermiso.FECHA_INICIO.value;

		    }
   
      document.formPermiso.horas_sel.value=horas_sele;
      //document.formPermiso.num_dias.value=horas_sele;

} 
function actualizaFecha()
{
	
	document.formPermiso.AP1.checked =false;
	document.formPermiso.AP2.checked =false;
	document.formPermiso.AP3.checked =false;
	document.formPermiso.FECHA_TURNO_1.value="";
	document.formPermiso.FECHA_TURNO_2.value="";
	document.formPermiso.FECHA_TURNO_3.value="";
	document.formPermiso.FECHA_FIN.value=document.formPermiso.FECHA_INICIO.value;
	 
}
function sumaFecha(d, fecha,fecha2)
{

 	
 var Fecha = new Date();
 var sFecha = fecha || (Fecha.getDate() + "/" + (Fecha.getMonth() +1) + "/" + Fecha.getFullYear());
 var sep = sFecha.indexOf('/') != -1 ? '/' : '-'; 
 var aFecha = sFecha.split(sep);
 var fecha = aFecha[2]+'/'+aFecha[1]+'/'+aFecha[0];
 fecha= new Date(fecha);
 fecha.setDate(fecha.getDate()+parseInt(d));
 var anno=fecha.getFullYear();
 var mes= fecha.getMonth()+1;
 var dia= fecha.getDate();
 mes = (mes < 10) ? ("0" + mes) : mes;
 dia = (dia < 10) ? ("0" + dia) : dia;
 var fechaFinal = dia+sep+mes+sep+anno;
 document.formPermiso.FECHA_TURNO_3.value=fechaFinal;
 document.formPermiso.FECHA_FIN.value=fechaFinal;
 fecha2=fechaFinal;
 
 }
function mostrarOcultar() { 

	var tipo_funcionario=0;

	tipo_funcionario=document.formPermiso.ID_TIPO_FUNCIONARIO.value; 

	   
   document.formPermiso.ID_TIPO_PERMISO.value= document.formPermiso.MENU_TIPO_PERMISO.value.substring(0,5);
   document.formPermiso.ID_JUSTIFICACION.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(9,7);

   
     document.formPermiso.TIPO_DIAS.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(12,11);

   
  
      document.getElementById('JUST').style.display='none'; 
      document.getElementById('GRAD').style.display='none';   
      document.getElementById('BOMB').style.display='none';   
      document.getElementById('BOMB2').style.display='none';   
      document.getElementById('BOMB3').style.display='none';  
      document.getElementById('COMP').style.display='none';  
      document.getElementById('BAJA').style.display='none';  	
  
  
  // document.formPermiso.ID_UNICO.value=document.formPermiso.MENU_TIPO_PERMISO.value.substring(16,14);

    if (document.formPermiso.ID_TIPO_PERMISO.value=="01000") 
      {
          
      
      document.getElementById('JUST').style.display='none'; 
      document.getElementById('GRAD').style.display='none';   
      document.getElementById('BOMB').style.display='none';   
      document.getElementById('COMP').style.display='none';  
      document.getElementById('BAJA').style.display='none';  	 
      document.getElementById('BOMB2').style.display='none'; 
	  
      }

    if (document.formPermiso.ID_TIPO_PERMISO.value=="11300") 
    {
        
    
    document.getElementById('JUST').style.display='none'; 
    document.getElementById('GRAD').style.display='none';   
    document.getElementById('BOMB').style.display='none';   
    document.getElementById('COMP').style.display='none';  
    document.getElementById('BAJA').style.display='';  	  
    document.getElementById('BOMB2').style.display='none';
	  
    }
	  
   if (document.formPermiso.ID_TIPO_PERMISO.value=="04000" ||  document.formPermiso.ID_TIPO_PERMISO.value=="04500" || document.formPermiso.ID_TIPO_PERMISO.value=="06100" ) 
       {
		   
           document.getElementById('JUST').style.display='none'; 
			document.getElementById('GRAD').style.display='';   
			document.getElementById('BOMB').style.display='none';   
			document.getElementById('COMP').style.display='none';  
			document.getElementById('BAJA').style.display='none';  
			document.getElementById('BOMB2').style.display='none';
	    }
		    
   if ( (document.formPermiso.ID_TIPO_PERMISO.value=="01501" || document.formPermiso.ID_TIPO_PERMISO.value=="02030" ||  document.formPermiso.ID_TIPO_PERMISO.value=="11000" ||  document.formPermiso.ID_TIPO_PERMISO.value=="02000" || document.formPermiso.ID_TIPO_PERMISO.value=="01015" ||  document.formPermiso.ID_TIPO_PERMISO.value=="02015" ) &&  
			   (document.formPermiso.ID_TIPO_FUNCIONARIO.value=="23") 
                 )
				               
       {
		   
           document.getElementById('JUST').style.display='none'; 
			document.getElementById('GRAD').style.display='none';   
			document.getElementById('BOMB').style.display='';   
			document.getElementById('COMP').style.display='none';  
			document.getElementById('BAJA').style.display='none';  
			document.getElementById('BOMB2').style.display='none';
	    }

       
   if (document.formPermiso.ID_JUSTIFICACION.value=="NO") 
    {
       
  	   document.getElementById('JUST').style.display=''; 
       
                   
     }
  if (document.formPermiso.ID_TIPO_PERMISO.value=="15000") 
    {
	  document.getElementById('JUST').style.display='none'; 
		document.getElementById('GRAD').style.display='none';   
		document.getElementById('BOMB').style.display='none';   
		document.getElementById('COMP').style.display='';  
		document.getElementById('BAJA').style.display='none';   
		document.getElementById('BOMB2').style.display='';    
		document.getElementById('BOMB2').style.display=''; 
    }
  if (document.formPermiso.ID_TIPO_PERMISO.value=="02031") 
  {
	  document.getElementById('JUST').style.display='none'; 
		document.getElementById('GRAD').style.display='none';   
		document.getElementById('BOMB').style.display='none';   
		document.getElementById('COMP').style.display='';  
		document.getElementById('BAJA').style.display='none';   
		document.getElementById('BOMB2').style.display='none';    
		document.getElementById('BOMB2').style.display='none';    
  }
  

} 
</script>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH_DESA</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<body OnLoad="carga_final()">
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
   <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
          
     <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li> 
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
     <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>  
      <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
      <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
      </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
<div>
	  <ul id="subtabh">
		<li id="active"><a href="../Datos" >Datos per.</a></li>
		<li><a href="../Permisos" id="current">Permisos</a></li>
		<li><a href="../Ausencias">Ausencias</a></li>		
		<li><a href="../Horas">Horas</a></li>
		<li><a href="../Firmas">Firmas</a></li>
		<li><a href="../Finger">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
	</div>
	<div id="subform">
	
	<table width="95%" border="0" cellspacing="5" cellpadding="0">
                          <form name="formPermiso" method="post" action="alta_result.jsp">
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top"> 
                                <table border="0" cellspacing="0" cellpadding="2">
                                  <tr> 
                                    <td> 
                                      <input type="button" value="Nuevo" name="Nuevo" onClick="window.location='alta.jsp'" disabled="yes">
                                    </td>
                                    <td> 
                                      <input type="submit" value="Guardar" name="Guardar" onClick="javascript:envia_unavez();">
                                    </td>
                                    <td>&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp; </td>
                                  </tr>
                                </table>
                              </td>
                              <td bgcolor="#E0E0E0" valign="top" align="right"><b> 
                                <input type="hidden" name="ID_PERMISO">  <input type="hidden" name="IP" value="0"> 
                                <%= "<input type='hidden' name='ID_FUNCIONARIO' value='" + session.getValue("MM_ID_FUNCIONARIO") + "'>" %> 
                                <input type="hidden" name="ANULADO" value="NO">
                                <input type="hidden" name="FECHA_ANULACION">
                                <%= "<input type='hidden' name='ID_USUARIO' value='" + session.getValue("MM_ID_USUARIO") + "'>" %> 
                                <input type="hidden" name="FECHA_MODI">
                                Formulario de Alta</b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#E0E0E0" valign="top" colspan="2"> 
                                <table align="center" cellpadding="2" cellspacing="1" border="0" width="100%">
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">A&ntilde;o:</td>
                                    <td width="75%" colspan="7"> 
                                      <input type="text" name="ID_ANO" value="<%= RSPERMISO_TIPOS__MMColParam1%>" size="6" maxlength="4">
                                    <input type="hidden" name="ID_TIPO_FUNCIONARIO" value="<%=(((RSFUNCIONARIO_data = RSFUNCIONARIO.getObject("TIPO_FUNCIONARIO"))==null || RSFUNCIONARIO.wasNull())?"":RSFUNCIONARIO_data)%>" size="16" maxlength="15">                                    </td>
                                  </tr>
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Tipo 
                                      de Permiso:</td>
                                    <td width="75%" colspan="7"> 
                                      <input type="hidden" name="ID_TIPO_PERMISO" value="01000" size="16" maxlength="15">
                                      <select name="MENU_TIPO_PERMISO"  onChange="mostrarOcultar(this)">
                                        <% while (RSTIPOPERMISO_hasData) {
%>
                                        <%= "<option value='" %><%= (((RSTIPOPERMISO_data = RSTIPOPERMISO.getObject("ID_TIPO_PERMISO"))==null || RSTIPOPERMISO.wasNull())?"":RSTIPOPERMISO_data) %><%= "'>" %> <%= (((RSTIPOPERMISO_data = RSTIPOPERMISO.getObject("ID_TIPO_PERMISO2"))==null || RSTIPOPERMISO.wasNull())?"":RSTIPOPERMISO_data) %><%= " - " %> <%= RSTIPOPERMISO_data= RSTIPOPERMISO.getObject("DESC_TIPO_PERMISO") %> <%= "</option>" %> 
                                        <%  RSTIPOPERMISO_hasData = RSTIPOPERMISO.next();
}
RSTIPOPERMISO.close();
RSTIPOPERMISO = StatementRSTIPOPERMISO.executeQuery();
RSTIPOPERMISO_hasData = RSTIPOPERMISO.next();
RSTIPOPERMISO_isEmpty = !RSTIPOPERMISO_hasData;
%>
                                      </select>
                                    </td>
                                  </tr>
                                    <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Tipo de D&iacute;as:</td>
                                    <td colspan=7><select name="TIPO_DIAS">
                                      <option value="L">LABORAL</option>
                                      <option value="N">NATURAL</option>
                                    </select> 
                                    </td>
                                    
                                  </tr>
                                                    
                           <tr bgcolor="#f2f2f2" id="GRAD">
                              <% if (RSQUEYFECHAS__MMColParam4.equals("06100") ) { %>
                                    <td nowrap align="right"></td>
									<td colspan="4"></td>
           						<% } else { %>
									<td nowrap align="right">Grado:</td>
                                     <td colspan="4"><select name="ID_GRADO" onChange="document.formPermiso.OBSERVACIONES.value=document.formPermiso.GRADO.options[selectedIndex].text">
                                	<option value="4">Padres/Padres pol�ticos 5 D&iacute;as Enfermedad y 4 D&iacute;as Fallecimiento</option>
					<option value="5">Hijos/Hijos politicos/Conyuge 5 D&iacute;as (Enfermedad y  Fallecimiento)</option>
					<option value="3">Abuelos/Hermanos/Nietos y pol�ticos 4 D&iacute;as Enfermedad y 2 D&iacute;as Fallecimiento</option>
					<option value="6">Tios/sobrinos carnales o c. del conyugue 1 D&iacute;a (Enfermedad y  Fallecimiento)</option>
                                    </select></td>
                               
	                          <% } %>
                                    <td>D/P:</td>
                                    <td><select name="DPROVINCIA">
                                      <option value="NO" selected>NO</option>
                                      <option value="SI">SI</option>
                                                                                                                                                                                    </select></td>
                                  </tr>
                  
                                   
             <tr bgcolor="#f2f2f2" id="BAJA"> 
                <td nowrap align="right" width="20%">Baja:</td>
             <td>
             <select name="TIPO_BAJA" id="TIPO_BAJA" >
                                                  <option value="AL" <%=(("AL".toString().equals(RSQUEYFECHAS__MMColParam12))?"SELECTED":"")%>>ACCIDENTE LABORAL</option>
    											  <option value="AR" <%=(("AR".toString().equals(RSQUEYFECHAS__MMColParam12))?"SELECTED":"")%>>ACCIDENTE LABORAL RECAIDA</option>
    											  <option value="AN" <%=(("AN".toString().equals(RSQUEYFECHAS__MMColParam12))?"SELECTED":"")%>>ACCIDENTE NO LABORAL</option>
    											  <option value="EC" <%=(("EC".toString().equals(RSQUEYFECHAS__MMColParam12))?"SELECTED":"")%>>ENFERMEDAD COMUN</option>
                                           </select> </td>
                 <td align="right" width="20%">Descuento a bolsa:</td>
                       <td  > 
                             <select name="DESCUENTO_BAJAS">
                                    <option value="NO" <%=(("NO".toString().equals(RSQUEYFECHAS__MMColParam13))?"SELECTED":"")%>>NO</option>
                                    <option value="SI" <%=(("SI".toString().equals(RSQUEYFECHAS__MMColParam13))?"SELECTED":"")%>>SI</option>
                             </select>
                             
                        </td>
                         <td nowrap align="right" width="20%">Descuento en d�as:</td>
                         <td><input name="DESCUENTO_DIAS" type="text" id="DESCUENTO_DIAS" value="<%=RSQUEYFECHAS__MMColParam14 %>" size="8" maxlength="5"></td>
                    
             </tr>     
   
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Fecha 
                                      Inicio:</td>
                                    <td valign="middle" colspan="7"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td  width="25%"> 
                                            <input type="text" name="FECHA_INICIO" value="<%=RSQUEYFECHAS__MMColParam1 %>" onChange="document.formPermiso.FECHA_FIN.value=document.formPermiso.FECHA_INICIO.value;" size="12" maxlength="10">
</td>
                                          <td><a href="javascript:show_Calendario('formPermiso.FECHA_INICIO');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>
                                    </td>
                                    </tr>
                                    <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%">Fecha Fin:</td>
                                    <td valign="middle" colspan="7"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="25%"> 
                                            <input type="text" name="FECHA_FIN" value="<%=RSQUEYFECHAS__MMColParam2 %>"  size="12" maxlength="10">
               </td>
                                          <td ><a href="javascript:show_Calendario('formPermiso.FECHA_FIN');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                      
                                
                           
 
<tr id="BOMB"> <td colspan="5" align="center"><table id="BOMBE">
            <tr><td colspan="5" >
            <tr><td colspan="3" >Guardia: Fecha Inicio a las 08:00 hasta d�a siguiente a las 08:00. Desde el 21 Mayo 2022</td></tr>
            <tr><td colspan="3">Solicitudes 00:00 a 08:00,es referido a la fecha del inicio de la Guardia.</td></tr>           
            <tr><td colspan="2" ><input name="AP1_1"  type="hidden" value="" size="12" maxlength="12"><input name="FECHA_TURNO_1" disabled="yes" type="text" value="" size="12" maxlength="12"><input type="checkbox" name="AP1" id="AP1" onclick="Turnos('1');"><label for="AP1">08:00 a 16:00</label> </td></tr>
            <tr><td colspan="2" ><input name="AP1_2"  type="hidden" value="" size="12" maxlength="12"><input name="FECHA_TURNO_2" disabled="yes" type="text" value="" size="12" maxlength="12"><input type="checkbox" name="AP2" id="AP2" onclick="Turnos('2');"><label for="AP2">16:00 a 00:00</label> </td></tr>
            <tr><td colspan="2" ><input name="AP1_3"  type="hidden" value="" size="12" maxlength="12"><input name="FECHA_TURNO_3" disabled="yes" type="text" value="" size="12" maxlength="12"><input type="checkbox" name="AP3" id="AP3" onclick="Turnos('3');"><label for="AP3">00:00 a 08:00</label></td> </tr>
            <tr><td colspan="2" >N�mero de d�as: <input type="text" disabled="yes" name="horas_sel" size="1"></td> </tr>
           
             </td></tr>
             </table></td>
            
             </tr> 
  

                                    
<tr bgcolor="#f2f2f2" id="COMP"> 
                                    <td nowrap align="right" width="20%">Hora Inicio :</td>
                                    <td><input name="HORA_INICIO" type="text" id="HORA_INICIO" value="<%=RSQUEYFECHAS__MMColParam7 %>" size="8" maxlength="5" onChange="cambio_hora(this)"> 
                                    </td>
                                    <td nowrap><div align="right">Hora Fin: </div></td>
                                    
	                                    <td><input name="HORA_FIN" type="text" id="HORA_FIN" value="<%=RSQUEYFECHAS__MMColParam8 %>" size="8" maxlength="5"></td>
	                                    
	                                    <td colspan="2" id="BOMB2"><div align="right">Disponibles: </div></td>
	                                    <td id="BOMB3">
	                                      <% if (!RSHORAS_isEmpty ) { %>
	                                      <input name="HORA_DIS2" type="text" disabled="yes" id="HORA_FIN2" value="<%=(((RSHORAS_data = RSHORAS.getObject("HORAS"))==null || RSHORAS.wasNull())?"":RSHORAS_data)%>" size="7" maxlength="5">
	                                      <% } /* end !RSHORAS_isEmpty */ %></td>
	                                    <td>&nbsp;</td>
                                    
                                  </tr>  
                                                 


                                                          <tr bgcolor="#f2f2f2" id="JUST"> 
                                    <td align="right" width="20%">Justificado:</td>
                                    <td colspan="7"> 
                                      <select name="ID_JUSTIFICACION">
                                        <option value="NO" <%=(("NO".toString().equals(RSQUEYFECHAS__MMColParam5))?"SELECTED":"")%>>NO</option>
                                        <option value="SI" <%=(("SI".toString().equals(RSQUEYFECHAS__MMColParam5))?"SELECTED":"")%>>SI</option>
                                        <option value="--" selected <%=(("--".toString().equals(RSQUEYFECHAS__MMColParam5))?"SELECTED":"")%>>--</option>
                                      </select>
                                    </td>
                                  </tr>     
                   
                  
               
                                  <tr bgcolor="#f2f2f2"> 
                                    <td nowrap align="right" width="20%" bgcolor="#f2f2f2" valign="middle">Observaciones:</td>
                                    <td width="75%" colspan="7" valign="baseline"> 
                                      <textarea name="OBSERVACIONES" value="<%=RSQUEYFECHAS__MMColParam9 %>" cols="100" rows="5"><%=RSQUEYFECHAS__MMColParam9 %></textarea>
                                    </td>
                                  </tr>
                                </table>
                                
                                <script language="JavaScript">
document.formPermiso.MENU_TIPO_PERMISO.value = document.formPermiso.ID_TIPO_PERMISO.value;
</script>
                              </td>
                            </tr>
                          </form>
      </table>
	
</div>
</div>	
</body>
</html>
<%
RSQUERY.close();
ConnRSQUERY.close();
%>
<%
RSTIPOPERMISO.close();
ConnRSTIPOPERMISO.close();
%>
<%
RSQUEYFECHAS.close();
ConnRSQUEYFECHAS.close();
%>
<%
RSFUNCIONARIO.close();
ConnRSFUNCIONARIO.close();
%>
<%
RSPERMISO_TIPOS.close();
ConnRSPERMISO_TIPOS.close();
%>
<%
RSHORAS.close();
StatementRSHORAS.close();
ConnRSHORAS.close();
%>

