package NegocioImpl;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import Dao.IPersonaDao;
import Dao.IUsuarioDao;
import DaoImpl.PersonaDaoImpl;
import DaoImpl.UsuarioDaoImpl;
import Dominio.Persona;
import Dominio.TipoUsuario;
import Dominio.Usuario;
import Dominio.DTO.PaginatedResponse;
import Negocio.IPersonaNegocio;
import servicios.ddbb.Conexion;

public class PersonaNegocioImpl implements IPersonaNegocio{

	IPersonaDao personaDao = new PersonaDaoImpl();
	IUsuarioDao usuarioDao = new UsuarioDaoImpl();

	@Override
	public void registrarCliente(Persona persona) throws RuntimeException, SQLException {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		try{
			conexion.setAutoCommit(false);

			Usuario usuario = persona.getUsuario();
			usuario.setId(usuarioDao.calcularSiguienteId());
			TipoUsuario tipoUsuario = new TipoUsuario("Cliente");
			tipoUsuario.setId(2);
			usuario.setTipoUsuario(tipoUsuario);
			usuario.setEstado(true);

			// Date actual
			Date fechaActual = new Date();
			usuario.setFechaCreacion(fechaActual);

			
			usuarioDao.insert(usuario);

			persona.setUsuario(usuario);
			persona.setEstado(true);

			personaDao.insert(persona);

			conexion.commit();
		
		} catch (Exception e) {
			e.printStackTrace();
			conexion.rollback();

			if (e.getMessage().contains("dni")) {
				throw new RuntimeException("Hubo un error al registrar el cliente: el dni ya existe");
			}
			if (e.getMessage().contains("cuil")) {
				throw new RuntimeException("Hubo un error al registrar el cliente: el cuil ya existe");
			}
			if (e.getMessage().contains("email")) {
				throw new RuntimeException("Hubo un error al registrar el cliente: el email ya existe");
			}
			if (e.getMessage().contains("usuarios.usuario")) {
				throw new RuntimeException("Hubo un error al registrar el cliente: el usuario ya existe");
			}
			
			throw new RuntimeException("Hubo un error al registrar el cliente: " + e.getMessage());
		}
	}

	@Override
	public boolean delete(int id) {
	    boolean estado = false;
	    estado = personaDao.delete(id);
	    return estado;
	}

	@Override
	public boolean update(Persona persona) {
	    boolean estado = false;
	    estado = personaDao.update(persona);
	    return estado;
	}

	@Override
	public PaginatedResponse<Persona> readAll(int pagina) {
	    return personaDao.readAll(pagina);
	}

	@Override
	public Persona getPersona(int id) {
		return personaDao.getPersona(id);
	}

}
