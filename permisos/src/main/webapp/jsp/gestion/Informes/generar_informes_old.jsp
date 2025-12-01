<%@page language="java" import="java.util.Date,java.sql.*" %>
<%@ include file="../../../Connections/RRHH.jsp" %>
<%@ include file="../../../Connections/APLIWEB.jsp" %>
<%
	/**
	* Garantiza que la sesion tenga los atributos necesarios para el
	* correcto funcionamiento de las aplicaciones web corporativas.
	*/
	es.aytosalamanca.http.controller.session.SessionManager.touchSession(request); 
%>

<%
Driver DriverTIPO_INFORME = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnTIPO_INFORME = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementTIPO_INFORME = ConnTIPO_INFORME.prepareStatement("select ID_TIPO_INFORME,DESC_TIPO_INFORME from FICHAJE_TR_TIPO_INFORME order by 2");
ResultSet TIPO_INFORME = StatementTIPO_INFORME.executeQuery();
boolean TIPO_INFORME_isEmpty = !TIPO_INFORME.next();
boolean TIPO_INFORME_hasData = !TIPO_INFORME_isEmpty;
Object TIPO_INFORME_data;
int TIPO_INFORME_numRows = 0;
%>
<%
Driver DriverRSDPTO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSDPTO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSDPTO = ConnRSDPTO.prepareStatement("select ID_UNIDAD as id_departamento,DESC_UNIDAD as abreviatura  from unidad order by 1");
ResultSet RSDPTO = StatementRSDPTO.executeQuery();
boolean RSDPTO_isEmpty = !RSDPTO.next();
boolean RSDPTO_hasData = !RSDPTO_isEmpty;
Object RSDPTO_data;
int RSDPTO_numRows = 0;
%>
		  <%
Driver DriverRSDPTO_PB = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSDPTO_PB = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSDPTO_PB = ConnRSDPTO_PB.prepareStatement("select ID_UNIDAD as id_departamento,DESC_UNIDAD as abreviatura  from unidad where id_unidad in ('0007000100','0007000200') order by 1");
ResultSet RSDPTO_PB = StatementRSDPTO_PB.executeQuery();
boolean RSDPTO_PB_isEmpty = !RSDPTO_PB.next();
boolean RSDPTO_PB_hasData = !RSDPTO_PB_isEmpty;
Object RSDPTO_PB_data;
int RSDPTO_PB_numRows = 0;
%>
                                       
