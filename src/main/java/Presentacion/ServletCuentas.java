package Presentacion;

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
@WebServlet("/ServletCuentas")
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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);        
		
		String dniUsuario = request.getParameter("dniUsuario");
		String tipoCuenta = request.getParameter("tipoCuenta");
		String fechaAltaCuenta = request.getParameter("fechaAltaCuenta");
		//String numeroCuenta = request.getParameter("numeroCuenta");
		//String cbu = request.getParameter("cbu");
		String saldo = request.getParameter("saldo");
		Persona cliente = null;
		int cantCuentas = 0;
		PersonaNegocioImpl personaNegocioTemp = new PersonaNegocioImpl();
		CuentaNegocioImpl cuentaNegocioTemp = new CuentaNegocioImpl();
		TipoCuentaNegocioImpl tipoCuentaTemp = new TipoCuentaNegocioImpl();
		Cuenta cuenta = new Cuenta();
		ArrayList<Persona> personasList;
		ArrayList<Cuenta> cuentasList;
		ArrayList<TipoCuenta> tipoCuentaList;
		personasList = personaNegocioTemp.readAll();
		cuentasList = cuentaNegocioTemp.readAll();
		tipoCuentaList = tipoCuentaTemp.readAll();
		//System.out.println(cuentaNegocioTemp.readAll());
		try {
			for(Persona persona : personasList) {
				if (persona.getDni().equals(dniUsuario)) {
					cliente = persona;
					break;
				}
			}
			if(cliente == null) {
				throw new Exception("La persona no existe");
			}
			
			for (Cuenta cuentaTemp : cuentasList ) {
					if(cuentaTemp.estado) {
						//System.out.println("El cliente es: " + cliente.getUsuario().getId());
						//System.out.println("La cuenta es : " + cuentaTemp.getPersona().getUsuario().getId());
						System.out.println("El id de cuenta :" + cuentaTemp.getId());
						System.out.println("El nombre del Usuario es: " + cuentaTemp.getPersona().getNombre());
						if(cuentaTemp.getPersona().getUsuario().getId() == cliente.getUsuario().getId()) {
							System.out.println("Entre aca");
							cantCuentas++;
						}
					}
				}

			if(cantCuentas < 3) {
				System.out.println("Este usuario tiene: " + cantCuentas + " cuentas.");
				//cuenta.setCbu(cbu);
				cuenta.setEstado(true);
				SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
				Date fechaCreacion = formatoFecha.parse(fechaAltaCuenta);
				cuenta.setFechaCreacion(fechaCreacion);
				cuenta.setId(cuentasList.size()+1);
				//cuenta.setNumeroCuenta(numeroCuenta);
				for(TipoCuenta tipoCuentas : tipoCuentaList) {
					if(tipoCuentas.getDescripcion().equals(tipoCuenta)) {
						cuenta.setTipoCuenta(tipoCuentas);
					}
				}
				cuenta.setPersona(cliente);
				cuenta.setSaldo(Integer.parseInt(saldo));
				System.out.println(cuenta.toString());
				//try {
				//	cuentaNegocioTemp.insert(cuenta);
				//}
				//catch (Exception e) {
				//	System.out.println(e.getMessage());
				//}
			
				request.setAttribute("mostrarPopUp", true);
				request.setAttribute("popUpStatus", "success");
			}
			else {
				throw new Exception("El cliente ya posee 3 cuentas");
			}
			
			
		}
		catch (Exception error) {
			System.out.println(error.getMessage());
			request.setAttribute("mensajeError", error.getMessage());
			request.setAttribute("popUpStatus", "error");
			request.setAttribute("mostrarPopUp", true);
		}
		
		//request.setAttribute("mostrarPopUp", true);
		//request.setAttribute("popUpStatus", "success"); // o "error" si ocurrió un error
		RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/AltaCuenta.jsp");   
        rd.forward(request, response); 
	}

}
