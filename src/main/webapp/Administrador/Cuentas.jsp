<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
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

/* Estilos para centrar los botones */
.button-container {
    display: flex;
    justify-content: center; /* Centra horizontalmente */
    align-items: center; /* Centra verticalmente */
    height: 100%; /* Ocupa toda la altura disponible */
    gap: 20px; /* Espacio entre los botones */
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

</head>
<body>
<%@include file="../../components/pre-body.jsp"%>
			<h2 class="my-4">Cuentas</h2>
			<div id="registrationForm" class="w-100">
				<div class="step">
					<h4>Gestión de Cuentas</h4>
					<div class="button-container mt-5">
            			<a href="./Cuentas/AltaCuenta.jsp" class="btn btn-primary">Alta Cuenta</a>
            			<a href="./Cuentas/ModificarEliminarCuentas.jsp" class="btn btn-warning">Modificar/Eliminar Cuenta</a>
            			<a href="${pageContext.request.contextPath}/Administrador/Cuentas/ServletCuentas" class="btn btn-info">Listar Cuentas</a>
        			</div>
				</div>
			</div>
	<%@include file="../../components/post-body.jsp"%>
</body>
</html>
