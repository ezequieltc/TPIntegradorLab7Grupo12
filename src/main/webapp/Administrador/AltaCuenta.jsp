<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BancArg - Alta de Cuenta</title>
<link rel="stylesheet" type="text/css" href="../css/layout.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
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
					<form action="${pageContext.request.contextPath}/ServletCuentas" method="POST">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="dniUsuario">DNI Usuario</label> <input type="number"
										id="dniUsuario" class="form-control"
										placeholder="Ingrese el DNI del usuario">
								</div>
								<div class="form-group">
									<label for="tipoCuenta">Tipo de Cuenta</label> <select
										id="tipoCuenta" class="form-control">
										<option value="cajaAhorro">Caja de Ahorro</option>
										<option value="cuentaCorriente">Cuenta Corriente</option>
									</select>
								</div>
								<div class="form-group">
									<label for="fechaAltaCuenta">Fecha de Alta</label> <input
										type="date" id="fechaAltaCuenta" class="form-control">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="numeroCuenta">Número de cuenta</label> <input
										type="number" id="numeroCuenta" class="form-control"
										placeholder="Número de cuenta">
								</div>
								<div class="form-group">
									<label for="cbu">CBU</label> <input type="number" id="cbu"
										class="form-control" placeholder="CBU">
								</div>
								<div class="form-group">
									<label for="saldo">Saldo Inicial</label> <input type="number"
										id="saldo" class="form-control" placeholder="$0" step="0.01"
										min="0">
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

	<footer class="footer">
		<p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
	</footer>
</body>
</html>
