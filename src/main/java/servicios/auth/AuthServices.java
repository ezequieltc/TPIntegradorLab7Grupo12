package servicios.auth;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import Dao.IPersonaDao;
import Dao.IUsuarioDao;
import DaoImpl.PersonaDaoImpl;
import DaoImpl.UsuarioDaoImpl;
import Dominio.Persona;
import Dominio.Usuario;
import excepciones.PersonaExistenteExcepcion;
import excepciones.UsuarioBloqueado;

public class AuthServices {
	
	private static Map<Integer, Integer> intentos = new HashMap<Integer, Integer>();
	
	public AuthServices() {
		
	}
	
	public Persona login(String email, String pass) throws UsuarioBloqueado, PersonaExistenteExcepcion
	{
		IUsuarioDao userDAO = new UsuarioDaoImpl();
		Persona persona = null;
		Usuario usuario = null;
		usuario = userDAO.getUsuario(email);
		if(usuario != null && usuario.getEstado()) {
			if(usuario.getContrasena().equals(pass)){
				persona = (new PersonaDaoImpl().getPersonaPorUsuario(usuario.getId()));
				intentos.remove(usuario);
				return persona;
			}
		}
		if(usuario == null) {
			throw new PersonaExistenteExcepcion("Usuario inexistente");
		}
		
		if(!setIntentosFallidos(usuario) || !usuario.getEstado()) {
			usuario.setEstado(false);
			userDAO.update(usuario);
			throw new UsuarioBloqueado("Usuario bloqueado, por favor ponganse en contacto con la sucursal mas cercana a su domicilio");
		}
		return persona;	
	}
	
	//Validacion e imputacion de intentos de login fallidos
	private boolean setIntentosFallidos(Usuario usuario) {
		Integer intento = (intentos.get(usuario.getId()) == null) ? 0 : intentos.get(usuario.getId());
		if(intento == 0) {
			intentos.put(usuario.getId(), intento);
		}
		System.err.println("Intento nro " + intento + " del usuario " + usuario.getUsuario());
		if(intento == 3) {
			return false;
		}else {
			intentos.replace(usuario.getId(), intento + 1);
		}
		return true;
	}


}
