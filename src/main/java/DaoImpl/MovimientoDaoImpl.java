package DaoImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Dao.IMovimientoDao;
import Dominio.Cuenta;
import Dominio.Movimiento;
import Dominio.Persona;
import Dominio.TipoMovimiento;
import Dominio.Transferencia;
import Dominio.DTO.PaginatedResponse;
import servicios.ddbb.Conexion;

public class MovimientoDaoImpl implements IMovimientoDao {

    private static final String INSERT_MOVIMIENTO_SQL = 
        "INSERT INTO movimientos (id_cuenta, id_tipo_movimiento, fecha, detalle, importe, estado) " +
        "VALUES (?, ?, ?, ?, ?, ?)";
    private static final String INSERT_TRANSFERENCIA_SQL =
        "INSERT INTO transferencias (id_movimiento_origen, id_movimiento_destino) " +
        "VALUES (?, ?)";

    private static final String SELECT_MOVIMIENTOS_POR_CUENTA_SQL = 
        "SELECT m.id_movimiento, m.id_cuenta, tm.id_tipo_movimiento, tm.descripcion, m.fecha, m.detalle, m.importe, m.estado " +
        "FROM movimientos m " +
        "INNER JOIN tiposmovimiento tm ON m.id_tipo_movimiento = tm.id_tipo_movimiento " +
        "WHERE m.id_cuenta = ?";

    private static final String SELECT_MOVIMIENTOS_MAS_TRANSFERENCIAS_SQL =
	"SELECT m.id_movimiento, m.id_cuenta, tm.id_tipo_movimiento, tm.descripcion, m.fecha, m.detalle, "
     + "m.importe, tr.id_transferencia, cd.cbu AS cbuDestino, cd.numero_cuenta AS nroCuentaDestino, "
     + "pd.apellido AS apellidoDestino, pd.nombre AS nombreDestino, co.cbu AS cbuOrigen, "
     + "co.numero_cuenta AS nroCuentaOrigen, po.apellido AS apellidoOrigen, po.nombre AS nombreOrigen "
     + "FROM movimientos m "
     + "INNER JOIN tiposmovimiento tm ON m.id_tipo_movimiento = tm.id_tipo_movimiento "
     + "LEFT JOIN transferencias tr ON tr.id_movimiento_origen = m.id_movimiento OR tr.id_movimiento_destino = m.id_movimiento "
     + "LEFT JOIN movimientos md ON tr.id_movimiento_destino = md.id_movimiento "
     + "LEFT JOIN cuentas cd ON md.id_cuenta = cd.id_cuenta "
     + "LEFT JOIN personas pd ON pd.id_usuario = cd.id_cliente "
     + "LEFT JOIN movimientos mo ON tr.id_movimiento_origen = mo.id_movimiento "
     + "LEFT JOIN cuentas co ON mo.id_cuenta = co.id_cuenta "
     + "LEFT JOIN personas po ON po.id_usuario = co.id_cliente "
     + "WHERE m.id_cuenta = ?;";
    
    private static final String COUNT_MOVIMIENTOS_POR_CUENTA_SQL =
    	"SELECT COUNT(*) AS total " +
        "FROM movimientos m " +
        "WHERE m.id_cuenta = ?";
    private final String SELECT_ULTIMOS_MOVIMIENTOS_SQL =
    	    "SELECT m.id_movimiento, m.id_cuenta, tm.id_tipo_movimiento, tm.descripcion, m.fecha, m.detalle, m.importe, m.estado " +
    	    "FROM movimientos m " +
    	    "INNER JOIN tiposmovimiento tm ON m.id_tipo_movimiento = tm.id_tipo_movimiento " +
    	    "WHERE m.id_cuenta IN ( " +
    	    "    SELECT c.id_cuenta " +
    	    "    FROM cuentas c " +
    	    "    WHERE c.id_cliente = ? " +
    	    ") " +
    	    "ORDER BY m.fecha DESC " +
    	    "LIMIT ?";

    // Método para insertar un nuevo movimiento
    @Override
    public void insertarMovimiento(Movimiento movimiento) throws Exception {
	Connection conexion = Conexion.getConexion().getSQLConexion();
    PreparedStatement statement = conexion.prepareStatement(INSERT_MOVIMIENTO_SQL);
    try {

            statement.setInt(1, movimiento.getIdCuenta());
            statement.setInt(2, movimiento.getTipoMovimiento().getId());
            statement.setDate(3, new java.sql.Date(movimiento.getFecha().getTime()));
            statement.setString(4, movimiento.getDetalle());
            statement.setDouble(5, movimiento.getImporte());
            statement.setBoolean(6, movimiento.getEstado());

            if (statement.executeUpdate() > 0) {
                conexion.commit();
            }
        } catch (SQLException e) {
            throw new Exception("Error al insertar movimiento: " + e.getMessage(), e);
        }
    }
    
