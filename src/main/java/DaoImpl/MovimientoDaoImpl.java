package DaoImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Dao.IMovimientoDao;
import Dominio.Movimiento;
import Dominio.TipoMovimiento;
import Dominio.DTO.PaginatedResponse;
import servicios.ddbb.Conexion;

public class MovimientoDaoImpl implements IMovimientoDao {

    private static final String INSERT_MOVIMIENTO_SQL = 
        "INSERT INTO movimientos (id_cuenta, id_tipo_movimiento, fecha, detalle, importe, estado) " +
        "VALUES (?, ?, ?, ?, ?, ?)";

    private static final String SELECT_MOVIMIENTOS_POR_CUENTA_SQL = 
        "SELECT m.id, m.id_cuenta, tm.id, tm.descripcion, m.fecha, m.detalle, m.importe, m.estado " +
        "FROM movimientos m " +
        "INNER JOIN tiposmovimiento tm ON m.id_tipo_movimiento = tm.id " +
        "WHERE m.id_cuenta = ?";
    
    private static final String COUNT_MOVIMIENTOS_POR_CUENTA_SQL =
    	"SELECT COUNT(*) AS total" +
        "FROM movimientos m" +
        "WHERE m.id_cuenta = ?";

    // Método para insertar un nuevo movimiento
    @Override
    public void insertarMovimiento(Movimiento movimiento) throws Exception {
    try (Connection conexion = Conexion.getConexion().getSQLConexion();
         PreparedStatement statement = conexion.prepareStatement(INSERT_MOVIMIENTO_SQL)) {

            statement.setInt(1, movimiento.getIdCuenta());
            statement.setInt(2, movimiento.getTipoMovimiento().getId());
            statement.setDate(3, new java.sql.Date(movimiento.getFecha().getTime()));
            statement.setString(4, movimiento.getDetalle());
            statement.setDouble(5, movimiento.getImporte());
            statement.setBoolean(6, movimiento.getEstado());

            statement.executeUpdate();
        } catch (SQLException e) {
            throw new Exception("Error al insertar movimiento: " + e.getMessage(), e);
        }
    }

    // Método para listar movimientos por cuenta
    @Override
    public PaginatedResponse<Movimiento> listarMovimientosPorCuenta(int idCuenta) throws Exception {
        List<Movimiento> movimientos = new ArrayList<>();
        int totalMovimientosPorCuenta = 0;
        try (Connection conexion = Conexion.getConexion().getSQLConexion();
                PreparedStatement statement = conexion.prepareStatement(SELECT_MOVIMIENTOS_POR_CUENTA_SQL)) {

            statement.setInt(1, idCuenta);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    int cuentaId = resultSet.getInt("id_cuenta");
                    int tipoId = resultSet.getInt("tm.id");
                    String descripcion = resultSet.getString("tm.descripcion");
                    Date fecha = resultSet.getDate("fecha");
                    String detalle = resultSet.getString("detalle");
                    Double importe = resultSet.getDouble("importe");
                    Boolean estado = resultSet.getBoolean("estado");

                    TipoMovimiento tipoMovimiento = new TipoMovimiento(tipoId, descripcion);
                    Movimiento movimiento = new Movimiento(cuentaId, tipoMovimiento, fecha, detalle, importe, estado);
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
        try (Connection conexion = Conexion.getConexion().getSQLConexion();
                PreparedStatement statement = conexion.prepareStatement(COUNT_MOVIMIENTOS_POR_CUENTA_SQL)) {
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
}

