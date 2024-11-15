package Presentacion.Auth;

import java.io.IOException;
import java.util.List;

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
        List<MenuItem> menuItems;

        if (isAdmin) {
            menuItems = getAdminMenu(request);
        } else {
            menuItems = getUserMenu(request);
        }

        session.setAttribute("sidebarMenu", menuItems);
        
        if (isAdmin) {
            response.sendRedirect("Administrador/VistaHomeAdministrador.jsp");
        } else {
            response.sendRedirect("VistaHomeUsuario.jsp");
        }
    }

    private List<MenuItem> getAdminMenu(HttpServletRequest request) {
        List<MenuItem> cuentasSubMenu = List.of(
            new MenuItem("Alta Cuenta", request.getContextPath() + "/Administrador/Cuentas/AltaCuenta.jsp"),
            new MenuItem("Modificar Cuenta", request.getContextPath() + "/Administrador/Cuentas/ModificacionCuenta.jsp"),
            new MenuItem("Listar Cuentas", request.getContextPath() + "/Administrador/Cuentas/ListarCuentas.jsp")
        );

        List<MenuItem> prestamosSubMenu = List.of(
            new MenuItem("Alta Préstamo", request.getContextPath() + "/Administrador/Prestamos/AltaPrestamo.jsp")
        );

        List<MenuItem> usuariosSubMenu = List.of(
            new MenuItem("Alta Usuario", request.getContextPath() + "/Administrador/Usuarios/AltaUsuario.jsp"),
            new MenuItem("Modificar Usuario", request.getContextPath() + "/Administrador/Usuarios/ModificacionUsuario.jsp")
        );

        return List.of(
            new MenuItem("Inicio", request.getContextPath() + "/home.jsp"),
            new MenuItem("Informes y Reportes", request.getContextPath() + "/Administrador/InformesReportes.jsp"),
            new MenuItem("Cuentas", cuentasSubMenu),
            new MenuItem("Préstamos", prestamosSubMenu),
            new MenuItem("Usuarios", usuariosSubMenu),
            new MenuItem("Cerrar Sesión", request.getContextPath() + "/SvLogout")
        );
    }

    private List<MenuItem> getUserMenu(HttpServletRequest request) {
        List<MenuItem> preferenciasSubMenu = List.of(
            new MenuItem("Preferencias Usuario", request.getContextPath() + "/Usuario/PreferenciasUsuario.jsp")
        );

        List<MenuItem> prestamosSubMenu = List.of(
            new MenuItem("Préstamos", request.getContextPath() + "/Usuario/Prestamos.jsp"),
            new MenuItem("Solicitar Préstamo", request.getContextPath() + "/Usuario/SolicitarPrestamo.jsp")
        );

        List<MenuItem> transferenciasSubMenu = List.of(
            new MenuItem("Transferencias", request.getContextPath() + "/Usuario/Transferencias.jsp"),
            new MenuItem("Nueva Transferencia", request.getContextPath() + "/Usuario/NuevaTransferencia.jsp")
        );

        return List.of(
            new MenuItem("Inicio", request.getContextPath() + "/home.jsp"),
            new MenuItem("Preferencias", preferenciasSubMenu),
            new MenuItem("Préstamos", prestamosSubMenu),
            new MenuItem("Transferencias", transferenciasSubMenu),
            new MenuItem("Cerrar Sesión", request.getContextPath() + "/SvLogout")
        );
    }
}