    public void txInsertarMovimiento(Movimiento movimiento) throws Exception {
    	Connection conexion = Conexion.getConexion().getSQLConexion();
        PreparedStatement statement = conexion.prepareStatement(INSERT_MOVIMIENTO_SQL, Statement.RETURN_GENERATED_KEYS);
        try {

                statement.setInt(1, movimiento.getIdCuenta());
                statement.setInt(2, movimiento.getTipoMovimiento().getId());
                statement.setDate(3, new java.sql.Date(movimiento.getFecha().getTime()));
                statement.setString(4, movimiento.getDetalle());
                statement.setDouble(5, movimiento.getImporte());
                statement.setBoolean(6, movimiento.getEstado());
                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    ResultSet generatedKeys = statement.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        movimiento.setId(generatedKeys.getInt(1));
                    } else {
                        throw new SQLException("No se pudo obtener la clave generada para el usuario.");
                    }
                } else {
                    throw new SQLException("La inserción del usuario falló, no se insertaron filas.");
                }
            } catch (SQLException e) {
                throw new Exception("Error al insertar movimiento: " + e.getMessage(), e);
            }
        }

    @Override
    public void insertarTransferencia(Transferencia transferencia) throws Exception {
        Connection conexion = Conexion.getConexion().getSQLConexion();
        PreparedStatement statement = conexion.prepareStatement(INSERT_TRANSFERENCIA_SQL);
        try {
            statement.setInt(1, transferencia.getMovimientoOrigen().getId());
            statement.setInt(2, transferencia.getMovimientoDestino().getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new Exception("Error al insertar transferencia: " + e.getMessage(), e);
        }
    }

    // Método para listar movimientos por cuenta
    @Override
    public PaginatedResponse<Movimiento> listarMovimientosPorCuenta(int idCuenta) throws Exception {
        List<Movimiento> movimientos = new ArrayList<>();
        int totalMovimientosPorCuenta = 0;
        Connection conexion = Conexion.getConexion().getSQLConexion();
    	PreparedStatement statement = conexion.prepareStatement(SELECT_MOVIMIENTOS_MAS_TRANSFERENCIAS_SQL);
        try{

            statement.setInt(1, idCuenta);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    int id = resultSet.getInt("id_movimiento");
                    int cuentaId = resultSet.getInt("id_cuenta");
                    int tipoId = resultSet.getInt("tm.id_tipo_movimiento");
                    String descripcion = resultSet.getString("tm.descripcion");
                    Date fecha = resultSet.getDate("fecha");
                    String detalle = resultSet.getString("detalle");
                    Double importe = resultSet.getDouble("importe");
                    
                    String cbuDestino = resultSet.getString("cbuDestino");
                    String nroCuentaDestino = resultSet.getString("nroCuentaDestino");
                    String apellidoDestino = resultSet.getString("apellidoDestino");
                    String nombreDestino = resultSet.getString("nombreDestino");
                    
                    String cbuOrigen = resultSet.getString("cbuOrigen");
                    String nroCuentaOrigen = resultSet.getString("nroCuentaOrigen");
                    String apellidoOrigen = resultSet.getString("apellidoOrigen");
                    String nombreOrigen = resultSet.getString("nombreOrigen");
                    
                    int idTransferencia = resultSet.getInt("id_transferencia");
                    
                    TipoMovimiento tipoMovimiento = new TipoMovimiento(tipoId, descripcion);
                    Movimiento movimiento = new Movimiento(cuentaId, tipoMovimiento, fecha, detalle, importe, true);

                    
                    if (cbuDestino != null) {
                        Transferencia transferencia = new Transferencia();
                        Cuenta cuentaDestino = new Cuenta();
                        Cuenta cuentaOrigen = new Cuenta();
                        
                        Persona personaDestino = new Persona();
                        Persona personaOrigen = new Persona();
                        
                        personaDestino.setNombre(nombreDestino);
                        personaDestino.setApellido(apellidoDestino);
                        
                        personaOrigen.setApellido(apellidoOrigen);
                        personaOrigen.setNombre(nombreOrigen);

                        cuentaDestino.setNumeroCuenta(nroCuentaDestino);
                        cuentaDestino.setCbu(cbuDestino);
                        cuentaDestino.setPersona(personaDestino);
                        
                        cuentaOrigen.setNumeroCuenta(nroCuentaOrigen);
                        cuentaOrigen.setCbu(cbuOrigen);
                        cuentaOrigen.setPersona(personaOrigen);
                        

                        transferencia.setCuentaDestino(cuentaDestino);
                        transferencia.setCuentaOrigen(cuentaOrigen);
                        transferencia.setId(idTransferencia);
                        movimiento.setTransferencia(transferencia);
                    }

                   
                    movimiento.setId(id);
                    movimientos.add(movimiento);
                }
                
                totalMovimientosPorCuenta = this.getTotalRegistrosPorCuenta(idCuenta);
            }
        } catch (SQLException e) {
            throw new Exception("Error al listar movimientos por cuenta: " + e.getMessage(), e);
        }
        
        return new PaginatedResponse<Movimiento>(movimientos, totalMovimientosPorCuenta, 0, 0);
    }
    
    
    
    private int getTotalRegistrosPorCuenta(int idCuenta) throws Exception {
    	Connection conexion = Conexion.getConexion().getSQLConexion();
    	PreparedStatement statement = conexion.prepareStatement(COUNT_MOVIMIENTOS_POR_CUENTA_SQL);
        try{
        	statement.setInt(1, idCuenta);
        	try(ResultSet resultSet = statement.executeQuery()){
        		if(resultSet.next()) {
        			return resultSet.getInt("total");
        		}
        	}
        } catch(SQLException e) {
        	throw new Exception("Error al contar movimientos por cuenta: " + e.getMessage(), e);
        }
		return 0;
    }
    
    public List<Movimiento> obtenerUltimosMovimientos(int idCliente, int limite) throws Exception {
        List<Movimiento> movimientos = new ArrayList<>();
        Connection conexion = Conexion.getConexion().getSQLConexion();
    	PreparedStatement ps = conexion.prepareStatement(SELECT_ULTIMOS_MOVIMIENTOS_SQL);
        try{
            
            ps.setInt(1, idCliente);
            ps.setInt(2, limite);
            System.out.println(idCliente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id_movimiento");
                    int cuentaId = rs.getInt("id_cuenta");
                    int tipoId = rs.getInt("tm.id_tipo_movimiento");
                    String descripcion = rs.getString("tm.descripcion");
                    Date fecha = rs.getDate("fecha");
                    String detalle = rs.getString("detalle");
                    Double importe = rs.getDouble("importe");
                    Boolean estado = rs.getBoolean("estado");

                    TipoMovimiento tipoMovimiento = new TipoMovimiento(tipoId, descripcion);
                    Movimiento movimiento = new Movimiento(cuentaId, tipoMovimiento, fecha, detalle, importe, estado);
                    movimiento.setId(id);
                    movimientos.add(movimiento);
                }
            }
        } catch(SQLException e) {
        	throw new Exception("Error al buscar ultimos movimientos: " + e.getMessage(), e);
        }
        
        return movimientos;
    }
    
    public List<Movimiento> obtenerTodosLosMovimientos() throws Exception {
        List<Movimiento> movimientos = new ArrayList<>();
        Connection conexion = Conexion.getConexion().getSQLConexion();
        String query = "SELECT m.id_movimiento, m.id_cuenta, tm.id_tipo_movimiento, tm.descripcion, m.fecha, m.detalle, m.importe, m.estado " +
                       "FROM movimientos m " +
                       "INNER JOIN tiposmovimiento tm ON m.id_tipo_movimiento = tm.id_tipo_movimiento";

        try (PreparedStatement ps = conexion.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("id_movimiento");
                int cuentaId = rs.getInt("id_cuenta");
                int tipoId = rs.getInt("tm.id_tipo_movimiento");
                String descripcion = rs.getString("tm.descripcion");
                Date fecha = rs.getDate("fecha");
                String detalle = rs.getString("detalle");
                Double importe = rs.getDouble("importe");
                Boolean estado = rs.getBoolean("estado");

                TipoMovimiento tipoMovimiento = new TipoMovimiento(tipoId, descripcion);
                Movimiento movimiento = new Movimiento(cuentaId, tipoMovimiento, fecha, detalle, importe, estado);
                movimiento.setId(id);
                movimientos.add(movimiento);
            }
        } catch (SQLException e) {
            throw new Exception("Error al obtener todos los movimientos: " + e.getMessage(), e);
        }
        return movimientos;
    }
}

