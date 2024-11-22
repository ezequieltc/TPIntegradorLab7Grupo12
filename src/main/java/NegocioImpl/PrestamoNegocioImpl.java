package NegocioImpl;

import java.util.ArrayList;

import Dao.IPrestamoDao;
import DaoImpl.PrestamoDaoImpl;
import Dominio.Prestamo;
import Negocio.IPrestamoNegocio;

public class PrestamoNegocioImpl implements IPrestamoNegocio {
	IPrestamoDao prestamoDao = new PrestamoDaoImpl();
	
	@Override
	public boolean insert(Prestamo prestamo) {
		boolean estado = false;
		estado = prestamoDao.insert(prestamo);
		return estado;
	}
	
	@Override
	public boolean delete(Prestamo prestamo) {
		boolean estado = false;
		estado = prestamoDao.delete(prestamo);
		return estado;
	}
	
	@Override
	public boolean update(Prestamo prestamo) {
		boolean estado = false;
		estado = prestamoDao.update(prestamo);
		return estado;
	}
	
	@Override
	public Prestamo getPrestamoPorId(int id) {
		Prestamo prestamo = prestamoDao.getPrestamoPorId(id);
		return prestamo;
	}
	
	@Override
	public ArrayList<Prestamo> getPrestamos(){
		return prestamoDao.getPrestamos();
	}

	@Override
	public ArrayList<Prestamo> getPrestamos(int idUsuario) {
		return prestamoDao.getPrestamos(idUsuario);
	}
	

}
