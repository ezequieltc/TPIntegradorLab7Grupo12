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
		int id = Integer.parseInt(request.getParameter("prestamoID"));
		Prestamo prestamo = prestamoNegocio.getPrestamoPorId(id);
		prestamo.setStatus(PrestamosStatus.EN_CURSO);
		try {
			prestamoNegocio.update(prestamo);
			System.out.println("Actualizado correctamente");
			
			}
		catch (Exception e){
			}
		
		response.sendRedirect(request.getContextPath() + "/Administrador/Prestamos/ServletAutorizarPrestamo"); 
	}

}
