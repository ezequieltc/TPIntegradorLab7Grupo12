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
<link rel="stylesheet" href="https://cdn.datatables.net/2.1.8/css/dataTables.dataTables.css" />
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

  table {
    width: 100%;
    border-collapse: collapse;
  }

  th, td {
    text-align: center !important; /* Centrado de texto */
    vertical-align: middle !important; /* Alineación vertical */
    padding: 0.5rem; /* Espaciado en las celdas */
  }
  .table-container {
    width: 100%;
    overflow-x: auto;
    text-align: center;
  }
      </style>
	</head>
  <body>
  <%@include  file="../../components/pre-body.jsp"%>

    <div class="content">
      <h3>Resumen de Cuentas</h3>

      <table class="dataTable display">
        <thead class="table-light" style="text-align: center;">
          <tr>
            <th>Tipo de Cuenta</th>
            <th>Nro de Cuenta</th>
            <th>Saldo</th>
            <th></th>
          </tr>
        </thead>
<tbody>
  <% 
    List<Cuenta> cuentas = (List<Cuenta>) request.getAttribute("lista");
    if (cuentas != null) {
      for (Cuenta cuenta : cuentas) { 
  %>
        <tr>
          <td><%= cuenta.getTipoCuenta().getDescripcion() %></td>
          <td><%= cuenta.getNumeroCuenta() %></td>
          <td><%= cuenta.getSaldo() %></td>
          <td>
            <form action="ServletMovimientos" method="POST">
              <input type="hidden" name="idCuenta" value="<%= cuenta.getId() %>">
              <button class="btn btn-primary btn-sm" type="submit">
                Ver Movimientos
              </button>
            </form>
          </td>
        </tr>
  <% 
      }
    }
  %>
</tbody>
      </table>
<h3>Últimos Movimientos</h3>
            <table class="dataTable display">
                <thead class="table-light" style="text-align: center;">
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

<%@include  file="../../components/post-body.jsp"%>

<script type="text/javascript" src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<script>
document.querySelectorAll('.dataTable').forEach(table => {
    new DataTable(table, {
        initComplete: function () {
            this.api()
                .columns()
                .every(function () {
                    let column = this;
                    let title = column.header().textContent;

                    // Crear el elemento input
                    let input = document.createElement('input');
                    input.placeholder = title;
                    column.header().replaceChildren(input);

                    // Listener para el input
                    input.addEventListener('keyup', () => {
                        if (column.search() !== input.value) {
                            column.search(input.value).draw();
                        }
                    });
                });
        },
        language: {
            info: 'Mostrando página _PAGE_ de _PAGES_',
            infoEmpty: 'No hay resultados disponibles',
            infoFiltered: '(filtrados desde _MAX_ resultados totales)',
            lengthMenu: ' _MENU_ Resultados por página',
            zeroRecords: 'Ups! Parece que no hay nada',
            search: 'Buscar'
        },
        layout: {
            topEnd: null
        }
    });
});
	});

</script>
  </body>
</html>