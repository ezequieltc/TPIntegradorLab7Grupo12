<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Dominio.Cuenta" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BancArg - Listado de Cuentas</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layout.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.datatables.net/2.1.8/css/dataTables.dataTables.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<style>
    .table-container {
        padding: 40px;
        background-color: #ffffff;
        border-radius: 5px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        width: 100%;
        min-height: 500px;
        overflow-y: auto;
    }
    .table thead th input {
        width: 100%;
        padding: 5px;
        box-sizing: border-box;
        text-align: center;
    	vertical-align: middle;
        
    }
    table th, table td {
    text-align: center; /* Centra el texto */
    vertical-align: middle; /* Alinea verticalmente los contenidos */
}
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
      h2 {
      	float:left;
      }
	  .btn {
	  margin-top: 25px;
	  	float: right;
	  }
      .transferForm {
          height: calc(100% - 100px);
      }
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="#">BancArg</a>
    <div class="collapse navbar-collapse justify-content-end">
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="#">Usuario: Administrador</a></li>
        </ul>
    </div>
</nav>

<div class="d-flex">
    <div class="sidebar">
        <a href="#">Inicio</a> 
        <a href="${pageContext.request.contextPath}/Administrador/Cuentas.jsp">Cuentas</a> 
        <a href="#">Transferencias</a>
        <a href="#">Préstamos</a> 
        <a href="#">Ajustes</a>
    </div>

    <div class="content-container">
        <h2 class="my-4">Listado de Cuentas</h2>
        <div class="table-container">
            	<table id="example" class="display" style="width:85%">
		        <thead>
		            <tr>
		                <th>ID Cuenta</th>
		                <th>ID Cliente</th>
		                <th>Tipo de Cuenta</th>
		                <th>Numero de Cuenta</th>
		                <th>CBU</th>
		                <th>Saldo</th>
		                <th>Fecha de Creación</th>
		                <th>Activa</th>
		            </tr>
		        </thead>
		        <tbody>
		        	<% ArrayList<Cuenta>cuentasList = new ArrayList<Cuenta>();
		        	 cuentasList = (ArrayList<Cuenta>)request.getAttribute("cuentasList");
		        	 for(Cuenta cuentaTemp : cuentasList){ %>
		        	<tr>
		                <td><%= cuentaTemp.getId() %></td>
		                <td><%= cuentaTemp.getPersona().getUsuario().getId()%></td>
		                <td><%= cuentaTemp.getTipoCuenta().getDescripcion() %></td>
		                <td><%= cuentaTemp.getNumeroCuenta() %></td>
		                <td><%= cuentaTemp.getCbu() %></td>
		                <td>$<%= cuentaTemp.getSaldo() %></td>
		                <td><%= cuentaTemp.getFechaCreacion() %></td>
		                <% if(cuentaTemp.isEstado()){ %>
		                	<td>Activa</td>
		                <%}else{ %>
		                	<td>Desactivada</td>
		                <%} %>
		            </tr>
		            <% } %>
		        </tbody>
		    </table>
        </div>
    </div> 
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
new DataTable('#example', {
    language: {
        info: 'Mostrando pagina _PAGE_ de _PAGES_',
        infoEmpty: 'No hay resultados disponibles',
        infoFiltered: '(filtrados desde _MAX_ resultados totales)',
        lengthMenu: ' _MENU_ Resultados por Pagina',
        zeroRecords: 'Ups! Parece que no hay nada',
        search: 'Buscar'
    }
});
</script>
<footer class="footer">
    <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
</footer>
</body>
</html>
