<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%> 
<%@ include file="../../../Connections/RRHH.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>
<%       response.setContentType("application/vnd.ms-excel");
   
%>
<% String RSIMPAR="";
   String RSCOLOR="";

%>
<%
String RSSINDICAL__MMColParam1 = "2017";
if (request.getParameter("ID_AÑO")   !=null) {RSSINDICAL__MMColParam1 = (String)request.getParameter("ID_AÑO")  ;}
%>
<%
Driver DriverRSQUERY = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSQUERY = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSQUERY = ConnRSQUERY.prepareStatement("SELECT distinct  trunc(e_total/60) || ':' || lpad(mod(e_total,60),2,'0')  as e_total_m,        trunc( e_utilizadas/60) || ':' || lpad(mod( e_utilizadas,60),2,'0') as  e_utilizadas_m,  trunc( f_total/60) || ':' || lpad(mod( f_total,60),2,'0') as  f_total_m,trunc( f_utilizadas/60)|| ':' || lpad(mod( f_utilizadas,60),2,'0') as  f_utilizadas_m,trunc( m_total/60) || ':' || lpad(mod( m_total,60),2,'0') as  m_total_m,trunc( m_utilizadas/60)|| ':' || lpad(mod( m_utilizadas,60),2,'0') as  m_utilizadas_m,trunc( a_total/60) || ':' || lpad(mod( a_total,60),2,'0') as  a_total_m,trunc( a_utilizadas/60) || ':' || lpad(mod( a_utilizadas,60),2,'0') as  a_utilizadas_m,trunc( ma_total/60) || ':' || lpad(mod( ma_total,60),2,'0') as  ma_total_m,trunc( ma_utilizadas/60)|| ':' || lpad(mod( ma_utilizadas,60),2,'0') as  ma_utilizadas_m,trunc( j_utilizadas/60) || ':' || lpad(mod( j_utilizadas,60),2,'0') as  j_utilizadas_m,trunc( j_total/60) || ':' || lpad(mod( j_total,60),2,'0') as  j_total_m,trunc( ju_utilizadas/60) || ':' || lpad(mod( ju_utilizadas,60),2,'0') as  ju_utilizadas_m,trunc( ju_total/60) || ':' || lpad(mod( ju_total,60),2,'0') as  ju_total_m,trunc( ag_utilizadas/60) || ':' || lpad(mod( ag_utilizadas,60),2,'0') as  ag_utilizadas_m,trunc( ag_total/60) || ':' || lpad(mod( ag_total,60),2,'0') as  ag_total_m,trunc( s_utilizadas/60) || ':' || lpad(mod( s_utilizadas,60),2,'0') as  s_utilizadas_m,trunc( s_total/60) || ':' || lpad(mod( s_total,60),2,'0') as  s_total_m,trunc( n_utilizadas/60)|| ':' || lpad(mod( n_utilizadas,60),2,'0') as  n_utilizadas_m,trunc( n_total/60) || ':' || lpad(mod( n_total,60),2,'0') as  n_total_m,trunc( o_utilizadas/60) || ':' || lpad(mod( o_utilizadas,60),2,'0') as  o_utilizadas_m,trunc( o_total/60) || ':' || lpad(mod( o_total,60),2,'0') as  o_total_m,trunc( d_utilizadas/60) || ':' || lpad(mod( d_utilizadas,60),2,'0') as  d_utilizadas_m,trunc( d_total/60) || ':' || lpad(mod( d_total,60),2,'0') as  d_total_m,                substr(desc_tipo_ausencia,                       instr(desc_tipo_ausencia, ' ', 1, 1) + 1,                       instr(desc_tipo_ausencia, ' ', 1, 2) -                       instr(desc_tipo_ausencia, ' ', 1, 1) - 1) as SINDICATO,                INITCAP(pe.nombre) || ' ' || INITCAP(pe.ape1) || ' ' ||                INITCAP(pe.ape2) as nombres,                tr.ID_TIPO_AUSENCIA ID_TIPO_AUSENCIA,                tr.ID_TIPO_AUSENCIA || '--' ||                SUBSTR((DESC_TIPO_AUSENCIA), 1, 40) as DESC_TIPO_AUSENCIA,                DECODE(nvl(FECHA_BAJA - sysdate, 0), '0', '0', '1') as ESTADO_BAJA,                h.id_funcionario as ID_FUNCIONARIO  FROM RRHH.TR_TIPO_AUSENCIA tr, hora_sindical h,horas_sindicales_totales  ht, personal_new pe WHERE tr.ID_TIPO_AUSENCIA between '500' and '800'   and tr.ID_TIPO_AUSENCIA = h.ID_TIPO_AUSENCIA   and ht.id_funcionario= pe.id_funcionario    and ht.id_ano= h.id_ano    and h.id_funcionario = pe.id_funcionario      and  h.id_ano = '" + RSSINDICAL__MMColParam1 + "'  ORDER BY SINDICATO, NOMBRES");
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

