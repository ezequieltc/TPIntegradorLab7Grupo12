package Presentacion.Administrador.Usuarios;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import Negocio.IUsuarioNegocio;
import NegocioImpl.UsuarioNegocioImpl;

@WebServlet("/Administrador/Usuarios/ServletReactivarUsuario")
public class ServletReactivarUsuario extends HttpServlet {
private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletReactivarUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		IUsuarioNegocio usuarioNegocio = new UsuarioNegocioImpl();
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            usuarioNegocio.reactivarUsuario(id);

            request.getSession().setAttribute("mensajeExito", "¡Usuario reactivado exitosamente!");
            request.getSession().setAttribute("mostrarPopUp", true);
            request.getSession().setAttribute("popUpStatus", "success");

            response.sendRedirect(request.getContextPath() + "/Administrador/Usuarios/ServletUsuarios");
        } catch (Exception e) {
            e.printStackTrace();

            request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + e.getMessage());
            request.getSession().setAttribute("popUpStatus", "error"); 
            request.getSession().setAttribute("mostrarPopUp", true);

            response.getWriter().println("Error al reactivar el usuario: " + e.getMessage());
        }
		
	}
}
