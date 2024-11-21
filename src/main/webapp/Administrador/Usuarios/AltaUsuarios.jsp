<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dominio.TipoSexo" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="es">
  <%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Alta Usuarios");
    ArrayList<TipoSexo> tipoSexos = (ArrayList<TipoSexo>) request.getSession().getAttribute("tipoSexos");
    if (tipoSexos == null) {
      tipoSexos = new ArrayList<>();
    }
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
      .error-message {
        color: red;
        font-size: 0.9em;
        margin-top: 5px;
        display: none;
      }

      input.invalid, select.invalid {
        border-color: red;
      }

      .d-none {
        display: none;
      }

      .d-block {
        display: block;
      }

  </style>
</head>
<body>
<%@include  file="../../components/pre-body.jsp"%>
    <h2 class="my-4">Alta de Usuario</h2>
    <div id="registrationForm" class="w-100">
      <form action="${pageContext.request.contextPath}/Administrador/Usuarios/ServletAgregarUsuario" method="post">
        <!-- Paso 1: Información Personal -->
        <div class="step step-1">
          <h4>Paso 1: Información Personal</h4>
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="dni">DNI</label>
                <input type="text" required value="${dni != null ? dni : ''}" id="dni" name="dni" class="form-control" placeholder="Ingrese su DNI">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
              <div class="form-group">
                <label for="cuil">CUIL</label>
                <input type="text" required value="${cuil != null ? cuil : ''}" id="cuil" name="cuil" class="form-control" placeholder="Ingrese su CUIL">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
              <div class="form-group">
                <label for="nombre">Nombre</label>
                <input type="text" value="${nombre != null ? nombre : ''}" required id="nombre" name="nombre" class="form-control" placeholder="Ingrese su nombre">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
              <div class="form-group">
                <label for="apellido">Apellido</label>
                <input type="text" value="${apellido != null ? apellido : ''}" required id="apellido" name="apellido" class="form-control" placeholder="Ingrese su apellido">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="sexo">Sexo</label>
                <select id="sexo" required name="sexo" class="form-control">
                  <% if (tipoSexos != null) {
                  for (TipoSexo tipoSexo : tipoSexos) { %>
                    <option value="<%= tipoSexo.getId() %>" ${requestScope.sexo != null && tipoSexo.getId() == requestScope.sexo ? 'selected' : ''}><%= tipoSexo.getDescripcion() %></option>         	              	  
                  <% }} %>
                </select>
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
              <div class="form-group">
                <label for="nacionalidad">Nacionalidad</label>
                <input type="text" value="${nacionalidad != null ? nacionalidad : ''}" required id="nacionalidad" name="nacionalidad" class="form-control" placeholder="Ingrese su nacionalidad">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
              <div class="form-group">
                <label for="fechaNacimiento">Fecha de Nacimiento</label>
                <input type="date" value="${fechaNacimiento != null ? fechaNacimiento : ''}" required id="fechaNacimiento" name="fechaNacimiento" class="form-control">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
            </div>
          </div>
          <div class="step-actions">
            <button type="button" class="btn btn-primary" id="nextStep1">Siguiente</button>
          </div>
        </div>
 
        <!-- Paso 2: Información de Contacto -->
        <div class="step step-2 d-none">
          <h4>Paso 2: Información de Contacto</h4>
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="direccion">Dirección</label>
                <input type="text"  value="${direccion != null ? direccion : ''}" required id="direccion" name="direccion" class="form-control" placeholder="Ingrese su dirección">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
              <div class="form-group">
                <label for="localidad">Localidad</label>
                <input type="text" value="${localidad != null ? localidad : ''}" required id="localidad" name="localidad" class="form-control" placeholder="Ingrese su localidad">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
              <div class="form-group">
                <label for="provincia">Provincia</label>
                <input type="text" value="${provincia != null ? provincia : ''}" required id="provincia" name="provincia" class="form-control" placeholder="Ingrese su provincia">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="correo">Correo Electrónico</label>
                <input type="email" value="${correo != null ? correo : ''}" required id="correo" name="correo" class="form-control" placeholder="Ingrese su correo electrónico">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
              <div class="form-group">
                <label for="telefono">Teléfono</label>
                <input type="tel" value="${telefono != null ? telefono : ''}" required id="telefono" name="telefono" class="form-control" placeholder="Ingrese su teléfono">
                <span class="error-message">Este campo es obligatorio.</span>
              </div>
            </div>
          </div>
          <div class="step-actions">
            <button type="button" class="btn btn-secondary" id="prevStep2">Anterior</button>
            <button type="button" class="btn btn-primary" id="nextStep2">Siguiente</button>
          </div>
        </div>
 
        <!-- Paso 3: Información de Cuenta -->
        <div class="step step-3 d-none">
          <h4>Paso 3: Información de Cuenta</h4>
          <div class="form-group">
            <label for="usuario">Usuario</label>
            <input type="text" value="${usuario != null ? usuario : ''}" required id="usuario" name="usuario" class="form-control" placeholder="Ingrese un nombre de usuario">
            <span class="error-message">Este campo es obligatorio.</span>
          </div>
          <div class="form-group">
            <label for="contrasena">Contraseña</label>
            <input type="password" value="${contrasena != null ? contrasena : ''}" required id="contrasena" name="contrasena" class="form-control" placeholder="Ingrese una contraseña">
            <span class="error-message">Este campo es obligatorio.</span>
          </div>
          <div class="form-group">
            <label for="confirmarContrasena">Confirmar contraseña</label>
            <input type="password" value="${confirmarContrasena != null ? confirmarContrasena : ''}" required id="confirmarContrasena" name="confirmarContrasena" class="form-control" placeholder="Ingrese una contraseña">
            <span class="error-message">Este campo es obligatorio.</span>
          </div>
          <div class="step-actions">
            <button type="button" class="btn btn-secondary" id="prevStep3">Anterior</button>
            <button type="submit" name="btnConfirmarAgregarUsuario" class="btn btn-success">Registrar Usuario</button>
          </div>
        </div>
      </form>
    </div>



