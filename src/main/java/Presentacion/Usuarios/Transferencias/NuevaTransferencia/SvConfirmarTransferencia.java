package Presentacion.Usuarios.Transferencias.NuevaTransferencia;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dominio.*;
import Negocio.ICuentaNegocio;
import NegocioImpl.CuentaNegocioImpl;

/**
 * Servlet implementation class ServletSolicitarPrestamo
 */
@WebServlet("/Usuarios/Transferencias/NuevaTransferencia/SvConfirmarTransferencia")
public class SvConfirmarTransferencia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvConfirmarTransferencia() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ICuentaNegocio cuentasNegocio = new CuentaNegocioImpl();

        String nroCbu = (String)(request.getParameter("cbuDestino"));
        String amount = (String)(request.getParameter("amount"));
        String sourceAccount = (String)(request.getParameter("sourceAccount"));


        try {
            Cuenta cuentaDestino = cuentasNegocio.getCuenta("", nroCbu == null ? "" : nroCbu);
            if (cuentaDestino == null){

                throw new Exception("El CBU al que se intenta transferir no se corresponde con ninguna cuenta.");
            }
        
            Persona personaActual = (Persona) request.getSession().getAttribute("persona");

            float amountFloat = Float.parseFloat(amount);

            Cuenta cuentaSource = cuentasNegocio.getCuenta(sourceAccount == null ? "" : sourceAccount, "");
            if (cuentaSource == null){
                throw new Exception("La cuenta de origen no se corresponde con ninguna cuenta.");
            }

            if (cuentaSource.getPersona().getUsuario().getId() != personaActual.getUsuario().getId()){
                throw new Exception("No puedes transferir de una cuenta de otro usuario.");
            }
            
            if (cuentaSource.getSaldo() < amountFloat){
                throw new Exception("El saldo de la cuenta de origen no es suficiente.");
            }

            cuentasNegocio.transferir(cuentaSource, cuentaDestino, amountFloat);
            
			request.getSession().setAttribute("mensajeExito", "¡Transferencia enviada exitosamente!");
			request.getSession().setAttribute("mostrarPopUp", true);
			request.getSession().setAttribute("popUpStatus", "success");
            request.getSession().setAttribute("paso", 1);

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
