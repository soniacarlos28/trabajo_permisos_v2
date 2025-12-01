<%@page language="java" import="java.sql.*"%>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%
java.util.Calendar cal = java.util.Calendar.getInstance();
java.util.Date dia = cal.getTime();
java.text.DateFormat dateFormatter = java.text.DateFormat.getDateInstance(java.text.DateFormat.FULL, java.util.Locale.getDefault());
String fecha = dateFormatter.format(dia);  
%>
<%
String RSQUERY__MMColParam1 = "";
if (request.getParameter("ANNO")  !=null) {RSQUERY__MMColParam1 = (String)request.getParameter("ANNO") ;}
%>
<%
String RSQUERY__MMColParam2 = "";
if (request.getParameter("TIPOPERMISO")  !=null) {RSQUERY__MMColParam2 = (String)request.getParameter("TIPOPERMISO") ;}
%>
<%
String RSQUERY__MMColParam3 = "";
if (request.getParameter("FECHA_INICIO")    !=null) {RSQUERY__MMColParam3 = (String)request.getParameter("FECHA_INICIO")   ;}
%>
<%
String RSQUERY__MMColParam4 = "";
if (request.getParameter("FECHA_HASTA")    !=null) {RSQUERY__MMColParam4 = (String)request.getParameter("FECHA_HASTA")   ;}
%>
<%
String RSQUERY__MMColParam5 = "";
if (request.getParameter("JUSTIFICADO")    !=null) {RSQUERY__MMColParam5 = (String)request.getParameter("JUSTIFICADO")   ;}
%>
<%
String RSQUERY__MMColParam6 = "1";
if (request.getParameter("ID_FUNCIONARIO")    !=null) {RSQUERY__MMColParam6 = (String)request.getParameter("ID_FUNCIONARIO")   ;
  if (RSQUERY__MMColParam6.equals(null) ) {RSQUERY__MMColParam6 = "1";}
}
%>
<%
String RSQUERY__SQL = "SELECT  rpad(s.ID_FUNCIONARIO,6,' ') || ' ' || INITCAP(nombre) || ' '|| INITCAP(ape1) || ' '|| INITCAP(ape2) as ID_FUNCIONARIO, ID_TIPO_BAJA, " +
  " TO_CHAR(FECHA_INICIO,'dd/mm/yyyy') AS fecha_INICIO,  TO_CHAR(FECHA_FIN,'dd/mm/yyyy') AS fecha_FIN, "+
  " TO_CHAR(FECHA_confirmacion,'dd/mm/yyyy') AS fecha_confirmacion, " +
  " INITCAP(OBSERVACIONES) as OBSERVACIONES" +
     " FROM RRHH.BAJAS_ILT s, RRHH.PERSONAL P  WHERE (ANULADA IS NULL OR ANULADA='NO') AND TO_DATE(TO_CHAR(S.FECHA_INICIO,'dd/mm/yyyy'),'dd/mm/yyyy')  between TO_DATE('" + RSQUERY__MMColParam3 + "','dd/MM/YYYY') AND   TO_DATE('" + RSQUERY__MMColParam4 + "','dd/MM/YYYY')   and   "+
	 " ( ID_TIPO_baja=substr('" + RSQUERY__MMColParam2 + "',3,2) OR ((substr('"+ RSQUERY__MMColParam2 + "',1,2)= 'TB')  and (1=1))  )  and " +
	 " fecha_confirmacion is not null and id_ano="+ RSQUERY__MMColParam1 + " and  s.id_funcionario=p.id_funcionario and ('"+ RSQUERY__MMColParam6 + "'=1 or s.ID_FUNCIONARIO='" + RSQUERY__MMColParam6 + "') ORDER BY id_funcionario";
%>
<%
Driver DriverRSQUERY= (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY= DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement(RSQUERY__SQL);
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
RSQUERY_numRows += Repeat1__numRows;
%>
<?xml version="1.0" encoding="ISO-8859-1"?>
<?xml-stylesheet type="text/xsl" href="listado03.xsl"?>
<LISTADO>
<%= "<PROPIEDADES TITULO='Listado de Bajas' VERSION='0.0' FECHA='" + fecha + "' AUTOR=''/>" %>
<REGISTROS> 
<% while ((RSQUERY_hasData)&&(Repeat1__numRows-- != 0)) { %>
<%= "<REGISTRO ID_FUNCIONARIO='" + (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "' ID_TIPO_BAJA='" + (((RSQUERY_data = RSQUERY.getObject("ID_TIPO_BAJA"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "' FECHA_INICIO='" + (((RSQUERY_data = RSQUERY.getObject("FECHA_INICIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "' FECHA_FIN='" + (((RSQUERY_data = RSQUERY.getObject("FECHA_FIN"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "' FECHA_CONFIRMACION='" + (((RSQUERY_data = RSQUERY.getObject("FECHA_confirmacion"))==null || RSQUERY.wasNull())?"":RSQUERY_data)       +      "' OBSERVACIONES='" + (((RSQUERY_data = RSQUERY.getObject("OBSERVACIONES"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'/> " %> 
<%
	  Repeat1__index++;
	  RSQUERY_hasData = RSQUERY.next();
	}
%>
</REGISTROS> 
</LISTADO> 
<%
RSQUERY.close();
ConnRSQUERY.close();
%>
