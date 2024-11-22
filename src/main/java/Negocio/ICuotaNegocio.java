package Negocio;

import java.util.ArrayList;

import Dominio.Cuota;

public interface ICuotaNegocio {
	
	boolean insertarCuota(Cuota cuota);
	boolean actualizarCuota(Cuota cuota);
	boolean eliminarCuota(Cuota cuota);
	ArrayList<Cuota> listadoCuotas();
	

}
