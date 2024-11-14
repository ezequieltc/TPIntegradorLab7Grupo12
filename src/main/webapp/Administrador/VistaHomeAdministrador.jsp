<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "AdminPanel");
%>
  <jsp:include page="../components/header.jsp"/>
  <jsp:include page="../components/pre-body.jsp"/>
  
  
      <h3 class="text-center">Usted es un usuario Administrador</h3>
      
  <jsp:include page="../components/post-body.jsp"/>
  
</html>
