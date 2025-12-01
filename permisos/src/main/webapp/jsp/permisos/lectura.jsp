<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ListIterator"%>

<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.NamingEnumeration"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="javax.naming.directory.Attribute"%>
<%@ page import="javax.naming.directory.Attributes"%>
<%@ page import="javax.naming.directory.DirContext"%>
<%@ page import="javax.naming.directory.InitialDirContext"%>
<%@ page import="javax.naming.directory.SearchControls"%>
<%@ page import="javax.naming.directory.SearchResult"%>

<%@ page import="es.aytosalamanca.util.configuration.MissingConfigurationParameterException"%>
<%@ page import="es.aytosalamanca.util.configuration.SecurityConfigurationParametersManager"%>

<%
List<String> userList = new ArrayList<String>();
String appTitle = "";

String urlService = SecurityConfigurationParametersManager.getParameter("service.authenticate.ldap.url.service");
String userDN = SecurityConfigurationParametersManager.getParameter("service.authenticate.ldap.mgr.dn");
String passWord = SecurityConfigurationParametersManager.getParameter("service.authenticate.ldap.mgr.pw");
String baseSearch = SecurityConfigurationParametersManager.getParameter("service.authenticate.ldap.mgr.basesearch");

Hashtable<String, String> env = new Hashtable<String, String>(5, 0.75f);
env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
env.put(Context.PROVIDER_URL, urlService);
env.put(Context.SECURITY_AUTHENTICATION, "simple");
env.put(Context.SECURITY_PRINCIPAL, userDN);
env.put(Context.SECURITY_CREDENTIALS, passWord);

String[] attrIDs = {"description","member"};
String distinguishedName = "CN=GA_R_PERMISOS,OU=App_Permisos,OU=Aplicaciones Web,OU=Seccion Aplicaciones Corporativas,OU=APLICACIONES,DC=aytosa,DC=inet";

SearchControls controls = new SearchControls();
controls.setReturningAttributes(attrIDs);
controls.setSearchScope(SearchControls.SUBTREE_SCOPE);  

NamingEnumeration<SearchResult> results;
try {
	DirContext ctx = new InitialDirContext(env);
	
	String filter = "(&(objectclass=group)(distinguishedName=" + distinguishedName + "))";
	
	results = ctx.search(baseSearch, filter, controls);
	if (results != null && results.hasMoreElements()) {
		SearchResult searchResult = (SearchResult) results.next();
		Attributes attributes = searchResult.getAttributes();

		Attribute attrDescription = attributes.get("description");
        appTitle = (String) attrDescription.get();

        Attribute attrMember = attributes.get("member");
        if (attrMember!=null) {
        	NamingEnumeration users = attrMember.getAll();
            while (users != null && users.hasMoreElements()) {
            	String member = (String) users.next();
            	userList.add(member);
            }
        }
    }
}
catch (NamingException e) {
	e.printStackTrace();
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%= appTitle %> - Usuarios con permiso de lectura</title>
</head>

<body>
<h1><%= appTitle %></h1>
<h2>Usuarios con permiso de lectura: </h2>
<ol>

<%
String fullName;
ListIterator<String> li = userList.listIterator();   
while( li.hasNext() ) {   
	String name = (String) li.next();
	fullName = name.substring(3, name.indexOf(',',3)); 
%>

<li><%= fullName %></li>

<% 
} 
%>

</ol>
</body>
</html>