<%@include  file="../../components/post-body.jsp"%>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const steps = document.querySelectorAll(".step");
    const nextButtons = document.querySelectorAll("[id^='nextStep']");
    const prevButtons = document.querySelectorAll("[id^='prevStep']");
    const submitButton = document.querySelector("[name='btnConfirmarAgregarUsuario']");
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Expresión regular para validar correo electrónico
    const dniRegex = /^\d{1,15}$/; // Hasta 15 números
    const cuilRegex = /^\d{1,15}$/; // Hasta 15 números
    const telefonoRegex = /^[\d+()-]+$/; // Solo números, +, -, y paréntesis

    function calcularEdad(fechaNacimiento) {
      const hoy = new Date();
      const nacimiento = new Date(fechaNacimiento);
      const edad = hoy.getFullYear() - nacimiento.getFullYear();
      const diferenciaMeses = hoy.getMonth() - nacimiento.getMonth();
      if (diferenciaMeses < 0 || (diferenciaMeses === 0 && hoy.getDate() < nacimiento.getDate())) {
        return edad - 1;
      }
      return edad;
    }

    function validarCampos(stepIndex) {
      const currentStep = steps[stepIndex];
      const inputs = currentStep.querySelectorAll("input, select");
      let isValid = true;

      // Validar todos los inputs en el paso actual
      inputs.forEach((input) => {
        const errorElement = input.nextElementSibling;
        let errorMessage = ""; // Variable para mensaje de error

        if (input.hasAttribute("required") && !input.value.trim()) {
          errorMessage = "Este campo es obligatorio.";
          isValid = false;
        } else if (input.id === "dni" && !dniRegex.test(input.value)) {
          errorMessage = "DNI debe contener solo números y no más de 15 dígitos.";
          isValid = false;
        } else if (input.id === "cuil" && !cuilRegex.test(input.value)) {
          errorMessage = "CUIL debe contener solo números y no más de 15 dígitos.";
          isValid = false;
        } else if (input.id === "nombre" && input.value.length > 50) {
          errorMessage = "El nombre no puede tener más de 50 caracteres.";
          isValid = false;
        } else if (input.id === "apellido" && input.value.length > 50) {
          errorMessage = "El apellido no puede tener más de 50 caracteres.";
          isValid = false;
        } else if (input.id === "nacionalidad" && input.value.length > 20) {
          errorMessage = "La nacionalidad no puede tener más de 20 caracteres.";
          isValid = false;
        } else if (input.id === "fechaNacimiento") {
          const edad = calcularEdad(input.value);
          if (edad < 18 || edad > 200) {
            errorMessage = "La fecha de nacimiento debe indicar una edad entre 18 y 200 años.";
            isValid = false;
          }
        } else if (input.id === "correo" && !emailRegex.test(input.value)) {
          errorMessage = "Por favor, ingrese un correo electrónico válido.";
          isValid = false;
        } else if (input.id === "telefono" && !telefonoRegex.test(input.value)) {
          errorMessage = "El teléfono solo puede contener números, '+', '-', y paréntesis.";
          isValid = false;
        } else if (input.id === "contrasena" || input.id === "confirmarContrasena") {
          const contrasena = document.getElementById("contrasena").value;
          const confirmarContrasena = document.getElementById("confirmarContrasena").value;
          if (contrasena !== confirmarContrasena) {
            errorMessage = "Las contraseñas no coinciden.";
            isValid = false;
          }
        }

        // Mostrar mensaje de error
        if (!isValid) {
          input.classList.add("invalid");
          if (errorElement) {
            errorElement.textContent = errorMessage;
            errorElement.style.display = "block";
          }
        } else {
          input.classList.remove("invalid");
          if (errorElement) errorElement.style.display = "none";
        }
      });

      return isValid;
    }

    nextButtons.forEach((btn, index) => {
      btn.addEventListener("click", function () {
        const isValid = validarCampos(index);

        // Si es válido, pasar al siguiente paso
        if (isValid && index < steps.length - 1) {
          steps[index].classList.add("d-none");
          steps[index + 1].classList.remove("d-none");
        }
      });
    });

    prevButtons.forEach((btn, index) => {
      btn.addEventListener("click", function () {
        steps[index + 1].classList.add("d-none");
        steps[index].classList.remove("d-none");
      });
    });

    // Validación en el botón de submit
    submitButton.addEventListener("click", function (event) {
      let isValid = true;

      // Validar todos los pasos
      steps.forEach((step, index) => {
        if (!validarCampos(index)) {
          isValid = false;

          // Mostrar el primer paso inválido
          if (step.classList.contains("d-none")) {
            step.classList.remove("d-none");
          }
        }
      });

      // Si no es válido, evitar el envío del formulario
      if (!isValid) {
        event.preventDefault();
        alert("Por favor, corrija los errores antes de enviar el formulario.");
      }
    });
  });
</script>
</body>
</html>
 