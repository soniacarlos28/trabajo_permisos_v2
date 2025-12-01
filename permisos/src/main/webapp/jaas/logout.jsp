<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cerrar sesión en aplicaciones corporativas</title>
</head>
<body>
<% String userName = (String) request.getUserPrincipal().getName(); %>
<p>La sesión que tenía actualmente abierta con el usuario <b>'<%= userName %>'</b> se ha cerrado.</p>
<%	session.invalidate(); %>
</body>
</html>