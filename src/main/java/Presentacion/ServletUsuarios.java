package Presentacion;

import DaoImpl.PersonaDaoImpl;
import DaoImpl.UsuarioDaoImpl;
import Dominio.Usuario;
import NegocioImpl.PersonaNegocioImpl;
import NegocioImpl.UsuarioNegocioImpl;
import Dominio.Persona;
import Dao.IPersonaDao;
import Dominio.TipoUsuario;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Servlet implementation class ServletUsuarios
 */
@WebServlet("/ServletUsuarios")
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

	    if (request.getParameter("btnEliminarUsuario") != null) {
	        int id = Integer.parseInt(request.getParameter("id"));

	        personaNegocio.delete(id);

	        response.sendRedirect(request.getContextPath() + "/ServletUsuarios");
	        return; 
	    }
	    
	    if(request.getParameter("btnModificarUsuario") != null) {
			int id = Integer.parseInt(request.getParameter("id"));
			
			Persona persona = personaNegocio.getPersona(id);
			
			request.setAttribute("persona", persona);
			RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/ModificarUsuario.jsp");
			rd.forward(request, response);
		}

	    List<Persona> personas = personaNegocio.readAll(0).getData();
	    request.setAttribute("lista", personas);

	    RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/ListarModificarEliminarUsuarios.jsp");
	    rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getParameter("btnEliminarUsuario") != null) {
        	
        	PersonaNegocioImpl personaNegocio = new PersonaNegocioImpl();
    		List<Persona> personas = personaNegocio.readAll(0).getData();
    		int id = Integer.parseInt(request.getParameter("id").toString());
        	personaNegocio.delete(id);
    		
    		request.setAttribute("lista", personas);
    		
    		RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/ListarModificarEliminarUsuarios.jsp");   
            rd.forward(request, response);
        }
		
		doGet(request, response);
	}

}
