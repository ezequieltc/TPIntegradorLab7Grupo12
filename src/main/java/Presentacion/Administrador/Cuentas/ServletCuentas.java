package Presentacion.Administrador.Cuentas;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import NegocioImpl.PersonaNegocioImpl;
import NegocioImpl.CuentaNegocioImpl;
import Dominio.Cuenta;
import Dominio.Persona;
import Dominio.TipoCuenta;
import NegocioImpl.TipoCuentaNegocioImpl;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ServletCuentas
 */
@WebServlet("/Administrador/Cuentas/ServletCuentas")
public class ServletCuentas extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletCuentas() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		CuentaNegocioImpl cuentaNegocioTemp = new CuentaNegocioImpl();
		ArrayList<Cuenta> cuentasList;
		cuentasList = cuentaNegocioTemp.readAll();
		
		//request.setAttribute("cuentasList", cuentasList);
		//RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/ListarCuentas.jsp");   
		//rd.forward(request, response);
		
		request.getSession().setAttribute("cuentasList", cuentasList);
		response.sendRedirect(request.getContextPath() + "/Administrador/Cuentas");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}