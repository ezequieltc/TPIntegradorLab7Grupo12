package DaoImpl;

import Dao.IPrestamoDao;
import Dominio.Cuenta;
import Dominio.Persona;
import Dominio.Prestamo;
import servicios.ddbb.Conexion;
import tipos.PrestamosStatus;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class PrestamoDaoImpl implements IPrestamoDao{
	
	PersonaDaoImpl personaDao;
	CuentaDaoImpl cuentaDao;
	private static final String read = "SELECT * FROM VW_Prestamos";
	private static final String insert = "INSERT INTO Prestamos(id_prestamo, id_cliente, id_cuenta, fecha_alta, importe, cuota_mensual, cuotas_total, cantidad_cuotas,status_prestamo, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	public PrestamoDaoImpl() {
		this.personaDao = new PersonaDaoImpl();
		this.cuentaDao = new CuentaDaoImpl();
	}
	
	
	@Override
	public boolean insert(Prestamo prestamo) {
		Prestamo prestamoInsert = prestamo;
		PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isInsertExitoso = false;
        prestamoInsert.setFecha_alta(new java.sql.Date(System.currentTimeMillis()));
        prestamoInsert.setStatus(PrestamosStatus.PENDIENTE);
        prestamoInsert.setTotal_pagado(0);
        prestamoInsert.setEstado(true);
        System.out.println("El siguiente ID es:" + getSiguienteID());
		try { 
			statement = conexion.prepareStatement(insert); 
			statement.setInt(1, getSiguienteID());
			statement.setInt(2,prestamoInsert.getPersona().getUsuario().getId()); 
			statement.setInt(3, prestamoInsert.getCuenta().getId());
			statement.setDate(4, new java.sql.Date(prestamoInsert.getFecha_alta().getTime()));
			statement.setFloat(5, prestamoInsert.getImporte()); 
			statement.setFloat(6,prestamoInsert.getCuota_mensual()); 
			statement.setFloat(7, prestamoInsert.getTotal_pagado()); 
			statement.setInt(8,	prestamoInsert.getCantidad_cuotas()); 
			statement.setString(9, prestamoInsert.getStatus().toString());
			statement.setBoolean(10, prestamoInsert.isEstado()); 
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
		return isDeleteExitoso;
	}
	
	@Override
	public boolean update(Prestamo prestamo) {
		boolean isUpdateExitoso = false;
		return isUpdateExitoso;
		
	}
	
	@Override
	public Prestamo getPrestamoPorId(int id) {
		Prestamo prestamoTemp = new Prestamo();
		
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
        float cuota_mensual = resultSet.getFloat("cuota_mensual");
        float total_pagado = resultSet.getFloat("cuotas_total");
        PrestamosStatus status = PrestamosStatus.valueOf(resultSet.getString("status_prestamo"));
        boolean estado = resultSet.getBoolean("estado");
       
        Persona persona = personaDao.getPersona(resultSet.getInt("id_persona"));
        return new Prestamo(id,cuenta, persona, fecha_alta, importe, cuota_mensual, total_pagado, status,estado);
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

	

}
