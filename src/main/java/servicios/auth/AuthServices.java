package servicios.auth;

import java.util.HashMap;
import java.util.Map;

import Dao.IPersonaDao;
import Dao.IUsuarioDao;
import DaoImpl.PersonaDaoImpl;
import DaoImpl.UsuarioDaoImpl;
import Dominio.Persona;
import Dominio.Usuario;
import excepciones.UsuarioBloqueado;

public class AuthServices {
	
	private static Map<Usuario, Integer> intentos = new HashMap<Usuario, Integer>();
	
	public AuthServices() {
		
	}
	
	public Persona login(String user, String pass) throws UsuarioBloqueado
	{
		System.out.println("Validando intentos de login nro: " + intento);
		IUsuarioDao userDAO = new UsuarioDaoImpl();
		Persona persona = null;
		Usuario usuario = new Usuario();
		usuario = userDAO.getUsuario(user);
		if(usuario != null && usuario.getEstado()) {
			if(usuario.getContrasena().equals(pass)){
				persona = (new PersonaDaoImpl().getPersonaPorUsuario(usuario.getId()));
				return persona;
			}
		}
		if(!setIntentosFallidos(usuario)) {
			usuario.setEstado(false);
			userDAO.update(usuario);
			throw new UsuarioBloqueado("Se bloquea usuario por reintentos fallidos");
		}
		return persona;	
	}
	
	private boolean setIntentosFallidos(Usuario usuario) {
		Integer intento = (intentos.get(usuario) == null) ? 0 : intentos.get(usuario);
		System.out.println("Validando intentos de login nro: " + intento);
		if(intento == 3) {
			return false;
		}else {
			intentos.put(usuario, intento++);
		}
		return true;
	}
}
