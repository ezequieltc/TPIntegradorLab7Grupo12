<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BancArg - Listado de Cuentas</title>
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
        <a href="#">Transferencias</a>
        <a href="#">Préstamos</a> 
        <a href="#">Ajustes</a>
    </div>

    <div class="content-container">
        <h2 class="my-4">Listado de Cuentas</h2>
        <div class="table-container">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th><input type="text" placeholder="DNI Usuario" onkeyup="filterTable(0)"></th>
                        <th><input type="text" placeholder="Tipo de Cuenta" onkeyup="filterTable(1)"></th>
                        <th><input type="text" placeholder="Fecha de Alta" onkeyup="filterTable(2)"></th>
                        <th><input type="text" placeholder="Número de Cuenta" onkeyup="filterTable(3)"></th>
                        <th><input type="text" placeholder="CBU" onkeyup="filterTable(4)"></th>
                        <th><input type="text" placeholder="Saldo" onkeyup="filterTable(5)"></th>
                    </tr>
                    <tr>
                        <th>DNI Usuario</th>
                        <th>Tipo de Cuenta</th>
                        <th>Fecha de Alta</th>
                        <th>Número de Cuenta</th>
                        <th>CBU</th>
                        <th>Saldo</th>
                    </tr>
                </thead>
                <tbody id="accountsTable">
                    <!-- Aquí irán los datos de las cuentas traídas desde la base de datos -->
                    <%-- Ejemplo estático para ilustración --%>
                    <tr><td>12345678</td><td>Caja de Ahorro</td><td>2024-01-01</td><td>00012345</td><td>1234567890123456789012</td><td>15000</td></tr>
                    <tr><td>87654321</td><td>Cuenta Corriente</td><td>2024-02-15</td><td>00054321</td><td>9876543210987654321098</td><td>20000</td></tr>
                    <!-- Fin de ejemplo -->
                </tbody>
            </table>
            <div class="pagination">
                <button onclick="prevPage()" id="btn_prev">Anterior</button>
                <button onclick="nextPage()" id="btn_next">Siguiente</button>
                Página: <span id="page"></span>
            </div>
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
    const table = document.getElementById("accountsTable");
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
    return Math.ceil(document.getElementById("accountsTable").getElementsByTagName("tr").length / records_per_page);
}

window.onload = function () {
    changePage(1);
};

// Filtrado por columna
function filterTable(columnIndex) {
    const input = document.getElementsByTagName("input")[columnIndex];
    const filter = input.value.toUpperCase();
    const table = document.getElementById("accountsTable");
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
