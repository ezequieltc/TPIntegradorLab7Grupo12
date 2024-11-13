package NegocioImpl;

import java.util.ArrayList;

import Dao.ITipoUsuarioDao;
import DaoImpl.TipoUsuarioDaoImpl;
import Dominio.TipoUsuario;
import Negocio.ITipoUsuarioNegocio;

public class TipoUsuarioNegocioImpl implements ITipoUsuarioNegocio{

	ITipoUsuarioDao tipoUsuario = new TipoUsuarioDaoImpl();
	@Override
	public ArrayList<TipoUsuario> readAll() {
		
		return tipoUsuario.getTipoUsuario();
	}

}
