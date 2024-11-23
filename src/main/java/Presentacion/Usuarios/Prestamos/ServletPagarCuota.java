package Presentacion.Usuarios.Prestamos;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dominio.Cuenta;
import Dominio.Cuota;
import Dominio.Persona;
import Dominio.Prestamo;
import NegocioImpl.CuentaNegocioImpl;
import NegocioImpl.CuotaNegocioImpl;
import NegocioImpl.PrestamoNegocioImpl;

/**
 * Servlet implementation class ServletPagarCuota
 */
@WebServlet("/Usuarios/Prestamos/ServletPagarCuota")
public class ServletPagarCuota extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CuentaNegocioImpl cuentaNegocio = new CuentaNegocioImpl();
	CuotaNegocioImpl cuotaNegocio = new CuotaNegocioImpl();
	PrestamoNegocioImpl prestamoNegocio = new PrestamoNegocioImpl();
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletPagarCuota() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		ArrayList<Cuenta> cuentasCliente = new ArrayList<Cuenta>();
		ArrayList<Prestamo> prestamosCliente = new ArrayList<Prestamo>();
		ArrayList<Cuota> cuotasPrestamo = new ArrayList<Cuota>();
		Prestamo prestamo = new Prestamo();
		Persona cliente = (Persona)(session.getAttribute("persona"));
		int idPrestamo = 0;
		int numeroCuota = 0;
		prestamosCliente = prestamoNegocio.getPrestamos();
		prestamosCliente.removeIf(e -> e.getPersona().getId() != cliente.getId() || e.isEstado() == false);
		cuentasCliente = cuentaNegocio.getCuentasPorCliente(((Persona)(session.getAttribute("persona"))).getUsuario().getId());
		idPrestamo = request.getParameter("selectPrestamo") != null ? Integer.parseInt(request.getParameter("selectPrestamo")) : 0;
		numeroCuota = request.getParameter("selectCuota") != null ? Integer.parseInt(request.getParameter("selectCuota")) : 0;
		request.getSession().setAttribute("prestamosCliente", prestamosCliente);
		request.getSession().setAttribute("cuentasCliente", cuentasCliente);
		response.sendRedirect(request.getContextPath() + "/Usuario/Prestamos/VistaPagarCuotas.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("buttonSubmit");
		int idPrestamo = 0;
		int numeroCuota = 0;
		int idCuenta = 0;
		int idCuota = 0;
		ArrayList<Cuota> cuotasPrestamo = new ArrayList<Cuota>();
		Cuenta cuentaTemp = new Cuenta();
		Prestamo prestamo = new Prestamo();
		Cuota cuota = new Cuota();
		if("pagar".equals(action)==false) {
			
			if(Integer.parseInt(request.getParameter("selectPrestamo")) != 0) {
				idPrestamo = Integer.parseInt(request.getParameter("selectPrestamo"));
				prestamo = prestamoNegocio.getPrestamoPorId(idPrestamo);
				cuotasPrestamo = cuotaNegocio.listadoCuotasPorIdPrestamo(idPrestamo);
				request.getSession().setAttribute("prestamoSeleccionado",idPrestamo);
				request.getSession().setAttribute("cuotasPrestamo",cuotasPrestamo);
				response.sendRedirect(request.getContextPath() + "/Usuarios/Prestamos/ServletPagarCuota");
				return;
			}
		}
		System.out.println("Accion: " + action);
		if ("pagar".equals(action)) {
			System.out.println("Este es el id prestamo: " + idPrestamo);
			idPrestamo = Integer.parseInt(request.getParameter("selectPrestamo"));
			prestamo = prestamoNegocio.getPrestamoPorId(idPrestamo);
			numeroCuota = Integer.parseInt(request.getParameter("selectCuota"));
			idCuenta = Integer.parseInt(request.getParameter("selectCuenta"));
			idCuota = Integer.parseInt(request.getParameter("selectCuota"));
			cuota = cuotaNegocio.getCuotaPorId(idCuota);
			System.out.println(idCuenta);
			cuentaTemp = cuentaNegocio.getCuenta(idCuenta);
			cuota.setEstado(false);
			System.out.println(cuota.toString());
			try {
				if(cuentaTemp.getSaldo() < cuota.getImporte()) {
					throw new Exception("No posee el saldo suficiente para realizar el pago.");
				}
				cuotaNegocio.pagarCuota(cuota,cuentaTemp);
				request.getSession().setAttribute("mensajeExito", "¡La cuota fue pagada correctamente!.");
				request.getSession().setAttribute("mostrarPopUp", true);
				request.getSession().setAttribute("popUpStatus", "success");
				request.getSession().setAttribute("prestamoSeleccionado",0);
			}
			catch (Exception e) {
				request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + e.getMessage());
				request.getSession().setAttribute("popUpStatus", "error");
				request.getSession().setAttribute("mostrarPopUp", true);
			}
			response.sendRedirect(request.getContextPath() + "/Usuarios/Prestamos/ServletPagarCuota");

		}
	}

}
