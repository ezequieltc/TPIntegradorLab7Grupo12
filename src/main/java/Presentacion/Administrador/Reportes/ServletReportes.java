package Presentacion.Administrador.Reportes;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Iterator;

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

        if (tipoReporte == null || tipoReporte.isEmpty() || fechaDesde == null || fechaDesde.isEmpty() || fechaHasta == null || fechaHasta.isEmpty()) {
        	 request.getSession().setAttribute("mensajeError", "Debe completar todos los campos del filtro.");
             request.getSession().setAttribute("mostrarPopUp", true);
             request.getSession().setAttribute("popUpStatus", "error");
             response.sendRedirect(request.getContextPath() + "/Administrador/InformesReportes.jsp");
             return;
        }
        try {
            if (tipoReporte.equals("prestamos")) {
                Date fechaInicioDate = Date.valueOf(fechaDesde);
                Date fechaFinDate = Date.valueOf(fechaHasta);
                if (Date.valueOf(fechaDesde).after(Date.valueOf(fechaHasta))) {
                    request.getSession().setAttribute("mensajeError", "La fecha de inicio no puede ser superior a la fecha de fin.");
                    request.getSession().setAttribute("mostrarPopUp", true);
                    request.getSession().setAttribute("popUpStatus", "error");
                    response.sendRedirect(request.getContextPath() + "/Administrador/InformesReportes.jsp");
                    return;
                }
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
                for (Prestamo prestamo : prestamos) {
                    montoTotal += prestamo.getImporte();

                    String status = prestamo.getStatus().toString();
                    if (status.equalsIgnoreCase("En_curso")) {
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
                if (Date.valueOf(fechaDesde).after(Date.valueOf(fechaHasta))) {
                    request.getSession().setAttribute("mensajeError", "La fecha de inicio no puede ser superior a la fecha de fin.");
                    request.getSession().setAttribute("mostrarPopUp", true);
                    request.getSession().setAttribute("popUpStatus", "error");
                    response.sendRedirect(request.getContextPath() + "/Administrador/InformesReportes.jsp");
                    return;
                }
                CuentaNegocioImpl cuentaNegocio = new CuentaNegocioImpl();
                PrestamoDaoImpl prestamoDao = new PrestamoDaoImpl();

                ArrayList<Cuenta> cuentas = cuentaNegocio.readAll();
                ArrayList<Prestamo> prestamos = prestamoDao.getPrestamos();

                Iterator<Cuenta> iterator = cuentas.iterator();
                while (iterator.hasNext()) {
                    Cuenta cuenta = iterator.next();
                    if (cuenta.getFechaCreacion().before(fechaInicioDate) || cuenta.getFechaCreacion().after(fechaFinDate)) {
                        iterator.remove();
                    }
                }
                int numeroCuentas = cuentas.size();
                double saldoTotal = 0;
                int cuentasActivas = 0;
                int cuentasInactivas = 0;
                int cuentasCorriente = 0;
                int cuentasCajaAhorro = 0;           
                for (Cuenta cuenta : cuentas) {
                    saldoTotal += cuenta.getSaldo();
                    if (cuenta.isEstado()) {
                        cuentasActivas++;
                    } else {
                        cuentasInactivas++;
                    }
                    if (cuenta.getTipoCuenta().getDescripcion().equalsIgnoreCase("Cuenta Corriente")) {
                        cuentasCorriente++;
                    } else if (cuenta.getTipoCuenta().getDescripcion().equalsIgnoreCase("Caja de Ahorro")) {
                        cuentasCajaAhorro++;
                    }                   
                }               
                double saldoPromedio = numeroCuentas > 0 ? saldoTotal / numeroCuentas : 0;

                request.setAttribute("numeroCuentas", numeroCuentas);
                request.setAttribute("saldoPromedioCuentas", saldoPromedio);
                request.setAttribute("cuentasActivas", cuentasActivas);
                request.setAttribute("cuentasInactivas", cuentasInactivas);
                request.setAttribute("cuentasCorriente", cuentasCorriente);
                request.setAttribute("cuentasCajaAhorro", cuentasCajaAhorro);

                request.setAttribute("reporte", cuentas);
            } else if (tipoReporte.equals("movimientos")) {
                Date fechaInicioDate = Date.valueOf(fechaDesde);
                Date fechaFinDate = Date.valueOf(fechaHasta);
                if (Date.valueOf(fechaDesde).after(Date.valueOf(fechaHasta))) {
                    request.getSession().setAttribute("mensajeError", "La fecha de inicio no puede ser superior a la fecha de fin.");
                    request.getSession().setAttribute("mostrarPopUp", true);
                    request.getSession().setAttribute("popUpStatus", "error");
                    response.sendRedirect(request.getContextPath() + "/Administrador/InformesReportes.jsp");
                    return;
                }
                MovimientoNegocioImpl movimientoNegocio = new MovimientoNegocioImpl();
                ArrayList<Movimiento> movimientos = (ArrayList<Movimiento>) movimientoNegocio.obtenerTodosLosMovimientos();
                Iterator<Movimiento> iterator = movimientos.iterator();
                while (iterator.hasNext()) {
                    Movimiento movimiento = iterator.next();
                    if (movimiento.getFecha().before(fechaInicioDate) || movimiento.getFecha().after(fechaFinDate)) {
                        iterator.remove();
                    }
                }
                int contadorTransferencias = 0;
                int contadorRetiros = 0;
                int contadorDepositos = 0;
                double montoTotal = 0;
                int numeroMovimientos = movimientos.size();
                for (Movimiento movimiento : movimientos) {
                    montoTotal += movimiento.getImporte();
                    String tipo = movimiento.getTipoMovimiento().getDescripcion();

                    if (tipo.equalsIgnoreCase("Transferencia recibida") || tipo.equalsIgnoreCase("Transferencia enviada")) {
                        contadorTransferencias++;
                    } else if (tipo.equalsIgnoreCase("Retiro")) {
                        contadorRetiros++;
                    } else if (tipo.equalsIgnoreCase("Deposito")) {
                        contadorDepositos++;
                    }
                }
                double montoPromedio = numeroMovimientos > 0 ? montoTotal / numeroMovimientos : 0;               	                          
                request.setAttribute("montoTotalMovimientos", montoTotal);
                request.setAttribute("numeroMovimientos", numeroMovimientos);
                request.setAttribute("montoPromedioMovimientos", montoPromedio);
                request.setAttribute("contadorTransferencias", contadorTransferencias);
                request.setAttribute("contadorRetiros", contadorRetiros);
                request.setAttribute("contadorDepositos", contadorDepositos);
                request.setAttribute("reporte", movimientos);
            } else {
                request.setAttribute("error", "El tipo de reporte seleccionado no es válido.");
            }

            request.getRequestDispatcher("/Administrador/InformesReportes.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar los datos: " + e.getMessage());
            e.printStackTrace();
            request.getRequestDispatcher("/Administrador/InformesReportes.jsp").forward(request, response);
        }
    }
}
