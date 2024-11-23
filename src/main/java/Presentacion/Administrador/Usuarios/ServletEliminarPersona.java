package Presentacion.Administrador.Usuarios;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Negocio.IPersonaNegocio;
import NegocioImpl.PersonaNegocioImpl;

@WebServlet("/Administrador/Usuarios/ServletEliminarPersona")
public class ServletEliminarPersona extends HttpServlet {
private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletEliminarPersona() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		IPersonaNegocio personaNegocio = new PersonaNegocioImpl();
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            personaNegocio.eliminarPersona(id);

            request.getSession().setAttribute("mensajeExito", "¡Persona eliminada exitosamente!");
            request.getSession().setAttribute("mostrarPopUp", true);
            request.getSession().setAttribute("popUpStatus", "success");

            response.sendRedirect(request.getContextPath() + "/Administrador/Usuarios/ServletUsuarios");
        } catch (Exception e) {
            e.printStackTrace();

            request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + e.getMessage());
            request.getSession().setAttribute("popUpStatus", "error"); 
            request.getSession().setAttribute("mostrarPopUp", true);

            response.sendRedirect(request.getContextPath() + "/Administrador/Usuarios/ServletUsuarios");
        }
		
	}
}
