package NegocioImpl;

import java.util.ArrayList;

import Dao.ITipoCuentaDao;
import DaoImpl.TipoCuentaDaoImpl;
import Dominio.TipoCuenta;
import Negocio.ITipoCuentaNegocio;

public class TipoCuentaNegocioImpl implements ITipoCuentaNegocio {

    ITipoCuentaDao tipoCuentaDao = new TipoCuentaDaoImpl();

    @Override
    public ArrayList<TipoCuenta> readAll() {
        return tipoCuentaDao.getTipoCuenta();
    }
}
