<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="Dominio.Prestamo" %>
<%@ page import="Dominio.Persona" %>
<%@ page import="Dominio.Cuenta" %>
<%@ page import="Dominio.TipoCuenta" %>

<!DOCTYPE html>
<html>
<head>
    <%@include file="../../components/header.jsp"%>
    <title>BancArg - Home Administrador</title>
    <style>
        table {
            margin-top: 30px;
            width: 100%;
            background-color: white;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .titulo {
            font-size: 1em;      
            font-weight: normal; 
            color: #555;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <%@include file="../../components/pre-body.jsp"%>

    <div class="container">
        <h2 class="text-center">Panel del Administrador</h2>

        <!-- Tabla de Préstamos -->
        <h5 class="titulo">Préstamos Recientes</h5>
        <% 
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <table class="table table-bordered table-hover">
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
                <%
                    try {
                        List<Prestamo> prestamos = (List<Prestamo>) request.getAttribute("listadoPrestamos");
                        if (prestamos != null && !prestamos.isEmpty()) {
                            for (Prestamo prestamo : prestamos) {
                %>
                <tr>
                    <td><%= prestamo.getId() %></td>
                    <td><%= (prestamo.getPersona() != null) ? prestamo.getPersona().getNombre() + " " + prestamo.getPersona().getApellido() : "Sin nombre" %></td>
                    <td><%= prestamo.getImporte() %></td>
                    <td><%= dateFormat.format(prestamo.getFecha_alta()) %></td>
                    <td><%= prestamo.getStatus() %></td>
                </tr>
                <%
                            }
                        } else {
                %>
                <tr>
                    <td colspan="5">No se encontraron préstamos.</td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5'>Error al mostrar los préstamos: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>

        <!-- Tabla de Cuentas -->
        <h5 class="titulo" style="margin-top: 40px;">Altas de Cuenta Recientes</h5>
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Número de Cuenta</th>
                    <th>Cliente</th>
                    <th>Tipo de Cuenta</th>
                    <th>Fecha de Alta</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        List<Cuenta> cuentas = (List<Cuenta>) request.getAttribute("listadoCuentas");
                        if (cuentas != null && !cuentas.isEmpty()) {
                            for (Cuenta cuenta : cuentas) {
                %>
                <tr>
                    <td><%= cuenta.getNumeroCuenta() %></td>
                    <td><%= (cuenta.getPersona() != null) ? cuenta.getPersona().getNombre() + " " + cuenta.getPersona().getApellido() : "Sin nombre" %></td>
                    <td><%= (cuenta.getTipoCuenta() != null) ? cuenta.getTipoCuenta().getDescripcion() : "Sin tipo" %></td>
                    <td><%= dateFormat.format(cuenta.getFechaCreacion()) %></td>
                    <td><%= cuenta.isEstado() ? "Activa" : "Inactiva" %></td>
                </tr>
                <%
                            }
                        } else {
                %>
                <tr>
                    <td colspan="5">No se encontraron cuentas recientes.</td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5'>Error al mostrar las cuentas: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>

    <%@include file="../../components/post-body.jsp"%>
</body>
</html>