<%
Driver DriverRSPERIO = (Driver)Class.forName(MM_RRHH_DRIVER).newInstance();
Connection ConnRSPERIO = DriverManager.getConnection(MM_RRHH_STRING,MM_RRHH_USERNAME,MM_RRHH_PASSWORD);
PreparedStatement StatementRSPERIO = ConnRSPERIO.prepareStatement("SELECT DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES) || ' de ' || ano as PER2,ano, MES,DECODE(MES,'01',rpad('Enero:' ,13, '  ')  ,                                      '02',rpad('Febrero:',13, '  ')  ,                                      '03',rpad('Marzo:',13, '  ')  ,                                      '04',rpad('Abril:',13, '  ')  ,                                      '05',rpad('Mayo:',13, '  ')  ,                                      '06',rpad('Junio:',13, '  ')  ,                                      '07',rpad('Julio:',13, '  ')  ,                                      '08',rpad('Agosto:',13, '  ')  ,                                      '09',rpad('Septiembre:',13, '  ')  ,                                      '10',rpad('Octubre:',13, '  ')  ,                                      '11',rpad('Noviembre',13, '  ')  ,                                      '12',rpad('Diciembre:',13, '  ')  ,MES)   || '  ' ||    to_char(INICIO,'DD/MM/YYYY') ||  ' a  ' || to_char(FIN,'DD/MM/YYYY') as periodo ,mes ||  ano as per FROM omesa.webperiodo  WHERE ano> to_number(To_char(sysdate,'yyyy'))-2 and  ano ||mes <= to_char(sysdate+30,'YYYYMM') ORDER BY ano,MES");
ResultSet RSPERIO = StatementRSPERIO.executeQuery();
boolean RSPERIO_isEmpty = !RSPERIO.next();
boolean RSPERIO_hasData = !RSPERIO_isEmpty;
Object RSPERIO_data;
int RSPERIO_numRows = 0;
%>
<script language="Javascript">
function Vista_informe(sel) {
      if (sel.value=="F"){
           divC = document.getElementById("nFuncionario");
           divC.style.display = "";
           divC = document.getElementById("nFuncionario_1");
           divC.style.display = "";
           
           divT = document.getElementById("nDepartamento");
           divT.style.display = "none";
           divT = document.getElementById("nDepartamento_1");
           divT.style.display = "none";
           divT = document.getElementById("nDepartamento_2");
           divT.style.display = "none";
           document.Informes.CAMPO_FILTRO_1.value="F";
        }
      if (sel.value=="D"){
          divC = document.getElementById("nFuncionario");
          divC.style.display = "none";
          divC = document.getElementById("nFuncionario_1");
          divC.style.display = "none";

          divT = document.getElementById("nDepartamento");
          divT.style.display = "";
         
          document.Informes.CAMPO_FILTRO_1.value="D";
       
          if (document.Informes.ID_TIPO_INFORME.value ==  "5" || document.Informes.ID_TIPO_INFORME.value ==  "6")   
             {
        	  divT = document.getElementById("nDepartamento_2");
              divT.style.display = "none";
             }
          else {
        	  divT = document.getElementById("nDepartamento_1");
              divT.style.display = "";
              }         
       }
      
      if (sel.value=="TD"){
          divC = document.getElementById("nFuncionario");
          divC.style.display = "none";
          divC = document.getElementById("nFuncionario_1");
          divC.style.display = "none";

          divT = document.getElementById("nDepartamento");
          divT.style.display = "none";
          divT = document.getElementById("nDepartamento_1");
          divT.style.display = "none";
          divT = document.getElementById("nDepartamento_2");
          divT.style.display = "none"; 
          document.Informes.CAMPO_FILTRO_1.value="TD";

        
       }

      if (sel.value=="M"){
          divC = document.getElementById("nFecha");
          divC.style.display = "";
          divC = document.getElementById("nFecha_1");
          divC.style.display = "";
          divC = document.getElementById("nFecha_2");
          divC.style.display = "";
          divC = document.getElementById("nFecha_3");
          divC.style.display = "";
          divC = document.getElementById("nAno");
          divC.style.display = "none";
          divC = document.getElementById("nAno_1");
          divC.style.display = "none";
          divC = document.getElementById("nPeriodo");
          divC.style.display = "none";
          divC = document.getElementById("nPeriodo_1");
          divC.style.display = "none";
          document.Informes.CAMPO_FILTRO_2.value="M";
      }

      if (sel.value=="A"){
          divC = document.getElementById("nAno");
          divC.style.display = "";
          divC = document.getElementById("nAno_1");
          divC.style.display = "";
          divC = document.getElementById("nPeriodo");
          divC.style.display = "none";
          divC = document.getElementById("nPeriodo_1");
          divC.style.display = "none";
          divC = document.getElementById("nFecha");
          divC.style.display = "none";
          divC = document.getElementById("nFecha_1");
          divC.style.display = "none";
          divC = document.getElementById("nFecha_2");
          divC.style.display = "none";
          divC = document.getElementById("nFecha_3");
          divC.style.display = "none";
          document.Informes.CAMPO_FILTRO_2.value="A";
      }


      if (sel.value=="P"){
          divC = document.getElementById("nPeriodo");
          divC.style.display = "";
          divC = document.getElementById("nPeriodo_1");
          divC.style.display = "";
          divC = document.getElementById("nAno");
          divC.style.display = "none";
          divC = document.getElementById("nAno_1");
          divC.style.display = "none";
          divC = document.getElementById("nFecha");
          divC.style.display = "none";
          divC = document.getElementById("nFecha_1");
          divC.style.display = "none";
          divC = document.getElementById("nFecha_2");
          divC.style.display = "none";
          divC = document.getElementById("nFecha_3");
          divC.style.display = "none";
          document.Informes.CAMPO_FILTRO_2.value="P";
      }
      
   
}

