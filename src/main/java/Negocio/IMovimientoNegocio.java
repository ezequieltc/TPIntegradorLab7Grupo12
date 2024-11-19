package Negocio;

import Dominio.Movimiento;
import Dominio.DTO.PaginatedResponse;

public interface IMovimientoNegocio {
	void insertarMovimiento(Movimiento movimiento);

    PaginatedResponse<Movimiento> listarMovimientosPorCuenta(int idCuenta);
}
