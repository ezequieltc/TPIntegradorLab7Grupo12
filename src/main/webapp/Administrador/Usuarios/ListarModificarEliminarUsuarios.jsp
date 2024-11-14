<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dominio.Persona" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BancArg - Listado de Usuarios</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layout.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
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
        <a href="#">Cuentas</a> 
        <a href="${pageContext.request.contextPath}/ServletUsuarios">Usuarios</a>
        <a href="#">Transferencias</a>
        <a href="#">Préstamos</a> 
        <a href="#">Ajustes</a>
    </div>
    
<div class="content-container">
        <h2 class="my-4">Listado de Usuarios</h2>
        <div class="table-container">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th><input type="text" placeholder="ID Usuario" onkeyup="filterTable(0)"></th>
                        <th><input type="text" placeholder="Usuario" onkeyup="filterTable(1)"></th>
                        <th><input type="text" placeholder="DNI Usuario" onkeyup="filterTable(2)"></th>
                        <th><input type="text" placeholder="CUIL" onkeyup="filterTable(3)"></th>
                        <th><input type="text" placeholder="Nombre" onkeyup="filterTable(4)"></th>
                        <th><input type="text" placeholder="Apellido" onkeyup="filterTable(5)"></th>
                        <th><input type="text" placeholder="Sexo" onkeyup="filterTable(6)"></th>
                        <th><input type="text" placeholder="Nacionalidad" onkeyup="filterTable(7)"></th>
                        <th><input type="text" placeholder="Fecha de Nacimiento" onkeyup="filterTable(8)"></th>
                        <th><input type="text" placeholder="Direccion" onkeyup="filterTable(9)"></th>
                        <th><input type="text" placeholder="Localidad" onkeyup="filterTable(10)"></th>
                        <th><input type="text" placeholder="Provincia" onkeyup="filterTable(11)"></th>
                        <th><input type="text" placeholder="E-mail" onkeyup="filterTable(12)"></th>
                        <th><input type="text" placeholder="Telefono" onkeyup="filterTable(13)"></th>
                    </tr>
                    <tr>
                        <th>ID Usuario</th>
                        <th>Usuario</th>
                        <th>DNI</th>
                        <th>CUIL</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Sexo</th>
                        <th>Nacionalidad</th>
                        <th>Fecha Nac.</th>
                        <th>Dirección</th>
                        <th>Localidad</th>
                        <th>Provincia</th>
                        <th>E-Mail</th>
                        <th>Teléfono</th>
                    </tr>
                </thead>
                <% 
               		ArrayList<Persona> personas = null;
               		if(request.getAttribute("lista") != null){
              	   
              	   	personas = (ArrayList<Persona>)request.getAttribute("lista");   
                   }
                   %>
                <tbody id="usersTable">
                   
                   <% 
                   if(personas != null)
                   for(Persona persona : personas)
                   {
                	   %>
                   <tr>
				           <td><%=persona.getId()%></td>
				           <td><%=persona.getUsuario().getId()%></td>
				           <td><%=persona.getDni() %></td>
				           <td><%=persona.getCuil() %></td>
				           <td><%=persona.getNombre() %></td>
				           <td><%=persona.getApellido() %></td>
				           <td><%=persona.getTipoSexo().getDescripcion()%></td>
				           <td><%=persona.getNacionalidad() %></td>
				           <td><%=persona.getFechaNacimiento() %></td>
				           <td><%=persona.getDireccion() %></td>
				           <td><%=persona.getLocalidad() %></td>
				           <td><%=persona.getProvincia() %></td>
				           <td><%=persona.getEmail() %></td>
				           <td><%=persona.getTelefono()%></td>
				       </tr>    
				    <%
                   }
				    %>       
                </tbody>
            </table>
            <div class="pagination">
                <button onclick="prevPage()" id="btn_prev" class="btn btn-primary" style="margin: 5px">Anterior</button>
                <button onclick="nextPage()" id="btn_next" class="btn btn-primary" style="margin: 5px">Siguiente</button>
                Página: <span id="page"></span>
            </div>
        </div>
    </div> 
    
<script>
// Paginación
let current_page = 1;
let records_per_page = 10;

function prevPage() {
    if (current_page > 1) {
        current_page--;
        changePage(current_page);
    }
}

function nextPage() {
    if (current_page < numPages()) {
        current_page++;
        changePage(current_page);
    }
}

function changePage(page) {
    const table = document.getElementById("usersTable");
    const rows = table.getElementsByTagName("tr");
    const page_span = document.getElementById("page");

    if (page < 1) page = 1;
    if (page > numPages()) page = numPages();

    for (let i = 0; i < rows.length; i++) {
        rows[i].style.display = "none";
    }

    for (let i = (page - 1) * records_per_page; i < (page * records_per_page) && i < rows.length; i++) {
        rows[i].style.display = "table-row";
    }
    page_span.innerHTML = page;
}

function numPages() {
    return Math.ceil(document.getElementById("usersTable").getElementsByTagName("tr").length / records_per_page);
}

window.onload = function () {
    changePage(1);
};

// Filtrado por columna
function filterTable(columnIndex) {
    const input = document.getElementsByTagName("input")[columnIndex];
    const filter = input.value.toUpperCase();
    const table = document.getElementById("usersTable");
    const rows = table.getElementsByTagName("tr");

    for (let i = 0; i < rows.length; i++) {
        const cells = rows[i].getElementsByTagName("td");
        if (cells) {
            const cellText = cells[columnIndex].textContent || cells[columnIndex].innerText;
            rows[i].style.display = cellText.toUpperCase().indexOf(filter) > -1 ? "" : "none";
        }
    }
}
</script>

<footer class="footer">
    <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
</footer>
</body>
</html>