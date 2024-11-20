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
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script type="text/javascript" src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
  
  <script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
        <style>

           	td {
	 			text-align: center;
	 		}

            .select-container {
                margin-bottom: 20px;
                text-align: center;
            }
                        .btn-container {
                margin-top: 30px;
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

        <h2>Últimos Movimientos</h2>
	<table id="example" class="display" style="width:85%">
            <thead>
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
                        <td><%= movimiento.getDetalle() %></td>
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
        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
	new DataTable('#example', {
	    initComplete: function () {
	        this.api()
	            .columns()
	            .every(function () {
	                let column = this;
	                let title = column.header().textContent;
	 
	                // Create input element
	                let input = document.createElement('input');
	                input.placeholder = title;
	                column.header().replaceChildren(input);
	 
	                // Event listener for user input
	                input.addEventListener('keyup', () => {
	                    if (column.search() !== this.value) {
	                        column.search(input.value).draw();
	                    }
	                });
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
