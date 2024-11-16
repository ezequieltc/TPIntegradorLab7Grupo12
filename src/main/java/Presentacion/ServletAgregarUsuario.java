package Presentacion;
 
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import Dominio.Persona;
import Dominio.TipoSexo;
import Dominio.Usuario;
import NegocioImpl.PersonaNegocioImpl;
 
@WebServlet("/ServletAgregarUsuario")
public class ServletAgregarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public ServletAgregarUsuario() {
        super();
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
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
                request.setAttribute("errorMessage", "ID de TipoSexo inválido.");
                RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/AltaUsuarios.jsp");
                rd.forward(request, response);
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
            usuario.setUsuario(request.getParameter("usuario"));
            usuario.setContrasena(request.getParameter("contrasena"));
            persona.setUsuario(usuario);
            
            boolean isAdded = personaNegocio.insert(persona);
            
            if (isAdded) {
                response.sendRedirect(request.getContextPath() + "/ServletUsuarios?status=success");
                System.out.println("Se agrego la persona con dni " + persona.getDni() );
                
            } else {
                request.setAttribute("errorMessage", "Hubo un error al agregar el usuario. Intente nuevamente.");
                RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/AltaUsuarios.jsp");
                rd.forward(request, response);
            }
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("/Administrador/Usuarios/AltaUsuarios.jsp");
            rd.forward(request, response);
        }
	}
}
 