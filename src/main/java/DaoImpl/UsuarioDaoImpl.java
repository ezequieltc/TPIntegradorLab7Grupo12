package DaoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Dao.IUsuarioDao;
import Dominio.Usuario;
import Dominio.DTO.PaginatedResponse;
import Dominio.TipoUsuario;


public class UsuarioDaoImpl implements IUsuarioDao {

    private static final String insert = "insert into usuarios(id_tipo_usuario, usuario, contrasena, fecha_creacion, estado) values (?, ?, ?, ?, ?)";
    private static final String delete = "update usuarios set estado = ? where id_usuario = ?";
    private static final String update = "update usuarios SET id_tipo_usuario = ?, usuario = ?, contrasena = ?, fecha_creacion = ?, estado = ? where id_usuario = ?";
//    private static final String readall = "select * from usuarios where estado = 1 limit ? offset ?";
    private static final String readall = "select * from usuarios where estado = 1";
    private static final String read = "select id_usuario, id_tipo_usuario, usuario, contrasena, fecha_creacion, estado from usuarios where id_usuario = ?";
    private static final String siguiente = "select max(id_usuario) from usuarios";

    
    private TipoUsuarioDaoImpl tipoUsuarioDao;
    
    public UsuarioDaoImpl() {
        this.tipoUsuarioDao = new TipoUsuarioDaoImpl();
    }
    
    @Override
    public boolean insert(Usuario usuario) {
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isInsertExitoso = false;
        try {
            statement = conexion.prepareStatement(insert);
            statement.setInt(1, usuario.getTipoUsuario().getId());
            statement.setString(2, usuario.getUsuario());
            statement.setString(3, usuario.getContrasena());
            statement.setDate(4, new java.sql.Date(usuario.getFechaCreacion().getTime()));
            statement.setBoolean(5, usuario.isEstado());
            
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
    public boolean delete(Usuario usuario) {
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isDeleteExitoso = false;
        try {
            statement = conexion.prepareStatement(delete);
            statement.setBoolean(1, false);
            statement.setInt(2, usuario.getId());
            
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
    public boolean update(Usuario usuario) {
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isUpdateExitoso = false;
        try {
            statement = conexion.prepareStatement(update);
            statement.setInt(1, usuario.getTipoUsuario().getId());
            statement.setString(2, usuario.getUsuario());
            statement.setString(3, usuario.getContrasena());
            statement.setDate(4, new java.sql.Date(usuario.getFechaCreacion().getTime()));
            statement.setBoolean(5, usuario.isEstado());
            statement.setInt(6, usuario.getId());
            
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
    public PaginatedResponse<Usuario> readAll(int pagina) {
        PreparedStatement statement;
        ResultSet resultSet;
        ArrayList<Usuario> usuarios = new ArrayList<>();
        Conexion conexion = Conexion.getConexion();
        final int limit = 5;
//        int offset = limit * (pagina - 1);
        try {
            statement = conexion.getSQLConexion().prepareStatement(readall);
//            statement.setInt(1, limit);
//            statement.setInt(2, offset);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                usuarios.add(getUsuario(resultSet));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        int totalRegistros = getTotalRegistros(conexion);
        return new PaginatedResponse<Usuario>(usuarios, totalRegistros, pagina, limit);
    }
    
    private int getTotalRegistros(Conexion conexion) {
        String countQuery = "SELECT COUNT(*) AS total FROM usuarios";
        try (PreparedStatement countStatement = conexion.getSQLConexion().prepareStatement(countQuery);
             ResultSet countResult = countStatement.executeQuery()) {
            if (countResult.next()) {
                return countResult.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Usuario getUsuario(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id_usuario");
        int idTipoUsuario = resultSet.getInt("id_tipo_usuario");
        String usuario = resultSet.getString("usuario");
        String contrasena = resultSet.getString("contrasena");
        java.sql.Date fechaCreacion = resultSet.getDate("fecha_creacion");
        boolean estado = resultSet.getBoolean("estado");

        TipoUsuario tipoUsuario = tipoUsuarioDao.getTipoUsuario(idTipoUsuario);
        return new Usuario(id, tipoUsuario, usuario, contrasena, fechaCreacion, estado);
    }

    public Usuario getUsuario(int id) {
        Usuario usuario = null;
        try {
            Conexion conn = Conexion.getConexion();
            Connection connection = conn.getSQLConexion();
            PreparedStatement ps = connection.prepareStatement(read);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id_usuario"));
                int tipoUsuarioId = rs.getInt("id_tipo_usuario");
                TipoUsuario tipoUsuario = tipoUsuarioDao.getTipoUsuario(tipoUsuarioId);
                usuario.setTipoUsuario(tipoUsuario);
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setFechaCreacion(rs.getDate("fecha_creacion"));
                usuario.setEstado(rs.getBoolean("estado"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }


    @Override
    public int calcularSiguienteId() {
        PreparedStatement statement;
        ResultSet resultSet;
        int siguienteId = 0;
        Conexion conexion = Conexion.getConexion();
        try {
            statement = conexion.getSQLConexion().prepareStatement(siguiente);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                siguienteId = resultSet.getInt(1) + 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return siguienteId;
    }
}
