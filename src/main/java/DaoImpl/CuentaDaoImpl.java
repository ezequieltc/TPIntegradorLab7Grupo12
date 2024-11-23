package DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import servicios.ddbb.*;

import Dao.ICuentaDao;
import Dominio.Cuenta;
import Dominio.Persona;
import Dominio.TipoCuenta;

public class CuentaDaoImpl implements ICuentaDao {

    private static final String insert = "INSERT INTO cuentas(id_cliente, id_tipo_cuenta, numero_cuenta, cbu, saldo, fecha_creacion, estado) VALUES(?, ?, ?, ?, ?, ?, ?)";
    private static final String delete = "UPDATE cuentas SET estado = ? WHERE id_cuenta = ?";
    private static final String update = "UPDATE cuentas SET id_cliente = ?, id_tipo_cuenta = ?, numero_cuenta = ?, cbu = ?, saldo = ?, fecha_creacion = ?, estado = ? WHERE id_cuenta = ?";
    //private static final String readall = "SELECT * FROM cuentas";
    private static final String readall = "select * from cuentas c inner join personas p on p.id_usuario = c.id_cliente WHERE c.estado = 1 order by c.id_cuenta";
    private static final String readALlWithDeleted = "select * from cuentas c inner join personas p on p.id_usuario = c.id_cliente order by c.id_cuenta";
    private static final String read = "SELECT c.id_cuenta, c.id_cliente, c.id_tipo_cuenta, c.numero_cuenta, c.cbu, c.saldo, c.fecha_creacion, c.estado, p.id_persona FROM cuentas c inner join personas p on p.id_usuario = c.id_cliente WHERE id_cuenta = ?";
    private static final String readCBU = "SELECT c.id_cuenta, c.id_cliente, c.id_tipo_cuenta, c.numero_cuenta, c.cbu, c.saldo, c.fecha_creacion, c.estado, p.id_persona FROM cuentas c inner join personas p on p.id_usuario = c.id_cliente WHERE cbu = ?";
    private static final String readNumeroCuenta = "SELECT c.id_cuenta, c.id_cliente, c.id_tipo_cuenta, c.numero_cuenta, c.cbu, c.saldo, c.fecha_creacion, c.estado, p.id_persona FROM cuentas c inner join personas p on p.id_usuario = c.id_cliente WHERE numero_cuenta = ?";
    private static final String siguiente = "SELECT MAX(id_cuenta) FROM cuentas";
    
    private static final String SELECT_CUENTAS_POR_USUARIO = 
            "SELECT * from cuentas c INNER JOIN personas p ON p.id_usuario = c.id_cliente WHERE c.estado = 1 AND p.id_usuario = ?";

    
    
    
    private PersonaDaoImpl personaDao;
    private TipoCuentaDaoImpl tipoCuentaDao;

    public CuentaDaoImpl() {
        this.personaDao = new PersonaDaoImpl();
        this.tipoCuentaDao = new TipoCuentaDaoImpl();
    }
    

