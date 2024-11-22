package Presentacion.Administrador.Prestamos;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dominio.Movimiento;
import Dominio.Prestamo;
import Dominio.TipoMovimiento;
import NegocioImpl.MovimientoNegocioImpl;
import NegocioImpl.PrestamoNegocioImpl;
import tipos.PrestamosStatus;

/**
 * Servlet implementation class ServletAprobarPrestamo
 */
@WebServlet("/Administrador/Prestamos/ServletAprobarPrestamo")
public class ServletAprobarPrestamo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletAprobarPrestamo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrestamoNegocioImpl prestamoNegocio = new PrestamoNegocioImpl();
		

		MovimientoNegocioImpl movimientoNegocio = new MovimientoNegocioImpl();
		int id = Integer.parseInt(request.getParameter("prestamoID"));
		Prestamo prestamo = prestamoNegocio.getPrestamoPorId(id);
		prestamo.setStatus(PrestamosStatus.EN_CURSO);
		try {
			prestamoNegocio.update(prestamo);
			double importe = prestamo.getImporte();
			Movimiento movimiento = new Movimiento(prestamo.getCuenta().getId(), new TipoMovimiento(1,"Deposito"), new java.util.Date(System.currentTimeMillis()), "Aprobación de prestamo ID " + prestamo.getId(), importe, true);
			movimientoNegocio.insertarMovimiento(movimiento);
			request.getSession().setAttribute("mensajeExito", "¡El prestamo fue aprobado correctamente!");
			request.getSession().setAttribute("mostrarPopUp", true);
			request.getSession().setAttribute("popUpStatus", "success");
			
			}
		catch (Exception e){
			request.getSession().setAttribute("mensajeError", "¡Ha ocurrido un error!");
			request.getSession().setAttribute("mostrarPopUp", true);
			request.getSession().setAttribute("popUpStatus", "error");
			}
		
		response.sendRedirect(request.getContextPath() + "/Administrador/Prestamos/ServletAutorizarPrestamo"); 
	}

}
