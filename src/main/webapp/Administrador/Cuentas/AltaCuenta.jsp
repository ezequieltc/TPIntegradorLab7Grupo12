<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="java.util.ArrayList"%>
<%@page import="Dominio.TipoCuenta"%>
<!DOCTYPE html>
<html lang="es">

<head>
<% request.setAttribute("rolPermitido", UserTypes.ADMIN); %>
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
					<form class="needs-validation" action="${pageContext.request.contextPath}/Administrador/Cuentas/ServletAgregarCuenta" method="POST" novalidate>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="dniUsuario">DNI Usuario</label> 
									<input type="text" id="dniUsuario" class="form-control" name="dniUsuario" placeholder="Ingrese el DNI del usuario" maxlength="8" pattern="\d{8}" title="Debe contener exactamente 8 dígitos numéricos." required>
								</div>
								<div class="form-group">
									<label for="tipoCuenta">Tipo de Cuenta</label> 
									<select id="tipoCuenta" class="form-control" name="tipoCuenta">
										<% List<TipoCuenta> tiposCuenta = (List<TipoCuenta>) request.getAttribute("tiposCuentas"); 
											if (tiposCuenta != null) {
								                for (TipoCuenta tipoCuenta : tiposCuenta) {
								        %>
								                    <option value="<%= tipoCuenta.getId() %>"><%= tipoCuenta.getDescripcion() %></option>
								        <%
								                }
								            }
								        %>
									</select>
								</div>
							</div>
						</div>
						<div>
							<button type="submit" class="btn btn-success" name="crearCuenta" id="crearCuenta" >Crear Cuenta</button>
						</div>
					</form>
				</div>
			</div>

	<%@include file="../../components/post-body.jsp"%>

<script>

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
