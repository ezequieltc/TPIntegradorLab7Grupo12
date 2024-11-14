package NegocioImpl;

import java.util.ArrayList;

import Dao.IPersonaDao;
import DaoImpl.PersonaDaoImpl;
import Dominio.Persona;
import Dominio.DTO.PaginatedResponse;
import Negocio.IPersonaNegocio;

public class PersonaNegocioImpl implements IPersonaNegocio{

	IPersonaDao personaDao = new PersonaDaoImpl();

	@Override
	public boolean insert(Persona persona) {
	    boolean estado = false;
	    estado = personaDao.insert(persona);
	    return estado;
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
