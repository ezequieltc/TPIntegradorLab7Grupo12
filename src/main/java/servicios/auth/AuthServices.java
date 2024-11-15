package servicios.auth;

import Dao.IPersonaDao;
import Dao.IUsuarioDao;
import DaoImpl.PersonaDaoImpl;
import DaoImpl.UsuarioDaoImpl;
import Dominio.Persona;
import Dominio.Usuario;

public class AuthServices {
	
	public AuthServices() {
		
	}
	
	public Persona login(String user, String pass)
	{
		IUsuarioDao userDAO = new UsuarioDaoImpl();
		IPersonaDao personaDAO = null;
		Persona persona = null;
		Usuario usuario = new Usuario();
		usuario = userDAO.getUsuario(user);
		if(usuario != null && (usuario.getContrasena().equals(pass) && usuario.getEstado())) {
			persona = (new PersonaDaoImpl().getPersonaPorUsuario(usuario.getId()));
		}
		return persona;
	}
}
