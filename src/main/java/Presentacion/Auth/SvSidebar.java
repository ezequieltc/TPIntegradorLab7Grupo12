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
            response.sendRedirect("Administrador/Home/ServletHomeAdministrador");
        } else {
            response.sendRedirect("Usuarios/Home/ServletHomeUsuario");
        }
    }

    private List<MenuItem> getAdminMenu(HttpServletRequest request) {
        List<MenuItem> cuentasSubMenu = Arrays.asList(
            new MenuItem("Alta Cuenta", request.getContextPath() + "/Administrador/Cuentas/ServletAgregarCuenta"),
            new MenuItem("Modificar Cuenta", request.getContextPath() + "/Administrador/Cuentas/ServletModificarEliminarCuenta"),
            new MenuItem("Listar Cuentas", request.getContextPath() + "/Administrador/Cuentas/ServletCuentas")
        );

        List<MenuItem> prestamosSubMenu = Arrays.asList(
            new MenuItem("Alta Préstamo", request.getContextPath() + "/Administrador/Prestamos/ServletAutorizarPrestamo")
        );

        List<MenuItem> usuariosSubMenu = Arrays.asList(
            new MenuItem("Alta Usuario", request.getContextPath() + "/Administrador/Usuarios/ServletAgregarUsuario"),
            new MenuItem("Listar Usuarios", request.getContextPath() + "/Administrador/Usuarios/ServletUsuarios")
        );

        return Arrays.asList(
            new MenuItem("Inicio", request.getContextPath() + "/Administrador/ServletHomeAdministrador"),
            new MenuItem("Informes y Reportes", request.getContextPath() + "/Administrador/InformesReportes.jsp"),
            new MenuItem("Cuentas", cuentasSubMenu),
            new MenuItem("Préstamos", prestamosSubMenu),
            new MenuItem("Usuarios", usuariosSubMenu),
            new MenuItem("Cerrar Sesión", request.getContextPath() + "/SvLogout")
        );
    }

    private List<MenuItem> getUserMenu(HttpServletRequest request) {

        List<MenuItem> prestamosSubMenu = Arrays.asList(
            new MenuItem("Préstamos", request.getContextPath() + "/Usuarios/Prestamos/ServletPrestamos"),
            new MenuItem("Pagar Cuotas", request.getContextPath() + "/Usuarios/Prestamos/ServletPagarCuota"),
            new MenuItem("Solicitar Préstamo", request.getContextPath() + "/Usuarios/Prestamos/ServletSolicitarPrestamo")
        );

        List<MenuItem> transferenciasSubMenu = Arrays.asList(
            new MenuItem("Transferencias", request.getContextPath() + "/Usuario/Transferencias"),
            new MenuItem("Nueva Transferencia", request.getContextPath() + "/Usuario/Transferencias/NuevaTransferencia.jsp")
        );

        return Arrays.asList(
            new MenuItem("Inicio", request.getContextPath() + "/Usuarios/Home/ServletHomeUsuario"),
            new MenuItem("Préstamos", prestamosSubMenu),
            new MenuItem("Transferencias", transferenciasSubMenu),
            new MenuItem("Cerrar Sesión", request.getContextPath() + "/SvLogout")
        );
    }
}