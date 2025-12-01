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
Driver DriverRSPENDIENTE = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPENDIENTE = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPENDIENTE = ConnRSPENDIENTE.prepareStatement("SELECT distinct pe.ID_ANO,ID_AUSENCIA as ID_PERMISO,rownum as fila , substr(initcap(Nombre) || ' ' || INITCAP(Ape1)|| ' ' || INITCAP(Ape2),1,60)|| '-->' || DEsc_tipo_AUSENCIA || '-- Dia:' ||   to_char(FECHA_INICIO,'DD/MM/YYYY')     as Cadena  FROM AUSENCIA  pe,personal_new p,tr_tipo_AUSENCIA tr  WHERE  pe.id_funcionario=p.id_funcionario  and                 tr.id_tipo_AUSENCIA=pe.id_tipo_AUSENCIA and                 id_Estado='22' and (anulado='NO' OR ANULADO IS NULL)       ORDER BY pe.id_AUSENCIA desc");
ResultSet RSPENDIENTE = StatementRSPENDIENTE.executeQuery();
boolean RSPENDIENTE_isEmpty = !RSPENDIENTE.next();
boolean RSPENDIENTE_hasData = !RSPENDIENTE_isEmpty;
Object RSPENDIENTE_data;
int RSPENDIENTE_numRows = 0;
%>
<%
int Repeat1__numRows = 50;
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
function mostrarOcultar(opcion) 
{    
       if (<%=RSPENDIENTE_total%> < 51 )
           {
              total_p=<%=RSPENDIENTE_total%>;  
           }
       else
          {
              total_p=50;
           }


     if (opcion==1) 
      {
          if (document.getElementById('PABIERTO').style.display=="none") 
             {
              document.getElementById('PABIERTO').style.display='';
             
              document.getElementById('PCERRADO').style.display='none';
                 
                  for (x = 1; x <=  total_p; x++)
              {
               document.getElementById('P'+x).style.display='';
              }                    
             }  
          else 
             {
              document.getElementById('PABIERTO').style.display='none';                          
              document.getElementById('PCERRADO').style.display='';
                 for (x = 1; x <=  <%=(RSPENDIENTE_total)%>; x++)
              {
               document.getElementById('P'+x).style.display='none';
              } 
             }  
      }
 }    

function carga_final(){

     if (<%=RSPENDIENTE_total%> < 51 )
           {
              total_p=<%=RSPENDIENTE_total%>;  
           }
       else
          {
              total_p=50;
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
<ul id="tabh">
    <li id="active"><a href="../../index_busqueda.jsp" >Permisos/Ausencias</a></li>
    <li><a href="../../gestion/Permisos_vo_rrhh/index.jsp" id="current">Autorizar</a></li>
    <li><a href="../../gestion/Listados">Sin Justificar</a></li>   
    <li><a href="../../gestion/Finger_apl/index.jsp" class="ah12b">Finger</a></li>
    <li><a href="../../gestion/Gestion/index.jsp" class="ah12b">Horas Sindicales</a></li>   
    <li><a href="../../gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>
    <li><a href="../../gestion/calendario_laboral/index.jsp" class="ah12b">Calendario Laboral</a></li> 
    <li><a href="../../gestion/Bajas/index.jsp" >Bajas Fichero</a></li>
    </ul>
<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
<div>
	  <ul id="subtabh">
		<li><a href="../../gestion/Permisos_vo_rrhh/index.jsp" >Permisos pendientes autorizar</a></li>
		<li><a href="../../gestion/Ausencias_vo_rrhh/index.jsp" id="current" >Ausencias pendientes autorizar</a></li>		
	  </ul>
	</div>
<div id="form">

<table width="760" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="75%" align="left" valign="top">       
      <table cellspacing=0 cellpadding=3 width=98% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><div align="left"><font face=arial color=#ffffff size=+1><b>Recursos Humanos - Firmar Ausencias </b></font></div></td>
        </tr>
        </tbody> 
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td valign="top" width="70%"> 
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
                    <tr> 
                      <td class="va10w">
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td>
                              <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td><img src="../../imagen/home.gif" width="19" height="16"></td>
                                  <td>&nbsp;<a href="firmar_index_a.jsp"><b>A u s e n c i a s</b></a></td>
                                </tr>
                            </table></td>
                          </tr>
                          <tr>
                            <td><table border="0" cellspacing="0" cellpadding="0"><tr ID="PCERRADO">
                                <td><a href="javascript:mostrarOcultar(1);"><img src="../../imagen/plus.gif" width="19" height="16" border="0"></a></td>
                                 <td><a href="javascript:mostrarOcultar(1);" > <img src="../../imagen/folder2.gif" width="19" height="16" border="0"></a></td>
                                  <td colspan="2" nowrap>&nbsp;<a href="javascript:mostrarOcultar(1);">Pendientes de Firma</a> (<%=(RSPENDIENTE_total)%>) </td>                         
                              </tr>
                                <tr ID="PABIERTO">
                                  <td><a href="javascript:mostrarOcultar(1);"><img src="../../imagen/minus.gif" width="19" height="16" border="0"></a></td>
                                  <td><a href="javascript:mostrarOcultar(1);"><img src="../../imagen/folderopen2.gif" width="19" height="16" border="0"></a></td>
                                  <td colspan="2" nowrap>&nbsp;<a href="javascript:mostrarOcultar(1);">Pendientes de Firma</a> (<%=(RSPENDIENTE_total)%>)</td>
                                </tr>
                                <% while ((RSPENDIENTE_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                <% if (!RSPENDIENTE_isEmpty ) { %>
                                <tr ID="P<%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FILA"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%>">
                                  <td width="1%"><img src="../../imagen/line.gif" width="19" height="16"></td>
                                  <td width="1%"><img src="../../imagen/join.gif" width="19" height="16"></td>
                                  <td width="1%"><img src="../../imagen/page.gif" width="19" height="16"></td>
                                  <td><%= "<a href='firmar_solicitud_a.jsp?ID_AUSENCIA=" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_PERMISO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "'>" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("CADENA"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "</a>" %></td>
                                </tr>
                                <% } /* end !RSPENDIENTE_isEmpty */ %>
                                <%
  Repeat1__index++;
  RSPENDIENTE_hasData = RSPENDIENTE.next();
}
%>
                            </table></td>
                          </tr>
                          
                          <tr>
                            <td><table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td><img src='../../imagen/fin.gif' width='19' height='16' border='0'></td>
                                </tr>
                            </table></td>
                          </tr>
                        </table>                        
                      ������������ </td>
                      <td align="right"> 
                      <b>                      </b>                      </td>
                    </tr>
                    
                  </table>
                </td>
              </tr>
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
RSPENDIENTE.close();
StatementRSPENDIENTE.close();
ConnRSPENDIENTE.close();
%>

