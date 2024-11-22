package Dao;

import java.util.ArrayList;

import Dominio.Prestamo;

public interface IPrestamoDao {
	public boolean insert(Prestamo prestamo);
	public boolean delete(Prestamo prestamo);
	public boolean update(Prestamo prestamo);
	public Prestamo getPrestamoPorId(int id);
	public ArrayList<Prestamo> getPrestamos();
	public ArrayList<Prestamo> getPrestamos(int idUsuario);

}
