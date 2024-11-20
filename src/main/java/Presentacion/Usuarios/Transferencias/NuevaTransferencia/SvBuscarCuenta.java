package Presentacion.Usuarios.Transferencias.NuevaTransferencia;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import Dominio.*;
import NegocioImpl.CuentaNegocioImpl;

/**
 * Servlet implementation class ServletSolicitarPrestamo
 */
@WebServlet("/Usuarios/Transferencias/NuevaTransferencia/SvBuscarCuenta")
public class SvBuscarCuenta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvBuscarCuenta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CuentaNegocioImpl cuentasNegocio = new CuentaNegocioImpl();

        String nroCbu = (String)(request.getParameter("cbuDestino"));
        try {
            Cuenta cuentaDestino = cuentasNegocio.getCuenta("", nroCbu == null ? "" : nroCbu);
            if (cuentaDestino == null){

                throw new Exception("El CBU que ingresaste no se corresponde con ninguna cuenta.");
            }
        

            Persona personaActual = (Persona) request.getSession().getAttribute("persona");
            ArrayList<Cuenta> cuentasCliente = cuentasNegocio.getCuentasPorCliente(personaActual.getUsuario().getId());
            request.getSession().setAttribute("cuentasCliente", cuentasCliente);
            request.getSession().setAttribute("cuentaDestino", cuentaDestino);
            request.getSession().setAttribute("paso", 2);
        } catch (Exception e) {
            System.out.println(e.getStackTrace());
            request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + e.getMessage());
			request.getSession().setAttribute("popUpStatus", "error");
			request.getSession().setAttribute("mostrarPopUp", true);
            request.getSession().setAttribute("paso", 1);
        }
        
        response.sendRedirect(request.getContextPath() + "/Usuario/Transferencias/NuevaTransferencia.jsp");
		
	}

}
