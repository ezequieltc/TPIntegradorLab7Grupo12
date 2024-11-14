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
		ArrayList<Persona> personas = personaNegocio.readAll();
		
		request.setAttribute("lista", personas);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/ListarModificarEliminarUsuarios.jsp");   
        rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		IPersonaDao personaDao = new PersonaDaoImpl();
		ArrayList<Persona> personas = personaDao.readAll();
		
		request.setAttribute("lista", personas);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/ListarModificarEliminarUsuarios.jsp");   
        rd.forward(request, response);
		doGet(request, response);
	}

}
