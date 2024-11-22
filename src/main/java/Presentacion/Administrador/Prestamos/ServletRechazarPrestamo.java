package Presentacion.Administrador.Prestamos;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dominio.Prestamo;
import NegocioImpl.PrestamoNegocioImpl;
import tipos.PrestamosStatus;

/**
 * Servlet implementation class ServletRechazarPrestamo
 */
@WebServlet("/Administrador/Prestamos/ServletRechazarPrestamo")
public class ServletRechazarPrestamo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletRechazarPrestamo() {
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
		int id = Integer.parseInt(request.getParameter("prestamoID"));
		Prestamo prestamo = prestamoNegocio.getPrestamoPorId(id);
		prestamo.setStatus(PrestamosStatus.RECHAZADO);
		try {
			prestamoNegocio.update(prestamo);
			request.getSession().setAttribute("mensajeExito", "¡El prestamo fue rechazado correctamente!");
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
