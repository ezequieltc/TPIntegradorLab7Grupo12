<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Dominio.Cuenta" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BancArg - Perfil de Usuario</title>
<link rel="stylesheet" type="text/css" href="../../css/layout.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<%@include  file="../../components/header.jsp"%>

<style>
.step {
	padding: 40px;
	background-color: #ffffff;
	border-radius: 5px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	width: 100%;
	min-height: 500px;
	overflow-y: auto;
	position: relative;
}

.step .form-group, .step .beneficiary-details {
	margin-bottom: 20px;
}

.step .step-actions {
	position: absolute;
	bottom: 20px;
	right: 20px;
}

.transferForm {
	height: calc(100% - 100px);
}
</style>
</head>

<%
	Persona logueado = (Persona) request.getSession().getAttribute("persona");
%>
<body>

<%@include  file="../../components/pre-body.jsp"%>

    <h2 class="my-4">Información del usuario</h2>
    <div id="registrationForm" class="w-100">
      <div class="step">
        <h4>Información Personal</h4>
        <form>
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="dniPreferencias">DNI</label>
                <input type="text" id="dniPreferencias" class="form-control" value="${persona.getDni() }" readonly>
              </div>
              <div class="form-group">
                <label for="cuilPreferencias">CUIL</label>
                <input type="text" id="cuilPreferencias" class="form-control" value="${persona.getCuil() }" readonly>
              </div>
              <div class="form-group">
                <label for="nombrePreferencias">Nombre</label>
                <input type="text" id="nombrePreferencias" class="form-control" value="${persona.getNombre() }" readonly>
              </div>
              <div class="form-group">
                <label for="apellidoPreferencias">Apellido</label>
                <input type="text" id="apellidoPreferencias" class="form-control" value="${persona.getApellido() }" readonly>
              </div>
              <div class="form-group">
                <label for="fechaNacimientoPreferencias">Fecha de Nacimiento</label>
                <input type="date" id="fechaNacimientoPreferencias" class="form-control" value="${persona.getFechaNacimiento() }" readonly>
              </div>
              <div class="form-group">
                  <label for="correoPreferencias">Correo Electrónico</label>
                  <input type="email" id="correoPreferencias" class="form-control" value="${persona.getEmail() }" readonly>
                </div>
            </div>
            <div class="col-md-6">
            	<div class="form-group">
                  <label for="telefonoPreferencias">Teléfono</label>
                  <input type="tel" id="telefonoPreferencias" class="form-control" value="${persona.getTelefono() }" readonly>
                </div>
              <div class="form-group">
                <label for="sexoPreferencias">Sexo</label>
                <input type="text" id="sexoPreferencias" class="form-control" value="${persona.getTipoSexo().getDescripcion().toString() }" readonly>
              </div>
              <div class="form-group">
                <label for="nacionalidadPreferencias">Nacionalidad</label>
                <input type="text" id="nacionalidadPreferencias" class="form-control" value="${persona.getNacionalidad() }" readonly>
              </div>
              <div class="form-group">
                  <label for="direccionPreferencias">Dirección</label>
                  <input type="text" id="direccionPreferencias" class="form-control" value="${persona.getDireccion() }" readonly>
                </div>
                <div class="form-group">
                  <label for="localidadPreferencias">Localidad</label>
                  <input type="text" id="localidadPreferencias" class="form-control" value="${persona.getLocalidad() }" readonly>
                </div>
                <div class="form-group">
                  <label for="provinciaPreferencias">Provincia</label>
                  <input type="text" id="provinciaPreferencias" class="form-control" value="${persona.getProvincia() }" readonly>
                </div>
              </div>
            </div>
          </div>   
        </form>
      </div>

	<h2 class="my-4">Información de Cuentas</h2>
    <div id="registrationForm" class="w-100">
      <div class="step">
     	<table class="table table-bordered table-hover">
        <thead>
          <tr>
            <th>Tipo de Cuenta</th>
            <th>Nro de Cuenta</th>
            <th>CBU</th>
            <th>Fecha de Alta</th>
            <th>Saldo</th>
          </tr>
        </thead>
        <tbody>
  <% 
    List<Cuenta> cuentas = (List<Cuenta>) request.getAttribute("cuentas");
    if (cuentas != null) {
      for (Cuenta cuenta : cuentas) { 
  %>	
  		<tr>
          <td><%= cuenta.getTipoCuenta().getDescripcion() %></td>
          <td><%= cuenta.getNumeroCuenta() %></td>
          <td><%= cuenta.getCbu() %></td>
          <td><%= cuenta.getFechaCreacion() %>
          <td><%= cuenta.getSaldo() %></td>
        </tr>
  <% 
      }
    }
  %>
</tbody>
        </table>
     </div>
	</div>
<%@include  file="../../components/post-body.jsp"%>
              
</body>
</html>