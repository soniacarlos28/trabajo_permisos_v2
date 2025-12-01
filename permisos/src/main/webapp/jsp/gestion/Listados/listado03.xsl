<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl"> 
<xsl:template match="/"> 
<HEAD><TITLE>Listado de bajas</TITLE></HEAD>
<BODY bgcolor="#FFFFFF" topmargin="10" leftmargin="10">
<CENTER>
<TABLE border="0" cellspacing="0" cellpadding="0" width="600">
  <TR>
    <TD align="left" width="50%">
      <TABLE border="0" cellspacing="0" cellpadding="5">
        <TR valign="bottom"> 
          <TD><IMG src="./imagen/escudo.gif" width="47" height="57"/></TD>
          <TD><SPAN style="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px">Excmo. Ayuntamiento<BR/>de Salamanca</SPAN></TD>
        </TR>
      </TABLE>
    </TD>
    <TD align="center" width="50%">
      <SPAN style="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px">Fecha del Listado<BR/>
      <xsl:value-of select="LISTADO/PROPIEDADES/@FECHA"/>
      </SPAN>
    </TD>
  </TR>
</TABLE>
<TABLE border="0" cellspacing="5" cellpadding="5" width="600">
  <TR>
    <TD align="center" bgcolor="#FFFFFF">
    <SPAN style="font-family: Arial, Helvetica, Verdana, serif; font-size: 20px">
    <xsl:value-of select="LISTADO/PROPIEDADES/@TITULO"/>
    </SPAN>
    </TD>
  </TR>  
</TABLE>
<TABLE border="0" cellspacing="0" cellpadding="0" width="600">
  <TR>
    <TD bgcolor="#000000">
      <TABLE border="0" cellspacing="1" cellpadding="5" width="100%">
        <TR>
          <TD align="center" bgcolor="#CCCCCC"><SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><B>AÑO</B></SPAN></TD>
          <TD align="center" bgcolor="#CCCCCC"><SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><B>FUNCIONARIO</B></SPAN></TD>
          <TD align="center" bgcolor="#CCCCCC"><SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><B>BAJA</B></SPAN></TD>
          <TD align="center" bgcolor="#CCCCCC"><SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><B>INICIO</B></SPAN></TD>
          <TD align="center" bgcolor="#CCCCCC"><SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><B>PRESENTACION</B></SPAN></TD>
          <TD align="center" bgcolor="#CCCCCC"><SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><B>FIN</B></SPAN></TD>
          <TD align="center" bgcolor="#CCCCCC"><SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><B>CONFIRMACION</B></SPAN></TD>
          <TD align="center" bgcolor="#CCCCCC"><SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><B>OBSERVACIONES</B></SPAN></TD>
        </TR>
        <xsl:for-each select="LISTADO/REGISTROS/REGISTRO"> 
        <TR>
          <TD align="left"   bgcolor="#FFFFFF"> <SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><xsl:value-of select="@ID_ANO"/></SPAN></TD>
          <TD align="center" bgcolor="#FFFFFF"> <SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><xsl:value-of select="@ID_FUNCIONARIO"/></SPAN></TD>
          <TD align="center" bgcolor="#FFFFFF"> <SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><xsl:value-of select="@ID_TIPO_BAJA"/></SPAN></TD>
          <TD align="center" bgcolor="#FFFFFF"> <SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><xsl:value-of select="@FECHA_INICIO"/></SPAN></TD>
          <TD align="center" bgcolor="#FFFFFF"> <SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><xsl:value-of select="@FECHA_PRESENTACION"/></SPAN></TD>
          <TD align="center" bgcolor="#FFFFFF"> <SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><xsl:value-of select="@FECHA_FIN"/></SPAN></TD>
          <TD align="center" bgcolor="#FFFFFF"> <SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><xsl:value-of select="@FECHA_CONFIRMACION"/></SPAN></TD>
          <TD align="center" bgcolor="#FFFFFF"> <SPAN STYLE="font-family: Arial, Helvetica, Verdana, serif; font-size: 12px"><xsl:value-of select="@OBSERVACIONES"/></SPAN></TD>
        </TR>
        </xsl:for-each> 
      </TABLE>
    </TD>
  </TR>
</TABLE>  
</CENTER>
</BODY>
</xsl:template> 
</xsl:stylesheet> 