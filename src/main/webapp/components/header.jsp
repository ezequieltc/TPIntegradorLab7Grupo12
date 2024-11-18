<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dominio.Persona,tipos.UserTypes" %>
<%
	Persona personaAuth = (Persona) request.getSession().getAttribute("persona");
    boolean isAdmin = (boolean) request.getSession().getAttribute("isAdmin");
    UserTypes rolPermitido = (UserTypes) request.getAttribute("rolPermitido");
    if(personaAuth==null || (rolPermitido ==  UserTypes.ADMIN && !isAdmin)) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }	
%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>
    BancArg
    <%= request.getAttribute("pageTitle") != null ? " - " + request.getAttribute("pageTitle") : "" %>
</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css" />