    @Override
    public boolean insert(Cuenta cuenta) {
    	long numeroDeCuenta = 0 ;
    	long CBU = 0;
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isInsertExitoso = false;
        ArrayList<Cuenta> cuentasAll;
        cuentasAll = readAllWithDeleted();
        if(cuentasAll.isEmpty()) {
        	numeroDeCuenta = 1000;
        	CBU = 1000000000000001L;  	
        } else {
        	numeroDeCuenta = Long.parseLong(cuentasAll.get(cuentasAll.size()-1).numeroCuenta)+1;
        	CBU = Long.parseLong(cuentasAll.get(cuentasAll.size()-1).getCbu()) + 1;
        }
        cuenta.setNumeroCuenta(String.valueOf(numeroDeCuenta));
        cuenta.setCbu(String.valueOf(CBU));
        try {
            statement = conexion.prepareStatement(insert);
            statement.setInt(1, cuenta.getPersona().getUsuario().getId());
            statement.setInt(2, cuenta.getTipoCuenta().getId());
            statement.setString(3, cuenta.getNumeroCuenta());
            statement.setString(4, cuenta.getCbu());
            statement.setDouble(5, cuenta.getSaldo());
            statement.setDate(6, new java.sql.Date(cuenta.getFechaCreacion().getTime()));
            statement.setBoolean(7, cuenta.isEstado());
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


    @Override
    public boolean delete(Cuenta cuenta) {
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isDeleteExitoso = false;
        try {
            statement = conexion.prepareStatement(delete);
            statement.setBoolean(1, false);
            statement.setInt(2, cuenta.getId());
            if (statement.executeUpdate() > 0) {
                conexion.commit();
                isDeleteExitoso = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isDeleteExitoso;
    }

    @Override
    public boolean update(Cuenta cuenta) {
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isUpdateExitoso = false;
        try {
            statement = conexion.prepareStatement(update);
            statement.setInt(1, cuenta.getPersona().getUsuario().getId());
            statement.setInt(2, cuenta.getTipoCuenta().getId());
            statement.setString(3, cuenta.getNumeroCuenta());
            statement.setString(4, cuenta.getCbu());
            statement.setDouble(5, cuenta.getSaldo());
            statement.setDate(6, new java.sql.Date(cuenta.getFechaCreacion().getTime()));
            statement.setBoolean(7, cuenta.isEstado());
            statement.setInt(8, cuenta.getId());
            if (statement.executeUpdate() > 0) {
                conexion.commit();
                isUpdateExitoso = true;
            }
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

    @Override
    public ArrayList<Cuenta> readAll() {
        PreparedStatement statement;
        ResultSet resultSet;
        ArrayList<Cuenta> cuentas = new ArrayList<>();
        Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
            statement = conexion.prepareStatement(readall);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                cuentas.add(getCuentaFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cuentas;
    }
    
    public ArrayList<Cuenta> readAllWithDeleted() {
        PreparedStatement statement;
        ResultSet resultSet;
        ArrayList<Cuenta> cuentas = new ArrayList<>();
        Connection conexion = Conexion.getConexion().getSQLConexion();
        try {
            statement = conexion.prepareStatement(readALlWithDeleted);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                cuentas.add(getCuentaFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cuentas;
    }

    private Cuenta getCuentaFromResultSet(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id_cuenta");
        int idCliente = resultSet.getInt("id_cliente");
        int idTipoCuenta = resultSet.getInt("id_tipo_cuenta");
        String numeroCuenta = resultSet.getString("numero_cuenta");
        String cbu = resultSet.getString("cbu");
        Double saldo = resultSet.getDouble("saldo");
        Date fechaCreacion = resultSet.getDate("fecha_creacion");
        boolean estado = resultSet.getBoolean("estado");

        Persona persona = personaDao.getPersona(resultSet.getInt("id_persona"));
        TipoCuenta tipoCuenta = tipoCuentaDao.getTipoCuenta(idTipoCuenta);
        return new Cuenta(id, persona, tipoCuenta, numeroCuenta, cbu, saldo, fechaCreacion, estado);
    }

    @Override
    public Cuenta getCuenta(int id) {
    	Cuenta cuenta = null;
    	try {
    		Connection conexion = Conexion.getConexion().getSQLConexion();
    		PreparedStatement ps = conexion.prepareStatement(read);
    		ps.setInt(1, id);
    		ResultSet rs = ps.executeQuery();
    		if (rs.next()) {
    			cuenta = getCuentaFromResultSet(rs);
    		}
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return cuenta;
    }
    
    @Override
    public Cuenta getCuenta(String numeroCuenta, String cbu) {
        System.out.println("getCuenta(String numeroCuenta, String cbu)");
    	Cuenta cuenta = null;
    	Connection conexion = Conexion.getConexion().getSQLConexion();

    	try {
    	if(!numeroCuenta.isEmpty()) {
    		PreparedStatement ps = conexion.prepareStatement(readNumeroCuenta);
    		ps.setString(1, numeroCuenta);
            System.out.println("numeroCuenta = " + numeroCuenta);
            System.out.println("cbu = " + cbu);
            System.out.println("readNumeroCuenta = " + readNumeroCuenta);
    		ResultSet rs = ps.executeQuery();
    		if (rs.next()) {
    			cuenta = getCuentaFromResultSet(rs);
    		}
    	}
    	if(!cbu.isEmpty()) {
    		PreparedStatement ps = conexion.prepareStatement(readCBU);
    		ps.setString(1, cbu);
            System.out.println("cbu = " + cbu);
            System.out.println("readCBU = " + readCBU);
    		ResultSet rs = ps.executeQuery();
    		if (rs.next()) {
    			cuenta = getCuentaFromResultSet(rs);
    		}
    	}
    	}
    	catch(SQLException e) {
    		e.printStackTrace();
    	}
    	
    	
    	return cuenta;
    }
    
    
    @Override
    public int calcularSiguienteId() {
    	int ultimoId = 0;
    	Connection conexion = Conexion.getConexion().getSQLConexion();
    	try {
    		PreparedStatement statement = conexion.prepareStatement(siguiente);
    		ResultSet resultSet = statement.executeQuery();
    		if (resultSet.next()) {
    			ultimoId = resultSet.getInt(1);
    		}
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return ultimoId + 1;
    }
    
    @Override
    public ArrayList<Cuenta> getCuentasPorCliente(int Id){
    	 PreparedStatement statement;
         ResultSet resultSet;
         ArrayList<Cuenta> cuentas = new ArrayList<>();
         Connection conexion = Conexion.getConexion().getSQLConexion();
         try {
             statement = conexion.prepareStatement(SELECT_CUENTAS_POR_USUARIO);
             statement.setInt(1, Id);
             resultSet = statement.executeQuery();
             while (resultSet.next()) {
                 cuentas.add(getCuentaFromResultSet(resultSet));
             }
         } catch (SQLException e) {
             e.printStackTrace();
         }
     	return cuentas;
    	    
    }
}
