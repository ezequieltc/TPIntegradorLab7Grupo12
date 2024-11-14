package Presentacion;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dominio.Persona;
import NegocioImpl.PersonaNegocioImpl;

/**
 * Servlet implementation class ServletModificarUsuario
 */
@WebServlet("/ServletModificarUsuario")
public class ServletModificarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletModificarUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PersonaNegocioImpl pNeg = new PersonaNegocioImpl();
		
		if(request.getParameter("btnConfirmarModificacionUsuario") != null) {
			int id = Integer.parseInt(request.getParameter("id"));
			
			Persona persona = pNeg.getPersona(id);
			System.out.println("Botón Guardar presionado, redirigiendo a /ServletUsuarios");
	        persona.setDireccion(request.getParameter("direccion"));
	        persona.setLocalidad(request.getParameter("localidad"));
	        persona.setProvincia(request.getParameter("provincia"));
	        persona.setEmail(request.getParameter("email"));
	        persona.setTelefono(request.getParameter("telefono"));
	        
			pNeg.update(persona);
			
			request.setAttribute("persona", persona);
			RequestDispatcher rd = request.getRequestDispatcher("/ServletUsuarios");
			rd.forward(request, response);
		}
		
		
		RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/ModificarUsuario.jsp");
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
