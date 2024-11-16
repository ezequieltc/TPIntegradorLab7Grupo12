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
	
	private static Map<Integer, Integer> intentos = new HashMap<Integer, Integer>();
	
	public AuthServices() {
		
	}
	
	public Persona login(String email, String pass) throws UsuarioBloqueado
	{
		IUsuarioDao userDAO = new UsuarioDaoImpl();
		Persona persona = null;
		Usuario usuario = new Usuario();
		usuario = userDAO.getUsuario(email);
		if(usuario != null && usuario.getEstado()) {
			System.out.println("validando usuario " + usuario.getContrasena());
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
	
	//Validacion e imputacion de intentos de login fallidos
	private boolean setIntentosFallidos(Usuario usuario) {
		Integer intento = (intentos.get(usuario.getId()) == null) ? 0 : intentos.get(usuario.getId());
		if(intento == 0) {
			intentos.put(usuario.getId(), intento);
		}
		if(intento == 3) {
			return false;
		}else {
			intentos.replace(usuario.getId(), intento + 1);
		}
		return true;
	}


}
