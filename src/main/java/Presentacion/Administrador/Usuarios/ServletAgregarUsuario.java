package Presentacion.Administrador.Usuarios;
 
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dominio.Persona;
import Dominio.TipoSexo;
import Dominio.Usuario;
import Negocio.ITipoSexoNegocio;
import NegocioImpl.PersonaNegocioImpl;
import NegocioImpl.TipoSexoNegocioImpl;
 
@WebServlet("/Administrador/Usuarios/ServletAgregarUsuario")
public class ServletAgregarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public ServletAgregarUsuario() {
        super();
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        ITipoSexoNegocio tipoSexoNegocio = new TipoSexoNegocioImpl();

        ArrayList<TipoSexo> tipoSexos = tipoSexoNegocio.readAll();

        session.setAttribute("tipoSexos", tipoSexos);

        response.sendRedirect(request.getContextPath() + "/Administrador/Usuarios/AltaUsuarios.jsp");
        
    }
 
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PersonaNegocioImpl personaNegocio = new PersonaNegocioImpl();
        
        if (request.getParameter("btnConfirmarAgregarUsuario") != null) {
            Persona persona = new Persona();
            persona.setDni(request.getParameter("dni"));
            persona.setCuil(request.getParameter("cuil"));
            persona.setNombre(request.getParameter("nombre"));
            persona.setApellido(request.getParameter("apellido"));
            persona.setNacionalidad(request.getParameter("nacionalidad"));            
            TipoSexo tipoSexo = new TipoSexo();
            try {
                int tipoSexoId = Integer.parseInt(request.getParameter("sexo"));
                tipoSexo.setId(tipoSexoId);
                persona.setTipoSexo(tipoSexo);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.getSession().setAttribute("mensajeError", "Ocurrió un error: " + e.getMessage());
    			request.getSession().setAttribute("popUpStatus", "error");
    			request.getSession().setAttribute("mostrarPopUp", true);
    			response.sendRedirect(request.getContextPath() + "/Administrador/Usuarios/AltaUsuarios.jsp");
                return;
            }
            
            String fechaNacimientoStr = request.getParameter("fechaNacimiento");
            try {
                Date fechaNacimiento = new SimpleDateFormat("yyyy-MM-dd").parse(fechaNacimientoStr);
                persona.setFechaNacimiento(fechaNacimiento);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            persona.setDireccion(request.getParameter("direccion"));
            persona.setLocalidad(request.getParameter("localidad"));
            persona.setProvincia(request.getParameter("provincia"));
            persona.setTelefono(request.getParameter("telefono"));
            persona.setEmail(request.getParameter("correo"));          
            Usuario usuario = new Usuario();
            String contrasena = request.getParameter("contrasena");
            String confirmarContrasena = request.getParameter("confirmarContrasena");
            usuario.setUsuario(request.getParameter("usuario"));
            usuario.setContrasena(contrasena);
            persona.setUsuario(usuario);
            
            try {
                if (!contrasena.equals(confirmarContrasena)) {
                	throw new Exception("Las contraseñas no coinciden");
                }
            	
            	personaNegocio.registrarCliente(persona);

                request.getSession().setAttribute("mensajeExito", "¡Usuario agregado exitosamente!");
                request.getSession().setAttribute("mostrarPopUp", true);
                request.getSession().setAttribute("popUpStatus", "success");

                response.sendRedirect(request.getContextPath() + "/Administrador/Usuarios/ServletUsuarios");
            }catch(Exception e){

                request.getSession().setAttribute("mensajeError", e.getMessage());
    			request.getSession().setAttribute("popUpStatus", "error");
    			request.getSession().setAttribute("mostrarPopUp", true);

    			    // Enviar los datos ingresados de vuelta al formulario
                request.setAttribute("dni", request.getParameter("dni"));
                request.setAttribute("cuil", request.getParameter("cuil"));
                request.setAttribute("nombre", request.getParameter("nombre"));
                request.setAttribute("apellido", request.getParameter("apellido"));
                request.setAttribute("nacionalidad", request.getParameter("nacionalidad"));
                request.setAttribute("sexo", request.getParameter("sexo"));
                request.setAttribute("fechaNacimiento", request.getParameter("fechaNacimiento"));
                request.setAttribute("direccion", request.getParameter("direccion"));
                request.setAttribute("localidad", request.getParameter("localidad"));
                request.setAttribute("provincia", request.getParameter("provincia"));
                request.setAttribute("telefono", request.getParameter("telefono"));
                request.setAttribute("correo", request.getParameter("correo"));
                request.setAttribute("usuario", request.getParameter("usuario"));

                // Redirigir de vuelta al formulario
                RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/AltaUsuarios.jsp");
                rd.forward(request, response);
            }
            
            
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/AltaUsuarios.jsp");
            rd.forward(request, response);
        }
	}
}
 