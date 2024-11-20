package Dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Dominio.Cuenta;
import Dominio.Movimiento;
import Dominio.DTO.PaginatedResponse;

public interface IMovimientoDao {
	void insertarMovimiento(Movimiento movimiento) throws Exception;

    PaginatedResponse<Movimiento> listarMovimientosPorCuenta(int idCuenta) throws Exception;
    List<Movimiento> obtenerUltimosMovimientos(int idCliente, int limite) throws Exception;
}
