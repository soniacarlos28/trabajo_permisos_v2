<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
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
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT DISTINCT pe.aPE1 as APE1,pe.APE2 as APE2,pe.NOMBRE AS NOMBRE,DECODE(substr(desc_tipo_ausencia, 1, 5),                       'HS CC',                       1,                       'HS UG',                       2,                       'HS CS',                       3,                       'HS SP',                       4,                       5) as ordena,                DECODE(substr(desc_tipo_ausencia, 1, 5),                       'HS CC',                       substr(desc_tipo_ausencia, 1, 9),                       'HS UG',                       substr(desc_tipo_ausencia, 1, 7),                       'HS CS',                       substr(desc_tipo_ausencia, 1, 9),                       'HS SP',                       substr(desc_tipo_ausencia, 1, 10),                       5) as ordena2,                      substr(desc_tipo_ausencia,instr(desc_tipo_ausencia,' ',1,1)+1                      ,instr(desc_tipo_ausencia,' ',1,2)-instr(desc_tipo_ausencia,' ',1,1)-1)                       as SINDICATO,                       INITCAP(pe.nombre) ||' ' || INITCAP(pe.ape1) || ' '|| INITCAP(pe.ape2) as nombres,                tr.ID_TIPO_AUSENCIA ID_TIPO_AUSENCIA,                tr.ID_TIPO_AUSENCIA || '--' ||                SUBSTR((DESC_TIPO_AUSENCIA), 1, 40) as DESC_TIPO_AUSENCIA,                DECODE(nvl(FECHA_BAJA - sysdate, 0), '0', '0', '1') as ESTADO_BAJA,                h.id_funcionario as ID_FUNCIONARIO  FROM RRHH.TR_TIPO_AUSENCIA tr, hora_sindical h, personal_new pe WHERE tr.ID_TIPO_AUSENCIA between '500' and '800'   and tr.ID_TIPO_AUSENCIA = h.ID_TIPO_AUSENCIA   and h.id_funcionario = pe.id_funcionario   and tr.TR_ANULADO = 'NO' ORDER BY ordena, ordena2");
ResultSet RSQUERY = StatementRSQUERY.executeQuery();
boolean RSQUERY_isEmpty = !RSQUERY.next();
boolean RSQUERY_hasData = !RSQUERY_isEmpty;
Object RSQUERY_data;
int RSQUERY_numRows = 0;
%>
<%
int Repeat1__numRows = 1200;
int Repeat1__index = 0;
RSQUERY_numRows += Repeat1__numRows;
%>

<script language="Javascript" >

function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
function show_confirm(id, description, url)
{
   var text = "¿Realmente desea eliminar: '" + description + "'?";
   var r = confirm(text);
   if (r==true) {
	 
      MM_goToURL('self',url + id);
   }
   else { 
      alert("Operación cancelada!"); 
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
          
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>  
    <li id="active" ><a href="#" id="current">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>   
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li>
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
    <li><a href="../../gestion/Informes/index_informes.jsp" >Informes</a></li>
<li><a href="../../gestion/Formacion/index_formacion.jsp" >Formacion</a></li>

  </ul>
</div>
<div id="form">
<div>
	 <ul id="subtabh">
		<li id="active"><a href="index.jsp" id="current">Horas</a></li>	
		<li id="active"><a href="index_listado.jsp">Listado Horas</a></li>			
	  </ul>
  </div> 
<table width="95%" border="0" cellspacing="0" cellpadding="2">
<tr bgcolor="#CCFFCC"> 
                                        <td colspan="7" align="center"><b> Horas Sindicales </b> (En rojo personal_new con fecha de baja)</td>
                                      </tr>
                          <tr> 
                            <td> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#f2f2f2"> 
                  <table width="100%" border="0" cellspacing="1" cellpadding="2">
                    <tr bgcolor="#CCCCCC"> 
                      <td class="va10b" align="center" width="5%">Ausencia</td>                     
                      <td class="va10b" width="30%">Nombre</td>
                        <td class="va10b" align="center" width="5%">ID</td>
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="15%">Sindicato</td>
                       <td class="va10b" bgcolor="#CCCCCC" align="center" width="5%">Acciones</td>
                      <td class="va10b" bgcolor="#f2f2f2" width="2%" align="center">  <a href="alta.jsp"><img	src="../../imagen/new.png" alt="Nuevo" width="20" height="20" border="0"></a>
                      </td>
                    </tr>
                    <% while ((RSQUERY_hasData)&&(Repeat1__numRows-- != 0)) { %>
                    <%   RSIMPAR =  (String) (((RSQUERY_data = RSQUERY.getObject("ESTADO_BAJA"))==null || RSQUERY.wasNull())?"":RSQUERY_data); 
                            	     if (RSIMPAR.equals("1") )  
                                     	 RSCOLOR="bgcolor=\"#FAD2D2\"";                     	
    				               else 	                   
                                          RSCOLOR="";   
							  	  
							  	  %> 
                                        
                    <tr bgcolor="#FFFFFF"> 
                     <td <%= RSCOLOR %> width="5%" align="center"><%=(((RSQUERY_data = RSQUERY.getObject("ID_TIPO_AUSENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                                       
                    <td <%= RSCOLOR %> width="30%"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRES"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                     
                      <td <%= RSCOLOR %> align="center" width="5%"><%= "<a href='../Datos/index.jsp?ID_FUNCIONARIO=" + (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&NOMBRE=" + (((RSQUERY_data = RSQUERY.getObject("NOMBRE"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE1=" + (((RSQUERY_data = RSQUERY.getObject("APE1"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "&APE2=" + (((RSQUERY_data = RSQUERY.getObject("APE2"))==null || RSQUERY.wasNull())?"":RSQUERY_data) + "'>" %><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                       <td <%= RSCOLOR %> align="center" width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("SINDICATO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td <%= RSCOLOR %> align="center" width="5%">
                        <a href='alta.jsp?EDITAR=SI&ID_FUNCIONARIO=<%= (((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)  %>&ID_TIPO_AUSENCIA=<%=  (((RSQUERY_data = RSQUERY.getObject("ID_TIPO_AUSENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%>' ><img
			
			src="../../imagen/edit.png" alt="Editar" width="20" height="20" border="0"></a>
			      <a href="javascript:show_confirm('<%=(((RSQUERY_data = RSQUERY.getObject("ID_TIPO_AUSENCIA")) == null || RSQUERY
							.wasNull()) ? "" : RSQUERY_data)%>','<%=(((RSQUERY_data = RSQUERY.getObject("DESC_TIPO_AUSENCIA")) == null || RSQUERY
							.wasNull()) ? "" : RSQUERY_data)%>','eliminar.jsp?ID_TIPO_AUSENCIA=')"><img
			src="../../imagen/delete.png" alt="Eliminar" width="20" height="20" border="0"></a>	</td>
                      
                    </tr>
                    <%
  Repeat1__index++;
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
</body>
</html>
<%
RSQUERY.close();
ConnRSQUERY.close();
%>