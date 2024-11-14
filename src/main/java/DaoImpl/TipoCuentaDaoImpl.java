package DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Dao.ITipoCuentaDao;
import Dominio.TipoCuenta;
import servicios.ddbb.*;
public class TipoCuentaDaoImpl implements ITipoCuentaDao {

    private Conexion conn = null;

    @Override
    public TipoCuenta getTipoCuenta(int id) {
        String query = "select id_tipo_cuenta, descripcion from tiposcuenta where id_tipo_cuenta = ?";
        TipoCuenta tipoCuenta = null;
        try {
            conn = Conexion.getConexion();
            Connection connection = conn.getSQLConexion();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                tipoCuenta = new TipoCuenta();
                tipoCuenta.setId(rs.getInt("id_tipo_cuenta"));
                tipoCuenta.setDescripcion(rs.getString("descripcion"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tipoCuenta;
    }

    @Override
    public ArrayList<TipoCuenta> getTipoCuenta() {
        ArrayList<TipoCuenta> listaTiposCuenta = new ArrayList<>();
        String query = "select id_tipo_cuenta, descripcion from tiposcuenta";
        
        try {
            conn = Conexion.getConexion();
            Connection connection = conn.getSQLConexion();
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TipoCuenta tipoCuenta = new TipoCuenta();
                tipoCuenta.setId(rs.getInt("id_tipo_cuenta"));
                tipoCuenta.setDescripcion(rs.getString("descripcion"));
                listaTiposCuenta.add(tipoCuenta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaTiposCuenta;
    }
}
