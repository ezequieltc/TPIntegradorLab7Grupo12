<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BancArg - Alta de Cuenta</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layout.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
.step {
    padding: 40px;
    background-color: #ffffff;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    min-height: 500px;
    overflow-y: auto;
    position: relative;
}

.step .form-group, .step .beneficiary-details {
    margin-bottom: 20px;
}

.step .step-actions {
    position: absolute;
    bottom: 20px;
    right: 20px;
}

.transferForm {
    height: calc(100% - 100px);
}

.modal-content.success {
    background-color: #d4edda;
    border-color: #c3e6cb;
}

.modal-header.success {
    background-color: #28a745;
    color: white;
}

.modal-content.error {
    background-color: #f8d7da;
    border-color: #f5c6cb;
}

.modal-header.error {
    background-color: #dc3545;
    color: white;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
$(document).ready(function() {
    // Asegurar que solo un checkbox esté seleccionado
    $('input[name="searchBy"]').on('change', function() {
        if ($('#searchByCbu').is(':checked')) {
            $('#searchInput').attr('placeholder', 'Buscar por CBU');
        } else if ($('#searchByAccountNumber').is(':checked')) {
            $('#searchInput').attr('placeholder', 'Buscar por número de cuenta');
        } else {
            $('#searchInput').attr('placeholder', 'Buscar por número de cuenta o CBU');
        }
    });

    // Inicializar el placeholder según el checkbox seleccionado al cargar la página
    if ($('#searchByCbu').is(':checked')) {
        $('#searchInput').attr('placeholder', 'Buscar por CBU');
    } else if ($('#searchByAccountNumber').is(':checked')) {
        $('#searchInput').attr('placeholder', 'Buscar por número de cuenta');
    }
});
</script>
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
            <h2 class="my-4">Gestión de Cuentas</h2>

            <!-- Formulario de búsqueda -->
            <div class="step">
                <h4>Buscar Cuenta</h4>
                <form class="needs-validation" action="${pageContext.request.contextPath}/ServletCuentas" method="POST">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="text" id="searchInput" class="form-control" name="searchInput" placeholder="Buscar por número de cuenta o CBU" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="searchByCbu" name="searchBy" value="cbu">
                                    <label class="form-check-label" for="searchByCbu">Buscar por CBU</label>
                                </div>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="searchByAccountNumber" name="searchBy" value="numeroCuenta">
                                    <label class="form-check-label" for="searchByAccountNumber">Buscar por número de cuenta</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="step-actions">
                        <button type="submit" class="btn btn-primary">Buscar</button>
                    </div>
                </form>
            </div>

            <!-- Formulario para editar cuenta -->
            <h4 class="my-4">Editar Cuenta</h4>
            <div id="editForm" class="w-100">
                <div class="step">
                    <h4>Editar Información de la Cuenta</h4>
                    <form class="needs-validation" action="${pageContext.request.contextPath}/ServletCuentas" method="POST">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group has-validation">
                                    <label for="editDniUsuario">DNI Usuario</label>
                                    <input type="text" id="editDniUsuario" class="form-control" name="editDniUsuario" placeholder="Ingrese el DNI del usuario" maxlength="8" pattern="\d{8}" title="Debe contener exactamente 8 dígitos numéricos." required>
                                </div>
                                <div class="form-group">
                                    <label for="editTipoCuenta">Tipo de Cuenta</label>
                                    <select id="editTipoCuenta" class="form-control" name="editTipoCuenta">
                                        <option value="caja de ahorro">Caja de Ahorro</option>
                                        <option value="cuenta corriente">Cuenta Corriente</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="editFechaAltaCuenta">Fecha de Alta</label>
                                    <input type="date" id="editFechaAltaCuenta" name="editFechaAltaCuenta" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="editNumeroCuenta">Número de cuenta</label>
                                    <input type="text" id="editNumeroCuenta" class="form-control" name="editNumeroCuenta" placeholder="Número de cuenta" maxlength="8" pattern="\d{8}" title="Debe contener exactamente 8 dígitos numéricos." required>
                                </div>
                                <div class="form-group">
                                    <label for="editSaldo">Saldo Inicial</label>
                                    <input type="number" id="editSaldo" name="editSaldo" class="form-control" placeholder="$10000" value="10000" step="100" min="0">
                                </div>
                            </div>
                        </div>
                        <div class="step-actions">
                            <button type="submit" class="btn btn-warning" id="modificarCuenta">Modificar Cuenta</button>
                            <button type="submit" class="btn btn-danger" id="eliminarCuenta">Eliminar Cuenta</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
