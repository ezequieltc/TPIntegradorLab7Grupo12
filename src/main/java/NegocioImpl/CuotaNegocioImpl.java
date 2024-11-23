package NegocioImpl;

import java.util.ArrayList;

import Dominio.Cuenta;
import Dominio.Cuota;
import Dao.ICuotaDao;
import DaoImpl.CuotaDaoImpl;

public class CuotaNegocioImpl {

	ICuotaDao cuotaDao = new CuotaDaoImpl();
	
	public boolean insertarCuota(Cuota cuota) {
		try {
			cuotaDao.insert(cuota);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	public boolean actualizarCuota(Cuota cuota) {
		try {
			cuotaDao.update(cuota);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	public boolean eliminarCuota(Cuota cuota) {
		try {
			cuotaDao.delete(cuota);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	public ArrayList<Cuota> listadoCuotas(){
		ArrayList<Cuota> listadoCuotas = new ArrayList<Cuota>();
		try {
			listadoCuotas = cuotaDao.listarCuotas();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listadoCuotas;

	}
	
	public ArrayList<Cuota> listadoCuotasPorIdPrestamo(int id){
		ArrayList<Cuota> listadoCuotas = new ArrayList<Cuota>();
		try {
			listadoCuotas = cuotaDao.listarCuotasPorIdPrestamo(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listadoCuotas;
	}
	
	public Cuota getCuotaPorId(int id) {
		Cuota cuota = new Cuota();
		try {
			cuota = cuotaDao.getCuotaPorId(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cuota;
	}
	
	public boolean pagarCuota(Cuota cuota, Cuenta cuenta) {
		try {
			cuotaDao.pagarCuota(cuota, cuenta);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
}
