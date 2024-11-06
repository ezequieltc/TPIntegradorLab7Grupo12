<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>BancArg - Autorizar Préstamo</title>
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
    .filtro-container {
      padding: 1rem;
      background-color: #f8f9fa;
      border: 1px solid #dee2e6;
      border-radius: 8px;
      margin-bottom: 1rem;
      display: flex;
      justify-content: space-around;
      width: 90%;
    }
    .filtro-container select {
      padding: 0.5rem;
      border-radius: 4px;
    }
    .listaPrestamos {
      font-weight: bold;
      padding: 0.5rem;
      border-radius: 4px;
      text-align: center;
      display: inline-block;
    }
    .status-para-autorizar {
      background-color: #FFC107;
      color: #000;
      font-size: 0.8rem;
      padding: 0.25rem 0.5rem;
    }
    .status-autorizado {
      background-color: #28A745;
      color: #FFF;
      font-size: 0.8rem;
      padding: 0.25rem 0.5rem;
    }
    .status-rechazado {
      background-color: #DC3545;
      color: #FFF;
      font-size: 0.8rem;
      padding: 0.25rem 0.5rem;
    }
  </style>
</head>
<body>
<nav class="navbar">
  <a class="navbar-brand" href="#">BancArg</a>
  <div class="justify-content-end">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="#">Usuario: Administrador</a>
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


    <div class="main-content">
      <h2 class="text-center text-primary mb-4">Listado de Préstamos para Autorizar</h2>
  <div class="content-container">
    <div class="filtro-container">
      <select>
        <option value="">ID</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
      </select>
      <select>
        <option value="">Monto</option>
        <option value="80000">$80,000</option>
        <option value="200000">$200,000</option>
        <option value="150000">$150,000</option>
      </select>
      <select>
        <option value="">Plazo</option>
        <option value="12">12 meses</option>
        <option value="24">24 meses</option>
        <option value="36">36 meses</option>
      </select>
      <select>
        <option value="">Cuenta</option>
        <option value="150234">Cuenta Ahorro - 150234</option>
        <option value="154588">Cuenta Ahorro - 154588</option>
        <option value="150588">Cuenta Corriente - 150588</option>
      </select>
      <select>
        <option value="">Titular</option>
        <option value="Juan Pérez">Juan Pérez</option>
        <option value="Rodrigo Gimenez">Rodrigo Gimenez</option>
        <option value="Romina Gomez">Romina Gomez</option>
      </select>
      <select>
        <option value="">Estado</option>
        <option value="Para autorizar">Para autorizar</option>
        <option value="Autorizado">Autorizado</option>
        <option value="Rechazado">Rechazado</option>
      </select>
    </div>
      
      <table class="table table-bordered">
        <thead class="table-light">
          <tr>
            <th>ID</th>
            <th>Monto</th>
            <th>Plazo</th>
            <th>Cuenta</th>
            <th>Titular</th>
            <th>Estado</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody id="listaPrestamos">
          <tr>
            <td>1</td>
            <td>$80,000</td>
            <td>12</td>
            <td>Cuenta Ahorro - 150234</td>
            <td>Juan Pérez</td>
            <td><span class="listaPrestamos status-para-autorizar">Para autorizar</span></td>
            <td>
              <div class="d-flex align-items-center justify-content-center">
                <button class="btn btn-success btn-sm me-2">Autorizar</button>
                <button class="btn btn-danger btn-sm">Rechazar</button>
                <button class="btn btn-info btn-sm ms-2" data-bs-toggle="modal" data-bs-target="#infoModal1">Más información</button>
              </div>
            </td>
          </tr>
          <tr>
            <td>2</td>
            <td>$200,000</td>
            <td>36</td>
            <td>Cuenta Ahorro - 154588</td>
            <td>Rodrigo Gimenez</td>
            <td><span class="listaPrestamos status-rechazado">Rechazado</span></td>
            <td>
              <div class="d-flex align-items-center justify-content-center">
                <button class="btn btn-danger btn-sm">Modificar</button>
                <button class="btn btn-info btn-sm ms-2">Más información</button>
              </div>
            </td>
          </tr>
          <tr>
            <td>3</td>
            <td>$150,000</td>
            <td>24</td>
            <td>Cuenta Corriente - 150588</td>
            <td>Romina Gomez</td>
            <td><span class="listaPrestamos status-autorizado">Autorizado</span></td>
            <td>
              <div class="d-flex align-items-center justify-content-center">
                <button class="btn btn-danger btn-sm">Modificar</button>
                <button class="btn btn-info btn-sm ms-2">Más información</button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- ESTA INFORMACION ESTA AGREGADA A MANO. EL MODAL SE VA A COMPLETAR CON LA INFORMACION QUE OBTIENE DE LA BASE DE DATOS. -->
<div class="modal fade" id="infoModal1" tabindex="-1" aria-labelledby="infoModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="infoModalLabel">Información de Contacto - Juan Pérez</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p><strong>DNI:</strong> 12.345.678</p>
        <p><strong>CUIL:</strong> 20-12345678-9</p>
        <p><strong>Nombre:</strong> Juan</p>
        <p><strong>Apellido:</strong> Pérez</p>
        <p><strong>Teléfono:</strong> 1234-5678</p>
        <p><strong>Correo Electrónico:</strong> juan.perez@example.com</p>
        <h6>Historial de Pagos de Cuotas</h6>
        <table class="table">
          <thead>
            <tr>
              <th>Monto de Cuota</th>
              <th>Fecha Vencimiento</th>
              <th>Fecha Pago</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>$8,000</td>
              <td>01/01/2024</td>
              <td>01/01/2024</td>
            </tr>
            <tr>
              <td>$8,000</td>
              <td>01/02/2024</td>
              <td>01/02/2024</td>
            </tr>
            <tr>
              <td>$8,000</td>
              <td>01/03/2024</td>
              <td>03/03/2024</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>
<footer class="footer">
  <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
