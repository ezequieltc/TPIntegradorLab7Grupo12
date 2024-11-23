package Presentacion.Usuarios.Prestamos;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dominio.Persona;
import Dominio.Prestamo;
import Negocio.IPrestamoNegocio;
import NegocioImpl.PrestamoNegocioImpl;

/**
 * Servlet implementation class ServletPrestamos
 */
@WebServlet("/Usuarios/Prestamos/ServletPrestamos")
public class ServletPrestamos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletPrestamos() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		IPrestamoNegocio prestamoNegocio = new PrestamoNegocioImpl();
		Persona persona = (Persona)session.getAttribute("persona");
		ArrayList<Prestamo> prestamos = prestamoNegocio.getPrestamos(persona.getId());
		request.setAttribute("prestamos", prestamos);	
		RequestDispatcher rs = request.getRequestDispatcher("/Usuario/Prestamos/index.jsp");
		rs.forward(request, response);	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
	
	}

}
