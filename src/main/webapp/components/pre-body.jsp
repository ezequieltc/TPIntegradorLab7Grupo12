<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Presentacion.Auth.MenuItem, Dominio.Persona" %>


<%
    List<MenuItem> sidebarMenu = (List<MenuItem>) session.getAttribute("sidebarMenu");
	Persona persona = (Persona) request.getSession().getAttribute("persona");
%>

<nav class="navbar">
  <a class="navbar-brand" href="#">BancArg</a>
  <div class="justify-content-end">
    <ul class="navbar-nav">
	<div class="header-user">
	<%if(persona.getUsuario().getTipoUsuario().getId() != 1){ %>
		<a href="../Usuario/Perfil/index.jsp" class="linkPerfil">Usuario: <%= persona.getNombreApellido() %></a>
	<% } else { %>
		<div>Usuario: <%= persona.getNombreApellido() %></div>
	<% } %>
		
<!--		<a href="../Usuario/Perfil/index.jsp" class="linkPerfil">Usuario: <%= persona.getNombreApellido() %></a>-->
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
	        <% if (sidebarMenu != null) { 
	            for (MenuItem item : sidebarMenu) { 
	        %>
	            <li class="nav-item">
	                <% if (item.hasSubMenu()) { %>
	                    <!-- Enlace con dropdown -->
	                    <a class="nav-link dropdown-toggle" href="javascript:void(0)" onclick="toggleSubMenu(this)">
	                        <%= item.getName() %>
	                    </a>
	                    <ul class="nav flex-column sub-menu">
	                        <% for (MenuItem subItem : item.getSubMenu()) { %>
	                            <li class="nav-item">
	                                <a class="nav-link" href="<%= subItem.getLink() %>"><%= subItem.getName() %></a>
	                            </li>
	                        <% } %>
	                    </ul>
	                <% } else { %>
	                    <!-- Enlace sin submenú -->
	                    <a class="nav-link" href="<%= item.getLink() %>"><%= item.getName() %></a>
	                <% } %>
	            </li>
	        <% } } %>
	    </ul>
	</div>
    <div class="content-container">


<script>
function toggleSubMenu(element) {
    const subMenu = element.nextElementSibling;
    const arrow = element.querySelector('.arrow');

    if (subMenu) {
        subMenu.style.display = subMenu.style.display === 'block' ? 'none' : 'block';
        arrow.classList.toggle('active');
    }
}
</script>

<style>
.linkPerfil{
	color: white;
	text-decoration: none;
}
</style>

