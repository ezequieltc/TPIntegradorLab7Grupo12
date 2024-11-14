package DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Dao.ITipoUsuarioDao;
import Dominio.TipoUsuario;
import servicios.ddbb.*;
public class TipoUsuarioDaoImpl implements ITipoUsuarioDao {

    private Conexion conn = null;

    @Override
    public TipoUsuario getTipoUsuario(int id) {
        String query = "select id_tipo_usuario, descripcion from tiposusuario where id_tipo_usuario = ?";
        TipoUsuario tipoUsuario = null;
        try {
            conn = Conexion.getConexion();
            Connection connection = conn.getSQLConexion();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                tipoUsuario = new TipoUsuario();
                tipoUsuario.setId(rs.getInt("id_tipo_usuario"));
                tipoUsuario.setDescripcion(rs.getString("descripcion"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tipoUsuario;
    }

    @Override
    public ArrayList<TipoUsuario> getTipoUsuario() {
        ArrayList<TipoUsuario> listaTiposUsuario = new ArrayList<>();
        String query = "select id_tipo_usuario, descripcion from tiposusuario";
        
        try {
            conn = Conexion.getConexion();
            Connection connection = conn.getSQLConexion();
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TipoUsuario tipoUsuario = new TipoUsuario();
                tipoUsuario.setId(rs.getInt("id_tipo_usuario"));
                tipoUsuario.setDescripcion(rs.getString("descripcion"));
                listaTiposUsuario.add(tipoUsuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaTiposUsuario;
    }
}
