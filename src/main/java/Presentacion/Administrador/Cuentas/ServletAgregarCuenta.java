package Presentacion.Administrador.Cuentas;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dominio.Cuenta;
import Dominio.Persona;
import Dominio.TipoCuenta;
import NegocioImpl.CuentaNegocioImpl;
import NegocioImpl.PersonaNegocioImpl;
import NegocioImpl.TipoCuentaNegocioImpl;

/**
 * Servlet implementation class ServletAgregarCuenta
 */
@WebServlet("/Administrador/Cuentas/ServletAgregarCuenta")
public class ServletAgregarCuenta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletAgregarCuenta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		TipoCuentaNegocioImpl tipoCuentaTemp = new TipoCuentaNegocioImpl();
		ArrayList<TipoCuenta> tipoCuentaList;
		tipoCuentaList = tipoCuentaTemp.readAll();
		request.setAttribute("tiposCuentas", tipoCuentaList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/AltaCuenta.jsp");
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PersonaNegocioImpl personaNegocioTemp = new PersonaNegocioImpl();
		CuentaNegocioImpl cuentaNegocioTemp = new CuentaNegocioImpl();
		TipoCuentaNegocioImpl tipoCuentaTemp = new TipoCuentaNegocioImpl();
		List<Persona> personasList;
		ArrayList<Cuenta> cuentasList;
		ArrayList<TipoCuenta> tipoCuentaList;
		personasList = personaNegocioTemp.readAll(0).getData();
		cuentasList = cuentaNegocioTemp.readAll();
		tipoCuentaList = tipoCuentaTemp.readAll();
		
		if(request.getParameter("crearCuenta")!= null) {
			
			
			String dniUsuario = request.getParameter("dniUsuario");
			int tipoCuenta = Integer.parseInt(request.getParameter("tipoCuenta"));
			String fechaAltaCuenta = request.getParameter("fechaAltaCuenta");
			String saldo = request.getParameter("saldo");
			Persona cliente = null;
			int cantCuentas = 0;
			Cuenta cuenta = new Cuenta();
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
						if(cuentaTemp.getPersona().getUsuario().getId() == cliente.getUsuario().getId()) {
							cantCuentas++;
						}
					}
				}
				
				if(cantCuentas < 3) {
					cuenta.setEstado(true);
					SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
					Date fechaCreacion = formatoFecha.parse(fechaAltaCuenta);
					cuenta.setFechaCreacion(fechaCreacion);
					cuenta.setId(cuentaNegocioTemp.calcularSiguienteId());
					
					for(TipoCuenta tipoCuentas : tipoCuentaList) {
						if(tipoCuentas.getId() == tipoCuenta) {
							cuenta.setTipoCuenta(tipoCuentas);
						}
					}
					cuenta.setPersona(cliente);
					cuenta.setSaldo(Integer.parseInt(saldo));
					try {
						cuentaNegocioTemp.insert(cuenta);
					}
					catch (Exception e) {
						System.out.println(e.getMessage());
					}
					
					
					request.getSession().setAttribute("mensajeExito", "¡Cuenta actualizada correctamente!");
					request.getSession().setAttribute("mostrarPopUp", true);
					request.getSession().setAttribute("popUpStatus", "success");
					
				}
				else {
					throw new Exception("El cliente ya posee 3 cuentas");
				}
				
				
			}
			catch (Exception error) {
				System.out.println(error.getMessage());
				request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + error.getMessage());
				request.getSession().setAttribute("popUpStatus", "error");
				request.getSession().setAttribute("mostrarPopUp", true);
			}
			
			response.sendRedirect(request.getContextPath() + "/Administrador/Cuentas/ServletAgregarCuenta");
		}
		
	}

}
