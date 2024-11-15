<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<%

	String mensajeExito = (String) session.getAttribute("mensajeExito");
	String mensajeError = (String) session.getAttribute("mensajeError"); 
	Boolean mostrarPopUp = (Boolean) session.getAttribute("mostrarPopUp");
	String popUpStatus = (String) session.getAttribute("popUpStatus");
	
	// Limpiar los atributos de la sesión para que no se muestren después de un refresh
	session.removeAttribute("mensajeExito");
	session.removeAttribute("mensajeError");
	session.removeAttribute("mostrarPopUp");
	session.removeAttribute("popUpStatus");
%>

<head>
<%@include file="../../components/header.jsp"%>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
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
<body>
	<%@include file="../../components/pre-body.jsp"%>
			<h2 class="my-4">Alta de Cuenta</h2>
			<div id="registrationForm" class="w-100">
				<div class="step">
					<h4>Información de la Cuenta</h4>
					<form class="needs-validation" action="${pageContext.request.contextPath}/ServletCuentas" method="POST" novalidate>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="dniUsuario">DNI Usuario</label> 
									<input type="text" id="dniUsuario" class="form-control" name="dniUsuario" placeholder="Ingrese el DNI del usuario" maxlength="8" pattern="\d{8}" title="Debe contener exactamente 8 dígitos numéricos." required>
								</div>
								<div class="form-group">
									<label for="tipoCuenta">Tipo de Cuenta</label> 
									<select id="tipoCuenta" class="form-control" name="tipoCuenta">
										<option value="caja de ahorro">Caja de Ahorro</option>
										<option value="cuenta corriente">Cuenta Corriente</option>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="fechaAltaCuenta">Fecha de Alta</label> 
									<input type="date" id="fechaAltaCuenta" name="fechaAltaCuenta" class="form-control" required>
								</div>
								<div class="form-group">
									<label for="saldo">Saldo Inicial</label> 
									<div class="input-group mb-3">
										<span class="input-group-text">$</span>
										<input type="number" id="saldo" name="saldo" class="form-control" placeholder="$0" value="10000" step="100" min="0">
									</div>
								</div>
							</div>
						</div>
						<div class="step-actions">
							<button type="submit" class="btn btn-success" name="crearCuenta" id="crearCuenta" >Crear Cuenta</button>
						</div>
					</form>
				</div>
			</div>

	<!-- Modales de éxito y error -->
	<div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content success">
				<div class="modal-header success">
					<h5 class="modal-title">Éxito</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<%= mensajeExito != null ? mensajeExito : "¡Cuenta creada exitosamente!" %>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content error">
				<div class="modal-header error">
					<h5 class="modal-title">Error</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<%= mensajeError != null ? mensajeError : "Hubo un error al crear la cuenta. Por favor, inténtelo nuevamente." %>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="../../components/post-body.jsp"%>

<script>
// Script para mostrar modales de éxito o error
$(document).ready(function(){
       <% if (mostrarPopUp != null && "success".equals(popUpStatus)) { %>
           var successModal = new bootstrap.Modal(document.getElementById('successModal'));
           successModal.show();
       <% } else if (mostrarPopUp != null && "error".equals(popUpStatus)) { %>
           var errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
           errorModal.show();
       <% } %>
   });

// Validación de formulario
(function () {
	  'use strict'
	  var forms = document.querySelectorAll('.needs-validation')
	  Array.prototype.slice.call(forms).forEach(function (form) {
	      form.addEventListener('submit', function (event) {
	        if (!form.checkValidity()) {
	          event.preventDefault()
	          event.stopPropagation()
	        }
	        form.classList.add('was-validated')
	      }, false)
	  })
})()
</script>
<footer class="footer">
	<p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
</footer>
</body>
</html>