function envia_unavez()
{
	
if (document.Informes.Planificar.disabled==false) 
 {
     document.Informes.Planificar.disabled=true;
     document.Informes.CAMPO_TODO.value="";

     //Parametros V_CAMPOS_INFORME
     
     // id_tipo_informe,     -- TI
     // titulo,              -- T
     
     // filtro_1 ,           -- F1
     // filtro_1_para        -- FP
     // filtro_2 ,           -- F2
     // filtro_2_para        --FI FF


    document.Informes.CAMPO_TODO.value= "TITULOZ" +  document.Informes.ID_TITULO.value  + ";";
    document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "TIPOZ" +  document.Informes.ID_TIPO_INFORME.value  + ";";
    document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "FILTRO1Z" +  document.Informes.CAMPO_FILTRO_1.value  + ";";
    document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "FILTRO2Z" +  document.Informes.CAMPO_FILTRO_2.value  + ";";
 
		

    if (document.Informes.FILTRO_1.value=="F"){
         
          document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "PARA1Z" +  document.Informes.ID_FUNCIONARIO.value  + ";";
          
          document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "FILTRO1ZTXT" +  document.Informes.ID_FUNCIONARIO_NOMBRE.value  + ";";
       }
     if (document.Informes.FILTRO_1.value=="D"){
         document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "PARA1Z" +  document.Informes.ID_DEPTO_ORIGEN.value  + ";";
         if (document.Informes.ID_TIPO_INFORME.value ==  "5" || document.Informes.ID_TIPO_INFORME.value ==  "6")   
         {
        	
             var text = "AA";
         }
      else {
    	  var select = document.getElementById("ID_DEPTO_ORIGEN");
          var text = select.options[select.selectedIndex].innerText;
          }         
            
         
         document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "FILTRO1ZTXT" +  text  + ";";         
      }
     
     if (document.Informes.FILTRO_1.value=="TD"){
           document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "PARA1Z" +   "TD;";  
           document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "FILTRO1ZTXTTodos Funcionarios;";
                  
      }

     if (document.Informes.FILTRO_2.value=="M"){
           document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value  + "PARA2FIZ" +document.Informes.FECHA_INICIO.value + ";"; 
           document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value  + "PARA2FPZ" +document.Informes.FECHA_FIN.value + ";";
           document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "FILTRO2ZTXT" +   "Fechas: " + document.Informes.FECHA_INICIO.value + "--" + document.Informes.FECHA_FIN.value  + ";";   
     }

     if (document.Informes.FILTRO_2.value=="A"){
            document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value  + "PARA2FIZ" +document.Informes.ID_ANO.value + ";";

            var select = document.getElementById("FILTRO_2");
            var text = select.options[select.selectedIndex].innerText;
            document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "FILTRO2ZTXT" +  text  + " " + document.Informes.ID_ANO.value +";";
      	    
     }


     if (document.Informes.FILTRO_2.value=="P"){
           document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value  + "PARA2FIZ" + document.Informes.PERIODO.value + ";";
                        
     }
 
  
     
     

      var select = document.getElementById("FILTRO_2");
      var text = select.options[select.selectedIndex].innerText;
      document.Informes.CAMPO_TODO.value=  document.Informes.CAMPO_TODO.value + "FILTRO2ZTXT" +  text  + ";";
	 
	document.Informes.submit();
	   
  }//fin if 

}  // envia_unavez

</script>
<html>
<head>
<title>GENERA INFORMES</title>
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



