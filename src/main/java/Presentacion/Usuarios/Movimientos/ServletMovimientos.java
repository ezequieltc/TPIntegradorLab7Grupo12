package Presentacion.Usuarios.Movimientos;

import Dominio.Cuenta;
import Dominio.Movimiento;
import Dominio.Persona;
import Dominio.DTO.PaginatedResponse;
import NegocioImpl.CuentaNegocioImpl;
import NegocioImpl.MovimientoNegocioImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/Usuarios/Home/ServletMovimientos")
public class ServletMovimientos extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/Usuario/Movimientos/Movimientos.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        int idCliente = (int) session.getAttribute("id");

        String idCuentaStr = request.getParameter("idCuenta");

        CuentaNegocioImpl cuentaNegocio = new CuentaNegocioImpl();
        MovimientoNegocioImpl movimientoNegocio = new MovimientoNegocioImpl();

        List<Cuenta> cuentas = cuentaNegocio.getCuentasPorCliente(idCliente);
        request.setAttribute("listaCuentas", cuentas);

        if (idCuentaStr != null && !idCuentaStr.isEmpty()) {
            try {
                int idCuenta = Integer.parseInt(idCuentaStr);

                PaginatedResponse<Movimiento> movimientos = movimientoNegocio.listarMovimientosPorCuenta(idCuenta);
                request.setAttribute("listaMovimientos", movimientos);

            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID de cuenta no válido.");
            }
        }

        RequestDispatcher rd = request.getRequestDispatcher("/Usuario/Movimientos/Movimientos.jsp");
        rd.forward(request, response);
    }
}
