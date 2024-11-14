<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dominio.Persona" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BancArg - Modificar Usuario</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layout.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="#">BancArg</a>
    <div class="collapse navbar-collapse justify-content-end">
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="#">Usuario: Administrador</a></li>
        </ul>
    </div>
</nav>

<div class="d-flex">
    <div class="sidebar">
        <a href="#">Inicio</a> 
        <a href="#">Cuentas</a> 
        <a href="${pageContext.request.contextPath}/ServletUsuarios">Usuarios</a>
        <a href="#">Transferencias</a>
        <a href="#">Préstamos</a> 
        <a href="#">Ajustes</a>
    </div>

<%
    Persona persona = (Persona) request.getAttribute("persona");
    if (persona != null) {
        System.out.println("Persona cargada correctamente: " + persona.getDni());
    } else {
        System.out.println("Persona es null");
    }
%>
<div class="content-container">
    <h2 class="my-4">Modificar Usuario</h2>
    <div id="modificationForm" class="w-100">
      <div class="step step-1">
        <h4>Información Personal</h4>
        <form action="ServletModificarUsuario" method="get">
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
                  <option value="masculino">Masculino</option>
                  <option value="femenino">Femenino</option>
                  <option value="otro">Otro</option>
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

          
   <div class="content-container">
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
            <a href="${pageContext.request.contextPath}/ServletUsuarios" class="btn btn-danger">Cancelar</a>
          </div>
        
      </div>
      </div>
      </div>
      </form>
</body>
</html>