<table width="95%" border="0" cellspacing="3" cellpadding="2">
<form name="Informes" method="POST" action="alta_informe.jsp">
   <tr bgcolor="#CCFFCC"> 
       <td colspan=8 align="center"><b> Generador de Informes</b></td>
   </tr>
   </br>
   <tr>
     
     <th colspan=1>Titulo</td>
     <td colspan=3><input type="text"  ID="ID_TITULO" size="98"   value="" ></td>
   </tr>  
    </br>
   <tr>
     
     <th colspan=1>Informe</td>
     <td colspan=3>
     <select name="ID_TIPO_INFORME" maxlength="100">
      <option value="" >Seleccione Opción</option>
    <%   while (TIPO_INFORME_hasData) { %>
                 <option value="<%=((TIPO_INFORME.getObject("ID_TIPO_INFORME")!=null)?TIPO_INFORME.getObject("ID_TIPO_INFORME"):"")%>"><%=((TIPO_INFORME.getObject("DESC_TIPO_INFORME")!=null)?TIPO_INFORME.getObject("DESC_TIPO_INFORME"):"")%></option>
             <%  TIPO_INFORME_hasData = TIPO_INFORME.next();
           }
                TIPO_INFORME.close();
                TIPO_INFORME = StatementTIPO_INFORME.executeQuery();
                TIPO_INFORME_hasData = TIPO_INFORME.next();
                TIPO_INFORME_isEmpty = !TIPO_INFORME_hasData;
             %>
                                             </select></td>
   </tr> 
   </br> 
   <tr>
    
       <th>Filtro personas</td>
       <td>
            <select name="FILTRO_1" ID="FILTRO_1" onChange="Vista_informe(this)">
                  <option value="" >Seleccione Opción</option>
                      <option value="TD">Todos funcionarios</option>
                      <option value="D">Departamento</option>
                      <option value="F">Funcionario</option>
            </select>
                                            
                                            
       </td>         
                    <th align="center" id="nFuncionario" style="display:none;">Funcionario:</th>
                       <td colspan="3"  id="nFuncionario_1" style="display:none;"> 
                                                   <input type="text" disabled="yes" ID="ID_FUNCIONARIO_ID" size="8"   value="" >
                                                   <input type="text" textcolor=#FFFFFF  ID="ID_FUNCIONARIO_NOMBRE" size="35"   value="" >
                                                   <input type="hidden" name="ID_FUNCIONARIO" ID="ID_FUNCIONARIO" size="6" value="" >
                                                   <input type="button" name="" value="Buscar Funcionario"
                                          onClick="javascript:window.open('../Busqueda/index_busqueda_funcionario.jsp?CAMPO=ID_FUNCIONARIO' ,null,'height=550,width=600,resizable=n0,scrollbars=no,status=no,toolbar=no ,menubar=no');"      >    
                       </td>
                                     
         <th align="right" id="nDepartamento" style="display:none;">Departamento: </th>
        <td id="nDepartamento_1" style="display:none;"><select name="ID_DEPTO_ORIGEN" id="ID_DEPTO_ORIGEN">
          <%
            while (RSDPTO_hasData) {
                 %>
            <option value="<%=((RSDPTO.getObject("ID_DEPARTAMENTO")!=null)?RSDPTO.getObject("ID_DEPARTAMENTO"):"")%>"><%=((RSDPTO.getObject("ABREVIATURA")!=null)?RSDPTO.getObject("ABREVIATURA"):"")%></option>
              <%
                  RSDPTO_hasData = RSDPTO.next();  }
              RSDPTO.close();
              RSDPTO = StatementRSDPTO.executeQuery();
              RSDPTO_hasData = RSDPTO.next();
              RSDPTO_isEmpty = !RSDPTO_hasData;
              %>
          </select>        </td> 
                                              
        <td id="nDepartamento_2" style="display:none;"><select name="ID_DEPTO_ORIGEN_2" id="ID_DEPTO_ORIGEN_2">
          <%
            while (RSDPTO_PB_hasData) {
                 %>
            <option value="<%=((RSDPTO_PB.getObject("ID_DEPARTAMENTO")!=null)?RSDPTO_PB.getObject("ID_DEPARTAMENTO"):"")%>"><%=((RSDPTO_PB.getObject("ABREVIATURA")!=null)?RSDPTO_PB.getObject("ABREVIATURA"):"")%></option>
              <%
                  RSDPTO_PB_hasData = RSDPTO_PB.next();  }
              RSDPTO_PB.close();
              RSDPTO_PB = StatementRSDPTO_PB.executeQuery();
              RSDPTO_PB_hasData = RSDPTO_PB.next();
              RSDPTO_PB_isEmpty = !RSDPTO_PB_hasData;
              %>
          </select>        </td> 
     </td>
   </tr>
   <tr>
    
       <th>Filtro Fechas</td>
       <td>
            <select name="FILTRO_2" ID="FILTRO_2" onChange="Vista_informe(this)">
                      <option value="" >Seleccione Opción</option>
                      <option value="A" >Año</option>
                      <option value="P">Perido Finger</option>
                      <option value="M">Entre dos Fechas</option>
            </select>
                                            
                                            
       </td>         
                    <th align="center" id="nPeriodo" style="display:none;">Periodo:</th>
                       <td colspan="3"  id="nPeriodo_1" style="display:none;">
                         <select name="PERIODO" maxlength="100">
                                                <option value="" >Seleccione Opción</option>
                                                  <option value="PA" >Periodo Anterior</option>
                                                  <option value="MA" >Mes Anterior</option>
                                                  <option value="DA" >Día Anterior</option> 
                                               <%
                                                 while (RSPERIO_hasData) {
                                                %>
                                                  
                                               <option value="<%=((RSPERIO.getObject("PER")!=null)?RSPERIO.getObject("PER"):"")%>"  ><%=((RSPERIO.getObject("PERIODO")!=null)?RSPERIO.getObject("PERIODO"):"")%></option>
                                                <%
  													RSPERIO_hasData = RSPERIO.next();
													}
													RSPERIO.close();
													RSPERIO = StatementRSPERIO.executeQuery();
													RSPERIO_hasData = RSPERIO.next();
													RSPERIO_isEmpty = !RSPERIO_hasData;
												%>
                                             </select> 
                     </td>
                                     
         <th align="right" id="nAno" style="display:none;">Año: </th>
            <td id="nAno_1" style="display:none;"> 
              <select name="ID_ANO" >
                       <option value="" >Seleccione Opción</option>
                      <option value="2018">2018</option>
                      <option value="2017">2017</option>                      
            </select>   </td> 
               
          <th align="center"   id="nFecha" style="display:none;">Fecha Inicio: 
                                   </th>
                                    <td valign="middle" id="nFecha_1" style="display:none;"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="25%"> 
                                            <input type="text" name="FECHA_INICIO" value=""  size="15" maxlength="10">
