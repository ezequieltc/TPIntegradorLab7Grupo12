package DaoImpl;

import Dao.IPrestamoDao;
import Dominio.Cuenta;
import Dominio.Cuota;
import Dominio.Movimiento;
import Dominio.Persona;
import Dominio.Prestamo;
import Dominio.TipoMovimiento;
import servicios.ddbb.Conexion;
import tipos.PrestamosStatus;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;

import NegocioImpl.CuentaNegocioImpl;
import NegocioImpl.CuotaNegocioImpl;
import NegocioImpl.MovimientoNegocioImpl;

public class PrestamoDaoImpl implements IPrestamoDao{
	
	PersonaDaoImpl personaDao;
	CuentaDaoImpl cuentaDao;
	private static final String read = "SELECT * FROM VW_Prestamos ORDER BY id_Prestamo";
	private static final String readByUserId = "SELECT * FROM VW_Prestamos where id_persona = ? and estado = 1 ORDER BY id_Prestamo";
	private static final String readId = "SELECT * FROM VW_Prestamos WHERE id_Prestamo = ?  and estado = 1";
	private static final String update = "UPDATE Prestamos SET cuotas_total = ?, status_prestamo = ? WHERE id_Prestamo = ?  and estado = 1 ";
	private static final String delete = "UPDATE Prestamos SET estado = 0 WHERE id_Prestamo = ? ";
	private static final String insert = "INSERT INTO Prestamos(id_cliente, id_cuenta, fecha_alta, importe, cuota_mensual, cuotas_total, cantidad_cuotas,status_prestamo, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	public PrestamoDaoImpl() {
		this.personaDao = new PersonaDaoImpl();
		this.cuentaDao = new CuentaDaoImpl();
	}
	
	
	@Override
	public boolean insert(Prestamo prestamo) {
		Prestamo prestamoInsert = prestamo;
		MovimientoNegocioImpl movimientoNegocio = new MovimientoNegocioImpl();
		
		PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isInsertExitoso = false;
        prestamoInsert.setFecha_alta(new java.sql.Date(System.currentTimeMillis()));
        prestamoInsert.setStatus(PrestamosStatus.PENDIENTE);
        prestamoInsert.setEstado(true);
        System.out.println("El siguiente ID es:" + getSiguienteID());
		try { 
			statement = conexion.prepareStatement(insert); 
			statement.setInt(1,prestamoInsert.getPersona().getUsuario().getId()); 
			statement.setInt(2, prestamoInsert.getCuenta().getId());
			statement.setDate(3, new java.sql.Date(prestamoInsert.getFecha_alta().getTime()));
			statement.setFloat(4, prestamoInsert.getImporte()); 
			statement.setFloat(5,prestamoInsert.getCuota_mensual()); 
			statement.setFloat(6, prestamoInsert.getTotal_pagado()); 
			statement.setInt(7,	prestamoInsert.getCantidad_cuotas()); 
			statement.setString(8, prestamoInsert.getStatus().toString());
			statement.setBoolean(9, prestamoInsert.isEstado()); 
			if (statement.executeUpdate() > 0) {
				conexion.commit(); isInsertExitoso = true; 
				} 
			} 
		catch (SQLException e) {
			e.printStackTrace(); 
		try { conexion.rollback(); 
			} 
		catch (SQLException e1) {
			e1.printStackTrace(); 
			} 
		}

        return isInsertExitoso;
		
	}
	@Override
	public boolean delete(Prestamo prestamo) {
		boolean isDeleteExitoso = false;
		
		PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
		try { 
			statement = conexion.prepareStatement(delete); 
			statement.setInt(1, prestamo.getId()); 
			if (statement.executeUpdate() > 0) {
				conexion.commit(); 
				isDeleteExitoso = true; 
				} 
			} 
		catch (SQLException e) {
			e.printStackTrace(); 
		try { conexion.rollback(); 
			} 
		catch (SQLException e1) {
			e1.printStackTrace(); 
			} 
		}

		return isDeleteExitoso;
	}
	
	@Override
	public boolean update(Prestamo prestamo) {
		MovimientoNegocioImpl movimientoNegocio = new MovimientoNegocioImpl();
		CuotaNegocioImpl cuotaNegocio = new CuotaNegocioImpl();
		CuentaNegocioImpl cuentaNegocio = new CuentaNegocioImpl();
		Cuenta cuentaTemp = new Cuenta();
		cuentaTemp = cuentaNegocio.getCuenta(prestamo.getCuenta().getId());
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean isUpdateExitoso = false;

		try
		{
			statement = conexion.prepareStatement(update);
	        statement.setFloat(1, prestamo.getTotal_pagado());  
	        statement.setString(2, prestamo.getStatus().toString());
	        statement.setInt(3, prestamo.getId());

			if(statement.executeUpdate() > 0)
			{
				conexion.commit();
				isUpdateExitoso = true;
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
			try {
				conexion.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}

		for (int i = 0; i<prestamo.getCantidad_cuotas(); i++) {
			Cuota cuotaTemp = new Cuota();
			cuotaTemp.setId_prestamo(prestamo.getId());
			cuotaTemp.setNumero_cuota(i+1);
			cuotaTemp.setImporte(prestamo.getCuota_mensual());
			LocalDate localDate = LocalDate.parse( new SimpleDateFormat("yyyy-MM-dd").format(prestamo.getFecha_alta()));
			LocalDate fechaConUnMesMas = localDate.plusMonths(i+1);
			Date nuevaFecha = Date.from(fechaConUnMesMas.atStartOfDay(ZoneId.systemDefault()).toInstant());
			cuotaTemp.setFecha_pago(nuevaFecha);
			cuotaTemp.setEstado(true);
			cuotaNegocio.insertarCuota(cuotaTemp);
		}
		double importe = prestamo.getImporte();
		Movimiento movimiento = new Movimiento(prestamo.getCuenta().getId(), new TipoMovimiento(1,"Deposito"), new java.util.Date(System.currentTimeMillis()), "Aprobación de prestamo ID " + prestamo.getId(), importe, true);
		movimientoNegocio.insertarMovimiento(movimiento);
		double nuevoSaldo = cuentaTemp.getSaldo() + prestamo.getImporte();
		cuentaTemp.setSaldo(nuevoSaldo);
		cuentaNegocio.update(cuentaTemp);
		return isUpdateExitoso;
		
	}
	
	@Override
	public Prestamo getPrestamoPorId(int id) {
		Prestamo prestamoTemp = new Prestamo();
		 PreparedStatement statement;
	        ResultSet resultSet;
	        Connection conexion = Conexion.getConexion().getSQLConexion();      
	        try {
	            statement = conexion.prepareStatement(readId);
	            statement.setInt(1,id);
	            resultSet = statement.executeQuery();
	            while (resultSet.next()) {
	                prestamoTemp = getPrestamoFromResultSet(resultSet);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		return prestamoTemp;
	}
	
	@Override
	public ArrayList<Prestamo> getPrestamos(){
        PreparedStatement statement;
        ResultSet resultSet;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        ArrayList<Prestamo> prestamosListado = new ArrayList<Prestamo>();
        
        try {
            statement = conexion.prepareStatement(read);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                prestamosListado.add(getPrestamoFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return prestamosListado;
	}
    private Prestamo getPrestamoFromResultSet(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id_prestamo");
        Date fecha_alta = resultSet.getDate("fecha_alta");
        Cuenta cuenta = cuentaDao.getCuenta(resultSet.getInt("id_cuenta"));
        float importe = resultSet.getFloat("importe");
        int cantidad_cuotas = resultSet.getInt("cantidad_cuotas");
        float cuota_mensual = resultSet.getFloat("cuota_mensual");
        float total_pagado = resultSet.getFloat("cuotas_total");
        PrestamosStatus status = PrestamosStatus.valueOf(resultSet.getString("status_prestamo"));
        boolean estado = resultSet.getBoolean("estado");
       
        Persona persona = personaDao.getPersona(resultSet.getInt("id_persona"));
        
        return new Prestamo(id,cuenta, persona, fecha_alta, importe, cuota_mensual, cantidad_cuotas, total_pagado, status,estado);
    }
    
    private int getSiguienteID() {
    	int ultimoId = 0;
    	Connection conexion = Conexion.getConexion().getSQLConexion();
    	try {
    		PreparedStatement statement = conexion.prepareStatement(read);
    		ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                ultimoId = resultSet.getInt("id_prestamo");
            }
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return ultimoId + 1;
    }


	@Override
	public ArrayList<Prestamo> getPrestamos(int idUsuario) {
		PreparedStatement statement;
        ResultSet resultSet;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        ArrayList<Prestamo> prestamosListado = new ArrayList<Prestamo>();
          try {
            statement = conexion.prepareStatement(readByUserId);
            statement.setInt(1, idUsuario);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                prestamosListado.add(getPrestamoFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return prestamosListado;
	}

	

}
