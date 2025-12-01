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
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("select to_char(sysdate-1,'dd/mm/yyyy') as AYER,DECODE(to_char(FECHA,'dd/mm/yyyy'),to_char(sysdate,'dd/mm/yyyy'),'0','1') as IMPAR,t.numero AS NUM_FIN,denom AS DENOM_FIN,to_char(Fecha,'dd/mm/yyyy') AS FECHA,to_char(hora,'hh24:MI:SS') as ULT_CON from  transacciones t, relojes r where  t.fecha> sysdate-15 and to_number(t.numero)=to_number(r.numero) and r.activo='S' and (t.claveomesa,t.numero) in (select max(claveomesa),numero  from  transacciones where fecha between sysdate-15 and sysdate +5 and numero not in ('91','MA','88','90') group by numero) order by t.numero");
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
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
     <li><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
      <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp">Autorizar</a></li>
        
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b" id="current">Finger</a></li>   
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>  
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" >Proceso Bolsa</a></li>   
   <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
   <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
   <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
   
    </ul>
  <%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
  <div id="form">
<div>
	 <ul id="subtabh">
		<li id="active"><a href="../Finger_apl/index.jsp" >Incidencias diarias</a></li>	
		<li id="active"><a href="" onClick="show_finger()">Fichajes on line</a></li>
		<li id="active"><a href="../Finger_apl/chequea_relojes.jsp" id="current">Chequeo de Relojes</a></li>
		<li id="active"><a href="../Finger_apl/index_calendario.jsp" >Calendarios</a></li>
	    				
	 		
	  </ul>
  </div> 
  <form id="direccion">
 <table width="95%"  border="0" cellspacing="1" cellpadding="1">
  <tr>
 <td>
<% if (!RSQUERY_isEmpty ) { %>
			<table width="60%"  border="1" cellspacing="0" cellpadding="0">
                              <tr>
                                <th width="10%" bgcolor="#E0E0E0"  class="ah12w" scope="col"><div align="center"><strong>Numero</strong></div></td>
                                <th width="45%" bgcolor="#E0E0E0"  class="ah12w"scope="col"><div align="center"><strong>Sede</strong></div></td>
                                <th width="10%" bgcolor="#E0E0E0"  class="ah12w"scope="col"> <div align="center"><strong>Fecha</strong></div></td>
                                <th width="10%" bgcolor="#E0E0E0"  class="ah12w"scope="col"> <div align="center"><strong>Ultima transacci�n</strong></div></td>
                                <th width="25%" bgcolor="#E0E0E0"  class="ah12w"scope="col"> <div align="center"><strong>Regenerar</strong></div></td>                               
                                                            
                              </tr>
                              <% while ((RSQUERY_hasData)&&(Repeat2__numRows-- != 0)) { 
				
                                    
                            	  RSIMPAR =  (String) (((RSQUERY_data = RSQUERY.getObject("IMPAR"))==null || RSQUERY.wasNull())?"":RSQUERY_data); 
                            	     if (RSIMPAR.equals("1") )  
                                     	 RSCOLOR="bgcolor=\"#FA8258\"";                     	
    									 else 	                   
                                          RSCOLOR="";   
							  	  
							  	  %> 
                             <tr>                 
                              <tr>
                                  <td width="10%"  <%= RSCOLOR %>><div align="center"><%=(((RSQUERY_data = RSQUERY.getObject("NUM_FIN"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></div></td>
                                  <td width="45%"<%= RSCOLOR %>><div align="left"><%=(((RSQUERY_data = RSQUERY.getObject("DENOM_FIN"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></div></td>
                                  <td width="10%"<%= RSCOLOR %>><div align="center"><%=(((RSQUERY_data = RSQUERY.getObject("FECHA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></div></td>
                                  <td width="10%"<%= RSCOLOR %>><div align="center"><%=(((RSQUERY_data = RSQUERY.getObject("ULT_CON"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></div></td>
                                  <td width="25%"<%= RSCOLOR %>><div align="center"><input type="text" name="FECHA" value="<%=(((RSQUERY_data = RSQUERY.getObject("AYER"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%>"  size="12" maxlength="12"> <a href="javascript:regenera();"><img src="../../imagen/regenerar.jpg" alt="Regenerar Fichajes"	width="20" height="20" border="0"></a>
                                  
                                            
                                            </div></td>
                                 
                              </tr>
                              <%
  Repeat2__index++;
  RSQUERY_hasData = RSQUERY.next();
}
%>
                        </table>
<% } %>
  </td>
 </tr>
  </table>
</form>
<div id="result"></div>
  
</body>
</html>



<%
RSQUERY.close();
StatementRSQUERY.close();
ConnRSQUERY.close();
%>
