package Dao;

import java.util.ArrayList;

import Dominio.Cuota;

public interface ICuotaDao {

	public boolean insert(Cuota cuota);
	public boolean delete(Cuota cuota);
	public boolean update(Cuota cuota);
	public Cuota getCuotaPorId(int id);
	public ArrayList<Cuota> listarCuotas();

}
