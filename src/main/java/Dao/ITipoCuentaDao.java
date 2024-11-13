package Dao;

import java.util.ArrayList;
import Dominio.TipoCuenta;

public interface ITipoCuentaDao {

    public TipoCuenta getTipoCuenta(int id);
    
    public ArrayList<TipoCuenta> getTipoCuenta();
    
}
