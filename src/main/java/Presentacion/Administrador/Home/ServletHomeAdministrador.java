package Presentacion.Administrador.Home;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dominio.Prestamo;
import Dominio.Persona;
import NegocioImpl.PrestamoNegocioImpl;
import Dominio.Cuenta;
import Dominio.TipoCuenta;
import NegocioImpl.CuentaNegocioImpl;
import java.util.List;


@WebServlet("/Administrador/ServletHomeAdministrador")
public class ServletHomeAdministrador extends HttpServlet {
    private static final long serialVersionUID = 1L;
    PrestamoNegocioImpl prestamoNegocio = new PrestamoNegocioImpl();

    public ServletHomeAdministrador() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Establecer la codificación de caracteres
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            ArrayList<Prestamo> listadoPrestamos = prestamoNegocio.getPrestamos();
            Collections.sort(listadoPrestamos, new Comparator<Prestamo>() {
                @Override
                public int compare(Prestamo p1, Prestamo p2) {
                    return p2.getFecha_alta().compareTo(p1.getFecha_alta());
                }
            });            
            if (listadoPrestamos != null && listadoPrestamos.size() > 5) {
                listadoPrestamos = new ArrayList<>(listadoPrestamos.subList(0, 5));
            }
            request.setAttribute("listadoPrestamos", listadoPrestamos);
            
    		CuentaNegocioImpl cuentaNegocioTemp = new CuentaNegocioImpl();
            ArrayList<Cuenta> listadoCuentas = cuentaNegocioTemp.readAll();
            Collections.sort(listadoCuentas, new Comparator<Cuenta>() {
                @Override
                public int compare(Cuenta c1, Cuenta c2) {
                    return c2.getFechaCreacion().compareTo(c1.getFechaCreacion());
                }
            });
            
            if (listadoCuentas != null && listadoCuentas.size() > 5) {
                listadoCuentas = new ArrayList<>(listadoCuentas.subList(0, 5));
            }
            request.setAttribute("listadoCuentas", listadoCuentas);                                                
            request.getRequestDispatcher("/Administrador/VistaHomeAdministrador.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al consultar los préstamos: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        doGet(request, response);
    }
}