<table width="95%" border="0" cellspacing="0" cellpadding="2">
<tr bgcolor="#CCFFCC"> 
                                        <td colspan="7" align="center"><b>AÑO: <%=  RSSINDICAL__MMColParam1%>  Horas Sindicales </b> (En rojo personal_new con fecha de baja)</td>
                                      </tr>
                          <tr> 
                            <td> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#f2f2f2"> 
                  <table width="100%" border="0" cellspacing="1" cellpadding="2">
                    <tr bgcolor="#CCCCCC"> 
                      <td class="va10b" align="center" width="5%">Ausencia</td>     
                      <td class="va10b" align="center" width="5%">ID</td>                
                      <td class="va10b" width="15%">Nombre</td>
                      <td class="va10b" bgcolor="#CCCCCC" align="center" width="15%">Sindicato</td>
                        <td class="va10b" align="center" width="5%">Enero Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Enero Utilizadas</td>
                        <td class="va10b" align="center" width="5%">Febrero Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Febrero Utilizadas</td>
                          <td class="va10b" align="center" width="5%">Marzo Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Marzo Utilizadas</td>
                          <td class="va10b" align="center" width="5%">Abril Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Abril Utilizadas</td>
                          <td class="va10b" align="center" width="5%">Mayo Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Mayo Utilizadas</td>
                          <td class="va10b" align="center" width="5%">Junio Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Junio Utilizadas</td>
                          <td class="va10b" align="center" width="5%">Julio Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Julio Utilizadas</td>
                       <td class="va10b" align="center" width="5%">Agosto Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Agosto Utilizadas</td>
                          <td class="va10b" align="center" width="5%">Septiembre Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Septiembre Utilizadas</td>
                         <td class="va10b" align="center" width="5%">Octubre Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Octubre Utilizadas</td>
                          <td class="va10b" align="center" width="5%">Noviembre Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Noviembre Utilizadas</td>
                        <td class="va10b" align="center" width="5%">Diciembre Total</td>
                        <td class="va10b" bgcolor="#EEEEEE" align="center" width="5%">Diciembre Utilizadas</td>
                        
                     
                    </tr>
                    <% while ((RSQUERY_hasData)&&(Repeat1__numRows-- != 0)) { %>
                    <%   RSIMPAR =  (String) (((RSQUERY_data = RSQUERY.getObject("ESTADO_BAJA"))==null || RSQUERY.wasNull())?"":RSQUERY_data); 
                            	     if (RSIMPAR.equals("1") )  
                                     	 RSCOLOR="bgcolor=\"#FAD2D2\"";                     	
    				               else 	                   
                                          RSCOLOR="";   
							  	  
							  	  %> 
                                        
                    <tr bgcolor="#FFFFFF"> 
                                     <td class="va10b" <%= RSCOLOR %> align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("ID_TIPO_AUSENCIA"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>     
                      <td class="va10b" <%= RSCOLOR %> align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("ID_FUNCIONARIO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>                
                      <td class="va10b" <%= RSCOLOR %> width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("NOMBRES"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      <td class="va10b" <%= RSCOLOR %>  align="center" width="15%"><%=(((RSQUERY_data = RSQUERY.getObject("SINDICATO"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b"  <%= RSCOLOR %>align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("E_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b"  <%= RSCOLOR %> bgcolor="#EEEEEE" align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("E_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("F_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE" align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("F_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                          <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("M_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE" align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("M_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                          <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("A_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE" align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("A_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                          <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("MA_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE" align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("MA_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                          <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("J_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE"  align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("J_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                          <td class="va10b" <%= RSCOLOR %> align="center"  bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("JU_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE"align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("JU_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                       <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("A_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE" align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("A_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                          <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("S_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE"  align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("S_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                         <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("O_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE"  align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("O_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                          <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("N_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> bgcolor="#EEEEEE" align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("N_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %> align="center" bgcolor="#CCCCCC" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("D_TOTAL_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                        <td class="va10b" <%= RSCOLOR %>bgcolor="#EEEEEE" align="center" width="5%"><%=(((RSQUERY_data = RSQUERY.getObject("D_UTILIZADAS_M"))==null || RSQUERY.wasNull())?"":RSQUERY_data)%></td>
                      
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