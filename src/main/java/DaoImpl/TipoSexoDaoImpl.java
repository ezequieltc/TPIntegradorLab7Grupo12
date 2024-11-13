package DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Dao.ITipoSexoDao;
import Dominio.TipoSexo;

public class TipoSexoDaoImpl implements ITipoSexoDao {

    private Conexion conn = null;

    @Override
    public TipoSexo getTipoSexo(int id) {
        String query = "select id_sexo, descripcion from tipossexo where id_sexo = ?";
        TipoSexo tipoSexo = null;
        try {
            conn = Conexion.getConexion();
            Connection connection = conn.getSQLConexion();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                tipoSexo = new TipoSexo();
                tipoSexo.setId(rs.getInt("id_sexo"));
                tipoSexo.setDescripcion(rs.getString("descripcion"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tipoSexo;
    }

    @Override
    public ArrayList<TipoSexo> getTipoSexo() {
        ArrayList<TipoSexo> listaTiposSexo = new ArrayList<>();
        String query = "select id_sexo, descripcion from tipossexo";
        
        try {
            conn = Conexion.getConexion();
            Connection connection = conn.getSQLConexion();
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TipoSexo tipoSexo = new TipoSexo();
                tipoSexo.setId(rs.getInt("id_sexo"));
                tipoSexo.setDescripcion(rs.getString("descripcion"));
                listaTiposSexo.add(tipoSexo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaTiposSexo;
    }
}
