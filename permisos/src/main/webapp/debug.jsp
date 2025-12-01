<!-- BEGIN DEBUG -->
<div style="text-align: left">

<h1>Información de Depuración</h1>

<h2>session:</h2>
<ul>
<%
	@SuppressWarnings("unchecked")
	java.util.Enumeration<String> names = session.getAttributeNames();
	while (names.hasMoreElements()) {
		String name1 = (String) names.nextElement();
%>
<li>
<b>Nombre: </b><%=name1%><br/>
&nbsp;Valor: <%=session.getAttribute(name1)%><br/>
</li>
<% } %>
</ul>

<h2>request:</h2>
<ul>
<% 
	@SuppressWarnings("unchecked")
	java.util.Enumeration<String> names2 = request.getAttributeNames();
	while (names2.hasMoreElements()) {
		String name2 = (String) names2.nextElement();
%>
<li>
<b>Nombre: </b><%=name2%><br/>
&nbsp;Valor: <%=request.getAttribute(name2)%><br/>
</li>
<% } %>
</ul>

<h2>header:</h2>
<ul>
<%  
	@SuppressWarnings("unchecked")
	java.util.Enumeration<String> names3 = request.getHeaderNames();
    while (names3.hasMoreElements()) {
		String name3 = (String) names3.nextElement(); 
%>
<li>
<b>Nombre: </b><%=name3%><br/>
&nbsp;Valor: <%=request.getHeader(name3)%><br/>
</li>
<% } %>
</ul>

<h2>contexto:</h2>
<ul>
<%  
	ServletContext ctx = session.getServletContext();
	
	@SuppressWarnings("unchecked")
	java.util.Enumeration<String> names4 = ctx.getAttributeNames();
	while (names4.hasMoreElements()) {
		String attribute = (String) names4.nextElement(); 
%>
<li>
<b>Nombre: </b><%= attribute %><br/>
&nbsp;Valor: <%= ctx.getAttribute(attribute)  %> 
</li>
<% } %>
</ul>
</div>
