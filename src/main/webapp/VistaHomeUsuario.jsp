<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BancArg - Home Usuario</title>
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
        padding: 20px;
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
      table {
        margin-top: 30px;
        width: 100%;
        background-color: white;
        border-radius: 5px;
        overflow: hidden;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
      }
      th,
      td {
        padding: 15px;
        text-align: left;
      }
      th {
        background-color: #007bff;
        color: white;
      }
      .dropdown-menu {
        position: absolute;
        display: none;
        z-index: 1000;
      }
      .table-row {
        cursor: pointer;
      }
      footer {
        text-align: center;
        color: #666;
        padding: 10px;
        background-color: #f8f9fa;
        width: 100%;
        position: absolute;
        bottom: 0;
        left: 0;
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
      <div>BancArg - Home Usuario</div>
      <div>Usuario: Pepito Pistolero</div>
    </div>

    <div class="content">
      <h3 class="text-center">Resumen de Cuentas</h3>

      <table class="table table-bordered table-hover">
        <thead>
          <tr>
            <th>Tipo de Cuenta</th>
            <th>Nro de Cuenta</th>
            <th>Saldo</th>
          </tr>
        </thead>
        <tbody>
          <tr
            class="table-row"
            data-toggle="dropdown"
            data-account="Caja de Ahorro"
            data-account-number="1234567890"
            data-balance="$25,000.00"
          >
            <td>Caja de Ahorro</td>
            <td>1234567890</td>
            <td>$25,000.00</td>
          </tr>
          <tr
            class="table-row"
            data-toggle="dropdown"
            data-account="Cuenta Corriente"
            data-account-number="0987654321"
            data-balance="$10,000.00"
          >
            <td>Cuenta Corriente</td>
            <td>0987654321</td>
            <td>$10,000.00</td>
          </tr>
        </tbody>
      </table>

      <div class="dropdown-menu" id="accountOptionsMenu">
        <a class="dropdown-item" href="#">Movimientos</a>
        <a class="dropdown-item" href="#">Transferir</a>
      </div>
    </div>

    <footer>
      <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
    </footer>

    <script>
        document.querySelectorAll(".table-row").forEach(function(row) {
            row.addEventListener("click", function(event) {
                const menu = document.getElementById("accountOptionsMenu");

                menu.style.display = "block";
                menu.style.top = event.clientY + "px";
                menu.style.left = event.clientX + "px";

                document.addEventListener("click", function hideMenu(e) {
                    if (!menu.contains(e.target) && !row.contains(e.target)) {
                        menu.style.display = "none";
                        document.removeEventListener("click", hideMenu);
                    }
                });
            });
        });
    </script>
  </body>
</html>