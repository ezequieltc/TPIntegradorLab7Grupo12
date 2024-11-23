<%@ page import="Dominio.Cuenta" %>
<%@ page import="Dominio.Movimiento" %>
<%@ page import="Dominio.DTO.PaginatedResponse" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <%@include  file="../../components/header.jsp"%>
        <title>BancArg - Movimientos</title>
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
    text-align: center; /* Centrado de texto */
    vertical-align: middle; /* Alineación vertical */
    padding: 0.5rem; /* Espaciado en las celdas */
  }
  .table-container {
    width: 100%;
    overflow-x: auto;
    text-align: center;
  }
            .btn-volver {
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                font-size: 16px;
                cursor: pointer;
            }
            .btn-volver:hover {
                background-color: #0056b3;
            }
            
        </style>
    </head>
    <body>
        <%@include  file="../../components/pre-body.jsp"%>

        <h2>Últimos Movimientos</h2>
        <div class="select-container">
            <form id="formCuentas" method="POST" action="ServletMovimientos">
                <label for="idCuenta">Seleccione una cuenta:</label>
                <select id="idCuenta" name="idCuenta" onchange="document.getElementById('formCuentas').submit();">
                    <option value="" disabled selected>Seleccione una cuenta</option>
                    <%
                        List<Cuenta> cuentas = (List<Cuenta>) request.getAttribute("listaCuentas");
                        if (cuentas != null) {
                            for (Cuenta cuenta : cuentas) {
                    %>
                        <option value="<%= cuenta.getId() %>" <%= (request.getParameter("idCuenta") != null 
                                && request.getParameter("idCuenta").equals(String.valueOf(cuenta.getId()))) ? "selected" : "" %>>
                            <%= cuenta.getTipoCuenta().getDescripcion() %> - <%= cuenta.getNumeroCuenta() %>
                        </option>
                    <%
                            }
                        }
                    %>
                </select>
            </form>
        </div>

      <div class="table-container">
  <div id="filtrosPadre" class="row">
  	<div id="filtros" class="column">

  	</div>
  </div>
	<table id="example" class="display" style="width:85%">
            <thead class="table-light" style="text-align: center;">
                <tr>
                    <th>Fecha</th>
                    <th>Tipo</th>
                    <th>Detalle</th>
                    <th>Importe</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <%
                    PaginatedResponse<Movimiento> movimientos = (PaginatedResponse<Movimiento>) request.getAttribute("listaMovimientos");
                    if (movimientos != null && movimientos.getData() != null && !movimientos.getData().isEmpty()) {
                        for (Movimiento movimiento : movimientos.getData()) {
                %>
                    <tr>    
                        <td><%= movimiento.getFecha() %></td>
                        <td><%= movimiento.getTipoMovimiento().getDescripcion() %></td>
                        <td>
                        	<% if (movimiento.getTransferencia() == null) {%>
                        		<%= movimiento.getDetalle() %>
                        	<%} else { 
                        	
                        		if (movimiento.getImporte() > 0) {
                        		%>
                        		  <%= movimiento.getTransferencia().getCuentaOrigen().getPersona().getNombre() %> <%= movimiento.getTransferencia().getCuentaOrigen().getPersona().getApellido() %> te envío dinero
                        		  desde el CBU: <%= movimiento.getTransferencia().getCuentaOrigen().getCbu() %>
                        	<%} else { %>
                        		   Enviaste dinero a la cuenta de <%= movimiento.getTransferencia().getCuentaDestino().getPersona().getNombre() %> <%= movimiento.getTransferencia().getCuentaDestino().getPersona().getApellido() %> con el CBU: <%= movimiento.getTransferencia().getCuentaDestino().getCbu() %>
                        		<% }}%>
                        </td>
                        <td><%= movimiento.getImporte() %></td>
                        <td><%= movimiento.getEstado() ? "Activo" : "Inactivo" %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5">No hay movimientos disponibles para esta cuenta.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        
        
        <div class="btn-container">
            <a href="ServletHomeUsuario" class="btn-volver">Volver</a>
        </div>

        <%@include  file="../../components/post-body.jsp"%>
        

  <script type="text/javascript" src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<script>


new DataTable('#example', {
    initComplete: function () {
        this.api()
            .columns()
            .every(function () {
                let column = this;
                if(column.header().textContent != "Acciones")
                	{
	                let title = column.header().textContent;
	 				
	                // Crear el input de filtro
	                let input = document.createElement('input');
	                let headerWidth = column.header().offsetWidth; // Ancho del encabezado
	                input.style.width = "${headerWidth}px";

	                input.style.margin = "10px";       
	                input.placeholder = "Filtrar por " + title;
	                input.className = 'column'; // Puedes agregar una clase para estilizar el input si lo deseas

	                // Añadir el input al div con id "prueba"
	                let pruebaDiv = document.getElementById("filtros");
	                pruebaDiv.appendChild(input); // Agrega el input al div
	                // Event listener for user input
	                input.addEventListener('keyup', () => {
	                    if (column.search() !== this.value) {
	                        column.search(input.value).draw();
	                    }
	                });
                	}
            });
    },
    language: {
        info: 'Mostrando pagina _PAGE_ de _PAGES_',
        infoEmpty: 'No hay resultados disponibles',
        infoFiltered: '(filtrados desde _MAX_ resultados totales)',
        lengthMenu: ' _MENU_ Resultados por Pagina',
        zeroRecords: 'Ups! Parece que no hay nada',
        search: 'Buscar'
    },
        layout: {
            topEnd: null
        }
    
});


</script>
    </body>
</html>
