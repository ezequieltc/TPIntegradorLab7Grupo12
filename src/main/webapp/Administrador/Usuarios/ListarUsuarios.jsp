<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dominio.Persona" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
  <%
    request.setAttribute("pageTitle", "Listado Usuarios");

    ArrayList<Persona> personas = null;
    if(request.getAttribute("lista") != null){
    
    personas = (ArrayList<Persona>)request.getAttribute("lista");   
    }
  %>
<head>
<% request.setAttribute("rolPermitido", UserTypes.ADMIN); %>
<%@include  file="../../components/header.jsp"%>
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

    .table-container {
        width: 100%;
        overflow-x: auto;
        text-align: center;
    }
    </style>
</head>
<body>
<%@include  file="../../components/pre-body.jsp"%>
   <h2 class="my-4">Listado de Usuarios</h2>
   <div class="table-container">
    <div id="filtrosPadre" class="row">
        <div id="filtros" class="column"></div>
    </div>

    
	    <table id="tablaPersonas" class="table table-bordered">
	        <thead class="table-light" style="text-align: center;">
	        
	        <tr>
	            <th>DNI</th>
	            <th>CUIL</th>
	            <th>Nombre</th>
	            <th>Apellido</th>
	            <th>Sexo</th>
	            <th>Nacionalidad</th>
	            <th>E-Mail</th>
	            <th>Teléfono</th>
	            <th>Usuario</th>
	            <th>Estado</th>
	            <th>Acciones</th>
	        </tr>
	        </thead>
	        <tbody id="listaPrestamos">
	            <% if (personas!= null) for (Persona personaTemp : personas) { %>
	            <tr>
	                <td><%=personaTemp.getDni() %></td>
	                <td><%=personaTemp.getCuil() %></td>
	                <td><%=personaTemp.getNombre() %></td>
	                <td><%=personaTemp.getApellido() %></td>
	                <td><%=personaTemp.getTipoSexo().getDescripcion() %></td>
	                <td><%=personaTemp.getNacionalidad() %></td>
	                <td><%=personaTemp.getEmail() %></td>
	                <td><%=personaTemp.getTelefono()%></td>
	                <td><%=personaTemp.getUsuario().getUsuario() %></td>
	                <td><%=personaTemp.getUsuario().getEstado() ? "Activa" : "Baja"%></td>
	                <td>
	                <div class="d-flex align-items-center justify-content-center">
	                    <form action="${pageContext.request.contextPath}/Administrador/Usuarios/ServletUsuarios" method="GET">
		                    <button class="btn btn-info btn-sm ms-2" type="submit" name="btnModificarUsuario">Detalle</button>
		                    <input type="hidden" name="id" value="<%=personaTemp.getId() %>">
                        </form>
	                </div>
	                </td>
	            </tr>
	            <%} %>
	        </tbody>
	    </table>

   </div>
 <%@include  file="../../components/post-body.jsp"%>


<script type="text/javascript" src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<script>
	new DataTable('#tablaPersonas', {
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