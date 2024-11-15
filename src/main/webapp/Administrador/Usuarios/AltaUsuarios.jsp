<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
  <%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Alta Usuarios");
  %>
<head>
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

      .step .form-group,
      .step .beneficiary-details {
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
<body>
<%@include  file="../../components/pre-body.jsp"%>
    <h2 class="my-4">Alta de Usuario</h2>
    <div id="registrationForm" class="w-100">
      <!-- Paso 1: Información Personal -->
      <div class="step step-1">
        <h4>Paso 1: Información Personal</h4>
        <form>
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="dni">DNI</label>
                <input type="text" id="dni" class="form-control" placeholder="Ingrese su DNI">
              </div>
              <div class="form-group">
                <label for="cuil">CUIL</label>
                <input type="text" id="cuil" class="form-control" placeholder="Ingrese su CUIL">
              </div>
              <div class="form-group">
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" class="form-control" placeholder="Ingrese su nombre">
              </div>
              <div class="form-group">
                <label for="apellido">Apellido</label>
                <input type="text" id="apellido" class="form-control" placeholder="Ingrese su apellido">
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
                <input type="text" id="nacionalidad" class="form-control" placeholder="Ingrese su nacionalidad">
              </div>
              <div class="form-group">
                <label for="fechaNacimiento">Fecha de Nacimiento</label>
                <input type="date" id="fechaNacimiento" class="form-control">
              </div>
            </div>
          </div>
          <div class="step-actions">
            <button type="button" class="btn btn-primary" id="nextStep1">Siguiente</button>
          </div>
        </form>
      </div>

      <!-- Paso 2: Información de Contacto -->
      <div class="step step-2 d-none">
          <h4>Paso 2: Información de Contacto</h4>
          <form>
            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                  <label for="direccion">Dirección</label>
                  <input type="text" id="direccion" class="form-control" placeholder="Ingrese su dirección">
                </div>
                <div class="form-group">
                  <label for="localidad">Localidad</label>
                  <input type="text" id="localidad" class="form-control" placeholder="Ingrese su localidad">
                </div>
                <div class="form-group">
                  <label for="provincia">Provincia</label>
                  <input type="text" id="provincia" class="form-control" placeholder="Ingrese su provincia">
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label for="correo">Correo Electrónico</label>
                  <input type="email" id="correo" class="form-control" placeholder="Ingrese su correo electrónico">
                </div>
                <div class="form-group">
                  <label for="telefono">Teléfono</label>
                  <input type="tel" id="telefono" class="form-control" placeholder="Ingrese su teléfono">
                </div>
              </div>
            </div>
            <div class="step-actions">
              <button type="button" class="btn btn-secondary" id="prevStep2">Anterior</button>
              <button type="button" class="btn btn-primary" id="nextStep2">Siguiente</button>
            </div>
          </form>
        </div>

      <!-- Paso 3: Información de Cuenta -->
      <div class="step step-3 d-none">
        <h4>Paso 3: Información de Cuenta</h4>
        <form>
          <div class="form-group">
            <label for="usuario">Usuario</label>
            <input type="text" id="usuario" class="form-control" placeholder="Ingrese un nombre de usuario">
          </div>
          <div class="form-group">
            <label for="contrasena">Contraseña</label>
            <input type="password" id="contrasena" class="form-control" placeholder="Ingrese una contraseña">
          </div>
          <div class="step-actions">
            <button type="button" class="btn btn-secondary" id="prevStep3">Anterior</button>
            <button type="submit" class="btn btn-success" id="confirmRegistration">Registrar Usuario</button>
          </div>
        </form>
      </div>
    </div>



<%@include  file="../../components/post-body.jsp"%>
<script>
  document.getElementById('nextStep1').addEventListener('click', function() {
    document.querySelector('.step-1').classList.add('d-none');
    document.querySelector('.step-2').classList.remove('d-none');
  });

  document.getElementById('prevStep2').addEventListener('click', function() {
    document.querySelector('.step-2').classList.add('d-none');
    document.querySelector('.step-1').classList.remove('d-none');
  });

  document.getElementById('nextStep2').addEventListener('click', function() {
    document.querySelector('.step-2').classList.add('d-none');
    document.querySelector('.step-3').classList.remove('d-none');
  });

  document.getElementById('prevStep3').addEventListener('click', function() {
    document.querySelector('.step-3').classList.add('d-none');
    document.querySelector('.step-2').classList.remove('d-none');
  });
</script>
</body>
</html>
