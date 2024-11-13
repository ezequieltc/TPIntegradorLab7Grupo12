<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BancArg - Alta de Cuenta</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layout.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
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
.modal-content.success {
    background-color: #d4edda;
    border-color: #c3e6cb;
}
.modal-header.success {
    background-color: #28a745;
    color: white;
}
.modal-content.error {
    background-color: #f8d7da;
    border-color: #f5c6cb;
}
.modal-header.error {
    background-color: #dc3545;
    color: white;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

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
			<a href="#">Transferencias</a>
			<a href="#">Préstamos</a> 
			<a href="#">Ajustes</a>
		</div>

		<div class="content-container">
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
							<button type="submit" class="btn btn-success" id="crearCuenta">Crear Cuenta</button>
						</div>
					</form>
				</div>
			</div>
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
					¡Cuenta creada exitosamente!
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
					<%= request.getAttribute("mensajeError") != null ? request.getAttribute("mensajeError") : "Hubo un error al crear la cuenta. Por favor, inténtelo nuevamente." %>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>

<script>
// Script para mostrar modales de éxito o error
$(document).ready(function(){
    <% if (request.getAttribute("mostrarPopUp") != null && "success".equals(request.getAttribute("popUpStatus"))) { %>
        var successModal = new bootstrap.Modal(document.getElementById('successModal'));
        successModal.show();
    <% } else if (request.getAttribute("mostrarPopUp") != null && "error".equals(request.getAttribute("popUpStatus"))) { %>
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
