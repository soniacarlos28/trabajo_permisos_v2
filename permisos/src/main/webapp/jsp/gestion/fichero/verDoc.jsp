<%@page language="java" import="java.util.Date,java.sql.*,java.io.InputStream" errorPage=""%>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%@ include file="../../../Connections/RRHH.jsp" %>


<%
String RS__MMColParam1 = "0";
if (request.getParameter("ID")    !=null) {RS__MMColParam1 = (String)request.getParameter("ID")   ;}

%>
 
<%
Driver DriverRS2 = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRS2 = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);  
PreparedStatement StatementRS2 = ConnRS2.prepareStatement("select FICHERO from ficheros_justificantes where id= '" + RS__MMColParam1 + "'  ");
ResultSet RS2 = StatementRS2.executeQuery();
boolean RS2_isEmpty = !RS2.next();
boolean RS2_hasData = !RS2_isEmpty;
Object RS2_data;
int RS2_numRows = 0;
%>


<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
RS2_numRows += Repeat2__numRows;
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
<% response.setContentType("application/pdf");
Blob sas = (Blob) (((RS2_data = RS2.getObject("FICHERO"))==null || RS2.wasNull())?"":RS2_data);

StringBuffer strOut = new StringBuffer();

int bytesread = 0;

InputStream fichero;

fichero = sas.getBinaryStream();

ServletOutputStream bOut=response.getOutputStream();

byte[] bytebuffer = new byte[ (int)sas.length() ];

while ( ( bytesread = fichero.read( bytebuffer ) ) != -1 ) {
bOut.write(bytebuffer );
}


fichero.close();

String varBLOB = strOut.toString();

%>


<%
RS2.close();
ConnRS2.close();
%>