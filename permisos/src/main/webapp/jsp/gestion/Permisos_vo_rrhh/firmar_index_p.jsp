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
PreparedStatement StatementRSPENDIENTE = ConnRSPENDIENTE.prepareStatement("SELECT distinct u.id_unidad,desc_unidad,pe.ID_ANO,ID_PERMISO,rownum as fila , DEsc_tipo_permiso,  ape1,ape2,substr(initcap(Nombre) || ' ' || INITCAP(Ape1)|| ' ' || INITCAP(Ape2),1,60)|| '-->' || DEsc_tipo_permiso || '-- D�as:' || pe.NUM_DIAS as Cadena  FROM   rrhh_sap8.personal_rpt pers,rrhh_sap8.unidad u,  permiso  pe,(select distinct id_funcionario ,NOMBRE, ape1, ape2  FROM personal_new)  p,tr_tipo_permiso tr  WHERE (     (id_estado in ('22') and pe.id_funcionario=p.id_funcionario            )           )           and tr.id_tipo_permiso=pe.id_tipo_permiso                    and tr.id_ano=pe.id_ano                     and (ANULADO IS  NULL OR ANULADO='NO')   and pe.id_funcionario=pers.id_funcionario(+)      and pers.id_unidad = u.id_unidad(+)  ORDER BY APE1  asc,APE2,DEsc_tipo_permiso");
ResultSet RSPENDIENTE = StatementRSPENDIENTE.executeQuery();
boolean RSPENDIENTE_isEmpty = !RSPENDIENTE.next();
boolean RSPENDIENTE_hasData = !RSPENDIENTE_isEmpty;
Object RSPENDIENTE_data;
int RSPENDIENTE_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
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
    else if (opcion==2) 
      {
          if (document.getElementById('FABIERTO').style.display=="none") 
             {
              document.getElementById('FABIERTO').style.display='';
               for (x = 1; x <=  total_f; x++)
              {
               document.getElementById('F'+x).style.display='';
              } 
              document.getElementById('FCERRADO').style.display='none';
             }  
          else 
             {
              document.getElementById('FABIERTO').style.display='none';
               for (x = 1; x <=  total_f; x++)
              {
               document.getElementById('F'+x).style.display='none';
              } 
              document.getElementById('FCERRADO').style.display='';
             }  
      }
    else if (opcion==3) 
      {
          if (document.getElementById('DABIERTO').style.display=="none") 
             {
              document.getElementById('DABIERTO').style.display='';
                 for (x = 1; x <=  total_d; x++)
              {
               document.getElementById('D'+x).style.display='';
              } 
              document.getElementById('DCERRADO').style.display='none';
             }  
          else 
             {
              document.getElementById('DABIERTO').style.display='none';
                               for (x = 1; x <=  total_d; x++)
              {
               document.getElementById('D'+x).style.display='none';
              } 
             document.getElementById('DCERRADO').style.display='';
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

     
        

      

		      document.getElementById('DABIERTO').style.display='none';             
              document.getElementById('DCERRADO').style.display='';
              for (x = 1; x <=  total_d; x++)
              {
               document.getElementById('D'+x).style.display='none';
              } 
              document.getElementById('PABIERTO').style.display='none';              
              document.getElementById('PCERRADO').style.display='';
              for (x = 1; x <=  total_p; x++)
              {
               document.getElementById('P'+x).style.display='none';
              }    
              document.getElementById('FABIERTO').style.display='none';
              document.getElementById('FCERRADO').style.display='';     
              for (x = 1; x <= total_f; x++)
              {
               document.getElementById('F'+x).style.display='none';
              } 

  
   }
// -->
</script>
<html>
<head>
<title>Gesti&oacute;n de Permisos - Administraci&oacute;n de RRHH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="esquema.css" rel="stylesheet" type="text/css">
<link href="apliweb.css" rel="stylesheet" type="text/css">
<body OnLoad="carga_final()">
<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>
<div>
<ul id="tabh">
    <li ><a href="../../index_busqueda.jsp" id="current">Permisos/Ausencias</a></li>
    <li><a href="../Listados" >Listados Generales</a></li>
    <li><a href="" onClick="../Finger">Finger</a></li>
    <li id="active" ><a href="../Horas" >Horas Sindicales</a></li>  
    <li><a href="gestion/Bolsa_proceso/index.jsp" class="ah12b">Proceso Bolsa</a></li>    
  </ul>
</div>
<div id="form">

<table width="760" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="75%" align="left" valign="top">       
      <table cellspacing=0 cellpadding=3 width=98% border=0>
        <tbody> 
        <tr> 
          <td bgcolor=#003366><div align="left"><font face=arial color=#ffffff size=+1><b>Recursos Humanos - Firma permisos </b></font></div></td>
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
                                  <td>&nbsp;<a href="index.jsp"><b>P e r m i s o s</b></a></td>
                                </tr>
                            </table></td>
                          </tr>
                          <tr>
                            <td><table border="0" cellspacing="0" cellpadding="0">
                                <tr ID="PABIERTO">
                                  <td><a href="javascript:mostrarOcultar(1);"><img src="../../imagen/minus.gif" width="19" height="16" border="0"></a></td>
                                  <td><a href="javascript:mostrarOcultar(1);"><img src="../../imagen/folderopen2.gif" width="19" height="16" border="0"></a></td>
                                  <td colspan="2" nowrap><strong>&nbsp;Pendientes de Firma</strong> (<%=(RSPENDIENTE_total)%>)</td>
                                </tr>
                                <% while ((RSPENDIENTE_hasData)&&(Repeat1__numRows-- != 0)) { %>
                                <% if (!RSPENDIENTE_isEmpty ) { %>
                                <tr ID="P<%=(((RSPENDIENTE_data = RSPENDIENTE.getObject("FILA"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data)%>">
                                  <td width="1%"><img src="../../imagen/line.gif" width="19" height="16"></td>
                                  <td width="1%"><img src="../../imagen/join.gif" width="19" height="16"></td>
                                  <td width="1%"><img src="../../imagen/page.gif" width="19" height="16"></td>
                                  <td><%= "<a href='firmar_solicitud_p.jsp?ID_PERMISO=" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_PERMISO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "&ID_ANO=" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("ID_ANO"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "'>" + (((RSPENDIENTE_data = RSPENDIENTE.getObject("CADENA"))==null || RSPENDIENTE.wasNull())?"":RSPENDIENTE_data) + "</a>" %></td>
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




<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>
</body>
</html>
<%
RSPENDIENTE.close();
StatementRSPENDIENTE.close();
ConnRSPENDIENTE.close();
%>
