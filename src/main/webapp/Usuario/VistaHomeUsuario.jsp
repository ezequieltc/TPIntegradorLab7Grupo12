<%@ page import="java.util.Map" %>
<%@ page import="Dominio.Cuenta" %>
<%@ page import="Dominio.Movimiento" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<%@include  file="../../components/header.jsp"%>
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
  <% 
    List<Cuenta> cuentas = (List<Cuenta>) request.getAttribute("lista");
    if (cuentas != null) {
      for (Cuenta cuenta : cuentas) { 
  %>
        <tr
          class="table-row"
          onclick="enviarFormulario(<%= cuenta.getId() %>)"
          data-toggle="dropdown"
          data-account="<%= cuenta.getTipoCuenta().getDescripcion() %>"
          data-account-number="<%= cuenta.getNumeroCuenta() %>"
          data-balance="<%= cuenta.getSaldo() %>"
          data-id-cuenta="<%= cuenta.getId() %>"
        >
          <td><%= cuenta.getTipoCuenta().getDescripcion() %></td>
          <td><%= cuenta.getNumeroCuenta() %></td>
          <td><%= cuenta.getSaldo() %></td>
        </tr>
  <% 
      }
    }
  %>
</tbody>
      </table>
<h3 class="text-center">Últimos Movimientos</h3>
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Nro de Cuenta</th>
                        <th>Tipo de Movimiento</th>
                        <th>Importe</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    	Map<Integer, Cuenta> cuentaMap = (Map<Integer, Cuenta>) request.getAttribute("cuentaMap");
                        List<Movimiento> ultimosMovimientos = (List<Movimiento>) request.getAttribute("ultimosMovimientos");
                        if (ultimosMovimientos != null) {
                            for (Movimiento movimiento : ultimosMovimientos) {
                            	Cuenta cuenta = cuentaMap.get(movimiento.getIdCuenta());
                    %>
                        <tr>
							<td><%= cuenta != null ? cuenta.getNumeroCuenta() : "Desconocido" %></td>
                            <td><%= movimiento.getTipoMovimiento().getDescripcion() %></td>
                            <td><%= movimiento.getImporte() %></td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
      <div class="dropdown-menu" id="accountOptionsMenu">
        <a class="dropdown-item" href="#">Movimientos</a>
        <a class="dropdown-item" href="#">Transferir</a>
      </div>
    </div>
<form id="formMovimientos" method="GET" action="ServletMovimientos">
    <input type="hidden" name="idCuenta" id="idCuenta">
</form>
    <script>
    document.querySelectorAll(".table-row").forEach(function (row) {
        row.addEventListener("click", function (event) {
            const menu = document.getElementById("accountOptionsMenu");

        const idCuenta = row.dataset.idCuenta;
        menu.dataset.idCuenta = idCuenta;

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

    document.querySelector("#accountOptionsMenu").addEventListener("click", function (event) {
        if (event.target.classList.contains("dropdown-item")) {
            const idCuenta = this.dataset.idCuenta;

            if (event.target.textContent.trim() === "Movimientos") {
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "ServletMovimientos";

                const input = document.createElement("input");
                input.type = "hidden";
                input.name = "idCuenta";
                input.value = idCuenta;

                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }
    });
        
    </script>
    
     <%@include  file="../../components/post-body.jsp"%>
  </body>
</html>