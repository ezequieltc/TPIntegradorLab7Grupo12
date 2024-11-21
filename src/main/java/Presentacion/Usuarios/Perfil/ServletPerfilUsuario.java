package Presentacion.Usuarios.Perfil;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dominio.Cuenta;
import Dominio.Movimiento;
import Dominio.Persona;
import NegocioImpl.CuentaNegocioImpl;
import NegocioImpl.MovimientoNegocioImpl;

/**
 * Servlet implementation class ServletPerfilUsuario
 */
@WebServlet("/Usuarios/Perfil/ServletPerfilUsuario")
public class ServletPerfilUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletPerfilUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Persona persona = (Persona) session.getAttribute("persona");
		
		CuentaNegocioImpl cuentasNegocio = new CuentaNegocioImpl();
		
		session.setAttribute("id", persona.getId());
		
		List<Cuenta> cuentas = cuentasNegocio.getCuentasPorCliente(persona.getUsuario().getId());
		
	    request.setAttribute("cuentas", cuentas);
	    
		RequestDispatcher rd = request.getRequestDispatcher("/Usuario/Perfil/index.jsp");
		rd.forward(request, response);
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
