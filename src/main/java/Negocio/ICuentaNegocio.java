package Negocio;

import java.sql.SQLException;
import java.util.ArrayList;
import Dominio.Cuenta;

public interface ICuentaNegocio {
    public boolean insert(Cuenta cuenta);
    public boolean delete(Cuenta cuenta);
    public boolean update(Cuenta cuenta);
    public ArrayList<Cuenta> readAll();
    public ArrayList<Cuenta> getCuentasPorCliente(int Id);
    public Cuenta getCuenta(int id);
    public Cuenta getCuenta(String numberoCuenta, String cbu);
    public void transferir(Cuenta cuentaOrigen, Cuenta cuentaDestino, float monto) throws Exception;
}
