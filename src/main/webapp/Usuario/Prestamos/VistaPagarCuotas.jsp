<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>BancArg - Pagar Cuotas</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <style>
      body {
        background-color: #e0f0ff;
        margin: 0;
      }
      .sidebar {
        background-color: #007bff;
        height: 100vh;
        padding-top: 20px;
        color: white;
        position: fixed;
        width: 200px;
      }
      .sidebar a {
        color: white;
        text-decoration: none;
        font-size: 1.2em;
        padding: 10px;
        display: block;
      }
      .sidebar a:hover {
        background-color: #0056b3;
      }
      .content {
        margin-left: 200px;
        padding: 0;
      }
      .header-bar {
        background-color: #007bff;
        padding: 10px 20px;
        color: white;
        font-size: 1.2em;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-left: 200px;
      }
      .card {
        max-width: 400px;
        margin: 50px auto;
        border: none;
      }
      .form-control {
        font-size: 1rem;
      }
      footer {
        text-align: center;
        margin-top: 20px;
        color: #666;
      }
    </style>
  </head>
  <body>
    <div class="sidebar">
      <h2 class="text-center">BancArg</h2>
      <a href="#">Inicio</a>
      <a href="#">Cuentas</a>
      <a href="#">Transferencias</a>
      <a href="#">Préstamos</a>
      <a href="#">Ajustes</a>
    </div>

    <div class="header-bar">
      <div>BancArg - Pago Cuotas</div>
      <div>Usuario: Pepito Pistolero</div>
    </div>

    <div class="content">
      <div class="card shadow">
        <div class="card-body">
          <h3 class="card-title text-center">Pagar Cuota</h3>
          <form>
            <select class="form-select mb-3">
              <option selected>Seleccione cuota a pagar</option>
              <option value="1">Cuota 1</option>
              <option value="2">Cuota 2</option>
              <option value="3">Cuota 3</option>
            </select>
            <select
              class="form-select mb-3"
              aria-label="Default select example"
            >
              <option selected>Seleccione cuenta a debitar</option>
              <option value="1">Caja de Ahorro</option>
              <option value="2">Cuenta Corriente</option>
            </select>
            <button type="submit" class="btn btn-primary btn-block">
              Pagar
            </button>
          </form>
        </div>
      </div>

      <footer>
        <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
      </footer>
    </div>
  </body>
</html>
