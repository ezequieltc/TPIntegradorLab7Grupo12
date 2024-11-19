package NegocioImpl;

import Dao.IMovimientoDao;
import DaoImpl.MovimientoDaoImpl;
import Dominio.Movimiento;
import Dominio.DTO.PaginatedResponse;
import Negocio.IMovimientoNegocio;

public class MovimientoNegocioImpl implements IMovimientoNegocio{
	IMovimientoDao movimientoDao = new MovimientoDaoImpl();
	@Override
	public void insertarMovimiento(Movimiento movimiento) {
		
        try {
			movimientoDao.insertarMovimiento(movimiento);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public PaginatedResponse<Movimiento> listarMovimientosPorCuenta(int idCuenta) {
		PaginatedResponse<Movimiento> movimientos = null;
		try {
			 movimientos = movimientoDao.listarMovimientosPorCuenta(idCuenta);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return movimientos;
	}

}
