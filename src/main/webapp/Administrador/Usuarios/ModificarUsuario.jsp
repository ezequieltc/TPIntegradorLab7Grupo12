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
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="dni">DNI</label>
                <input type="text" id="dniUser" class="form-control" value="${persona.dni }" readonly>
              </div>
              <div class="form-group">
                <label for="cuil">CUIL</label>
                <input type="text" id="cuilUser" class="form-control"readonly>
              </div>
              <div class="form-group">
                <label for="nombre">Nombre</label>
                <input type="text" id="nombreUser" class="form-control" readonly>
              </div>
              <div class="form-group">
                <label for="apellido">Apellido</label>
                <input type="text" id="apellidoUser" class="form-control"readonly>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="sexo">Sexo</label>
                <select id="sexo" class="form-control">
                  <option value="masculino">Masculino</option>
                  <option value="femenino">Femenino</option>
                  <option value="otro">Otro</option>
                </select>
              </div>
              <div class="form-group">
                <label for="nacionalidad">Nacionalidad</label>
                <input type="text" id="nacionalidadUser" class="form-control" readonly>
              </div>
              <div class="form-group">
                <label for="fechaNacimiento">Fecha de Nacimiento</label>
                <input type="date" id="fechaNacimientoUser" class="form-control" readonly>
              </div>
            </div>
          </div>

          
   <div class="content-container">
    <div id="registrationForm" class="w-100">
      <div class="step step-1">
        <h4>Información de Contacto</h4>
        <form>
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="direccion">Dirección</label>
                <input type="text" id="direccionUser" class="form-control">
              </div>
              <div class="form-group">
                <label for="localidad">Localidad</label>
                <input type="text" id="localidadUser" class="form-control">
              </div>
              <div class="form-group">
                <label for="provincia">Provincia</label>
                <input type="text" id="provinciaUser" class="form-control">
              </div>

            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="text" id="emailUser" class="form-control">
              </div>
              <div class="form-group">
                <label for="telefono">Teléfono</label>
                <input type="date" id="telefonoUser" class="form-control" readonly>
              </div>
            </div>
          </div>
          <div class="step-actions" style="margin-top: 10px">
            <button type="button" class="btn btn-success" id="btnConfirmarModificacionUsuario">Guardar Cambios</button>
            <a href="${pageContext.request.contextPath}/ServletUsuarios" class="btn btn-danger">Cancelar</a>
          </div>
        </form>
      </div>
</body>
</html>