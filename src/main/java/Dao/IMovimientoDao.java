package Dao;

import java.util.List;

import Dominio.Movimiento;
import Dominio.Transferencia;
import Dominio.DTO.PaginatedResponse;

public interface IMovimientoDao {
	void insertarMovimiento(Movimiento movimiento) throws Exception;
	void txInsertarMovimiento(Movimiento movimiento) throws Exception;
    void insertarTransferencia(Transferencia transferencia) throws Exception;

    PaginatedResponse<Movimiento> listarMovimientosPorCuenta(int idCuenta) throws Exception;
    List<Movimiento> obtenerUltimosMovimientos(int idCliente, int limite) throws Exception;
    List<Movimiento> obtenerTodosLosMovimientos() throws Exception;

}
