 package Presentacion.Auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Dominio.Persona;
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
		 
		Persona persona = authService.login(user, pass);
		
		if(persona != null){
			HttpSession session = request.getSession(true);
			session.setAttribute("usuario", user);
			session.setAttribute("isAdmin", persona.getUsuario().getTipoUsuario().getId() == 1);
			response.sendRedirect("SvSidebar");
		} else {
			response.sendRedirect("Login.jsp");
		}
	}

}
