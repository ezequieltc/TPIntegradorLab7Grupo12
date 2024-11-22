package Presentacion.Administrador.Reportes;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DaoImpl.PrestamoDaoImpl;
import Dominio.Cuenta;
import Dominio.Movimiento;
import Dominio.Prestamo;
import NegocioImpl.CuentaNegocioImpl;
import NegocioImpl.MovimientoNegocioImpl;

@WebServlet("/Administrador/Usuarios/ServletReportes")
public class ServletReportes extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ServletReportes() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Administrador/InformesReportes.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoReporte = request.getParameter("tipoReporte");
        String fechaDesde = request.getParameter("fechaDesde");
        String fechaHasta = request.getParameter("fechaHasta");

        System.out.println("Tipo de Reporte: " + tipoReporte);
        System.out.println("Fecha Desde: " + fechaDesde);
        System.out.println("Fecha Hasta: " + fechaHasta);

        if (tipoReporte == null || tipoReporte.isEmpty()) {
            request.setAttribute("error", "Debe seleccionar un tipo de reporte.");
            request.getRequestDispatcher("/Administrador/InformesReportes.jsp").forward(request, response);
            return;
        }

        try {
            if (tipoReporte.equals("prestamos")) {
                Date fechaInicioDate = Date.valueOf(fechaDesde);
                Date fechaFinDate = Date.valueOf(fechaHasta);
                PrestamoDaoImpl prestamoDao = new PrestamoDaoImpl();
                ArrayList<Prestamo> prestamos = prestamoDao.getPrestamos();
                Iterator<Prestamo> iterator = prestamos.iterator();
                while (iterator.hasNext()) {
                    Prestamo prestamo = iterator.next();
                    if (prestamo.getFecha_alta().before(fechaInicioDate) || prestamo.getFecha_alta().after(fechaFinDate)) {
                        iterator.remove();
                    }
                }
                double montoTotal = 0;
                int numeroPrestamos = prestamos.size();
                int aprobados = 0;
                int pendientes = 0;
                int rechazados = 0;
                Map<String, Integer> prestamosPorMes = new TreeMap<>();
                SimpleDateFormat monthFormat = new SimpleDateFormat("MM-yyyy");

                for (Prestamo prestamo : prestamos) {
                    montoTotal += prestamo.getImporte();
                    String status = prestamo.getStatus().toString();
                    if (status.equalsIgnoreCase("En_Curso")) {
                        aprobados++;
                    } else if (status.equalsIgnoreCase("Pendiente")) {
                        pendientes++;
                    } else if (status.equalsIgnoreCase("Rechazado")) {
                        rechazados++;
                    }                  
                }

                double montoPromedio = numeroPrestamos > 0 ? montoTotal / numeroPrestamos : 0;
                request.setAttribute("montoTotalPrestamos", montoTotal);
                request.setAttribute("numeroPrestamos", numeroPrestamos);
                request.setAttribute("montoPromedioPrestamos", montoPromedio);
                request.setAttribute("aprobados", aprobados);
                request.setAttribute("pendientes", pendientes);
                request.setAttribute("rechazados", rechazados);
                request.setAttribute("reporte", prestamos);

            } else if (tipoReporte.equals("cuentas")) {
                Date fechaInicioDate = Date.valueOf(fechaDesde);
                Date fechaFinDate = Date.valueOf(fechaHasta);
                CuentaNegocioImpl cuentaNegocio = new CuentaNegocioImpl();
                ArrayList<Cuenta> cuentas = cuentaNegocio.readAll();
                Iterator<Cuenta> iterator = cuentas.iterator();
                while (iterator.hasNext()) {
                    Cuenta cuenta = iterator.next();
                    if (cuenta.getFechaCreacion().before(fechaInicioDate) || cuenta.getFechaCreacion().after(fechaFinDate)) {
                        iterator.remove();
                    }
                }

                // Calcular estadísticas
                int numeroCuentas = cuentas.size();
                double saldoTotal = 0;
                int cuentasActivas = 0;
                int cuentasInactivas = 0;
                Map<String, Integer> cuentasPorMes = new TreeMap<>();
                SimpleDateFormat monthFormat = new SimpleDateFormat("MM-yyyy");

                for (Cuenta cuenta : cuentas) {
                    saldoTotal += cuenta.getSaldo();

                    // Contar por estado
                    if (cuenta.isEstado()) {
                        cuentasActivas++;
                    } else {
                        cuentasInactivas++;
                    }

                    // Contar cuentas por mes
                    String mes = monthFormat.format(cuenta.getFechaCreacion());
                    cuentasPorMes.put(mes, cuentasPorMes.getOrDefault(mes, 0) + 1);
                }

                double saldoPromedio = numeroCuentas > 0 ? saldoTotal / numeroCuentas : 0;

                // Pasar estadísticas al JSP
                request.setAttribute("numeroCuentas", numeroCuentas);
                request.setAttribute("saldoPromedioCuentas", saldoPromedio);
                request.setAttribute("cuentasActivas", cuentasActivas);
                request.setAttribute("cuentasInactivas", cuentasInactivas);
                request.setAttribute("cuentasPorMes", cuentasPorMes);

                request.setAttribute("reporte", cuentas);
            } else if (tipoReporte.equals("movimientos")) {
                Date fechaInicioDate = Date.valueOf(fechaDesde);
                Date fechaFinDate = Date.valueOf(fechaHasta);
                MovimientoNegocioImpl movimientoNegocio = new MovimientoNegocioImpl();
                ArrayList<Movimiento> movimientos = (ArrayList<Movimiento>) movimientoNegocio.obtenerTodosLosMovimientos();
                Iterator<Movimiento> iterator = movimientos.iterator();
                while (iterator.hasNext()) {
                    Movimiento movimiento = iterator.next();
                    if (movimiento.getFecha().before(fechaInicioDate) || movimiento.getFecha().after(fechaFinDate)) {
                        iterator.remove();
                    }
                }

                // Calcular estadísticas
                double montoTotal = 0;
                int numeroMovimientos = movimientos.size();
                Map<String, Double> montoPorTipo = new HashMap<>();
                Map<String, Integer> movimientosPorMes = new TreeMap<>();
                SimpleDateFormat monthFormat = new SimpleDateFormat("MM-yyyy");

                for (Movimiento movimiento : movimientos) {
                    montoTotal += movimiento.getImporte();

                    // Acumular montos por tipo de movimiento
                    String tipo = movimiento.getTipoMovimiento().getDescripcion();
                    montoPorTipo.put(tipo, montoPorTipo.getOrDefault(tipo, 0.0) + movimiento.getImporte());

                    // Contar movimientos por mes
                    String mes = monthFormat.format(movimiento.getFecha());
                    movimientosPorMes.put(mes, movimientosPorMes.getOrDefault(mes, 0) + 1);
                }

                double montoPromedio = numeroMovimientos > 0 ? montoTotal / numeroMovimientos : 0;

                // Pasar estadísticas al JSP
                request.setAttribute("montoTotalMovimientos", montoTotal);
                request.setAttribute("numeroMovimientos", numeroMovimientos);
                request.setAttribute("montoPromedioMovimientos", montoPromedio);
                request.setAttribute("montoPorTipo", montoPorTipo);
                request.setAttribute("movimientosPorMes", movimientosPorMes);

                request.setAttribute("reporte", movimientos);
            } else {
                request.setAttribute("error", "El tipo de reporte seleccionado no es válido.");
            }

            request.getRequestDispatcher("/Administrador/InformesReportes.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar los datos: " + e.getMessage());
            request.getRequestDispatcher("/Administrador/InformesReportes.jsp").forward(request, response);
        }
    }
}
