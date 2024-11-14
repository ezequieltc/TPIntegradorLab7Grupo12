package NegocioImpl;

import java.util.ArrayList;

import Dao.IUsuarioDao;
import DaoImpl.UsuarioDaoImpl;
import Dominio.Usuario;
import Dominio.DTO.PaginatedResponse;
import Negocio.IUsuarioNegocio;

public class UsuarioNegocioImpl implements IUsuarioNegocio{

	IUsuarioDao usuarioDao = new UsuarioDaoImpl();
	@Override
	public boolean insert(Usuario usuario) {
		boolean estado = false;
		estado = usuarioDao.insert(usuario);
		return estado;
	}

	@Override
	public boolean delete(Usuario usuario) {
		boolean estado = false;
		estado = usuarioDao.delete(usuario);
		return estado;
	}

	@Override
	public boolean update(Usuario usuario) {
		boolean estado = false;
		estado = usuarioDao.update(usuario);
		return estado;
	}
	
	@Override
	public PaginatedResponse<Usuario> readAll(int pagina) {
		
		return usuarioDao.readAll(pagina);
	}


}
