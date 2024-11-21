<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Dominio.Prestamo" %>
<%@ page import="Dominio.Cuenta" %>
<%@ page import="Dominio.Movimiento" %>

<!DOCTYPE html>
<html>
<%
    request.setAttribute("pageTitle", "Informes y Reportes");
%>
<%@include file="../components/header.jsp"%>
<head>
    <style>
        .step {
            padding: 40px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            min-height: 450px;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <%@include file="../components/pre-body.jsp"%>
    <h2 class="my-4">Informes y Reportes</h2>
    <div class="step">
        <h4>Generar Informes y Reportes</h4>
        <form action="<%= request.getContextPath() %>/Administrador/Usuarios/ServletReportes" method="POST">
            <div class="form-group">
                <label for="tipoReporte">Tipo de Reporte</label>
                <select id="tipoReporte" class="form-control" name="tipoReporte">
                    <option value="">Seleccione una opción...</option>
                    <option value="prestamos">Préstamos</option>
                    <option value="cuentas">Cuentas</option>
                    <option value="movimientos">Movimientos</option>
                </select>
            </div>
            <div class="form-group">
                <label for="fechaInicio">Fecha de Inicio</label>
                <input type="date" id="fechaInicio" class="form-control" name="fechaDesde">
            </div>
            <div class="form-group">
                <label for="fechaFin">Fecha de Fin</label>
                <input type="date" id="fechaFin" class="form-control" name="fechaHasta">
            </div>
            <div>
                <button type="submit" class="btn btn-info btn-sm ms-2" name="generarReporte" id="generarReporte">Generar Reporte</button>
            </div>
        </form>

        <!-- Mostrar reportes -->
        <%
            String tipoReporte = request.getParameter("tipoReporte");

            if (tipoReporte != null && tipoReporte.equals("prestamos")) {
                ArrayList<Prestamo> prestamos = (ArrayList<Prestamo>) request.getAttribute("reporte");
                if (prestamos != null && !prestamos.isEmpty()) {
        %>
        <h4 class="mt-4">Reporte de Préstamos</h4>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Cliente</th>
                    <th>Monto</th>
                    <th>Fecha Alta</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Prestamo prestamo : prestamos) { %>
                <tr>
                    <td><%= prestamo.getId() %></td>
                    <td><%= prestamo.getPersona().getNombre() %></td>
                    <td><%= prestamo.getImporte() %></td>
                    <td><%= prestamo.getFecha_alta() %></td>
                    <td><%= prestamo.getStatus() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
                } else {
        %>
        <p class="mt-4">No se encontraron préstamos para las fechas seleccionadas.</p>
        <%
                }
            } else if (tipoReporte != null && tipoReporte.equals("cuentas")) {
                ArrayList<Cuenta> cuentas = (ArrayList<Cuenta>) request.getAttribute("reporte");
                if (cuentas != null && !cuentas.isEmpty()) {
        %>
        <h4 class="mt-4">Reporte de Cuentas</h4>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Cliente</th>
                    <th>Tipo de Cuenta</th>
                    <th>Saldo</th>
                    <th>Fecha de Creación</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Cuenta cuenta : cuentas) { %>
                <tr>
                    <td><%= cuenta.getId() %></td>
                    <td><%= cuenta.getPersona().getNombre() %></td>
                    <td><%= cuenta.getTipoCuenta().getDescripcion() %></td>
                    <td><%= cuenta.getSaldo() %></td>
                    <td><%= cuenta.getFechaCreacion() %></td>
                    <td><%= cuenta.isEstado() ? "Activa" : "Inactiva" %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
                } else {
        %>
        <p class="mt-4">No se encontraron cuentas para las fechas seleccionadas.</p>
        <%
                }
            } else if (tipoReporte != null && tipoReporte.equals("movimientos")) {
                ArrayList<Movimiento> movimientos = (ArrayList<Movimiento>) request.getAttribute("reporte");
                if (movimientos != null && !movimientos.isEmpty()) {
        %>
        <h4 class="mt-4">Reporte de Movimientos</h4>
        <table>
            <thead>
                <tr>
                    <th>ID Movimiento</th>
                    <th>ID Cuenta</th>
                    <th>Tipo Movimiento</th>
                    <th>Fecha</th>
                    <th>Detalle</th>
                    <th>Importe</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Movimiento movimiento : movimientos) { %>
                <tr>
                    <td><%= movimiento.getId() %></td>
                    <td><%= movimiento.getIdCuenta() %></td>
                    <td><%= movimiento.getTipoMovimiento().getDescripcion() %></td>
                    <td><%= movimiento.getFecha() %></td>
                    <td><%= movimiento.getDetalle() %></td>
                    <td><%= movimiento.getImporte() %></td>
                    <td><%= movimiento.getEstado() ? "Activo" : "Inactivo" %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
                } else {
        %>
        <p class="mt-4">No se encontraron movimientos para las fechas seleccionadas.</p>
        <%
                }
            } else {
        %>
        <p class="mt-4">No se encontraron datos para el tipo de reporte seleccionado.</p>
        <%
            }
        %>
    </div>
    <%@include file="../components/post-body.jsp"%>
</body>
</html>