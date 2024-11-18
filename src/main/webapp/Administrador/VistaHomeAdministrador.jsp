<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="servicios.auth.UserTypes" %>

<!DOCTYPE html>
<html>
  <%
    request.setAttribute("pageTitle", "AdminPanel");
  	request.setAttribute("rolPermitido", UserTypes.ADMIN);
  %>
<head>
  <%@include  file="../components/header.jsp"%>
  
</head>
<body>
  <%@include  file="../components/pre-body.jsp"%>
  
  <h3 class="text-center">Usted es un usuario Administrador</h3>
      
  <%@include  file="../components/post-body.jsp"%>
  
</body>
  
</html>
