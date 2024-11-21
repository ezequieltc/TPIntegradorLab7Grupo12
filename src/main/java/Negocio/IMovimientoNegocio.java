package Negocio;

import java.sql.SQLException;
import java.util.List;

import Dominio.Movimiento;
import Dominio.DTO.PaginatedResponse;

public interface IMovimientoNegocio {
	void insertarMovimiento(Movimiento movimiento);

    PaginatedResponse<Movimiento> listarMovimientosPorCuenta(int idCuenta);
    
    List<Movimiento> obtenerUltimosMovimientos(int idCuenta, int limite) throws SQLException;
    
    List<Movimiento> obtenerTodosLosMovimientos() throws Exception;

}
