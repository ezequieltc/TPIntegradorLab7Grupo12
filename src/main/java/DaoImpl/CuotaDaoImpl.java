package DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import Dao.ICuotaDao;
import Dominio.Cuenta;
import Dominio.Cuota;
import Dominio.Movimiento;
import Dominio.Persona;
import Dominio.Prestamo;
import Dominio.TipoCuenta;
import Dominio.TipoMovimiento;
import NegocioImpl.CuentaNegocioImpl;
import NegocioImpl.CuotaNegocioImpl;
import NegocioImpl.MovimientoNegocioImpl;
import NegocioImpl.PrestamoNegocioImpl;
import servicios.ddbb.Conexion;

public class CuotaDaoImpl implements ICuotaDao {
	private static final String insert = "INSERT INTO Cuotas(id_prestamo, numero_cuota, importe, fecha_pago, estado) VALUES (?,?,?,?,?) ";
	private static final String delete = "UPDATE Cuotas SET estado = 0 WHERE id_cuota = ?";
	private static final String update = "UPDATE Cuotas SET id_prestamo = ?, numero_cuota = ?, importe = ?, fecha_pago = ?";
	private static final String readAll = "SELECT * FROM Cuotas";
	private static final String read = "SELECT * FROM Cuotas where estado = 1 and id_prestamo = ?";
	private static final String readCuota = "SELECT * FROM Cuotas where id_cuota = ?";
	

	public boolean insert(Cuota cuota) {
		boolean isInsertExitoso = false;
		PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
        	statement = conexion.prepareStatement(insert);
        	statement.setInt(1, cuota.getId_prestamo());
        	statement.setInt(2, cuota.getNumero_cuota());
        	statement.setDouble(3, cuota.getImporte());
        	statement.setDate(4, new java.sql.Date(cuota.getFecha_pago().getTime()));
        	statement.setBoolean(5, cuota.isEstado());
            if (statement.executeUpdate() > 0) {
                conexion.commit();
                isInsertExitoso = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conexion.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
		return isInsertExitoso;
	}
	public boolean delete(Cuota cuota)
	{
		boolean isDeleteExitoso = false;
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
            statement = conexion.prepareStatement(delete);
            statement.setInt(1, cuota.getId());
            if (statement.executeUpdate() > 0) {
                conexion.commit();
                isDeleteExitoso = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return isDeleteExitoso;
	}
	
	public boolean pagarCuota(Cuota cuota, Cuenta cuenta)
	{
		boolean isDeleteExitoso = false;
		MovimientoNegocioImpl movimientoNegocio = new MovimientoNegocioImpl();
		CuotaNegocioImpl cuotaNegocio = new CuotaNegocioImpl();
		CuentaNegocioImpl cuentaNegocio = new CuentaNegocioImpl();
		PrestamoNegocioImpl prestamoNegocio = new PrestamoNegocioImpl();
		Prestamo prestamo = new Prestamo();
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
            statement = conexion.prepareStatement(delete);
            statement.setInt(1, cuota.getId());
            if (statement.executeUpdate() > 0) {
                conexion.commit();
                isDeleteExitoso = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        prestamo = prestamoNegocio.getPrestamoPorId(cuota.getId_prestamo());
        Movimiento movimiento = new Movimiento(cuenta.getId(), new TipoMovimiento(2,"Pago"), new java.util.Date(System.currentTimeMillis()), "Pago de cuota número: " + cuota.getNumero_cuota() + " del prestamo número: " + prestamo.getId(), cuota.getImporte()*-1, true);
        movimientoNegocio.insertarMovimiento(movimiento);
        double nuevoSaldo = cuenta.getSaldo() - cuota.getImporte();
        cuenta.setSaldo(nuevoSaldo);
        cuentaNegocio.update(cuenta);
        if(cuotaNegocio.listadoCuotasPorIdPrestamo(prestamo.getId()).isEmpty()) {
        	prestamoNegocio.delete(prestamo);
        }
		return isDeleteExitoso;
	}
	
	public boolean update(Cuota cuota) {
		boolean isUpdateExitoso = false;
		PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
        	statement = conexion.prepareStatement(update);
        	statement.setInt(1, cuota.getId_prestamo());
        	statement.setInt(2, cuota.getNumero_cuota());
        	statement.setDouble(3, cuota.getImporte());
        	statement.setDate(4, new java.sql.Date(cuota.getFecha_pago().getTime()));
        	
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conexion.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
		return isUpdateExitoso;
	}
	public Cuota getCuotaPorId(int id) {
		Cuota cuota = new Cuota();
    	try {
    		Connection conexion = Conexion.getConexion().getSQLConexion();
    		PreparedStatement ps = conexion.prepareStatement(readCuota);
    		ps.setInt(1, id);
    		ResultSet rs = ps.executeQuery();
    		if (rs.next()) {
    			cuota = getCuotaFromResultSet(rs);
    		}
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
		return cuota;
	}
	public ArrayList<Cuota> listarCuotas(){
		ArrayList<Cuota> listadoCuotas = new ArrayList<Cuota>();
        PreparedStatement statement;
        ResultSet resultSet;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
            statement = conexion.prepareStatement(readAll);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                listadoCuotas.add(getCuotaFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return listadoCuotas;
	}
	
	public ArrayList<Cuota> listarCuotasPorIdPrestamo(int id){
		ArrayList<Cuota> listadoCuotas = new ArrayList<Cuota>();
        PreparedStatement statement;
        ResultSet resultSet;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
            statement = conexion.prepareStatement(read);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                listadoCuotas.add(getCuotaFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return listadoCuotas;
	}
	private Cuota getCuotaFromResultSet(ResultSet resultSet) throws SQLException {
		int id_cuota = resultSet.getInt("id_cuota");
		int id_prestamo = resultSet.getInt("id_prestamo");
		int numero_cuota = resultSet.getInt("numero_cuota");
		double importe = resultSet.getDouble("importe");
		Date fecha_pago = resultSet.getDate("fecha_pago");
		boolean estado = resultSet.getBoolean("estado");
        return new Cuota(id_cuota, id_prestamo, numero_cuota, importe, fecha_pago, estado);
    }
}
