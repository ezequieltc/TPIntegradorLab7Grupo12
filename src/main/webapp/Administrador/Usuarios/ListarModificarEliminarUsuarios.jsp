<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dominio.Persona" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
  <%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Listado Usuarios");
  %>
<head>
<%@include  file="../../components/header.jsp"%>
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
<%@include  file="../../components/pre-body.jsp"%>
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
                   <th><input type="text" placeholder="Estado" onkeyup="filterTable(14)"></th>
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
                   <th>Estado</th>
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
              <form action="${pageContext.request.contextPath}/Administrador/Usuarios/ServletUsuarios" method="get">
          <td><%=persona.getId()%></td> <input type="hidden" name="id" value="<%=persona.getId() %>"></td>
          <td><%=persona.getUsuario().getId()%> 
          <td><%=persona.getDni() %></td>
          <td><%=persona.getCuil() %></td>
          <td><%=persona.getNombre() %></td>
          <td><%=persona.getApellido() %></td>
          <td><%=persona.getTipoSexo().getDescripcion() %></td>
          <td><%=persona.getNacionalidad() %></td>
          <td><%=persona.getFechaNacimiento() %></td>
          <td><%=persona.getDireccion() %></td>
          <td><%=persona.getLocalidad() %></td>
          <td><%=persona.getProvincia() %></td>
          <td><%=persona.getEmail() %></td>
          <td><%=persona.getTelefono()%></td>
          <td><%=persona.isEstado() ? "Activa" : "Baja"%></td>

          		<td><input type="submit" name="btnModificarUsuario" class="btn btn-success" value="Modificar"></td>		           
          <td><input type="submit" name="btnEliminarUsuario" class="btn btn-danger" value="Eliminar"></td>
	</form>
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
 <%@include  file="../../components/post-body.jsp"%>
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

</body>
</html>