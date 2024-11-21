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
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoReporte = request.getParameter("tipoReporte");
        String fechaDesde = request.getParameter("fechaDesde");
        String fechaHasta = request.getParameter("fechaHasta");

        System.out.println("Tipo de Reporte: " + tipoReporte);
        System.out.println("Fecha Desde: " + fechaDesde);
        System.out.println("Fecha Hasta: " + fechaHasta);

        if (tipoReporte == null || fechaDesde == null || fechaHasta == null || tipoReporte.isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
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

                //VERIFICAR LOS PRESTAMOSS
                System.out.println("Préstamos después del filtrado:");
                for (Prestamo prestamo : prestamos) {
                    System.out.println(prestamo);
                }
                request.setAttribute("reporte", prestamos);
                
            }else if (tipoReporte.equals("cuentas")) {
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
                System.out.println("Cuentas después del filtrado:");
                for (Cuenta cuenta : cuentas) {
                    System.out.println(cuenta);
                }
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

                System.out.println("Movimientos después del filtrado:");
                for (Movimiento movimiento : movimientos) {
                    System.out.println(movimiento);
                }
                request.setAttribute("reporte", movimientos);

            } else {
                request.setAttribute("error", "El tipo de reporte seleccionado no es válido.");
            }

            request.getRequestDispatcher("/Administrador/InformesReportes.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al procesar los datos: " + e.getMessage());
            request.getRequestDispatcher("/Administrador/InformesReportes.jsp").forward(request, response);
        }
    }

}