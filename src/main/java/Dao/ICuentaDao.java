package Dao;

import java.util.ArrayList;

import Dominio.Cuenta;

public interface ICuentaDao {

	public boolean insert(Cuenta cuenta);
	public boolean delete(Cuenta cuenta);
	public boolean update(Cuenta cuenta);
	public Cuenta getCuenta(int id);
	public Cuenta getCuenta(String numberoCuenta, String cbu);
	public ArrayList<Cuenta> readAll();
	public int calcularSiguienteId();
}
