package Negocio;

import java.util.ArrayList;

import Dominio.Cuenta;
import Dominio.Cuota;

public interface ICuotaNegocio {
	
	boolean insertarCuota(Cuota cuota);
	boolean actualizarCuota(Cuota cuota);
	boolean eliminarCuota(Cuota cuota);
	boolean pagarCuota(Cuota cuota, Cuenta cuenta);
	ArrayList<Cuota> listadoCuotas();
	ArrayList<Cuota> listadoCuotasPorIdPrestamo(int id);
	Cuota getCuotaPorId(int id);
	

}
