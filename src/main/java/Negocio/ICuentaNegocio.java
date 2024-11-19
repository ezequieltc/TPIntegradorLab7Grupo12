package Negocio;

import java.util.ArrayList;
import Dominio.Cuenta;

public interface ICuentaNegocio {
    public boolean insert(Cuenta cuenta);
    public boolean delete(Cuenta cuenta);
    public boolean update(Cuenta cuenta);
    public ArrayList<Cuenta> readAll();
    public ArrayList<Cuenta> getCuentasPorCliente(int Id);
}
