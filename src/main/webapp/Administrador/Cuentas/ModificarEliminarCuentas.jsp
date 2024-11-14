<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Dominio.Cuenta" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BancArg - Alta de Cuenta</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layout.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .step {
            padding: 40px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            min-height: 300px;
            overflow-y: auto;
            position: relative;
        }
        .step .form-group {
            margin-bottom: 20px;
        }
        .step-actions {
            position: absolute;
            bottom: 20px;
            right: 20px;
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
            <h2 class="my-4">Gestión de Cuentas</h2>

            <div class="step">
                <h4>Buscar Cuenta</h4>
                <form class="needs-validation" action="${pageContext.request.contextPath}/ServletCuentas" method="POST">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="busquedaCBU">Buscar por CBU</label>
                                <input type="text" id="busquedaCBU" class="form-control" name="busquedaCBU" placeholder="Ingrese el CBU" pattern="\d*" title="El CBU debe contener solo números">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="busquedaNumeroCuenta">Buscar por Número de Cuenta</label>
                                <input type="text" id="busquedaNumeroCuenta" class="form-control" name="busquedaNumeroCuenta" placeholder="Ingrese el número de cuenta" pattern="\d*" title="El número de cuenta debe contener solo números">
                            </div>
                        </div>
                    </div>
                    <div class="step-actions">
                        <button type="submit" name="botonBuscarCuenta" id="botonBuscarCuenta" class="btn btn-primary" disabled>Buscar</button>
                    </div>
                </form>
            </div>

            <h4 class="my-4">Editar Cuenta</h4>
            <div id="editForm" class="w-100">
                <div class="step">
                    <h4>Editar Información de la Cuenta</h4>
                    <% 
                        Cuenta cuentaDatos = (Cuenta) request.getAttribute("cuenta");
                        if (cuentaDatos != null) {
                    %>
                    <form class="needs-validation" action="${pageContext.request.contextPath}/ServletCuentas" method="POST">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                	<input type="hidden" id="idCuenta" name="idCuenta" value=<%= cuentaDatos.getId() %>>
                                    <label for="editDniUsuario">DNI Usuario</label>
                                    <input type="text" id="editDniUsuario" class="form-control" name="editDniUsuario" required readonly value="<%= cuentaDatos.getPersona().getDni() %>">
                                </div>
                                <div class="form-group">
                                    <label for="editTipoCuenta">Tipo de Cuenta</label>
                                    <select id="editTipoCuenta" class="form-control" name="editTipoCuenta">
                                        <option value="caja de ahorro" <%= "caja de ahorro".equals(cuentaDatos.getTipoCuenta().getDescripcion()) ? "selected" : "" %>>Caja de Ahorro</option>
                                        <option value="cuenta corriente" <%= "cuenta corriente".equals(cuentaDatos.getTipoCuenta().getDescripcion()) ? "selected" : "" %>>Cuenta Corriente</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="editFechaAltaCuenta">Fecha de Alta</label>
                                    <input type="date" id="editFechaAltaCuenta" name="editFechaAltaCuenta" class="form-control" required value="<%= cuentaDatos.getFechaCreacion() %>">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="editNumeroCuenta">Número de cuenta</label>
                                    <input type="text" id="editNumeroCuenta" class="form-control" name="editNumeroCuenta" required readonly value="<%= cuentaDatos.getNumeroCuenta() %>">
                                </div>
                                <div class="form-group">
                                    <label for="editCBU">CBU</label>
                                    <input type="text" id="editCBU" class="form-control" name="editCBU" required readonly value="<%= cuentaDatos.getCbu() %>">
                                </div>
                                <div class="form-group">
                                    <label for="editSaldo">Saldo</label>
                                    <input type="number" id="editSaldo" name="editSaldo" class="form-control" required value="<%= cuentaDatos.getSaldo() %>">
                                </div>
                                <div class="form-group">
                                    <label for="editEstadoCuenta">Estado Cuenta</label>
                                    <select id="editEstadoCuenta" class="form-control" name="editEstadoCuenta" style="pointer-events: none;">
                                        <option value="activa" <%= cuentaDatos.isEstado() ? "selected" : "" %>>Activa</option>
                                        <option value="inactiva" <%= !cuentaDatos.isEstado() ? "selected" : "" %>>Inactiva</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="step-actions">
                            <% if (cuentaDatos.isEstado()) { %>
                            <button type="submit" class="btn btn-warning" name="modificarCuenta" id="modificarCuenta" onclick="return confirm('¿Está seguro de que desea actualizar los datos de esta cuenta?')">Modificar Cuenta</button>
                                <button type="submit" class="btn btn-danger" name="eliminarCuenta" id="eliminarCuenta" onclick="return confirm('¿Está seguro de que desea eliminar esta cuenta?')">Eliminar Cuenta</button>
                            <% } else { %>
                                <button type="submit" class="btn btn-success" name="reactivarCuenta" id="reactivarCuenta" onclick="return confirm('¿Está seguro de que desea reactivar esta cuenta?')">Reactivar Cuenta</button>
                            <% } %>
                        </div>
                    </form>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    	<div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content success">
				<div class="modal-header success">
					<h5 class="modal-title">Éxito</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<%= request.getAttribute("mensajeExito") != null ? request.getAttribute("mensajeExito") : "¡Acción ejecutada exitosamente!" %>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content error">
				<div class="modal-header error">
					<h5 class="modal-title">Error</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<%= request.getAttribute("mensajeError") != null ? request.getAttribute("mensajeError") : "Hubo un error al crear la cuenta. Por favor, inténtelo nuevamente." %>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>
    

    <script>
    $(document).ready(function(){
        <% if (request.getAttribute("mostrarPopUp") != null && "success".equals(request.getAttribute("popUpStatus"))) { %>
            var successModal = new bootstrap.Modal(document.getElementById('successModal'));
            successModal.show();
        <% } else if (request.getAttribute("mostrarPopUp") != null && "error".equals(request.getAttribute("popUpStatus"))) { %>
            var errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
            errorModal.show();
        <% } %>
    });

    $(document).ready(function() {
        $('#busquedaCBU, #busquedaNumeroCuenta').on('input', function() {
            let cbuVal = $('#busquedaCBU').val();
            let cuentaVal = $('#busquedaNumeroCuenta').val();
            $('#botonBuscarCuenta').prop('disabled', !(cbuVal || cuentaVal));
        });
    });
    </script>
</body>
</html>
