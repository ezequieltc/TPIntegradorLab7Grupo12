<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Dominio.Cuenta" %>
<!DOCTYPE html>
<html lang="es">
<%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Alta Cuenta");
%>
<head>
<% request.setAttribute("rolPermitido", UserTypes.ADMIN); %>
	<%@include file="../../components/header.jsp"%>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
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
	          
	            right: 20px;
	        }
	</style>
</head>
  
  

 
<body>
	<%@include file="../../components/pre-body.jsp"%>
        <h2 class="my-4">Gestión de Cuentas</h2>

        <div class="step">
            <h4>Buscar Cuenta</h4>
            <form class="needs-validation" action="${pageContext.request.contextPath}/Administrador/Cuentas/ServletModificarEliminarCuenta" method="POST">
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
                
                <form class="needs-validation" action="${pageContext.request.contextPath}/Administrador/Cuentas/ServletModificarEliminarCuenta" method="POST">
                    <div style="padding-bottom:50px;">
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
                                    <option value="1" <%= 1 == cuentaDatos.getTipoCuenta().getId() ? "selected" : "" %>>Cuenta Corriente</option>
                                    <option value="2" <%= 2 == cuentaDatos.getTipoCuenta().getId() ? "selected" : "" %>>Caja de Ahorro</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="editFechaAltaCuenta">Fecha de Alta</label>
                                <input type="date" id="editFechaAltaCuenta" name="editFechaAltaCuenta" class="form-control" required value="<%= cuentaDatos.getFechaCreacion() %>" readonly>
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
                                <input type="number" id="editSaldo" name="editSaldo" class="form-control" min="0" required readonly value="<%= cuentaDatos.getSaldo() %>">
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
                    </div>
                </form>
                <% } %>
            </div>
        </div>
	
	<%@include file="../../components/post-body.jsp"%>
    
    <script>
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
