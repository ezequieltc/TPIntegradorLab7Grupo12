package Presentacion.Administrador.Usuarios;

import NegocioImpl.PersonaNegocioImpl;
import Dominio.Persona;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class ServletUsuarios
 */
@WebServlet("/Administrador/Usuarios/ServletUsuarios")
public class ServletUsuarios extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

    /**
     * Default constructor. 
     */
    public ServletUsuarios() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PersonaNegocioImpl personaNegocio = new PersonaNegocioImpl();

	    
	    if(request.getParameter("btnModificarUsuario") != null) {
			int id = Integer.parseInt(request.getParameter("id"));
			
			Persona persona = personaNegocio.getPersona(id);
			
			request.setAttribute("personaModificada", persona);
			RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/ServletModificarUsuario");
			rd.forward(request, response);
			return; 
		}

	    List<Persona> personas = personaNegocio.readAll(0).getData();
	    request.setAttribute("lista", personas);

	    RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/ListarUsuarios.jsp");
	    rd.forward(request, response);
		
	}


}
