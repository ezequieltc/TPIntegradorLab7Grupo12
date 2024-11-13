package NegocioImpl;

import java.util.ArrayList;

import Dao.ICuentaDao;
import DaoImpl.CuentaDaoImpl;
import Dominio.Cuenta;
import Negocio.ICuentaNegocio;

public class CuentaNegocioImpl implements ICuentaNegocio {

    ICuentaDao cuentaDao = new CuentaDaoImpl();

    @Override
    public boolean insert(Cuenta cuenta) {
        boolean estado = false;
        estado = cuentaDao.insert(cuenta);
        return estado;
    }

    @Override
    public boolean delete(Cuenta cuenta) {
        boolean estado = false;
        estado = cuentaDao.delete(cuenta);
        return estado;
    }

    @Override
    public boolean update(Cuenta cuenta) {
        boolean estado = false;
        estado = cuentaDao.update(cuenta);
        return estado;
    }

    @Override
    public ArrayList<Cuenta> readAll() {
        return cuentaDao.readAll();
    }
}
