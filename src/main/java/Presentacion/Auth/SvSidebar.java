package Presentacion.Auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SvSidebar
 */
@WebServlet("/SvSidebar")
public class SvSidebar extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        boolean isAdmin = (boolean) session.getAttribute("isAdmin");

        // Define elementos de la barra lateral según el tipo de usuario
        String[] sidebarNames;
        String[] sidebarLinks;

        if (isAdmin) {
            sidebarNames = new String[]{"Inicio", "Usuarios", "Configuración", "Cerrar Sesión"};
            sidebarLinks = new String[]{request.getContextPath() + "/home.jsp",
                                        request.getContextPath() + "/users.jsp",
                                        request.getContextPath() + "/settings.jsp",
                                        request.getContextPath() + "/logout"};
        } else {
            sidebarNames = new String[]{"Inicio", "Perfil", "Soporte", "Cerrar Sesión"};
            sidebarLinks = new String[]{request.getContextPath() + "/home.jsp",
                                        request.getContextPath() + "/profile.jsp",
                                        request.getContextPath() + "/support.jsp",
                                        request.getContextPath() + "/logout"};
        }

        session.setAttribute("sidebarNames", sidebarNames);
        session.setAttribute("sidebarLinks", sidebarLinks);
        
        if (isAdmin) {
        	response.sendRedirect("Administrador/VistaHomeAdministrador.jsp");
        } else {
        	response.sendRedirect("VistaHomeUsuario.jsp");
        }
       
    }
}
