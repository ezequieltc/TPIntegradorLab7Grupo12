package Presentacion.Administrador.Prestamos;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dominio.Prestamo;
import NegocioImpl.PrestamoNegocioImpl;

/**
 * Servlet implementation class ServletAutorizarPrestamo
 */
@WebServlet("/Administrador/Prestamos/ServletAutorizarPrestamo")
public class ServletAutorizarPrestamo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PrestamoNegocioImpl prestamoNegocio = new PrestamoNegocioImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletAutorizarPrestamo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ArrayList<Prestamo> listadoPrestamos = new ArrayList<Prestamo>();
		listadoPrestamos = prestamoNegocio.getPrestamos();
		request.getSession().setAttribute("listadoPrestamos", listadoPrestamos);
		response.sendRedirect(request.getContextPath() + "/Administrador/Prestamos/AutorizarPrestamo.jsp"); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrestamoNegocioImpl prestamoNegocio = new PrestamoNegocioImpl();
		int id = Integer.parseInt(request.getParameter("prestamoID"));
		Prestamo prestamo = prestamoNegocio.getPrestamoPorId(id);
		
		request.getSession().setAttribute("prestamoModal", prestamo);
		request.getSession().setAttribute("mostrarModal", true);
		response.sendRedirect(request.getContextPath() + "/Administrador/Prestamos/ServletAutorizarPrestamo"); 
	}

}
