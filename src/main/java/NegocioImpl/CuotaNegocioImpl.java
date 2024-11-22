package NegocioImpl;

import java.util.ArrayList;

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
	
}
