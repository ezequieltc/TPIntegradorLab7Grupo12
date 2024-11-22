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
    <%@include file="../components/header.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        .chart-container {
            position: relative;
            margin: auto;
            height: 300px;
            width: 100%;
        }
        .report-table {
            width: 100%;
            margin-top: 20px;
        }
        .report-table td {
            vertical-align: top;
            padding: 10px;
        }
        .report-table .info-column {
            width: 50%;
        }
        .report-table .chart-column {
            width: 50%;
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
        .charts-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 20px;
        }
        .chart-item {
            flex: 1 1 30%;
            margin: 10px;
        }
        .chart-item canvas {
            width: 100% !important;
            height: auto !important;
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
                    Map<String, Integer> prestamosPorMes = (Map<String, Integer>) request.getAttribute("prestamosPorMes");
        %>
        <h4>Reporte de Préstamos</h4>
        <table class="report-info-table">
            <tr>
                <td>Cantidad de prestamos:</td>
                <td><%= numeroPrestamos %></td>
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
            <tr>
                <td>Monto Promedio por Préstamo:</td>
                <td>$<%= String.format("%.2f", montoPromedioPrestamos) %></td>
            </tr>
            <tr>
                <td>Dinero total prestado:</td>
                <td>$<%= String.format("%.2f", montoTotalPrestamos) %></td>
            </tr>
        </table>

        <div class="charts-container">
            <div class="chart-item">
                <canvas id="graficoPrestamosMonto"></canvas>
            </div>
            <div class="chart-item">
                <canvas id="graficoPrestamosEstado"></canvas>
            </div>
            <div class="chart-item">
                <canvas id="graficoPrestamosMes"></canvas>
            </div>
        </div>

        <script>
     
            var ctxEstado = document.getElementById('graficoPrestamosEstado').getContext('2d');
            var graficoPrestamosEstado = new Chart(ctxEstado, {
                type: 'pie',
                data: {
                    labels: ['Aprobados', 'Pendientes', 'Rechazados'],
                    datasets: [{
                        data: [<%= aprobados %>, <%= pendientes %>, <%= rechazados %>],
                        backgroundColor: ['rgba(75, 192, 192, 0.6)', 'rgba(255, 205, 86, 0.6)', 'rgba(255, 99, 132, 0.6)'],
                        borderColor: ['rgba(75, 192, 192, 1)', 'rgba(255, 205, 86, 1)', 'rgba(255, 99, 132, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true
                }
            });

            var ctxMes = document.getElementById('graficoPrestamosMes').getContext('2d');
            var labelsMes = <%= new ArrayList<>(prestamosPorMes.keySet()).toString() %>;
            var dataMes = <%= new ArrayList<>(prestamosPorMes.values()).toString() %>;
            var graficoPrestamosMes = new Chart(ctxMes, {
                type: 'line',
                data: {
                    labels: labelsMes,
                    datasets: [{
                        label: 'Número de Préstamos',
                        data: dataMes,
                        backgroundColor: 'rgba(153, 102, 255, 0.6)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        fill: false,
                        tension: 0.1
                    }]
                },
                options: {
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });
        </script>
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
                    Map<String, Integer> cuentasPorMes = (Map<String, Integer>) request.getAttribute("cuentasPorMes");
        %>
        <h4>Reporte de Cuentas</h4>
        <table class="report-info-table">
            <tr>
                <td>Número de Cuentas:</td>
                <td><%= numeroCuentas %></td>
            </tr>
            <tr>
                <td>Cuentas Activas:</td>
                <td><%= cuentasActivas %></td>
            </tr>
            <tr>
                <td>Cuentas que poseen prestamos]:</td>
                <td><%= cuentasInactivas %></td>
            </tr>
            <tr>
                <td>Saldo Promedio por Cuenta:</td>
                <td>$<%= String.format("%.2f", saldoPromedioCuentas) %></td>
            </tr>
        </table>

        <div class="charts-container">            
                <canvas id="graficoCuentasNumero"></canvas>
            </div>
            <div class="chart-item">
                <canvas id="graficoCuentasEstado"></canvas>
            </div>
            <div class="chart-item">
                <canvas id="graficoCuentasMes"></canvas>
            </div>
        </div>

        <script>
            var ctxNumero = document.getElementById('graficoCuentasNumero').getContext('2d');
            var graficoCuentasNumero = new Chart(ctxNumero, {
                type: 'bar',
                data: {
                    labels: ['Total Cuentas', 'Cuentas Activas'],
                    datasets: [{
                        label: 'Número de Cuentas',
                        data: [<%= numeroCuentas %>, <%= cuentasActivas %>],
                        backgroundColor: ['rgba(54, 162, 235, 0.6)', 'rgba(75, 192, 192, 0.6)'],
                        borderColor: ['rgba(54, 162, 235, 1)', 'rgba(75, 192, 192, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });

            var ctxEstado = document.getElementById('graficoCuentasEstado').getContext('2d');
            var graficoCuentasEstado = new Chart(ctxEstado, {
                type: 'pie',
                data: {
                    labels: ['Activas', 'Inactivas'],
                    datasets: [{
                        data: [<%= cuentasActivas %>, <%= cuentasInactivas %>],
                        backgroundColor: ['rgba(75, 192, 192, 0.6)', 'rgba(255, 99, 132, 0.6)'],
                        borderColor: ['rgba(75, 192, 192, 1)', 'rgba(255, 99, 132, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true
                }
            });

            var ctxMes = document.getElementById('graficoCuentasMes').getContext('2d');
            var labelsMes = <%= new ArrayList<>(cuentasPorMes.keySet()).toString() %>;
            var dataMes = <%= new ArrayList<>(cuentasPorMes.values()).toString() %>;
            var graficoCuentasMes = new Chart(ctxMes, {
                type: 'line',
                data: {
                    labels: labelsMes,
                    datasets: [{
                        label: 'Cuentas Creadas',
                        data: dataMes,
                        backgroundColor: 'rgba(255, 159, 64, 0.6)',
                        borderColor: 'rgba(255, 159, 64, 1)',
                        fill: false,
                        tension: 0.1
                    }]
                },
                options: {
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });
        </script>       
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
                    Map<String, Double> montoPorTipo = (Map<String, Double>) request.getAttribute("montoPorTipo");
                    Map<String, Integer> movimientosPorMes = (Map<String, Integer>) request.getAttribute("movimientosPorMes");
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
        </table>

        <div class="charts-container">
            <div class="chart-item">
                <canvas id="graficoMovimientosTipo"></canvas>
            </div>
            <div class="chart-item">
                <canvas id="graficoMovimientosNumero"></canvas>
            </div>
            <div class="chart-item">
                <canvas id="graficoMovimientosMes"></canvas>
            </div>
        </div>

        <script>
            var ctxTipo = document.getElementById('graficoMovimientosTipo').getContext('2d');
            var labelsTipo = <%= new ArrayList<>(montoPorTipo.keySet()).toString() %>;
            var dataTipo = <%= new ArrayList<>(montoPorTipo.values()).toString() %>;
            var graficoMovimientosTipo = new Chart(ctxTipo, {
                type: 'bar',
                data: {
                    labels: labelsTipo,
                    datasets: [{
                        label: 'Monto por Tipo ($)',
                        data: dataTipo,
                        backgroundColor: 'rgba(153, 102, 255, 0.6)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });

            var ctxNumero = document.getElementById('graficoMovimientosNumero').getContext('2d');
            var graficoMovimientosNumero = new Chart(ctxNumero, {
                type: 'doughnut',
                data: {
                    labels: ['Total Movimientos'],
                    datasets: [{
                        data: [<%= numeroMovimientos %>],
                        backgroundColor: ['rgba(54, 162, 235, 0.6)'],
                        borderColor: ['rgba(54, 162, 235, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true
                }
            });

            var ctxMes = document.getElementById('graficoMovimientosMes').getContext('2d');
            var labelsMes = <%= new ArrayList<>(movimientosPorMes.keySet()).toString() %>;
            var dataMes = <%= new ArrayList<>(movimientosPorMes.values()).toString() %>;
            var graficoMovimientosMes = new Chart(ctxMes, {
                type: 'line',
                data: {
                    labels: labelsMes,
                    datasets: [{
                        label: 'Movimientos',
                        data: dataMes,
                        backgroundColor: 'rgba(255, 206, 86, 0.6)',
                        borderColor: 'rgba(255, 206, 86, 1)',
                        fill: false,
                        tension: 0.1
                    }]
                },
                options: {
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });
        </script>        
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
    <%@include file="../components/post-body.jsp"%>
</body>
</html>
