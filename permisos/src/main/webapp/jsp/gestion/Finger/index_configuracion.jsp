<%@page language="java" import="java.util.Date,java.sql.*" %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<% String RSIMPAR="";
   String RSCOLOR="";

%>
<%
String RSF__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FICHAJE")   !=null) {RSF__MMColParam1 = (String)session.getAttribute("MM_ID_FICHAJE")  ;}
%>
<%
String RSFICHAJE_DIA__MMColParam1 = "000000";
if (session.getValue("MM_ID_FUNCIONARIO")    !=null) {RSFICHAJE_DIA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")   ;}
%>
<%
String RSFICHAJE_DIA__MMColParam2 = "12/02/2018";
if (request.getParameter("ID_DIA") !=null) {RSFICHAJE_DIA__MMColParam2 = (String)request.getParameter("ID_DIA");}
%>
<%
java.util.Calendar cal_periodo = java.util.Calendar.getInstance();
Integer periodo = new Integer( cal_periodo.get(java.util.Calendar.YEAR) );
%>

<%
String RSPERIODO__MMColParam1 = "000000";
if (request.getParameter("ID_FUNCIONARIO")   !=null) {RSPERIODO__MMColParam1 = (String)request.getParameter("ID_FUNCIONARIO")  ;}
%>
<%
String RSPERIODO__MMColParam5 = "";
if (request.getParameter("NOMBRE")    !=null) {RSPERIODO__MMColParam5 = (String)request.getParameter("NOMBRE")   ;}
%>

<%
String RSQUERY__MMColParam7 = "";
if (request.getParameter("APE1")    !=null) {RSQUERY__MMColParam7 = (String)request.getParameter("APE1")   ;}
%>
<%
String RSQUERY__MMColParam8 = "";
if (request.getParameter("APE2")    !=null) {RSQUERY__MMColParam8 = (String)request.getParameter("APE2")   ;}
%>

<%
if (!RSPERIODO__MMColParam1.equals("000000")) { 
	session.putValue("MM_ID_FUNCIONARIO", 			RSPERIODO__MMColParam1); 
	session.putValue("MM_ID_FUNCIONARIO_NOMBRE", RSPERIODO__MMColParam5); 
	session.putValue("MM_ID_FUNCIONARIO_APE1", 			RSQUERY__MMColParam7); 
	session.putValue("MM_ID_FUNCIONARIO_APE2", 			RSQUERY__MMColParam8); 
	
} else {
	RSPERIODO__MMColParam1 = (String) session.getValue("MM_ID_FUNCIONARIO");
}
%>

<%
String RSFICHA__MMColParam1= "00";
if (session.getValue("MM_ID_FUNCIONARIO")   !=null) {RSFICHA__MMColParam1 = (String)session.getValue("MM_ID_FUNCIONARIO")  ;}
%>
<%
Driver DriverRSFICHA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSFICHA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSFICHA = ConnRSFICHA.prepareStatement("select NVL(PIN,'SIN') as PIN,to_char(nvl(ID_TIPO_FIcHAJE,9))as ID_TIPO_FICHAJE,p.id_funcionario from FUNCIONARIO_FICHAJE f,personal_new p where f.id_funcionario(+)=p.id_funcionario and lpad(p.id_funcionario,6,'0')=lpad('" + RSFICHA__MMColParam1 + "',6,'0') ");

ResultSet RSFICHA = StatementRSFICHA.executeQuery();
boolean RSFICHA_isEmpty = !RSFICHA.next();
boolean RSFICHA_hasData = !RSFICHA_isEmpty;
Object RSFICHA_data;
int RSFICHA_numRows = 0; 
%>
<%
Driver DriverRSTIPO_FICHA = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSTIPO_FICHA = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSTIPO_FICHA = ConnRSTIPO_FICHA.prepareStatement("select DESC_FICHAJE ,to_char(ID_TIPO_FICHAJE) as ID_TIPO_FICHAJE   from tr_tipo_fichaje tr order by 2");

ResultSet RSTIPO_FICHA = StatementRSTIPO_FICHA.executeQuery();
boolean RSTIPO_FICHA_isEmpty = !RSTIPO_FICHA.next();
boolean RSTIPO_FICHA_hasData = !RSTIPO_FICHA_isEmpty;
Object RSTIPO_FICHA_data;
int RSTIPO_FICHA_numRows = 0; 
%>

<%
String RS_PTO_FICHAJE__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RS_PTO_FICHAJE__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>

<%
Driver DriverRS_PTO_FICHAJE = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_PTO_FICHAJE = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_PTO_FICHAJE = ConnRS_PTO_FICHAJE.prepareStatement("select TRIM(LPAD(NVL(denom, 'MANUAL  '), 22, ' '))as RELOJ,t.id_funcionario,R.numero as NUM_RELOJ  from       fichaje_funcionario_reloj t,           relojes       r where    lpad(t.id_funcionario, 6, '0') = lpad('" + RS_PTO_FICHAJE__MMColParam1 + "', 6, '0') and      t.relojes= r.numero and r.activo='S'    order by t.id_funcionario");
ResultSet RS_PTO_FICHAJE = StatementRS_PTO_FICHAJE.executeQuery();
boolean RS_PTO_FICHAJE_isEmpty = !RS_PTO_FICHAJE.next();
boolean RS_PTO_FICHAJE_hasData = !RS_PTO_FICHAJE_isEmpty;
Object RS_PTO_FICHAJE_data;
int RS_PTO_FICHAJE_numRows = 0;
%>     

<%
int Repeat1__numRows = 30;
int Repeat1__index = 0;
RS_PTO_FICHAJE_numRows += Repeat1__numRows;
%>

<%
String RS_JORNADA_FUN__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RS_JORNADA_FUN__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>

<%
Driver DriverRS_JORNADA_FUN = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_JORNADA_FUN = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_JORNADA_FUN = ConnRS_JORNADA_FUN.prepareStatement("select DECODE(horas_semanales, 37, 'checked', '') as H37,       decode(bolsa, 1, 'checked', '') as bolsa,       DECODE(horas_semanales, 37.5, 'checked', '') as H37_5,       DECODE(horas_semanales, 40, 'checked', '') as H40,       to_char(horas_jornada, 'HH24:MI') as horas_jornada,       reduccion,       DECODE(LIBRE, 'SI', 'checked') as LIBRE,       DECODE(CONTAR_COMIDA, 'SI', 'checked') as CONTAR_COMIDA,       DIAS,       DECODE(DIAS, 5, 'checked', '') as S5,       DECODE(DIAS, 7, 'checked', '') as S7,       DECODE(DIAS, 5, '', 7, '', 'checked') as S0,       to_char(fecha_inicio, 'DD/mm/yyyy') as fecha_inicio,       to_char(fecha_fin, 'DD/mm/yyyy') as fecha_fin,        DECODE(substr(DIAS_SEMANA,1,1),1, 'checked', '') as J_LUNES,       DECODE(substr(DIAS_SEMANA,2,1),1, 'checked', '') as J_MARTES,       DECODE(substr(DIAS_SEMANA,3,1),1, 'checked', '') as J_MIERCOLES,      DECODE(substr(DIAS_SEMANA,4,1),1, 'checked', '') as J_JUEVES,       DECODE(substr(DIAS_SEMANA,5,1),1, 'checked', '') as J_VIERNES,       DECODE(substr(DIAS_SEMANA,6,1),1, 'checked', '') as J_SABADO,       DECODE(substr(DIAS_SEMANA,7,1),1, 'checked', '') as J_DOMINGO,              decode(bolsa_con, 1, 'checked', '') as BOLSA_CON from fichaje_funcionario_jornada t where lpad(t.id_funcionario, 6, '0') =      lpad('" + RS_JORNADA_FUN__MMColParam1 + "', 6, '0')   and sysdate  between fecha_inicio and nvl(fecha_fin,sysdate) order by t.id_funcionario");
ResultSet RS_JORNADA_FUN = StatementRS_JORNADA_FUN.executeQuery();
boolean RS_JORNADA_FUN_isEmpty = !RS_JORNADA_FUN.next();
boolean RS_JORNADA_FUN_hasData = !RS_JORNADA_FUN_isEmpty;
Object RS_JORNADA_FUN_data;
int RS_JORNADA_FUN_numRows = 0;
%>   
<%
String RS_ALERTAS__MMColParam1 = "00000";
if (session.getAttribute("MM_ID_FUNCIONARIO")   !=null) {RS_ALERTAS__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO")  ;}
%>

<%
Driver DriverRS_ALERTAS = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS_ALERTAS = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRS_ALERTAS = ConnRS_ALERTAS.prepareStatement("select DECODE(sin_alertas, 1, 'checked', '') as sin_alertas,       DECODE(alerta_0, 1, 'checked', '') as  alerta_0,       DECODE(alerta_1, 1, 'checked', '') as  alerta_1,       DECODE(alerta_2, 1, 'checked', '') as  alerta_2 ,       DECODE(alerta_3, 1, 'checked', '') as alerta_3,       DECODE(alerta_4, 1, 'checked', '') as alerta_4,       DECODE(alerta_5, 1, 'checked', '') as alerta_5,       DECODE(alerta_6, 1, 'checked', '') as alerta_6,       DECODE(alerta_7, 1, 'checked', '') as alerta_7,       DECODE(alerta_8, 1, 'checked', '') as alerta_8,       DECODE(alerta_9, 1, 'checked', '') as alerta_9,       DECODE(alerta_10, 1, 'checked', '') as alerta_10,       DECODE(alerta_11, 1, 'checked', '') as alerta_11,       DECODE(alerta_12, 1, 'checked', '') as alerta_12,       DECODE(alerta_13, 1, 'checked', '') as alerta_13,       DECODE(alerta_14, 1, 'checked', '') as alerta_14,       DECODE(alerta_15, 1, 'checked', '') as alerta_15  from fichaje_funcionario_alerta t where lpad(t.id_funcionario, 6, '0') =       lpad('" + RS_ALERTAS__MMColParam1 + "', 6, '0')   order by t.id_funcionario");
ResultSet RS_ALERTAS = StatementRS_ALERTAS.executeQuery();
boolean RS_ALERTAS_isEmpty = !RS_ALERTAS.next();
boolean RS_ALERTAS_hasData = !RS_ALERTAS_isEmpty;
Object RS_ALERTAS_data;
int RS_ALERTAS_numRows = 0;
%>   

<%
String RSCALENDARIO__MMColParam1 = "0";
if (session.getAttribute("MM_ID_FUNCIONARIO")  !=null) {RSCALENDARIO__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO") ;}
%>
<%
Driver DriverRSCALENDARIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCALENDARIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCALENDARIO = ConnRSCALENDARIO.prepareStatement("select         to_char( mod(to_number(dia),2)) as impar,      t.id_calendario,        dia, DECODE(dia, 2,'Lunes', 3,'Martes', 4,'Miercoles', 5,'Jueves', 6,'Viernes',  7,'Sabado',  8,'Domingo') as  dia_semana,        to_char(horas_teoricas,'hh24:mi') as  horas_teoricas,        to_char(p1_obl_desde,'hh24:mi') as p1_obl_desde,        to_char(p1_obl_hasta,'hh24:mi') as p1_obl_hasta,        to_char(p1_fle_desde,'hh24:mi') as p1_fle_desde,        to_char(p1_fle_hasta,'hh24:mi') as p1_fle_hasta,        to_char(p2_obl_desde,'hh24:mi') as p2_obl_desde,        to_char(p2_obl_hasta,'hh24:mi') as p2_obl_hasta,        to_char(p2_fle_desde,'hh24:mi') as p2_fle_desde,        to_char(p2_fle_hasta,'hh24:mi') as p2_fle_hasta,        to_char(p3_obl_desde,'hh24:mi') as p3_obl_desde,        to_char(p3_obl_hasta,'hh24:mi') as p3_obl_hasta,        to_char(p3_fle_desde,'hh24:mi') as p3_fle_desde,        to_char(p3_fle_hasta,'hh24:mi') as p3_fle_hasta,        turno,        fc.horas_semanales,        DESC_CALENDARIO,        t.fecha_inicio,        t.fecha_fin         from  fichaje_funcionario_jornada   ff , FICHAJE_CALENDARIO_JORNADA t,FICHAJE_CALENDARIO  FC where ff.id_funcionario= '" + RSCALENDARIO__MMColParam1 + "'    and   t.id_calendario = ff.id_calendario    and to_date(to_char(sysdate,'DD/mm/yyyy'),'DD/mm/yyyy') between ff.fecha_inicio and  nvl(ff.fecha_fin, to_date(to_char(sysdate,'DD/mm/yyyy'),'DD/mm/yyyy'))  and t.fecha_fin is  null          and fc.fecha_fin is  null          and t.id_calendario=fc.id_calendario                  order by dia");
ResultSet RSCALENDARIO = StatementRSCALENDARIO.executeQuery();
boolean RSCALENDARIO_isEmpty = !RSCALENDARIO.next();
boolean RSCALENDARIO_hasData = !RSCALENDARIO_isEmpty;
Object RSCALENDARIO_data;
int RSCALENDARIO_numRows = 0;
%>  

<%
int Repeat2__numRows = 15;
int Repeat2__index = 0;
RSCALENDARIO_numRows += Repeat2__numRows;
%>
<%
String RSCALENDARIO_H__MMColParam1 = "0";
if (session.getAttribute("MM_ID_FUNCIONARIO")  !=null) {RSCALENDARIO_H__MMColParam1 = (String)session.getAttribute("MM_ID_FUNCIONARIO") ;}
%>
<%
Driver DriverRSCALENDARIO_H = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSCALENDARIO_H = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSCALENDARIO_H = ConnRSCALENDARIO_H.prepareStatement("select distinct id_funcionario,   to_char(fecha_hoy_entre_dos(f.fecha_inicio,nvl(f.fecha_fin,sysdate+1))) as activo,   f.fecha_inicio as fei, f.fecha_fin as fef,   f.id_calendario,       fc.desc_calendario,              to_char(f.fecha_inicio,'dd/mm/yyyy') as fecha_inicio,             to_char(f.fecha_fin,'dd/mm/yyyy') as fecha_fin,       f.horas_semanales,       reduccion,      to_char( horas_jornada,'hh24:mi') as horas_jornada ,f.dias,       contar_comida,       libre ,    DECODE(bolsa,1,'SI','NO') as bolsa  ,                DECODE(bolsa_con,1,'SI','NO') as bolsa_con ,                DECODE(substr(dias_semana,1,1),1,'L','') ||                DECODE(substr(dias_semana,2,1),1,'M','') ||                DECODE(substr(dias_semana,3,1),1,'X','') ||                DECODE(substr(dias_semana,4,1),1,'J','') ||                DECODE(substr(dias_semana,5,1),1,'V','') ||                DECODE(substr(dias_semana,6,1),1,'S','') ||                DECODE(substr(dias_semana,7,1),1,'D','')  as DIAS_SEMANA          from FICHAJE_FUNCIONARIO_JORNADA f,FICHAJE_CALENDARIO FC  where f.id_funcionario= '" + RSCALENDARIO_H__MMColParam1 + "'   and f.id_calendario=fc.id_calendario  order by fei desc");
ResultSet RSCALENDARIO_H = StatementRSCALENDARIO_H.executeQuery();
boolean RSCALENDARIO_H_isEmpty = !RSCALENDARIO_H.next();
boolean RSCALENDARIO_H_hasData = !RSCALENDARIO_H_isEmpty;
Object RSCALENDARIO_H_data;
int RSCALENDARIO_H_numRows = 0;
%>  
<%
int Repeat3__numRows = 15;
int Repeat3__index = 0;
RSCALENDARIO_H_numRows += Repeat2__numRows;
%>
<%
Driver DriverRSRELOJ= (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSRELOJ= DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSRELOJ= ConnRSRELOJ.prepareStatement("select numero,denom from  relojes where activo='S' order by denom");
ResultSet RSRELOJ= StatementRSRELOJ.executeQuery();
boolean RSRELOJ_isEmpty = !RSRELOJ.next();
boolean RSRELOJ_hasData = !RSRELOJ_isEmpty;
Object RSRELOJ_data;
int RSRELOJ_numRows = 0;
%>  
<script language="Javascript" >
function envia_unavez()
{
	document.FINGER.CAMPO_ALERT.value="";
if (document.FINGER.Guardar.disabled==false) 
 {
     document.FINGER.Guardar.disabled=true;

     if(document.FINGER.ALERTA_1.checked == true) 
    	 document.FINGER.CAMPO_ALERT.value="ALERTA_11;" +  document.FINGER.CAMPO_ALERT.value;
     else 
    	 document.FINGER.CAMPO_ALERT.value="ALERTA_10;" +  document.FINGER.CAMPO_ALERT.value;
     
   if(document.FINGER.ALERTA_2.checked == true) 
	   document.FINGER.CAMPO_ALERT.value="ALERTA_21;" +  document.FINGER.CAMPO_ALERT.value;
   else 
 	   document.FINGER.CAMPO_ALERT.value="ALERTA_20;" +  document.FINGER.CAMPO_ALERT.value;
   
   if(document.FINGER.ALERTA_3.checked == true) 
	   document.FINGER.CAMPO_ALERT.value="ALERTA_31;" +  document.FINGER.CAMPO_ALERT.value;
   else 
 	  document.FINGER.CAMPO_ALERT.value="ALERTA_30;" +  document.FINGER.CAMPO_ALERT.value;
   
   if(document.FINGER.ALERTA_4.checked == true) 
	   document.FINGER.CAMPO_ALERT.value="ALERTA_41;" +  document.FINGER.CAMPO_ALERT.value;
   else 
 	  document.FINGER.CAMPO_ALERT.value="ALERTA_40;" +  document.FINGER.CAMPO_ALERT.value;
   
   if(document.FINGER.ALERTA_5.checked == true) 
	   document.FINGER.CAMPO_ALERT.value="ALERTA_51;" +  document.FINGER.CAMPO_ALERT.value;
   else 
 	  document.FINGER.CAMPO_ALERT.value="ALERTA_50;" +  document.FINGER.CAMPO_ALERT.value;
   
   if(document.FINGER.ALERTA_6.checked == true) 
	   document.FINGER.CAMPO_ALERT.value="ALERTA_61;" +  document.FINGER.CAMPO_ALERT.value;
   else 
 	  document.FINGER.CAMPO_ALERT.value="ALERTA_60;" +  document.FINGER.CAMPO_ALERT.value;

 if(document.FINGER.ALERTA_7.checked == true) 
	 document.FINGER.CAMPO_ALERT.value="ALERTA_71;" +  document.FINGER.CAMPO_ALERT.value;
 else 
	  document.FINGER.CAMPO_ALERT.value="ALERTA_70;" +  document.FINGER.CAMPO_ALERT.value;
 

 if(document.FINGER.ALERTA_8.checked == true) 
	 document.FINGER.CAMPO_ALERT.value="ALERTA_81;" +  document.FINGER.CAMPO_ALERT.value;
 else 
	  document.FINGER.CAMPO_ALERT.value="ALERTA_80;" +  document.FINGER.CAMPO_ALERT.value;
 
 if(document.FINGER.ALERTA_9.checked == true) 	 
	 document.FINGER.CAMPO_ALERT.value="ALERTA_91;" +  document.FINGER.CAMPO_ALERT.value;
  else 
	  document.FINGER.CAMPO_ALERT.value="ALERTA_90;" +  document.FINGER.CAMPO_ALERT.value;
  
     
   
   //ALERTAS CAMPO
   if(document.FINGER.ALERTAS_SIN.checked == true) 
	         document.FINGER.CAMPO_ALERT.value="ALERTA_SIN1;" +  document.FINGER.CAMPO_ALERT.value;
   else	 
	     document.FINGER.CAMPO_ALERT.value="ALERTA_SIN0;ALERTA_10;ALERTA_20;ALERTA_30;ALERTA_40;ALERTA_50;ALERTA_60;ALERTA_70;ALERTA_80;ALERTA_80;ALERTA_90;";
	

   
   
   document.FINGER.CAMPO_ALERT.value=document.FINGER.CAMPO_ALERT.value +"*";
   
  //FIN CAMPO ALERTAS
   

   //CAMPO_JORNADA
   contador_dias_jornada=0;
   document.FINGER.CAMPO_JORNADA.value="";
   dias_sele="07:00";
   horas_sele="5";
     for (i=0;i<3;i++)
	 {	   
	   if (document.FINGER.horas[i].checked)
	    {		
		 dias_sele=document.FINGER.horas[i].value;		
		}
	   
	   if (document.FINGER.Jornada[i].checked)
	    {		
		 horas_sele=document.FINGER.Jornada[i].value;		
	  	}
     }
	    hcomida="J_HC0"; 
       if (document.FINGER.J_HCOMIDA.checked)
	    {		
		  hcomida="J_HC1";
	  	}	 
		
		hlibre="J_LI0"; 
       if (document.FINGER.J_LIBRE.checked)
	    {		
		  hlibre="J_LI1";
	  	}	 

       hbolsa="J_BO0";
       if (document.FINGER.J_BOLSA.checked)
	    {		
    	   hbolsa="J_BO1";
	  	}	

       hbolsa_con="J_BOC0";
       if (document.FINGER.J_BOLSA_CON.checked)
	    {		
    	   hbolsa_con="J_BOC1";
	  	}	
	  	
       if (document.FINGER.J_LUNES.checked)	
        {       	
   	     dias_semana="DIAS_SEMANA1";
   	    contador_dias_jornada=contador_dias_jornada+1;
        }	
       else 
        {  
    	 dias_semana="DIAS_SEMANA0";
        }
       
       if (document.FINGER.J_MARTES.checked)	
        {      	
     	     dias_semana= dias_semana + "1";
     	    contador_dias_jornada=contador_dias_jornada+1;
        }   
         else   
         { 
      	     dias_semana=dias_semana  + "0";	 	
         }  
         
       if (document.FINGER.J_MIERCOLES.checked)	
       {    	
   	     dias_semana=dias_semana + "1";
   	     contador_dias_jornada=contador_dias_jornada+1; 
       }
       else
       {   
    	  dias_semana=dias_semana  +"0";
       }  

       if (document.FINGER.J_JUEVES.checked)
       {  	    	
     	     dias_semana=dias_semana  + "1";
     	    contador_dias_jornada=contador_dias_jornada+1;
       }
       else 
       {    
      	  dias_semana=dias_semana + "0";    
       }        
    	            
       if (document.FINGER.J_VIERNES.checked)
       {     	    	
   	     dias_semana=dias_semana  + "1";
   	    contador_dias_jornada=contador_dias_jornada+1;
       }  
     else 
       {     
    	  dias_semana=dias_semana + "0";
       }    

       if (document.FINGER.J_SABADO.checked)
       {  	    	
     	     dias_semana=dias_semana  + "1";
     	    contador_dias_jornada=contador_dias_jornada+1;
       }     
       else
       {     
      	  dias_semana=dias_semana + "0";
       }    

       if (document.FINGER.J_DOMINGO.checked)
        {  	    	
     	     dias_semana=dias_semana  + "1";
     	    contador_dias_jornada=contador_dias_jornada+1;
        }     
       else
        {     
      	  dias_semana=dias_semana + "0";  
        } 
  	          

       
       document.FINGER.CAMPO_JORNADA.value= document.FINGER.MODIFICA_JORNADA.value +document.FINGER.CAMPO_JORNADA.value;
        
	   document.FINGER.CAMPO_JORNADA.value=  document.FINGER.CAMPO_JORNADA.value + "J_FI" + document.FINGER.FECHA_INICIO.value + ";"  ;
	   document.FINGER.CAMPO_JORNADA.value=  document.FINGER.CAMPO_JORNADA.value + "J_FF" + document.FINGER.FECHA_FIN.value + ";"     ;	   
	   document.FINGER.CAMPO_JORNADA.value=  document.FINGER.CAMPO_JORNADA.value + "J_DI" + horas_sele + ";" ;
	   document.FINGER.CAMPO_JORNADA.value=  document.FINGER.CAMPO_JORNADA.value + "J_HD" +document.FINGER.HORAS_J.value + ";" ;
	   document.FINGER.CAMPO_JORNADA.value=  document.FINGER.CAMPO_JORNADA.value + "J_RE" +document.FINGER.REDUCCION.value + ";" ;
	   document.FINGER.CAMPO_JORNADA.value=  document.FINGER.CAMPO_JORNADA.value + "J_HS" + contador_dias_jornada+ ";" ;
	   document.FINGER.CAMPO_JORNADA.value=  document.FINGER.CAMPO_JORNADA.value + hbolsa + ";" + hbolsa_con + ";";
	   document.FINGER.CAMPO_JORNADA.value=  document.FINGER.CAMPO_JORNADA.value + hcomida + ";"  + hlibre + ";" +dias_semana  + ";" ;


	   
	//FIN CAMPO_JORNADA

    //CAMPO_PTO_FICHAJE
	   ida=0;

       ptofichaje="P_T0";
       
       if (document.FINGER.PTO_TODOS.checked)
       {		
    	   ptofichaje="P_T1";
	   }	

	   document.FINGER.CAMPO_PTO_FICHAJE.value = ptofichaje + ";" ;
	   
	   while (ida < 6) 
        {

         	if (document.getElementById('campoc' + ida).value == 1 || document.getElementById('valorc' + ida).value==3 )

     		    {
                   document.FINGER.CAMPO_PTO_FICHAJE.value =  document.FINGER.CAMPO_PTO_FICHAJE.value + "P"+ document.getElementById('CLAVE_HORA_' + ida).value + 'X' +
                                                     document.getElementById('valorc' + ida).value   +'*' ;
                }			
							
         	ida = ida + 1;
			  
		}
		
	//CAMPO_CALENDARIO	
	document.FINGER.CAMPO_CALENDARIO.value=document.FINGER.ID_CALENDARIO_CAM.value;
	document.FINGER.submit();
	   
  }//fin if 

}  // envia_unavez
function Modifica_Alertas()
{
	 document.FINGER.MODIFICA_ALERTA.value="1";
}
function Alertas()
{

   document.FINGER.ALERTA_1.checked  = false;
   document.FINGER.ALERTA_2.checked  = false;
   document.FINGER.ALERTA_3.checked  = false;
   document.FINGER.ALERTA_4.checked  = false;
   document.FINGER.ALERTA_5.checked  = false;
   document.FINGER.ALERTA_6.checked  = false;
   document.FINGER.ALERTA_7.checked  = false;
   document.FINGER.ALERTA_8.checked  = false;
   document.FINGER.ALERTA_9.checked  = false;
   
   
   document.FINGER.MODIFICA_ALERTA.value="1";



   if(document.FINGER.ALERTAS_SIN.checked == true) 
	   {        
	   document.FINGER.ALERTA_1.checked  = true;
	   document.FINGER.ALERTA_2.checked  = true;
	   document.FINGER.ALERTA_3.checked  = true;
	   document.FINGER.ALERTA_4.checked  = true;
	   document.FINGER.ALERTA_5.checked  = true;
	   document.FINGER.ALERTA_6.checked  = true;
	   document.FINGER.ALERTA_7.checked  = true;
	   document.FINGER.ALERTA_8.checked  = true;
	   document.FINGER.ALERTA_9.checked  = true;

	   }
   
} 

function a�adir()
{

   var ida = 1;
   var encontrado=0;

   
     while (ida < 6) 
        {
	        
			
			thediv = document.getElementById('campoc' + ida).value;
		       		 
		   if (thediv == "0") 
     		    {
		    	 eval('c'+ida).style.display ='';
				 document.getElementById('campoc' + ida).value= 1;
      		     document.getElementById('valorc' + ida).value= 1;
				
		    	 ida=15;
			    }			
							
         	ida = ida + 1;
			  
		}

  
}
function asignar_calen()
{
  window.open('select_calendario.jsp?CAMPO=ID_CALENDARIO_CAM' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');
  eval("calen_campo_id").style.display='';
}
function borrar(capa)
{        
		
	eval(capa).style.display='none';   
    thediv = document.getElementById('campo' + capa);
    document.getElementById('valor' + capa).value= 3;
	
	thediv.value = "0" ;     
  
}

function mostrar()
{
	vt.style.display='none';
	ot.style.display='';
}

function ocultar()
{
	vt.style.display='';
	ot.style.display='none';
}
function Cambia_Horas2()
{

	 campo= document.getElementById("REDUCCION").value;
	 document.FINGER.MODIFICA_JORNADA.value="CAMBIA1;";
	 
	for(i=0;i<document.FINGER.horas.length;i++)
		{
		  if(document.FINGER.horas[i].checked) 
		   {
               
		         
		         document.getElementById("HORAS_JORNADAS").value=document.FINGER.horas[i].value;
				 
		         str=document.getElementById("HORAS_JORNADAS").value;
		         pos = str.indexOf(":");
		  
		         Horas = str.substring(0,pos);
		         Minutos=str.substring(pos+1,str.length);
				 
				 				 
				 str=document.getElementById("HORAS_J").value;
		         pos = str.indexOf(":");
		  
		         Horas_j = str.substring(0,pos);
		         Minutos_j=str.substring(pos+1,str.length);
				 
				 
		    	
		       if (isNaN(parseInt(Horas))) 
	     	   	  {
		           alert('\nEl campo: HORAS_JORNADAS valor: ' + document.getElementById("HORAS_JORNADAS").value + '\nDebe ser HORAS. Ejemplo 08:00' );
		           campo.focus();
		           return false;
		          }  
		       
		       if (isNaN(parseInt(Minutos))) 
		   	     {
		   	      alert('\nEl campo: HORAS_JORNADAS valor: ' + document.getElementById("HORAS_JORNADAS").value +  '\nDebe ser HORAS. Ejemplo 08:00' );
		   	      campo.focus();
		          return false;
		         }  
				 
				if (isNaN(parseInt(Horas_j))) 
	     	   	  {
		           alert('\nEl campo: HORAS_JORNADAS valo: ' + document.getElementById("HORAS_J").value + '\nDebe ser HORAS. Ejemplo 08:00' );
		           campo.focus();
		           return false;
		          }  
		       
		       if (isNaN(parseInt(Minutos_j))) 
		   	     {
		   	      alert('\nEl campo: HORAS_JORNADA valor: ' + document.getElementById("HORAS_J").value +  '\nDebe ser HORAS. Ejemplo 08:00' );
		   	      campo.focus();
		          return false;
		         }  
 
				 

	              total =(parseInt(Horas)*60 + parseInt(Minutos));
				  total_j =(parseInt(Horas_j)*60 + parseInt(Minutos_j));
				  
				  document.getElementById("REDUCCION").value= 100-Math.round((total_j/total)*100);
				  
	         
		   }
		 }  
	

}
function Cambia_Horas()
{

	 campo= document.getElementById("REDUCCION").value;
	 document.FINGER.MODIFICA_JORNADA.value="CAMBIA1;";
	 
	for(i=0;i<document.FINGER.horas.length;i++)
		{
		  if(document.FINGER.horas[i].checked) 
		   {
                 alert(document.FINGER.horas[i].value);  
		         document.getElementById("HORAS_J").value=document.FINGER.horas[i].value;
		         document.getElementById("HORAS_JORNADAS").value=document.FINGER.horas[i].value;
		         str=document.getElementById("HORAS_JORNADAS").value;
		          pos = str.indexOf(":");
		  
		         Horas = str.substring(0,pos);
		         Minutos=str.substring(pos+1,str.length);
		    	
		         if (isNaN(parseInt(Horas))) 
	     	   	  {
		           alert('\nEl campo: HORAS_JORNADAS valor: ' + document.getElementById("HORAS_JORNADAS").value + '\nDebe ser HORAS. Ejemplo 08:00' );
		           campo.focus();
		           return false;
		          }  
		       
		       if (isNaN(parseInt(Minutos))) 
		   	     {
		   	      alert('\nEl campo: HORAS_JORNADAS valor: ' + document.getElementById("HORAS_JORNADAS").value +  '\nDebe ser HORAS. Ejemplo 08:00' );
		   	      campo.focus();
		          return false;
		         }  

	              total =(parseInt(Horas)*60 + parseInt(Minutos)) -(parseInt(Horas)*60 + parseInt(Minutos))*(campo/100) ;

	              var hours = Math.floor( total / 60 );  
	              var minutes = Math.round(total- hours*60);

	              //Anteponiendo un 0 a los minutos si son menos de 10 
	              hours  = hours  < 10 ? '0' + hours  : hours ;

	               
	              //Anteponiendo un 0 a los minutos si son menos de 10 
	              minutes = minutes < 10 ? '0' + minutes : minutes;
	               

	              var totals = hours + ":" + minutes;  // 2:41:3 
	              
	              document.getElementById("HORAS_J").value=totals;
	         
		   }
		 }  
	

}
function cambio_jornada()
{
	 document.FINGER.MODIFICA_JORNADA.value="CAMBIA1;";
}
function calcular()
{
	
	 campo= document.getElementById("REDUCCION").value;
	 document.FINGER.MODIFICA_JORNADA.value="CAMBIA1;";
	
	 
	 if (isNaN(parseInt(campo))) 
	  {
     alert('\nDebe ser Numerico la reducci�n.' );
     document.getElementById("REDUCCION").focus();
     return false;
     }
     if (campo.length > 0)
         {
    	
    	 str=document.getElementById("HORAS_JORNADAS").value;
    	 if ((str.length > 0) ) 	
           {	
    		 
              str=document.getElementById("HORAS_JORNADAS").value;
	          pos = str.indexOf(":");
	  
	         Horas = str.substring(0,pos);
	         Minutos=str.substring(pos+1,str.length);
	    	
	         if (isNaN(parseInt(Horas))) 
     	   	  {
	           alert('\nEl campo: HORAS_JORNADAS valor: ' + document.getElementById("HORAS_JORNADAS").value + '\nDebe ser HORAS. Ejemplo 08:00' );
	           campo.focus();
	           return false;
	          }  
	       
	       if (isNaN(parseInt(Minutos))) 
	   	     {
	   	      alert('\nEl campo: HORAS_JORNADAS valor: ' + document.getElementById("HORAS_JORNADAS").value +  '\nDebe ser HORAS. Ejemplo 08:00' );
	   	      campo.focus();
	          return false;
	         }  

              total =(parseInt(Horas)*60 + parseInt(Minutos)) -(parseInt(Horas)*60 + parseInt(Minutos))*(campo/100) ;

              var hours = Math.floor( total / 60 );  
              var minutes = Math.round(total- hours*60);

              //Anteponiendo un 0 a los minutos si son menos de 10 
              hours  = hours  < 10 ? '0' + hours  : hours ;

               
              //Anteponiendo un 0 a los minutos si son menos de 10 
              minutes = minutes < 10 ? '0' + minutes : minutes;
               

              var totals = hours + ":" + minutes;  // 2:41:3 
              
              document.getElementById("HORAS_J").value=totals;

              
               
	          alert("Horas a realizar :" + totals);
	    	  
            }
         }
   }



</script>




<%
String valor_acumulado;
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>Gesti&oacute;n de Ausencias - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../imagen/calendario.js"></script>
<script type="text/JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->

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
       <li><a href="../../gestion/calendario_laboral/index.jsp?ID_ANO=2016" class="ah12b">Calendario Laboral</a></li>   
       <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
        <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

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
		<li><a href="../Finger" id="current">Fichajes</a></li>
		<li><a href="../Bolsa">Bolsa</a></li>
	  </ul>
	</div>
	
	<table width="87%" border="0" cellspacing="0" cellpadding="0" bgcolor="#f2f2f2">
	 <form name="FINGER" method="POST" action="guarda_configuracion.jsp">
       <tr> 
       
    <%   if (!RSFICHA_isEmpty ) {%>  
         <td class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;PIN:<%=(((RSFICHA_data = RSFICHA.getObject("PIN"))==null || RSFICHA.wasNull())?"":RSFICHA_data)%></td>
     <% } else { %>
             <td class="va12b">&nbsp;<b><%= session.getValue("MM_ID_FUNCIONARIO_NOMBRE") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE1") %> <%= session.getValue("MM_ID_FUNCIONARIO_APE2") %></b>&nbsp;PIN: SIN PIN ASIGNADO</td>     
     <% }  %>
        
                                  <td width="6%" valign="center" nowrap  ><div align="right">Ficha<strong>:</strong> </div></td>
                                  <td width="11%" valign="center"> 
                                     						<select name="RELOJES" maxlength="100">
                                               <%
while (RSTIPO_FICHA_hasData) {
%>
                                               <option value="<%=((RSTIPO_FICHA.getObject("ID_TIPO_FICHAJE")!=null)?RSTIPO_FICHA.getObject("ID_TIPO_FICHAJE"):"")%>" <%=(((RSTIPO_FICHA.getObject("ID_TIPO_FICHAJE")).toString().equals(((((RSFICHA_data = RSFICHA.getObject("ID_TIPO_FICHAJE"))==null || RSFICHA.wasNull())?"":RSFICHA_data)).toString()))?"SELECTED":"")%> ><%=((RSTIPO_FICHA.getObject("ID_TIPO_FICHAJE")!=null)?RSTIPO_FICHA.getObject("DESC_FICHAJE"):"")%></option>
                                                 <%
  RSTIPO_FICHA_hasData = RSTIPO_FICHA.next();
}

RSTIPO_FICHA = StatementRSTIPO_FICHA.executeQuery();
RSTIPO_FICHA_hasData = RSTIPO_FICHA.next();
RSTIPO_FICHA_isEmpty = !RSTIPO_FICHA_hasData;
%>
                                             </select>             
      </tr>
     
      <tr>
       
     </table>   <br> 
     
  <table  border="1" cellspacing="0" cellpadding="0">   
    <tr>   
             <td colspan=1 bgcolor="#CCCCCC" align="center">    <input type="checkbox" name="ALERTAS_SIN" id="ALERTAS_SIN" 
             <%  if (!RS_ALERTAS_isEmpty ) {%> 
              <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("SIN_ALERTAS"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %>  
                 <% } %>
                   onclick="Alertas();"   ><label for="ALERTAS_SIN"></label>Alertas</td>
           
           
           
          <%  if (!RS_JORNADA_FUN_isEmpty ) {%>   
           <td colspan=1 bgcolor="#CCCCCC" align="center">Jornada</td>
         <% } else {  %>
           <td colspan=1 bgcolor="#CCCCCC" align="center">Sin Jornada en el d�a de hoy</td>
         <% } %>
           <td colspan=1 bgcolor="#CCCCCC" align="center">Puntos Fichajes</td>
                </tr>         
       <tr> <td  width="35%" align="center" >
     
       <table  border="0" cellspacing="0" cellpadding="0">              
        <tr>
         <td>
           <tr> 
                   
               <td nowrap><input type="checkbox" name="ALERTA_1" id="ALERTA_1" 
                   <%  if (!RS_ALERTAS_isEmpty ) {%>    
                        <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("ALERTA_1"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %>   <% }   %>  
                          onchange="Modifica_Alertas();"   ><label for="ALERTA_1">Sin Fichajes</label>                                   
                         </td>
                  
                 <td nowrap><input type="checkbox" name="ALERTA_2" id="ALERTA_2" 
                   <%  if (!RS_ALERTAS_isEmpty ) {%>    
                        <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("ALERTA_2"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %>   <% }   %>  
                          onchange="Modifica_Alertas();"   ><label for="ALERTA_2">D�as no Laborables</label>                                   
                         </td>
                                  
                         
              <td nowrap><input type="checkbox" name="ALERTA_7" id="ALERTA_7"
                    <%  if (!RS_ALERTAS_isEmpty ) {%>     
                      <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("ALERTA_7"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %> 
                      <% }   %> 
                      onchange="Modifica_Alertas();" ><label for="ALERTA_7">En otro Reloj</label></td>
           
            </tr>
            <tr> 
                   
               <td nowrap><input type="checkbox" name="ALERTA_4" id="ALERTA_4" 
                   <%  if (!RS_ALERTAS_isEmpty ) {%>    
                        <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("ALERTA_4"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %>   <% }   %>  
                          onchange="Modifica_Alertas();"   ><label for="ALERTA_4">Limite entrada Superado</label>                                   
                         </td>
                  
                 <td nowrap><input type="checkbox" name="ALERTA_5" id="ALERTA_5" 
                   <%  if (!RS_ALERTAS_isEmpty ) {%>    
                        <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("ALERTA_5"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %>   <% }   %>  
                          onchange="Modifica_Alertas();"   ><label for="ALERTA_5">Limite salida no alcanzado</label>                                   
                         </td>
                                  
                         
              <td nowrap><input type="checkbox" name="ALERTA_6" id="ALERTA_6"
                    <%  if (!RS_ALERTAS_isEmpty ) {%>     
                      <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("ALERTA_6"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %> 
                      <% }   %> 
                      onchange="Modifica_Alertas();" ><label for="ALERTA_6">Entrada y Salida</label></td>
           
            </tr>
            <tr> 
                   
               <td nowrap><input type="checkbox" name="ALERTA_8" id="ALERTA_8" 
                   <%  if (!RS_ALERTAS_isEmpty ) {%>    
                        <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("ALERTA_8"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %>   <% }   %>  
                          onchange="Modifica_Alertas();"   ><label for="ALERTA_8">Supera 8 horas</label>                                   
                         </td>
                  
                 <td nowrap><input type="checkbox" name="ALERTA_3" id="ALERTA_3" 
                   <%  if (!RS_ALERTAS_isEmpty ) {%>    
                        <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("ALERTA_3"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %>   <% }   %>  
                          onchange="Modifica_Alertas();"   ><label for="ALERTA_3">Policia.Turno no encontrado</label>                                   
                         </td>
                                  
                         
              <td nowrap><input type="checkbox" name="ALERTA_9" id="ALERTA_9"
                    <%  if (!RS_ALERTAS_isEmpty ) {%>     
                      <%= (((RS_ALERTAS_data = RS_ALERTAS.getObject("ALERTA_9"))==null || RS_ALERTAS.wasNull())?"":RS_ALERTAS_data)  %> 
                      <% }   %> 
                      onchange="Modifica_Alertas();" ><label for="ALERTA_9">Sin calendario</label></td>
           
            </tr>
           </td>         
         </tr>
       </table>
       
 
   <td align="center" style=" width : 387px;">
      
     <table  border="0" cellspacing="0" cellpadding="0" style=" width : 334px;">   
        
    <tr>
        <td nowrap >Fecha Inicio
              <table border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                       <td> 
                           <input type="text" name="FECHA_INICIO" 
											      <%  if (!RS_JORNADA_FUN_isEmpty ) {%>  value="<%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("FECHA_INICIO"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %>" 
												  <% } %>
					     			  size="12" maxlength="12" onchange="javascript:cambio_jornada();" style=" height : 18px;">                                           
                       </td>
                       <td><a href="javascript:show_Calendario('FINGER.FECHA_INICIO');javascript:cambio_jornada();"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                    </tr>
              </table>
         </td>
         <td nowrap >Fecha Fin
                <table border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                         <td>                                             
                             <input type="text" name="FECHA_FIN" 
											    <%  if (!RS_JORNADA_FUN_isEmpty ) {%>       value="<%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("FECHA_FIN"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %>" 
												 <% } %>
												size="12" maxlength="12" onchange="javascript:cambio_jornada();">                                              
                         </td>
                         <td><a href="javascript:show_Calendario('FINGER.FECHA_FIN');javascript:cambio_jornada();"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                       </tr>
                 </table>                                        
          </td>                            
     </tr>
      
          
          <tr>
            <td >Horas Semanales <br/>              
            		<input type="radio" name="horas" onchange="Cambia_Horas();" 
					     <%  if (!RS_JORNADA_FUN_isEmpty ) {%>
					       <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("H40"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %>   
						 <% } %>  
						   value="08:00" /> 40 horas <br/>
	        		<input type="radio" name="horas" onchange="Cambia_Horas();" 
					     <%  if (!RS_JORNADA_FUN_isEmpty ) {%>
					      <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("H37_5"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
						 <% } %> 
						  value="07:30" /> 37:30 horas <br/>
	        		<input type="radio" name="horas" onchange="Cambia_Horas();" 
					     <%  if (!RS_JORNADA_FUN_isEmpty ) {%>
					      <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("H37"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %>   
						  <% } %>  
						  value="07:00" /> 35 Horas						  
	        </td>
            <td nowrap align=top>Dias<br/>               
                 <input type="radio" name="Jornada" 
				     <%  if (!RS_JORNADA_FUN_isEmpty ) {%> 
				        <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("S5"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
					 <% } %>		
						value=5  onchange="javascript:cambio_jornada();" /> Lunes a Viernes <br/>  
	             <input type="radio" name="Jornada" 
				     <%  if (!RS_JORNADA_FUN_isEmpty ) {%> 
				        <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("S7"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
					 <% } %>	
						value=7  onchange="javascript:cambio_jornada();" /> Lunes a Domingo <br/>
	             <input type="radio" name="Jornada" 
				     <%  if (!RS_JORNADA_FUN_isEmpty ) {%> 
				        <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("S0"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
					 <% } %>		
						value=0  onchange="javascript:cambio_jornada();" /> Otra <br />	          
	        </td>
	        <td colspan=3>
	        <table>        
<tr>
 <td nowrap>L</td>
 <td nowrap>M</td>
 <td nowrap>X</td>
 <td nowrap>J</td>
 <td nowrap>V</td>
 <td nowrap>S</td>
 <td nowrap>D</td> 
</tr>
<tr>
 <td nowrap  ><input type="checkbox" name="J_LUNES" id="J_LUNES"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%>
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("J_LUNES"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>    				   
                 onchange="javascript:cambio_jornada();">
  </td> 
		<td nowrap  ><input type="checkbox" name="J_MARTES" id="J_MARTES"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%>
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("J_MARTES"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>    
				 onchange="javascript:cambio_jornada();"> 
  </td> 
  <td nowrap  ><input type="checkbox" name="J_MIERCOLES" id="J_MIERCOLES"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%>
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("J_MIERCOLES"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>    
				onchange="javascript:cambio_jornada();">
  </td> 
  <td nowrap  ><input type="checkbox" name="J_JUEVES" id="J_JUEVES"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%>
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("J_JUEVES"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>    
				onchange="javascript:cambio_jornada();">
  </td> 
  <td nowrap  ><input type="checkbox" name="J_VIERNES" id="J_VIERNES"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%>
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("J_VIERNES"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>    
				onchange="javascript:cambio_jornada();">
  </td> 
  <td nowrap  ><input type="checkbox" name="J_SABADO" id="J_SABADO"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%>
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("J_SABADO"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>    
				onchange="javascript:cambio_jornada();">
  </td> 
  <td nowrap  ><input type="checkbox" name="J_DOMINGO" id="J_DOMINGO"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%>
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("J_DOMINGO"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>    
				onchange="javascript:cambio_jornada();">
  </td> 
  
  </tr>
</table> 	
	</td>        
          </tr>
   
               <tr><td>Horas a realizar:   
                 <input type='hidden' name="HORAS_JORNADAS" disabled="yes" ID="HORAS_JORNADAS" 
				   <%  if (!RS_JORNADA_FUN_isEmpty ) {%> 
				    value="<%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("HORAS_JORNADA"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %>" 
				   <% } %>	
					size="5" maxlength="5">
                 <input name="HORAS_J" ID="HORAS_J"   onchange="Cambia_Horas2();" 
				   <%  if (!RS_JORNADA_FUN_isEmpty ) {%> 
				    value="<%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("HORAS_JORNADA"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %>" 
				   <% } %>		
					size="5" maxlength="5">            
      </td>
      <td nowrap>Reduccion %: <table border="0" cellspacing="0" cellpadding="0">
                                  <td>  
                                      <input name="REDUCCION" ID="REDUCCION" type="text" 
									   <% if (!RS_JORNADA_FUN_isEmpty ) {%> 
									    value="<%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("REDUCCION"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %>" 
									   <% } %>		
										size="4" maxlength="4">
                                  </td>
                                  <td> <a href="javascript:calcular();"><img src="../../imagen/calculator.png" alt="A�adir transacci�n"	width="20" height="20" border="0"></a></td>                                        
                              </table>           
      </td>       
   </tr>
            <tr>
                <td nowrap  ><input type="checkbox" name="J_HCOMIDA" id="J_HCOMIDA"  
				   <% if (!RS_JORNADA_FUN_isEmpty ) {%> 
				      <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("CONTAR_COMIDA"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>  
					  onchange="javascript:cambio_jornada();" ><label for="J_HCOMIDA"> Hora Comida</label>
		        </td>
                <td nowrap  ><input type="checkbox" name="J_LIBRE" id="J_LIBRE"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%> 
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("LIBRE"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				  <% } %>   
				     onchange="javascript:cambio_jornada();" ><label for="J_LIBRE">Libre</label>
			    </td> 				
                <td nowrap  ><input type="checkbox" name="J_BOLSA" id="J_BOLSA"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%>
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("BOLSA"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>    
				    onchange="javascript:cambio_jornada();"><label for="J_BOLSA">Bolsa 75h</label>
			    </td> 
                <td nowrap  ><input type="hidden" name="J_BOLSA_CON" id="J_BOLSA_CON"  
				  <% if (!RS_JORNADA_FUN_isEmpty ) {%>
				   <%= (((RS_JORNADA_FUN_data = RS_JORNADA_FUN.getObject("BOLSA_CON"))==null || RS_JORNADA_FUN.wasNull())?"":RS_JORNADA_FUN_data)  %> 
				   <% } %>    
				    onchange="javascript:cambio_jornada();">
			    </td>               
           </tr>
        
         
      
    
       
      </table>
      
      
  
       </td>
       
     <td width=15% align="top">
     
        <table >
         <tr >
                  <td nowrap><input type="checkbox" name="PTO_TODOS" id="PTO_TODOS"  ><label for="PTO_TODOS"> Todos</label></td>          
             <td colspan=2 align="right"><a href="javascript:a�adir();"><img src="../../imagen/new.png" alt="A�adir transacci�n"	width="20" height="20" border="0"></a>
	    </tr>
           <tr> 
             <td colspan=2 align="center" bgcolor="#CCCCCC"><span class="va10b">Lugar Fichaje</span></td>   
                                              
           </tr>
      
<% while ((RS_PTO_FICHAJE_hasData)&&(Repeat1__numRows-- != 0)) 
   {  
       if (!RS_PTO_FICHAJE_isEmpty ) 
	      { %>
            <tr id="c<%= Repeat1__index %>" style="DISPLAY: ">
			 <td  align="center" valign="bottom" nowrap bgcolor="#FFFFFF"><%=(((RS_PTO_FICHAJE_data = RS_PTO_FICHAJE.getObject("RELOJ"))==null || RS_PTO_FICHAJE.wasNull())?"":RS_PTO_FICHAJE_data)%>
			 </td>
			 <td nowrap>
			    <input type="hidden"  id="CLAVE_HORA_<%= Repeat1__index %>" name="CLAVE_HORA_<%= Repeat1__index %>" value="<%=(((RS_PTO_FICHAJE_data = RS_PTO_FICHAJE.getObject("NUM_RELOJ"))==null || RS_PTO_FICHAJE.wasNull())?"":RS_PTO_FICHAJE_data)%>"  size="10" maxlength="10">						 							  
				<a href="javascript:borrar('c<%= Repeat1__index %>');"> <img src="../../imagen/delete.png" alt="Borrar"	width="20" height="20" border="0"></a><input type="hidden" id="campoc<%= Repeat1__index %>" value="1">
				<input type="hidden" id="valorc<%= Repeat1__index %>" name="valorc<%= Repeat1__index %>" value="0">
			 </td> 
            </tr>
       <% } /* end !RSQUERY_isEmpty */
                                              
          Repeat1__index++;
          RS_PTO_FICHAJE_hasData = RS_PTO_FICHAJE.next();
   } 
		
		    
%> 
<%  Repeat1__index--;
    while (Repeat1__index++ != 5) 
	{   %>                              
       <tr id="c<%= Repeat1__index %>" style="DISPLAY: none">         
         <td nowrap><input type="hidden"  id="CLAVE_HORA_<%= Repeat1__index %>" name="CLAVE_HORA_<%= Repeat1__index %>" value="000000000" size="10" maxlength="10">								   
		   <select id="RELOJ_<%= Repeat1__index %>" name="RELOJ_<%= Repeat1__index %>" onChange="document.FINGER.CLAVE_HORA_<%= Repeat1__index %>.value=document.FINGER.RELOJ_<%= Repeat1__index %>.value;">
		    <option value="0"></option>
       <%
             while (RSRELOJ_hasData) 
	       {
       %>
             <option value="<%=((RSRELOJ.getObject("NUMERO")!=null)?RSRELOJ.getObject("NUMERO"):"")%>"><%=((RSRELOJ.getObject("DENOM")!=null)?RSRELOJ.getObject("DENOM"):"")%></option>
       <% 
			 RSRELOJ_hasData = RSRELOJ.next();
           }
		  
        %>
          </select>
		  <a href="javascript:borrar('c<%= Repeat1__index %>');"> <img src="../../imagen/delete.png" alt="Borrar"	width="20" height="20" border="0"></a> 
		  <input type="hidden" id="campoc<%= Repeat1__index %>" value="0">
		  <input type="hidden" id="valorc<%= Repeat1__index %>" name="valorc<%= Repeat1__index %>" value="0">
	     </td> 	 
	  </tr>						 
 <% } %>
 
              </tr>
       </table>
      </td>
       </tr>
       
      </table>
     
     
	  <br>
	 
	   <% 
	   
	   RSCALENDARIO = StatementRSCALENDARIO.executeQuery();
	   RSCALENDARIO_hasData = RSCALENDARIO.next();
	   RSCALENDARIO_isEmpty = !RSCALENDARIO_hasData;    
	   
	   %>
	 
	 
	  <br>                            
	  Historico de Jornadas  (En verde la actual)
	  <table  width="87%" border="1" cellspacing="0" cellpadding="0">	   
      <tr> 
                                         <td width="20%" colspan=2 bgcolor="#CACFD2" align="center">Calendario</td>
                                        <td width="20%" colspan=2 bgcolor="#F2F3F4" align="center">Fecha Inicio</td>
                                        <td width="20%" colspan=2 bgcolor="#CACFD2" align="center">Fecha Hasta</td> 
                                        <td width="20%" colspan=2 bgcolor="#F2F3F4" align="center">Horas Semanales</td>
                                        <td width="20%" colspan=2 bgcolor="#CACFD2" align="center">Horas Teoricas</td>  
                                         <td width="20%" colspan=2 bgcolor="#CACFD2" align="center">D�as Jornada</td>                                                                                                                                                                                                   
                                        <td width="20%" colspan=1 bgcolor="#CCCCCC" align="center">Reduccion</td>
                                        <td width="20%" colspan=1 bgcolor="#CCCCCC" align="center">Libre</td>
                                         <td width="20%" colspan=1 bgcolor="#CCCCCC" align="center">Contar Comida</td>
                                         <td width="20%" colspan=1 bgcolor="#CCCCCC" align="center">Bolsa 75H</td>
                                         <td width="20%" colspan=1 bgcolor="#CCCCCC" align="center">Conciliacion</td>
                                      </tr>
                  <% while ((RSCALENDARIO_H_hasData)&&(Repeat3__numRows-- != 0)) { %>
                      <%   RSIMPAR =  (String) (((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("ACTIVO"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data); 
                            	     if (RSIMPAR.equals("1") )  
                                     	 RSCOLOR="bgcolor=\"#A9D89D\"";                     	
    				               else 	                   
                                          RSCOLOR="";   
							  	  
							  	  %> 
                      <tr> 
                      <td <%= RSCOLOR %> colspan=2 width="10%"  align="center"><span class="va10b"><%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("DESC_CALENDARIO"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%></span></td>
                      <td  <%= RSCOLOR %> nowrap width="15%" colspan=2  align="center"> 
                                    <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("FECHA_INICIO"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>
                                         </td>
                      <td <%= RSCOLOR %> nowrap width="15%" colspan=2  align="center">
                                        <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("FECHA_FIN"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>
                                        </td>
                      <td  <%= RSCOLOR %>  nowrap width="15%" colspan=2  align="center"> 
                                   <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("HORAS_SEMANALES"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>
                                        </td>
                      <td <%= RSCOLOR %>  nowrap width="15%" colspan=2  align="center"> 
                                   <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("HORAS_JORNADA"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>
                                        </td>
                                         <td <%= RSCOLOR %>  nowrap width="15%" colspan=2  align="center"> 
                                   <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("DIAS_SEMANA"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>
                                        </td>
                      <td  <%= RSCOLOR %> nowrap width="15%"  align="center"> 
                                   <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("REDUCCION"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>
                                        </td>   
                      <td <%= RSCOLOR %>  nowrap width="15%"  align="center">
                                      <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("LIBRE"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>      </td>     
                        <td <%= RSCOLOR %>  nowrap width="15%"  align="center">
                                      <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("CONTAR_COMIDA"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>      </td>     
                                   
                         <td <%= RSCOLOR %>  nowrap width="15%"  align="center">
                                      <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("BOLSA"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>      </td>  
                         <td <%= RSCOLOR %>  nowrap width="15%"  align="center">
                                      <%=(((RSCALENDARIO_H_data = RSCALENDARIO_H.getObject("BOLSA_CON"))==null || RSCALENDARIO_H.wasNull())?"":RSCALENDARIO_H_data)%>      </td>     
                                         
                                      </tr>    
                                               
                                      <% 
                                            Repeat3__index++;
                                            RSCALENDARIO_H_hasData = RSCALENDARIO_H.next();
                                        }
                                       %>            
                              
	  </table>
	  
	  <br>
	   
	   
	  
	  
	  <tr>
	  
	   <table>
	  <tr>
	    <td>
	       <input type="button" name="" value="Asignar otro calendario" onClick="javascript:asignar_calen();javascript:cambio_jornada();" >
	    </td>
	   <td id="calen_campo_id" style="DISPLAY:none"  size="30" maxlength="32">>
     <%  if (!RSCALENDARIO_isEmpty ) {%>  
       <input type="hidden" id="ID_CALENDARIO_CAM" value="<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("ID_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>">      
       CAMBIAR POR: <input type="text" id="ID_CALENDARIO_CAM_DES" value="">
     <% } else { %>
       <input type="hidden" id="ID_CALENDARIO_CAM" value="">      
       CAMBIAR POR: <input type="text" id="ID_CALENDARIO_CAM_DES" value="">     
     <% }  %> 
      </td>
	  
	  </tr>
	 
     
      </table>
      
	  </tr>
	  <table  width="87%" border="1" cellspacing="0" cellpadding="0">
	  <tr>
	   <%  if (!RSCALENDARIO_isEmpty ) {%> 
	    <th align center colspan=13 bgcolor="#FFCCCC" >Calendario Actual:<%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("DESC_CALENDARIO"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%><th>
	   <% } else { %>
	    <th align center colspan=13 bgcolor="#FFCCCC" >Sin Calendario Actual<th>	 
	   <% }  %> 
	  </tr>	   
            <tr> 
                                        <td width="10%" bgcolor="#CCCCCC" align="center">D�a<span class="va10b"></span></td>
                                        <td width="15%" colspan=2 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="15%" colspan=2 bgcolor="#F2F3F4" align="center">Flexible</td>
                                        <td width="15%" colspan=2 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="15%" colspan=2 bgcolor="#F2F3F4" align="center">Flexible</td>    
                                        <td width="15%" colspan=2 bgcolor="#CACFD2" align="center">Obligatorio</td>
                                        <td width="15%" colspan=2 bgcolor="#F2F3F4" align="center">Flexible</td>                                          
                                        <td width="20%" colspan=1 bgcolor="#CCCCCC" align="center">Horas Jornada</td>                                                                              
                                      </tr>
                                      
                             <% while ((RSCALENDARIO_hasData)&&(Repeat2__numRows-- != 0)) { %>
                                 <%   RSIMPAR =  (String) (((RSCALENDARIO_data = RSCALENDARIO.getObject("IMPAR"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data); 
                            	     if (RSIMPAR.equals("1") )  
                                     	 RSCOLOR="bgcolor=\"#FAD2D2\"";                     	
    				               else 	                   
                                          RSCOLOR="";   
							  	  
							  	  %> 
                                            
                                      <tr> 
                                          <td <%= RSCOLOR %>  width="10%"  align="center"><span class="va10b"><%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("DIA_SEMANA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%></span></td>
                                          <td <%= RSCOLOR %> nowrap width="15%" colspan=2  align="center"> 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> -
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>
                                         </td>
                                         <td <%= RSCOLOR %> nowrap width="15%" colspan=2  align="center">
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P1_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                             
                                        </td>
                                        <td <%= RSCOLOR %>  nowrap width="15%" colspan=2  align="center"> 
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> -
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>
                                        </td>
                                        <td <%= RSCOLOR %> nowrap width="15%" colspan=2  align="center">
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                          <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P2_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                             
                                        </td>                                    
                                         <td <%= RSCOLOR %> nowrap width="15%" colspan=2  align="center"> 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_OBL_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_OBL_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>
                                        </td>
                                        <td <%= RSCOLOR %> nowrap width="15%" colspan=2  align="center">
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_FLE_DESDE"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%> - 
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("P3_FLE_HASTA"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                             
                                        </td>    
                                         <td <%= RSCOLOR %> nowrap width="15%" colspan=2  align="center">
                                           <%=(((RSCALENDARIO_data = RSCALENDARIO.getObject("HORAS_TEORICAS"))==null || RSCALENDARIO.wasNull())?"":RSCALENDARIO_data)%>                                                                      
                                        </td>     
                                      </tr>
                                      
                                      <% 
                                            Repeat2__index++;
                                            RSCALENDARIO_hasData = RSCALENDARIO.next();
                                        }
                                       %>
	  </table>  
	  <table>
	    <tr>
               <td align="center" style=" width : 772px;">
                           <input type="button" name="Guardar" value="Guardar Configuraci�n" onClick="javascript:envia_unavez();" >
                         </td>
               </tr> 
                <tr>
               <td align="center" style=" width : 772px;">
                           <input type="hidden" name="MODIFICA_ALERTA" value="0">
                           <input type="hidden" name="CAMPO_ALERT" value="">
                           <input type="hidden" name="CAMPO_JORNADA" value="">
                           <input type="hidden" name="MODIFICA_JORNADA" value="CAMBIA0;">
                           <input type="hidden" name="CAMPO_PTO_FICHAJE" value="">
                           <input type="hidden" name="CAMPO_CALENDARIO" value="">
                         </td>
               </tr> 
	  </table>
	  </form>
      <br/>
      <br/>
     
</div>
	</div>
</body>
</html>

<%
RSTIPO_FICHA.close();
StatementRSTIPO_FICHA.close();
ConnRSTIPO_FICHA.close();
%>
<%
RSFICHA.close();
StatementRSFICHA.close();
ConnRSFICHA.close();
%>
<%
RS_PTO_FICHAJE.close();
StatementRS_PTO_FICHAJE.close();
ConnRS_PTO_FICHAJE.close();
%>
<%
RSCALENDARIO.close();
StatementRSCALENDARIO.close();
ConnRSCALENDARIO.close();
%>
<%
RSCALENDARIO.close();
StatementRSCALENDARIO.close();
ConnRSCALENDARIO.close();
%>
<%
RS_ALERTAS.close();
StatementRS_ALERTAS.close();
ConnRS_ALERTAS.close();
%>

<%
RS_JORNADA_FUN.close();
StatementRS_JORNADA_FUN.close();
ConnRS_JORNADA_FUN.close();
%>

<%
RSRELOJ.close();
StatementRSRELOJ.close();
ConnRSRELOJ.close();
%>




