<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>BancArg - Nueva Transferencia</title>
  <link rel="stylesheet" type="text/css" href="../../css/layout.css" />
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"
  />
  <style>
      .step {
          padding: 40px;
          background-color: #ffffff;
          border-radius: 5px;
          box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
          width: 100%;
          min-height: 450px;
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
<nav class="navbar">
  <a class="navbar-brand" href="#">BancArg</a>
  <div class="justify-content-end">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="#">Usuario: Pepito Pistolero</a>
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
    <h2 class="my-4">Nueva Transferencia</h2>
    <div id="transferForm" class="w-100">
      <div class="step step-1">
        <h4>Paso 1: Seleccionar Alias o CBU</h4>
        <form>
          <div class="form-group">
            <label for="aliasOrCbu">Alias o CBU</label>
            <input type="text" id="aliasOrCbu" class="form-control" placeholder="Ingrese Alias o CBU">
          </div>
          <div class="step-actions">
            <button type="button" class="btn btn-primary mt-3" id="nextStep1">Siguiente</button>
          </div>
        </form>
      </div>

      <div class="step step-2 d-none">
        <h4>Paso 2: Detalle del Beneficiario</h4>
        <div class="beneficiary-details card p-4 mb-4">
          <p><strong>Cuenta:</strong> <span id="accountNumber">0987654321</span></p>
          <p><strong>Nombre del titular:</strong> <span id="accountHolderName">Juan Perez</span></p>
        </div>
        <div class="step-actions">
          <button type="button" class="btn btn-secondary" id="prevStep2">Anterior</button>
          <button type="button" class="btn btn-primary" id="nextStep2">Siguiente</button>
        </div>
      </div>

      <div class="step step-3 d-none">
        <h4>Paso 3: Monto y Cuenta de Origen</h4>
        <form>
          <div class="form-group">
            <label for="amount">Monto a Transferir</label>
            <input type="number" id="amount" class="form-control" placeholder="Ingrese el monto">
          </div>
          <div class="form-group">
            <label for="sourceAccount">Cuenta de Origen</label>
            <select id="sourceAccount" class="form-control">
              <option value="1234567890">Caja de Ahorro - $25,000.00</option>
              <option value="0987654321">Cuenta Corriente - $10,000.00</option>
            </select>
          </div>
          <div class="step-actions">
            <button type="button" class="btn btn-secondary" id="prevStep3">Anterior</button>
            <button type="submit" class="btn btn-success" id="confirmTransfer">Confirmar Transferencia</button>
          </div>
        </form>
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