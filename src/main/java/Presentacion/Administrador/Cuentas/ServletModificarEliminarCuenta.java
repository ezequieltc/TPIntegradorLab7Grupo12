package Presentacion.Administrador.Cuentas;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dominio.Cuenta;
import Dominio.TipoCuenta;
import NegocioImpl.CuentaNegocioImpl;
import NegocioImpl.TipoCuentaNegocioImpl;

/**
 * Servlet implementation class ServletModificarEliminarCuenta
 */
@WebServlet("/Administrador/Cuentas/ServletModificarEliminarCuenta")
public class ServletModificarEliminarCuenta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletModificarEliminarCuenta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		CuentaNegocioImpl cuentaNegocioTemp = new CuentaNegocioImpl();
		ArrayList<Cuenta> cuentasList;
		cuentasList = cuentaNegocioTemp.readAll();
		
		//request.setAttribute("cuentasList", cuentasList);
		//RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Cuentas/ListarCuentas.jsp");   
		//rd.forward(request, response);
		
		request.getSession().setAttribute("cuentasList", cuentasList);
		response.sendRedirect(request.getContextPath() + "/Administrador/Cuentas/ModificarEliminarCuentas.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<TipoCuenta> tipoCuentaList;
		TipoCuentaNegocioImpl tipoCuentaTemp = new TipoCuentaNegocioImpl();
		tipoCuentaList = tipoCuentaTemp.readAll();
		CuentaNegocioImpl cuentaNegocioTemp = new CuentaNegocioImpl();
		Cuenta cuentaTemp = new Cuenta();
		if(request.getParameter("botonBuscarCuenta") != null){
			String buscarCBU = request.getParameter("busquedaCBU");
			String busquedaNumeroCuenta = request.getParameter("busquedaNumeroCuenta");
			if(!busquedaNumeroCuenta.isEmpty()) {
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
			int cuentaID= Integer.parseInt(request.getParameter("idCuenta"));
			tipoCuentaList = tipoCuentaTemp.readAll();
			cuentaTemp = cuentaNegocioTemp.getCuenta(cuentaID);
			int tipoCuenta = Integer.parseInt(request.getParameter("editTipoCuenta"));
			cuentaTemp.setTipoCuenta(new TipoCuenta(tipoCuenta, ""));
			cuentaNegocioTemp.update(cuentaTemp);
			
				}
			catch (Exception e) {
				request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + e.getMessage());
				request.getSession().setAttribute("popUpStatus", "error");
				request.getSession().setAttribute("mostrarPopUp", true);
				System.out.println(e.getMessage());
			}
			
			request.getSession().setAttribute("mensajeExito", "¡Cuenta actualizada correctamente!");
			request.getSession().setAttribute("mostrarPopUp", true);
			request.getSession().setAttribute("popUpStatus", "success");
			response.sendRedirect(request.getContextPath() + "/Administrador/Cuentas/ModificarEliminarCuentas.jsp");
		}
		
		if(request.getParameter("eliminarCuenta") != null){
			int cuentaID= Integer.parseInt(request.getParameter("idCuenta"));
			cuentaTemp = cuentaNegocioTemp.getCuenta(cuentaID);		
			if(request.getParameter("editEstadoCuenta").equals("activa")) {
				cuentaTemp.setEstado(false);
			}
			try {
				cuentaNegocioTemp.delete(cuentaTemp);
				}
			catch (Exception e) {
				request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + e.getMessage());
				request.getSession().setAttribute("popUpStatus", "error");
				request.getSession().setAttribute("mostrarPopUp", true);
				System.out.println(e.getMessage());
			}

			request.getSession().setAttribute("mensajeExito", "¡Cuenta eliminada correctamente!");
			request.getSession().setAttribute("mostrarPopUp", true);
			request.getSession().setAttribute("popUpStatus", "success");
			
			response.sendRedirect(request.getContextPath() + "/Administrador/Cuentas/ModificarEliminarCuentas.jsp");
		}
		
		if(request.getParameter("reactivarCuenta") != null){
		int cuentaID= Integer.parseInt(request.getParameter("idCuenta"));
		cuentaTemp = cuentaNegocioTemp.getCuenta(cuentaID);		
		System.out.println(cuentaTemp);
		if(cuentaTemp.isEstado() == false) {
			cuentaTemp.setEstado(true);
		}
		try {
			cuentaNegocioTemp.update(cuentaTemp);
			}
		catch (Exception e) {
			request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + e.getMessage());
			request.getSession().setAttribute("popUpStatus", "error");
			request.getSession().setAttribute("mostrarPopUp", true);
			//System.out.println(e.getMessage());
		}
		request.getSession().setAttribute("mensajeExito", "¡Cuenta reactivada correctamente!");
		request.getSession().setAttribute("mostrarPopUp", true);
		request.getSession().setAttribute("popUpStatus", "success");
		response.sendRedirect(request.getContextPath() + "/Administrador/Cuentas/ModificarEliminarCuentas.jsp");
	
	}
}
}
	

