<%
String userName = (String) session.getAttribute("userName");
String passWord = (String) session.getId();
%>
<html>
<head>
<title>Accediendo a la aplicaci&oacute;n...</title>

<% if (userName != null && !userName.equals("")) { %>
<script type="text/javascript">
function submitform() { document.forms['loginForm'].submit(); }
window.onload = submitform;
</script>
<% } %>

</head>
<body>

<%	if (userName != null && !userName.equals("")) { %>

	<form name="loginForm" method="POST" action='<%=response.encodeURL("j_security_check")%>' >
	<input type="hidden" name="j_username" value="<%= userName %>" />
	<input type="hidden" name="j_password" value="<%= passWord %>" />
	<!--  <p><input type="submit" value="Pulse para entrar" /></p>  -->
	</form>

<%	} else { %>

<div id="section-top" >
<h1>Acceso a aplicaciones corporativas 2</h1><hr/>
</div>

<div style="margin-left: 1em; margin-right: 1em;">
    <h2>Usuarios autorizados</h2>

	 <form name="loginForm" method="POST"
          action='<%= response.encodeURL(request.getContextPath() + "/j_security_check") %>'>
      <fieldset>
        <legend>Datos de identificaci&oacute;n</legend> 
        <p>
          <label for="j_username"
                 style="width: 12em; text-align: right">Nombre de usuario:</label>
          <input id="j_username" name="j_username" type="text"
                 tabindex="3" size="16" maxlength="25"
                 style="margin-left: 0.5em" />
        </p>
        <p>
          <label for="j_password"
                 style="width: 12em; text-align: right">Contraseña:</label> 
          <input id="j_password" name="j_password" type="password"
                 tabindex="3" size="16" maxlength="25"
                 style="margin-left: 0.5em" />
        </p>
      </fieldset>
      <p>
        <input type="submit" value="Pulse para entrar" />
      </p>
    </form>

</div>

<% 	} %>

</body>
</html>
