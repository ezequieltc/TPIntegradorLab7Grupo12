<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Dominio.Cuenta" %>
<!DOCTYPE html>
<html lang="es">
<head>
<% request.setAttribute("rolPermitido", UserTypes.ADMIN); %>
	<%@include file="../../components/header.jsp"%>
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
    text-align: center; 
    vertical-align: middle;
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
	<%@include file="../../components/pre-body.jsp"%>
        <h2 class="my-4">Listado de Cuentas</h2>
        <div class="table-container">
            	<table id="example" class="display" style="width:85%">
		        <thead>
		            <tr>
		                <th>ID Cuenta</th>
		                <th>ID Cliente</th>
		                <th>DNI Cliente</th>
		                <th>Nombre</th>
		                <th>Apellido</th>
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
		        	
		        	 cuentasList = (ArrayList<Cuenta>) session.getAttribute("cuentasList");
		        	 if (cuentasList != null){
		        	 for(Cuenta cuentaTemp : cuentasList){ %>
		        	<tr>
		                <td><%= cuentaTemp.getId() %></td>
		                <td><%= cuentaTemp.getPersona().getUsuario().getId()%></td>
		                <td><%= cuentaTemp.getPersona().getDni()%></td>
		                <td><%= cuentaTemp.getPersona().getNombre()%></td>
		                <td><%= cuentaTemp.getPersona().getApellido()%></td>
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
		            <% }
		        	 } %>
		        </tbody>
		    </table>
        </div>
	<%@include file="../../components/post-body.jsp"%>
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
 	
</body>
</html>