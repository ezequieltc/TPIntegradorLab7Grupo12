package NegocioImpl;

import java.util.ArrayList;

import Dao.ITipoSexoDao;
import DaoImpl.TipoSexoDaoImpl;
import Dominio.TipoSexo;
import Negocio.ITipoSexoNegocio;

public class TipoSexoNegocioImpl implements ITipoSexoNegocio{

ITipoSexoDao tipoSexo = new TipoSexoDaoImpl();
@Override
public ArrayList<TipoSexo> readAll() {

return tipoSexo.getTipoSexo();
}

public TipoSexo getTipoSexo(int id) {
return tipoSexo.getTipoSexo(id);
}

}