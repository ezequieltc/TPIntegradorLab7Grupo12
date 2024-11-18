<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dominio.Persona" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
  <%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Modificar Usuario");
  %>
<head>
<%@include  file="../../components/header.jsp"%>
</head>
<body>
<%@include  file="../../components/pre-body.jsp"%>
    <h2 class="my-4">Modificar Usuario</h2>
    <div id="modificationForm" class="w-100">
      <div class="step step-1">
        <h4>Información Personal</h4>
        <form action="${pageContext.request.contextPath}/Administrador/Usuarios/ServletModificarUsuario" method="post">
        <input type="hidden" name="id" value="${persona.getId()}">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="dni">DNI</label>
                <input type="text" name="dni" class="form-control" readonly value="${persona.getDni()}">
              </div>
              <div class="form-group">
                <label for="cuil">Cuil</label>
                <input type="text" name="cuil" class="form-control"readonly value="${persona.getCuil()}">
              </div>
              <div class="form-group">
                <label for="nombre">Nombre</label>
                <input type="text" name="nombre" class="form-control" readonly value="${persona.getNombre()}">
              </div>
              <div class="form-group">
                <label for="apellido">Apellido</label>
                <input type="text" name="apellido" class="form-control"readonly value="${persona.getApellido()}">
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
              
                <label for="sexo">Sexo</label>
				<select name="sexo" class="form-control">
    				<option value="1" <%= (persona.getTipoSexo().getId() == 1) ? "selected" : "" %>>Masculino</option>
    				<option value="2" <%= (persona.getTipoSexo().getId() == 2) ? "selected" : "" %>>Femenino</option>
    				<option value="3" <%= (persona.getTipoSexo().getId() == 3) ? "selected" : "" %>>Otro</option>
				</select>
              </div>
              <div class="form-group">
                <label for="nacionalidad">Nacionalidad</label>
                <input type="text" name="nacionalidad" class="form-control" readonly value="${persona.getNacionalidad()}">
              </div>
              <div class="form-group">
                <label for="fechaNacimiento">Fecha de Nacimiento</label>
                <input type="date" name="fechaNacimiento" class="form-control" readonly value="${persona.getFechaNacimiento()}">
              </div>
            </div>
          </div>

          
    <div id="registrationForm" class="w-100">
      <div class="step step-1">
        <h4>Información de Contacto</h4>
        
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="direccion">Dirección</label>
                <input type="text" name="direccion" class="form-control" value="${persona.getDireccion()}">
              </div>
              <div class="form-group">
                <label for="localidad">Localidad</label>
                <input type="text" name="localidad" class="form-control" value="${persona.getLocalidad()}">
              </div>
              <div class="form-group">
                <label for="provincia">Provincia</label>
                <input type="text" name="provincia" class="form-control" value="${persona.getProvincia()}">
              </div>

            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="text" name="email" class="form-control" value="${persona.getEmail()}">
              </div>
              <div class="form-group">
                <label for="telefono">Teléfono</label>
                <input type="text" name="telefono" class="form-control" value="${persona.getTelefono()}">
              </div>
            </div>
          </div>
          <div class="step-actions" style="margin-top: 10px">
            <button type="submit" class="btn btn-success" name="btnConfirmarModificacionUsuario">Guardar Cambios</button>
            <a href="${pageContext.request.contextPath}/Administrador/Usuarios/ServletUsuarios" class="btn btn-danger">Cancelar</a>
          </div>
        
      </div>
      </div>
      </form>
      <%@include  file="../../components/post-body.jsp"%>
</body>
</html>