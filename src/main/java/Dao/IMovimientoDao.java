package Dao;

import java.util.ArrayList;

import Dominio.Cuenta;
import Dominio.Movimiento;
import Dominio.DTO.PaginatedResponse;

public interface IMovimientoDao {
	void insertarMovimiento(Movimiento movimiento) throws Exception;

    PaginatedResponse<Movimiento> listarMovimientosPorCuenta(int idCuenta) throws Exception;
}