</td>
                                          <td width="22%"><a href="javascript:show_Calendario('Informes.FECHA_INICIO');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>
                                    </td>


    <th align="center" id="nFecha_2" style="display:none;">Fecha Fin:</th>
                                    <td valign="middle" id="nFecha_3" style="display:none;"> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="25%"> 
                                            <input type="text" name="FECHA_FIN" value=""  size="15" maxlength="10">
</td>
                                          <td width="22%"><a href="javascript:show_Calendario('Informes.FECHA_FIN');"><img src="../../imagen/calendario.gif" width="34" height="22" border="0"></a></td>
                                        </tr>
                                      </table>
                                    </td> 
                                                                     
       
     
   </tr>
   <tr> 
       <td colspan=8 align="center"> <input type="button" name="Planificar" value="Planificar Informe" onClick="javascript:envia_unavez();">
                                              
                                              </td>
                                            
                           <input type="hidden" name="V_ID_FUNCIONARIO" value="0">
                           <input type="hidden" name="CAMPO_TODO" value="">
                           <input type="hidden" name="CAMPO_FILTRO_1" value="">
                           <input type="hidden" name="CAMPO_FILTRO_2" value="">
                         </td>
   </tr>
   <tr> 
       <td colspan=8 align="center"></td>
   </tr>
   
   </form>
</table>
                     
	

</body>
</html>
<%
RSDPTO.close();
StatementRSDPTO.close();
ConnRSDPTO.close();
%>

