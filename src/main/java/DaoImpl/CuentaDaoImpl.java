package DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import Dao.ICuentaDao;
import Dominio.Cuenta;
import Dominio.Persona;
import Dominio.TipoCuenta;

public class CuentaDaoImpl implements ICuentaDao {

    private static final String insert = "INSERT INTO cuentas(id_cliente, id_tipo_cuenta, numero_cuenta, cbu, saldo, fecha_creacion, estado) VALUES(?, ?, ?, ?, ?, ?, ?)";
    private static final String delete = "UPDATE cuentas SET estado = ? WHERE id_cuenta = ?";
    private static final String update = "UPDATE cuentas SET id_cliente = ?, id_tipo_cuenta = ?, numero_cuenta = ?, cbu = ?, saldo = ?, fecha_creacion = ?, estado = ? WHERE id_cuenta = ?";
    private static final String readall = "SELECT * FROM cuentas";
    private static final String read = "SELECT id_cuenta, id_cliente, id_tipo_cuenta, numero_cuenta, cbu, saldo, fecha_creacion, estado FROM cuentas WHERE id_cuenta = ?";
    private static final String siguiente = "SELECT MAX(id_cuenta) FROM cuentas";
    
    private PersonaDaoImpl personaDao;
    private TipoCuentaDaoImpl tipoCuentaDao;

    public CuentaDaoImpl() {
        this.personaDao = new PersonaDaoImpl();
        this.tipoCuentaDao = new TipoCuentaDaoImpl();
    }

    @Override
    public boolean insert(Cuenta cuenta) {
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isInsertExitoso = false;
        try {
            statement = conexion.prepareStatement(insert);
            statement.setInt(1, cuenta.getPersona().getId());
            statement.setInt(2, cuenta.getTipoCuenta().getId());
            statement.setString(3, cuenta.getNumeroCuenta());
            statement.setString(4, cuenta.getCbu());
            statement.setInt(5, cuenta.getSaldo());
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
            statement.setInt(1, cuenta.getPersona().getId());
            statement.setInt(2, cuenta.getTipoCuenta().getId());
            statement.setString(3, cuenta.getNumeroCuenta());
            statement.setString(4, cuenta.getCbu());
            statement.setInt(5, cuenta.getSaldo());
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
        //System.out.println(cuentas.toString());
        return cuentas;
    }

    private Cuenta getCuentaFromResultSet(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id_cuenta");
        int idCliente = resultSet.getInt("id_cliente");
        int idTipoCuenta = resultSet.getInt("id_tipo_cuenta");
        String numeroCuenta = resultSet.getString("numero_cuenta");
        String cbu = resultSet.getString("cbu");
        int saldo = resultSet.getInt("saldo");
        Date fechaCreacion = resultSet.getDate("fecha_creacion");
        boolean estado = resultSet.getBoolean("estado");

        Persona persona = personaDao.getPersona(idCliente);
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
}
