package NegocioImpl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;

import Dao.ICuentaDao;
import Dao.IMovimientoDao;
import DaoImpl.CuentaDaoImpl;
import DaoImpl.MovimientoDaoImpl;
import Dominio.Cuenta;
import Dominio.Movimiento;
import Dominio.TipoMovimiento;
import Negocio.ICuentaNegocio;
import servicios.ddbb.Conexion;

public class CuentaNegocioImpl implements ICuentaNegocio {

    ICuentaDao cuentaDao = new CuentaDaoImpl();
    IMovimientoDao movimientoDao = new MovimientoDaoImpl();

    @Override
    public boolean insert(Cuenta cuenta) {
        boolean estado = false;
        estado = cuentaDao.insert(cuenta);
        return estado;
    }

    @Override
    public boolean delete(Cuenta cuenta) {
        boolean estado = false;
        estado = cuentaDao.delete(cuenta);
        return estado;
    }

    @Override
    public boolean update(Cuenta cuenta) {
        boolean estado = false;
        estado = cuentaDao.update(cuenta);
        return estado;
    }

    @Override
    public ArrayList<Cuenta> readAll() {
        return cuentaDao.readAll();
    }
    
    @Override
    public Cuenta getCuenta(int id) {
    	Cuenta cuenta = cuentaDao.getCuenta(id);
    	return cuenta;
    }
    @Override
    public Cuenta getCuenta(String numeroCuenta, String CBU) {
    	Cuenta cuenta = cuentaDao.getCuenta(numeroCuenta,CBU);
    	return cuenta;
    }

    @Override
    public void transferir(Cuenta cuentaOrigen, Cuenta cuentaDestino, float monto) throws Exception {
    	Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
            conexion.setAutoCommit(false);
            // Get double from float
            Double importe = Double.valueOf(monto);
            Movimiento movimientoNegativo = new Movimiento(cuentaOrigen.getId(), new TipoMovimiento(4, null), new Date(), "", importe * -1, true ); 
            Movimiento movimientoPositivo = new Movimiento(cuentaDestino.getId(), new TipoMovimiento(4, null), new Date(), "", importe, true );


            // Insertar movimiento negativo de la cuenta origen
            movimientoDao.insertarMovimiento(movimientoNegativo);

            // Insertar movimiento positivo de la cuenta destino
            movimientoDao.insertarMovimiento(movimientoPositivo);
            
            

            // Actualizar saldo de la cuenta origen
            cuentaOrigen.setSaldo(cuentaOrigen.getSaldo() - importe);
           
            if (cuentaOrigen.getSaldo() < 0){
                throw new Exception("No se puede transferir más de lo que tiene la cuenta de origen.");
            }
            cuentaDao.update(cuentaOrigen);
            // Actualizar saldo de la cuenta destino
            cuentaDestino.setSaldo(cuentaDestino.getSaldo() + importe);
            if (cuentaDestino.getSaldo() < 0){
                throw new Exception("No se puede transferir más de lo que tiene la cuenta de destino.");
            }
            cuentaDao.update(cuentaDestino);

            conexion.commit();
        }   catch (Exception e) {
            e.printStackTrace();
            conexion.rollback();
            throw new Exception("Hubo un error al realizar la transferencia: " + e.getMessage());
        }
    }

    public int calcularSiguienteId() {
        int id = cuentaDao.calcularSiguienteId();
        return id;
    }
    @Override
    public ArrayList<Cuenta> getCuentasPorCliente(int id){
    	return cuentaDao.getCuentasPorCliente(id);
    }
    
    
}
