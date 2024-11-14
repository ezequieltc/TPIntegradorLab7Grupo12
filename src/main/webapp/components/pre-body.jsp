<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- Validación Sesión -->
<% HttpSession misession = request.getSession();
    String usuario = (String) request.getSession().getAttribute("usuario");
    
    if(usuario==null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
    }
    
    String[] sidebarNames = (String[]) session.getAttribute("sidebarNames");
    String[] sidebarLinks = (String[]) session.getAttribute("sidebarLinks");
   
%> 
<body>
<nav class="navbar">
  <a class="navbar-brand" href="#">BancArg</a>
  <div class="justify-content-end">
    <ul class="navbar-nav">
	<div class="header-user">
    	<div>Usuario: <%=usuario %></div>
    	<a class="logout-button" href="${pageContext.request.contextPath}/SvLogout">    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="icon-logout">
        <path d="M10 3H7a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h3a1 1 0 1 0 0-2H7V5h3a1 1 0 1 0 0-2zm10.707 10.707a1 1 0 0 0 0-1.414l-4-4a1 1 0 0 0-1.414 1.414L17.586 11H9a1 1 0 1 0 0 2h8.586l-2.293 2.293a1 1 0 0 0 1.414 1.414l4-4z"/></svg>
    	Cerrar sesión</a>
    </div>
    </ul>
  </div>
</nav>

<div class="d-flex">
  <div class="sidebar">
  	<ul class="nav flex-column">
        <% 
            if (sidebarNames != null && sidebarLinks != null) {
                for (int i = 0; i < sidebarNames.length; i++) { 
        %>
            <li class="nav-item">
                <a class="nav-link" href="<%= sidebarLinks[i] %>"><%= sidebarNames[i] %></a>
            </li>
        <% 
                } 
            }
        %>
    </ul>
  </div>
 
  
  <div class="content-container">
