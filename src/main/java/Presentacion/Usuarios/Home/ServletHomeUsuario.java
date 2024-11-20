package Presentacion.Usuarios.Home;

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



@WebServlet("/Usuarios/Home/ServletHomeUsuario")
public class ServletHomeUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ServletHomeUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Persona persona = (Persona) session.getAttribute("persona");
		
		CuentaNegocioImpl cuentasNegocio = new CuentaNegocioImpl();
		MovimientoNegocioImpl movimientoNegocio = new MovimientoNegocioImpl();
		
		session.setAttribute("id", persona.getId());
		
		List<Cuenta> cuentas = cuentasNegocio.getCuentasPorCliente(persona.getUsuario().getId());
	    request.setAttribute("lista", cuentas);
	    
	    try {
	        List<Movimiento> ultimosMovimientos = movimientoNegocio.obtenerUltimosMovimientos(persona.getId(), 5);

	        Map<Integer, Cuenta> cuentaMap = new HashMap<>();
	        for (Cuenta cuenta : cuentas) {
	            cuentaMap.put(cuenta.getId(), cuenta);
	        }
	        request.setAttribute("cuentaMap", cuentaMap);
	        
	        request.setAttribute("cuentas", cuentas);
	        request.setAttribute("ultimosMovimientos", ultimosMovimientos);

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new ServletException("Error al obtener cuentas y movimientos", e);
	    }

		RequestDispatcher rd = request.getRequestDispatcher("/Usuario/VistaHomeUsuario.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
