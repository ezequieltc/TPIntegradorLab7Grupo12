package Presentacion.Usuarios.Prestamos;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import Dominio.*;
import NegocioImpl.CuentaNegocioImpl;
import NegocioImpl.PrestamoNegocioImpl;

/**
 * Servlet implementation class ServletSolicitarPrestamo
 */
@WebServlet("/Usuarios/Prestamos/ServletSolicitarPrestamo")
public class ServletSolicitarPrestamo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletSolicitarPrestamo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		CuentaNegocioImpl cuentasNegocio = new CuentaNegocioImpl();
		ArrayList<Cuenta> cuentasCliente = new ArrayList<Cuenta>();
		cuentasCliente = cuentasNegocio.getCuentasPorCliente(((Persona)(session.getAttribute("persona"))).getUsuario().getId());
		System.out.println(cuentasCliente);
		//request.getSession().setAttribute(getServletInfo(), response);
		//response.sendRedirect(request.getContextPath() + "/Usuarios/Prestamos/SolicitarPrestamo.jsp");
		request.setAttribute("cuentasCliente", cuentasCliente);
	    RequestDispatcher rd = request.getRequestDispatcher("/Usuario/Prestamos/SolicitarPrestamo.jsp");
	    rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		CuentaNegocioImpl cuentasNegocio = new CuentaNegocioImpl();
		PrestamoNegocioImpl prestamoNegocio = new PrestamoNegocioImpl();
		Prestamo prestamoTemp = new Prestamo();
		prestamoTemp.setPersona((Persona)(session.getAttribute("persona")));
		System.out.println("Es la cuenta ID: " + request.getParameter("cuentaDropDown"));
		prestamoTemp.setCuenta(cuentasNegocio.getCuenta(Integer.parseInt(request.getParameter("cuentaDropDown"))));
		float montoPrestamo = Float.parseFloat(request.getParameter("montoPrestamo"));
		int cantCuotas = Integer.parseInt(request.getParameter("cantCuotas"));
		float tasaAnual = 0.72f;
		float tasaMensual = (float) Math.pow(1 + tasaAnual, 1.0 / 12.0) - 1;
		float pagoMensual = montoPrestamo * (tasaMensual / (float) (1 - Math.pow(1 + tasaMensual, -cantCuotas)));
		float pagoTotal = pagoMensual * cantCuotas;
		prestamoTemp.setImporte(pagoTotal);
		prestamoTemp.setCuota_mensual(pagoMensual);
		prestamoTemp.setCantidad_cuotas(cantCuotas);
		try {
			prestamoNegocio.insert(prestamoTemp);
			request.getSession().setAttribute("mensajeExito", "¡Su prestamo fue solicitado correctamente! Ahora solo te queda esperar a que lo aprueben.");
			request.getSession().setAttribute("mostrarPopUp", true);
			request.getSession().setAttribute("popUpStatus", "success");
			
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + e.getMessage());
			request.getSession().setAttribute("popUpStatus", "error");
			request.getSession().setAttribute("mostrarPopUp", true);
			
		}
		
		response.sendRedirect(request.getContextPath() + "/Usuarios/Prestamos/ServletSolicitarPrestamo");
		
	}

}
