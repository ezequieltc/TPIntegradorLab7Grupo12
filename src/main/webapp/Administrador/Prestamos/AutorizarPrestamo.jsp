<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="Dominio.Prestamo"%>
<%@ page import="tipos.PrestamosStatus"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="es">
  <%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Autorizar Prestamo");
  	ArrayList<Prestamo> listadoPrestamos = (ArrayList<Prestamo>)request.getSession().getAttribute("listadoPrestamos");
    Boolean mostrarModal = (Boolean) request.getSession().getAttribute("mostrarModal");
    Prestamo prestamoModal = (Prestamo) request.getSession().getAttribute("prestamoModal");
    if (mostrarModal == null) mostrarModal = false; // Evitar errores en caso de que sea nulo
	
    session.removeAttribute("mostrarModal");
	session.removeAttribute("prestamoModal");

  	
  %>
 <head>
  <%@include  file="../../components/header.jsp"%>
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

  table {
    width: 100%;
    border-collapse: collapse;
  }

  th, td {
    text-align: center; /* Centrado de texto */
    vertical-align: middle; /* Alineación vertical */
    padding: 0.5rem; /* Espaciado en las celdas */
  }

  .status-pendiente {
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

  .status-deuda {
    background-color: #FD7E14;
    color: #FFF;
    font-size: 0.8rem;
    padding: 0.25rem 0.5rem;
  }

  .status-en-curso {
    background-color: #007BFF;
    color: #FFF;
    font-size: 0.8rem;
    padding: 0.25rem 0.5rem;
  }

  .table-container {
    width: 100%;
    overflow-x: auto;
    text-align: center;
  }
</style>

</head>
  <link rel="stylesheet" href="https://cdn.datatables.net/2.1.8/css/dataTables.dataTables.css" />
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script type="text/javascript" src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
  
  <script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>

<body>
	<%@include  file="../../components/pre-body.jsp"%>
  <h2 class="text-center text-primary mb-4">Listado de Préstamos para Autorizar</h2>

    
      <div class="table-container">
  <div id="filtrosPadre" class="row">
  	<div id="filtros" class="column">

  	</div>
  </div>
  <table id="tablaPrestamos" class="table table-bordered">
    <thead class="table-light" style="text-align: center;">
    
      <tr>
        <th>ID</th>
        <th>Monto</th>
        <th>Plazo</th>
        <th>Numero de Cuenta</th>
        <th>Tipo de Cuenta</th>
        <th>Titular</th>
        <th>Fecha de Alta</th>
        <th>Estado</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody id="listaPrestamos">
      <% for (Prestamo prestamo : listadoPrestamos){ %>
      <tr>
        <td><%= prestamo.getId() %></td>
        <td>$<%= prestamo.getImporte() %></td>
        <td><%= prestamo.getCantidad_cuotas()  %></td>
        <td><%= prestamo.getCuenta().getNumeroCuenta() %></td>
        <td><%= prestamo.getCuenta().getTipoCuenta().getDescripcion() %></td>
        <td><%= prestamo.getPersona().getNombre() %> <%= prestamo.getPersona().getApellido() %></td>
        <% Date fechaAlta = prestamo.getFecha_alta();
        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd-MM-yyyy");
        String fechaFormateada = formatoFecha.format(fechaAlta);
        %>
        <td><%= fechaFormateada%></td>
        <% if(prestamo.getStatus().equals(PrestamosStatus.PAGO)){ %>
        <td><span class="listaPrestamos status-autorizado">Pago</span></td>
        <% }
        else if(prestamo.getStatus().equals(PrestamosStatus.PENDIENTE)){%>
        <td><span class="listaPrestamos status-pendiente">Pendiente</span></td>
        <% }
        else if(prestamo.getStatus().equals(PrestamosStatus.DEUDA)){
        %>
        <td><span class="listaPrestamos status-deuda">Deuda</span></td>
        <% }
        else if(prestamo.getStatus().equals(PrestamosStatus.RECHAZADO)){ %>
        <td><span class="listaPrestamos status-rechazado">Rechazado</span></td>
        <%} 
        else{ %>
        <td><span class="listaPrestamos status-en-curso">En Curso</span></td>
        <%}%>
        <td>
          <div class="d-flex align-items-center justify-content-center">
            <% if(prestamo.getStatus().equals(PrestamosStatus.PENDIENTE)){ %>
            <form action="${pageContext.request.contextPath}/Administrador/Prestamos/ServletAprobarPrestamo" method="POST">
              <button class="btn btn-success btn-sm me-2" name="prestamoID" value=<%= prestamo.getId() %> type="submit" onclick="return confirm('¿Está seguro de que desea autorizar este prestamo?')">Autorizar</button>
            </form> 
            <form action="${pageContext.request.contextPath}/Administrador/Prestamos/ServletRechazarPrestamo" method="POST">              
              <button class="btn btn-danger btn-sm" name="prestamoID" value=<%= prestamo.getId() %> type="submit" onclick="return confirm('¿Está seguro de que desea rechazar este prestamo?')">Rechazar</button>
            </form>
            <% } %>
            <form action="${pageContext.request.contextPath}/Administrador/Prestamos/ServletAutorizarPrestamo" method="POST">
            	<button class="btn btn-info btn-sm ms-2"  name="prestamoID" value=<%= prestamo.getId() %> data-bs-toggle="modal" data-bs-target="#infoModal1">Más información</button>
            </form>
          </div>
        </td>
      </tr>
      <%} %>
    </tbody>
  </table>
</div>


      
<!-- ESTA INFORMACION ESTA AGREGADA A MANO. EL MODAL SE VA A COMPLETAR CON LA INFORMACION QUE OBTIENE DE LA BASE DE DATOS. -->
<div class="modal fade" id="infoModal1" tabindex="-1" aria-labelledby="infoModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="infoModalLabel">Información del Préstamo</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <% if (prestamoModal != null) { %>
        <p><strong>DNI:</strong> <%= prestamoModal.getPersona().getDni() %></p>
        <p><strong>CUIL:</strong> <%= prestamoModal.getPersona().getCuil() %></p>
        <p><strong>Nombre:</strong> <%= prestamoModal.getPersona().getNombre() %></p>
        <p><strong>Apellido:</strong> <%= prestamoModal.getPersona().getApellido() %></p>
        <p><strong>Teléfono:</strong> <%= prestamoModal.getPersona().getTelefono() %></p>
        <p><strong>Correo Electrónico:</strong> <%= prestamoModal.getPersona().getEmail() %></p>
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
        <% } else { %>
          <p>No se encontró información del préstamo.</p>
        <% } %>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>
<%@include  file="../../components/post-body.jsp"%>

<script>
	new DataTable('#tablaPrestamos', {
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
	  <% if (mostrarModal) { %>
	    const infoModal = new bootstrap.Modal(document.getElementById('infoModal1'));
	    infoModal.show();
	  <% 
	     // Limpiar el flag para evitar que el modal vuelva a mostrarse en la siguiente carga
	     request.getSession().setAttribute("mostrarModal", false);
	  %>
	  <% } %>

</script>
</body>
</html>
