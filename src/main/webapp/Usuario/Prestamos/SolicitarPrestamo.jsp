<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>BancArg - Solicitud de Préstamos</title>
  <link rel="stylesheet" type="text/css" href="../../css/layout.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .main-content {
      flex: 1;
      padding: 2rem;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .cajaPrestamo {
      background-color: #FFFFFF;
      padding: 2rem;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      width: 100%;
      max-width: 600px;
    }
  </style>
</head>
<body>
<nav class="navbar">
  <a class="navbar-brand" href="#">BancArg</a>
  <div class="justify-content-end">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="#">Usuario: Jorge Ramos</a>
      </li>
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
	<div class="main-content">
      <div class="cajaPrestamo">
        <h2 class="text-center text-primary mb-4">Solicitar un Préstamo</h2>
        <form id="PrestamoForm">
          <div class="mb-3">
            <label for="montoPrestamo" class="form-label">Monto del Préstamo</label>
            <input type="number" class="form-control" id="montoPrestamo" placeholder="Ingrese el monto" required>
          </div>
          <div class="mb-3">
			<label for="cantCuotas" class="form-label">Cantidad de Cuotas</label>
			  <select class="form-control" id="cantCuotas" required>
			    <option value="" disabled selected>Seleccione la cantidad de cuotas</option>
			    <option value="6">6</option>
			    <option value="12">12</option>
			    <option value="24">24</option>
			    <option value="36">36</option>
			    <option value="48">48</option>
			    <option value="72">72</option>
			  </select>
          </div>
          <div class="mb-3">
            <label for="cuenta" class="form-label">Cuenta para el Depósito</label>
            <select class="form-control" id="cuenta" required>
              <option value="" disabled selected>Seleccione una cuenta</option>
              <option value="Cuenta Corriente">Cuenta 1530545 - Cuenta Corriente</option>
              <option value="Caja de Ahorro">Cuenta 1530468 - Caja de Ahorro</option>
            </select>
          </div>
          <div class="d-grid gap-2">
            <button type="button" class="btn btn-primary btn-block" onclick="simularPrestamo()">Simular Prestamo</button>
          </div>
        </form>
        <div class="text-center mt-4" id="resultContainer" style="display: none;">
          <p><strong>Resultado de la Simulación:</strong></p>
          <p>Cuota Mensual: <span id="pagoMensual">-</span></p>
          <p>Total a Pagar: <span id="pagoTotal">-</span></p>
          <p>Intereses: <span id="intereses">-</span></p>          
        </div>
        <div class="text-center mt-4" id="containerSolicitar" style="display: none;">
        	<div class="d-grid gap-2">
       			<button type="button" id="buttonSolicitar" class="btn btn-primary btn-block" hidden="true" onclick="solicitarPrestamo()">Solicitar Prestamo</button>
       			<p id="mensajeAprobacion" class="text-success mt-3" hidden="true"></p>
       		</div>
        </div>
      </div>
    </div>
  </div>
</div>

<footer class="footer">
  <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function simularPrestamo() {
    const montoPrestamo = parseFloat(document.getElementById('montoPrestamo').value);
    const cantCuotas = parseInt(document.getElementById('cantCuotas').value);
    const cuenta = document.getElementById('cuenta').value;


    if (isNaN(montoPrestamo) || isNaN(cantCuotas) || !cuenta) {
      alert("Por favor, complete todos los campos correctamente.");
      return;
    }
    const intereses = 1.2;  // Ejemplo tasa fija del 10%
    const interesesMensuales = intereses / 12;


    const pagoMensual = montoPrestamo * (interesesMensuales / (1 - Math.pow(1 + interesesMensuales, -cantCuotas)));
    const pagoTotal = pagoMensual * cantCuotas;
    const interesTotalPagado = pagoTotal - montoPrestamo;
    const porcentajeInteresReal = (interesTotalPagado / montoPrestamo) * 100;


	document.getElementById('resultContainer').style.display = "block";
	document.getElementById('containerSolicitar').style.display = "block";
	document.getElementById('pagoMensual').textContent = "$" + pagoMensual.toFixed(2);
	document.getElementById('pagoTotal').textContent = "$" + pagoTotal.toFixed(2);
	document.getElementById('intereses').textContent = porcentajeInteresReal.toFixed(2) + "%";
	document.getElementById('buttonSolicitar').hidden = false;
  }
  function solicitarPrestamo(){
	document.getElementById('mensajeAprobacion').hidden = false;
	document.getElementById('mensajeAprobacion').textContent = "Solicitud de préstamo enviada. Espere la aprobación del banco.";
  }
</script>
</body>
</html>
