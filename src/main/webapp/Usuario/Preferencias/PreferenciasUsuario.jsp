<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BancArg - Preferencias de Usuario</title>
<link rel="stylesheet" type="text/css" href="../../css/layout.css" />
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
    <h2 class="my-4">Información del usuario</h2>
    <div id="registrationForm" class="w-100">
      <div class="step">
        <h4>Información Personal</h4>
        <form>
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="dniPreferencias">DNI</label>
                <input type="text" id="dniPreferencias" class="form-control">
              </div>
              <div class="form-group">
                <label for="cuilPreferencias">CUIL</label>
                <input type="text" id="cuilPreferencias" class="form-control">
              </div>
              <div class="form-group">
                <label for="nombrePreferencias">Nombre</label>
                <input type="text" id="nombrePreferencias" class="form-control" >
              </div>
              <div class="form-group">
                <label for="apellidoPreferencias">Apellido</label>
                <input type="text" id="apellidoPreferencias" class="form-control">
              </div>
              <div class="form-group">
                <label for="fechaNacimientoPreferencias">Fecha de Nacimiento</label>
                <input type="date" id="fechaNacimientoPreferencias" class="form-control">
              </div>
              <div class="form-group">
                  <label for="correoPreferencias">Correo Electrónico</label>
                  <input type="email" id="correoPreferencias" class="form-control">
                </div>
            </div>
            <div class="col-md-6">
            	<div class="form-group">
                  <label for="telefonoPreferencias">Teléfono</label>
                  <input type="tel" id="telefonoPreferencias" class="form-control">
                </div>
              <div class="form-group">
                <label for="sexoPreferencias">Sexo</label>
                <input type="text" id="sexoPreferencias" class="form-control">
              </div>
              <div class="form-group">
                <label for="nacionalidadPreferencias">Nacionalidad</label>
                <input type="text" id="nacionalidadPreferencias" class="form-control">
              </div>
              <div class="form-group">
                  <label for="direccionPreferencias">Dirección</label>
                  <input type="text" id="direccionPreferencias" class="form-control">
                </div>
                <div class="form-group">
                  <label for="localidadPreferencias">Localidad</label>
                  <input type="text" id="localidadPreferencias" class="form-control">
                </div>
                <div class="form-group">
                  <label for="provinciaPreferencias">Provincia</label>
                  <input type="text" id="provinciaPreferencias" class="form-control" >
                </div>
              </div>
            </div>
          </div>   
        </form>
      </div>

    <div class="content-container">
    <div id="registrationForm" class="w-100">
      <div class="step step-1">
        <h4>Información de Cuentas</h4>
        <form>
          <div class="row">
            <div class="col-md-4">
              <div class="form-group">
					<label for="tipoCuentaPreferencias1">Tipo de Cuenta</label> 
					<input type="text" id="tipoCuentaPreferencias1" class="form-control">
				</div>
              <div class="form-group">
					<label for="fechaAltaCuentaPreferencias1">Fecha de Alta</label> <input
						type="date" id="fechaAltaCuentaPreferencias1" class="form-control">
				</div>
				
              <div class="form-group">
					<label for="numeroCuentaPreferencias1">Número de cuenta</label> <input
						type="number" id="numeroCuentaPreferencias1" class="form-control"
						>
				</div>
				<div class="form-group">
				<div class="form-group">
					<label for="cbuCuentaPreferencias1">CBU</label> <input type="number" id="cbuCuentaPreferencias1"
						class="form-control">
				</div>
			</div>
			<div class="form-group">
					<label for="saldoCuentaPreferencias1">Saldo</label> <input type="number"
						id="saldoCuentaPreferencias1" class="form-control" placeholder="$0" step="0.01"
						min="0">
			</div>
          </div>
          <div class="col-md-4">
          	<div class="form-group">
					<label for="tipoCuentaPreferencias2">Tipo de Cuenta</label> 
					<input type="text" id="tipoCuentaPreferencias2" class="form-control">
				</div>
              <div class="form-group">
					<label for="fechaAltaCuentaPreferencias2">Fecha de Alta</label> <input
						type="date" id="fechaAltaCuentaPreferencias2" class="form-control">
				</div>
				
              <div class="form-group">
					<label for="numeroCuentaPreferencias2">Número de cuenta</label> <input
						type="number" id="numeroCuentaPreferencias2" class="form-control"
						>
				</div>
				<div class="form-group">
				<div class="form-group">
					<label for="cbuCuentaPreferencias2">CBU</label> <input type="number" id="cbuCuentaPreferencias2"
						class="form-control">
				</div>
			</div>
			<div class="form-group">
					<label for="saldoCuentaPreferencias2">Saldo</label> <input type="number"
						id="saldoCuentaPreferencias2" class="form-control" placeholder="$0" step="0.01"
						min="0">
			</div>
          </div>
          <div class="col-md-4">
          	<div class="form-group">
					<label for="tipoCuentaPreferencias3">Tipo de Cuenta</label> 
					<input type="text" id="tipoCuentaPreferencias3" class="form-control">
				</div>
              <div class="form-group">
					<label for="fechaAltaCuentaPreferencias3">Fecha de Alta</label> <input
						type="date" id="fechaAltaCuentaPreferencias3" class="form-control">
				</div>
				
              <div class="form-group">
					<label for="numeroCuentaPreferencias3">Número de cuenta</label> <input
						type="number" id="numeroCuentaPreferencias3" class="form-control"
						>
				</div>
				<div class="form-group">
				<div class="form-group">
					<label for="cbuCuentaPreferencias3">CBU</label> <input type="number" id="cbuCuentaPreferencias3"
						class="form-control">
				</div>
				<div class="form-group">
					<label for="saldoCuentaPreferencias3">Saldo</label> <input type="number"
						id="saldoCuentaPreferencias3" class="form-control" placeholder="$0" step="0.01"
						min="0">
			</div>
          </div>
        </form>
      </div>
                 
</body>
</html>