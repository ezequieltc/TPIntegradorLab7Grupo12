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
		CuentaNegocioImpl cuentaNegocioTemp = new CuentaNegocioImpl();
		ArrayList<Cuenta> cuentasList;
		cuentasList = cuentaNegocioTemp.readAll();
		
		request.setAttribute("cuentasList", cuentasList);
		RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/ListarCuentas.jsp");   
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);        
		PersonaNegocioImpl personaNegocioTemp = new PersonaNegocioImpl();
		CuentaNegocioImpl cuentaNegocioTemp = new CuentaNegocioImpl();
		TipoCuentaNegocioImpl tipoCuentaTemp = new TipoCuentaNegocioImpl();
		ArrayList<Persona> personasList;
		ArrayList<Cuenta> cuentasList;
		ArrayList<TipoCuenta> tipoCuentaList;
		personasList = personaNegocioTemp.readAll();
		cuentasList = cuentaNegocioTemp.readAll();
		tipoCuentaList = tipoCuentaTemp.readAll();
		if(request.getParameter("crearCuenta")!= null) {
			
			String dniUsuario = request.getParameter("dniUsuario");
			String tipoCuenta = request.getParameter("tipoCuenta");
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
				for (Cuenta cuentasTmp : cuentasList) {
					System.out.println(cuentasList.toString());
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
						if(tipoCuentas.getDescripcion().equals(tipoCuenta)) {
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
			
			RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/AltaCuenta.jsp");   
			rd.forward(request, response); 
		}

		Cuenta cuentaTemp = new Cuenta();
		if(request.getParameter("botonBuscarCuenta") != null){
			System.out.println("Buscar");
			String buscarCBU = request.getParameter("busquedaCBU");
			String busquedaNumeroCuenta = request.getParameter("busquedaNumeroCuenta");
			if(busquedaNumeroCuenta != null) {
				cuentaTemp = cuentaNegocioTemp.getCuenta(busquedaNumeroCuenta,"");
			}
			else {
				cuentaTemp = cuentaNegocioTemp.getCuenta("",buscarCBU);
				
			}
			request.setAttribute("cuenta", cuentaTemp);
			RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/ModificarEliminarCuentas.jsp");   
			rd.forward(request, response);
		}
		if(request.getParameter("modificarCuenta") != null){
			try {
			String busquedaNumeroCuenta = request.getParameter("editNumeroCuenta");
			tipoCuentaList = tipoCuentaTemp.readAll();
			cuentaTemp = cuentaNegocioTemp.getCuenta(busquedaNumeroCuenta,"");
			String tipoCuenta = request.getParameter("editTipoCuenta");
			for(TipoCuenta tipoCuentas : tipoCuentaList) {
				if(tipoCuentas.getDescripcion().equals(tipoCuenta)) {
					cuentaTemp.setTipoCuenta(tipoCuentas);
				}
			}
			cuentaTemp.setSaldo(Integer.parseInt(request.getParameter("editSaldo")));
			SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");

			Date fechaCreacion = formatoFecha.parse(request.getParameter("editFechaAltaCuenta"));
			cuentaTemp.setFechaCreacion(fechaCreacion);
			cuentaNegocioTemp.update(cuentaTemp);
				}
			catch (Exception e) {
				System.out.println(e.getMessage());
			}
			RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/ModificarEliminarCuentas.jsp");   
			rd.forward(request, response);
		}
		
		if(request.getParameter("eliminarCuenta") != null){
			String busquedaNumeroCuenta = request.getParameter("editNumeroCuenta");
			tipoCuentaList = tipoCuentaTemp.readAll();
			cuentaTemp = cuentaNegocioTemp.getCuenta(busquedaNumeroCuenta,"");
			if(request.getParameter("editEstadoCuenta").equals("activa")) {
				cuentaTemp.setEstado(false);
			}
			try {
				cuentaNegocioTemp.update(cuentaTemp);
				}
			catch (Exception e) {
				System.out.println(e.getMessage());
			}
			System.out.println("Eliminar");
			RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/ModificarEliminarCuentas.jsp");   
			rd.forward(request, response);
		}
		if(request.getParameter("reactivarCuenta") != null){
			String busquedaNumeroCuenta = request.getParameter("editNumeroCuenta");
			tipoCuentaList = tipoCuentaTemp.readAll();
			cuentaTemp = cuentaNegocioTemp.getCuenta(busquedaNumeroCuenta,"");
			if(request.getParameter("editEstadoCuenta").equals("inactiva")) {
				cuentaTemp.setEstado(true);
			}
			try {
				cuentaNegocioTemp.update(cuentaTemp);
				}
			catch (Exception e) {
				System.out.println(e.getMessage());
			}
			RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/ModificarEliminarCuentas.jsp");   
			rd.forward(request, response);
		
		}
	}

}