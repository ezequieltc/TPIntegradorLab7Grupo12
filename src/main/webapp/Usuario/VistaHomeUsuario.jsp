<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<%@include  file="../components/header.jsp"%>
<title>BancArg - Home Usuario</title>
    <style>
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
    </style>
  </head>
  <body>
  <%@include  file="../../components/pre-body.jsp"%>

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
    
     <%@include  file="../components/post-body.jsp"%>
  </body>
</html>