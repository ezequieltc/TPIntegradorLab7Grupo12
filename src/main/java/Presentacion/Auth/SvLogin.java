 package Presentacion.Auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Dominio.Persona;
import excepciones.PersonaExistenteExcepcion;
import excepciones.UsuarioBloqueado;
import servicios.auth.AuthServices;

/**
 * Servlet implementation class SvLogin
 */
@WebServlet("/SvLogin")
public class SvLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvLogin() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("user");
		String pass = request.getParameter("pass");
		AuthServices authService = new AuthServices();
		HttpSession session = request.getSession(true);
		
		Persona persona = null;
		try {
			persona = authService.login(user, pass);
			if(persona != null){
				session = request.getSession(true);
			}
			if((persona = authService.login(user, pass)) != null){
				session.setAttribute("persona", persona);
				session.setAttribute("isAdmin", persona.getUsuario().getTipoUsuario().getId() == 1);
				response.sendRedirect("SvSidebar");
			} else {
				session.setAttribute("mensajeError", "Error al aceeder, por favor intente mas tarde");
				session.setAttribute("mostrarPopUp", true);
				session.setAttribute("popUpStatus", "error");
				
				response.sendRedirect("Login.jsp");
			}
		} catch (PersonaExistenteExcepcion e) {
			session.setAttribute("mensajeError", e.getMessage());
			session.setAttribute("mostrarPopUp", true);
			session.setAttribute("popUpStatus", "error");
			response.sendRedirect("Login.jsp");
		} catch (UsuarioBloqueado e) {
			session.setAttribute("mensajeError", e.getMessage());
			session.setAttribute("mostrarPopUp", true);
			session.setAttribute("popUpStatus", "error");
			response.sendRedirect("Login.jsp");
			//e.printStackTrace();
		}

	}

}