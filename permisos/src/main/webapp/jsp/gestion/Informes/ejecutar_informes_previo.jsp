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


String PERMI__V_ID_CAMPO = "0";
if(request.getParameter("ID_INFORME") != null){ PERMI__V_ID_CAMPO = (String)request.getParameter("ID_INFORME");}



String PERMI__V_ID_USUARIO = "0";
if (session.getValue("MM_ID_USUARIO")    !=null) {PERMI__V_ID_USUARIO = (String)session.getValue("MM_ID_USUARIO")   ;}


%>


<script language="Javascript" >
function nuevo_informe()
{
 	var URL = "ejecutar_informes.jsp?ID_INFORME=" + <%=PERMI__V_ID_CAMPO %>;
	var WNAME = "INFORMES";
	var windowW = 1;
	var windowH = 1;
	var windowX = 1;
	var windowY = 9999;
	DIMENSION=",width="+windowW+",height="+windowH;

	splashWin = window.open( URL , WNAME, "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1"+DIMENSION);
	//splashWin.opener = self;
	splashWin.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
	splashWin.focus();
}
</script>
<%
String thisPage = request.getRequestURI();
%>
<html>
<head>
<title>EJECUTANDO INFORME.....</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


</head>
<body onLoad="nuevo_informe()" onunload="window.opener.location.reload()">


                         
<img	src="../../imagen/gear.gif" alt="Ejecutando Informe" width="100" height="100" border="0">
Ejecutando Informe....Al finalizar se cerrara la ventana. 
    

</body>
</html>


