<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Dominio.Prestamo" %>
<%@ page import="Dominio.Cuenta" %>
<%@ page import="Dominio.Movimiento" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<%
    request.setAttribute("pageTitle", "Informes y Reportes");
%>
<head>
<% request.setAttribute("rolPermitido", UserTypes.ADMIN); %>
    <%@include file="../components/header.jsp"%>
    <style>
        
        .step .form-group, .step .beneficiary-details {
            margin-bottom: 20px;
        }
        .step .step-actions {
            position: absolute;
            bottom: 20px;
            right: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
            color: #333;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
        }
        h4 {
            margin-top: 30px;
            color: #333;
        }
        p {
            color: #333;
        }
        .report-info-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .report-info-table td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        .report-info-table td:first-child {
            font-weight: bold;
            width: 60%;
        }
        .report-info-table td:last-child {
            width: 40%;
            text-align: right;
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
        <%
            String tipoReporte = request.getParameter("tipoReporte");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

            if (tipoReporte != null && tipoReporte.equals("prestamos")) {
                ArrayList<Prestamo> prestamos = (ArrayList<Prestamo>) request.getAttribute("reporte");
                if (prestamos != null && !prestamos.isEmpty()) {
                    double montoTotalPrestamos = (double) request.getAttribute("montoTotalPrestamos");
                    int numeroPrestamos = (int) request.getAttribute("numeroPrestamos");
                    double montoPromedioPrestamos = (double) request.getAttribute("montoPromedioPrestamos");
                    int aprobados = (int) request.getAttribute("aprobados");
                    int pendientes = (int) request.getAttribute("pendientes");
                    int rechazados = (int) request.getAttribute("rechazados");
        %>
        <h4>Reporte de Préstamos</h4>
        <table class="report-info-table">
            <tr>
                <td>Monto Total de Préstamos:</td>
                <td>$<%= String.format("%.2f", montoTotalPrestamos) %></td>
            </tr>
            <tr>
                <td>Número de Préstamos:</td>
                <td><%= numeroPrestamos %></td>
            </tr>
            <tr>
                <td>Monto Promedio por Préstamo:</td>
                <td>$<%= String.format("%.2f", montoPromedioPrestamos) %></td>
            </tr>
            <tr>
                <td>Préstamos Aprobados:</td>
                <td><%= aprobados %></td>
            </tr>
            <tr>
                <td>Préstamos Pendientes:</td>
                <td><%= pendientes %></td>
            </tr>
            <tr>
                <td>Préstamos Rechazados:</td>
                <td><%= rechazados %></td>
            </tr>
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
                    int numeroCuentas = (int) request.getAttribute("numeroCuentas");
                    double saldoPromedioCuentas = (double) request.getAttribute("saldoPromedioCuentas");
                    int cuentasActivas = (int) request.getAttribute("cuentasActivas");
                    int cuentasInactivas = (int) request.getAttribute("cuentasInactivas");
                    int cuentasCorriente = (int) request.getAttribute("cuentasCorriente");
                    int cuentasCajaAhorro = (int) request.getAttribute("cuentasCajaAhorro");
        %>
        <h4>Reporte de Cuentas</h4>
        <table class="report-info-table">
            <tr>
                <td>Número de Cuentas:</td>
                <td><%= numeroCuentas %></td>
            </tr>
            <tr>
                <td>Saldo Promedio por Cuenta:</td>
                <td>$<%= String.format("%.2f", saldoPromedioCuentas) %></td>
            </tr>
            <tr>
                <td>Cuentas Activas:</td>
                <td><%= cuentasActivas %></td>
            </tr>
            <tr>
                <td>Cuentas Inactivas:</td>
                <td><%= cuentasInactivas %></td>
            </tr>
            <tr>
                <td>Cantidad de Cuentas Corriente:</td>
                <td><%= cuentasCorriente %></td>
            </tr>
            <tr>
                <td>Cantidad de Cuentas Caja de Ahorro:</td>
                <td><%= cuentasCajaAhorro %></td>
            </tr>
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
                    double montoTotalMovimientos = (double) request.getAttribute("montoTotalMovimientos");
                    int numeroMovimientos = (int) request.getAttribute("numeroMovimientos");
                    double montoPromedioMovimientos = (double) request.getAttribute("montoPromedioMovimientos");
                    int depositos = (int) request.getAttribute("contadorDepositos");
                    int retiros = (int) request.getAttribute("contadorRetiros");
                    int transferencias = (int) request.getAttribute("contadorTransferencias");

                    
        %>
        <h4>Reporte de Movimientos</h4>
        <table class="report-info-table">
            <tr>
                <td>Monto Total de Movimientos:</td>
                <td>$<%= String.format("%.2f", montoTotalMovimientos) %></td>
            </tr>
            <tr>
                <td>Número de Movimientos:</td>
                <td><%= numeroMovimientos %></td>
            </tr>
            <tr>
                <td>Monto Promedio por Movimiento:</td>
                <td>$<%= String.format("%.2f", montoPromedioMovimientos) %></td>
            </tr>
            <tr>
    			<td>Depósitos:</td>
    			<td><%= depositos %></td>
			</tr>
			<tr>
    			<td>Retiros:</td>
    			<td><%= retiros %></td>
			</tr>
			<tr>
    			<td>Transferencias:</td>
    			<td><%= transferencias %></td>
			</tr>
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
