package Presentacion.Auth;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;

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
            response.sendRedirect("Usuario/VistaHomeUsuario.jsp");
        }
    }

    private List<MenuItem> getAdminMenu(HttpServletRequest request) {
        List<MenuItem> cuentasSubMenu = Arrays.asList(
            new MenuItem("Alta Cuenta", request.getContextPath() + "/Administrador/Cuentas/AltaCuenta.jsp"),
            new MenuItem("Modificar Cuenta", request.getContextPath() + "/Administrador/Cuentas/ModificarEliminarCuentas.jsp"),
            new MenuItem("Listar Cuentas", request.getContextPath() + "/Administrador/Cuentas/ServletCuentas")
        );

        List<MenuItem> prestamosSubMenu = Arrays.asList(
            new MenuItem("Alta Préstamo", request.getContextPath() + "/Administrador/Prestamos/AutorizarPrestamo.jsp")
        );

        List<MenuItem> usuariosSubMenu = Arrays.asList(
            new MenuItem("Alta Usuario", request.getContextPath() + "/Administrador/Usuarios/AltaUsuarios.jsp"),
            new MenuItem("Listar Usuarios", request.getContextPath() + "/Administrador/Usuarios/ServletUsuarios")
        );

        return Arrays.asList(
            new MenuItem("Inicio", request.getContextPath() + "/Administrador/VistaHomeAdministrador.jsp"),
            new MenuItem("Informes y Reportes", request.getContextPath() + "/Administrador/InformesReportes.jsp"),
            new MenuItem("Cuentas", cuentasSubMenu),
            new MenuItem("Préstamos", prestamosSubMenu),
            new MenuItem("Usuarios", usuariosSubMenu),
            new MenuItem("Cerrar Sesión", request.getContextPath() + "/SvLogout")
        );
    }

    private List<MenuItem> getUserMenu(HttpServletRequest request) {
        List<MenuItem> preferenciasSubMenu = Arrays.asList(
            new MenuItem("Preferencias Usuario", request.getContextPath() + "/Usuario/Preferencias")
        );

        List<MenuItem> prestamosSubMenu = Arrays.asList(
            new MenuItem("Préstamos", request.getContextPath() + "/Usuario/Prestamos"),
            new MenuItem("Pagar Cuotas", request.getContextPath() + "/Usuario/Prestamos/VistaPagarCuotas.jsp"),
            new MenuItem("Solicitar Préstamo", request.getContextPath() + "/Usuarios/Prestamos/ServletSolicitarPrestamo")
        );

        List<MenuItem> transferenciasSubMenu = Arrays.asList(
            new MenuItem("Transferencias", request.getContextPath() + "/Usuario/Transferencias"),
            new MenuItem("Nueva Transferencia", request.getContextPath() + "/Usuario/NuevaTransferencia.jsp")
        );

        return Arrays.asList(
            new MenuItem("Inicio", request.getContextPath() + "/Usuario/VistaHomeUsuario.jsp"),
            new MenuItem("Preferencias", preferenciasSubMenu),
            new MenuItem("Préstamos", prestamosSubMenu),
            new MenuItem("Transferencias", transferenciasSubMenu),
            new MenuItem("Cerrar Sesión", request.getContextPath() + "/SvLogout")
        );
    }
}