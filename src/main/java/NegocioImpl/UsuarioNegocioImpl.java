package NegocioImpl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import Dao.IUsuarioDao;
import DaoImpl.UsuarioDaoImpl;
import Dominio.Usuario;
import Dominio.DTO.PaginatedResponse;
import Negocio.IUsuarioNegocio;
import servicios.ddbb.Conexion;

public class UsuarioNegocioImpl implements IUsuarioNegocio{

	IUsuarioDao usuarioDao = new UsuarioDaoImpl();
	@Override
	public boolean insert(Usuario usuario) {
		boolean estado = false;
		try {
			usuarioDao.insert(usuario);
			estado = true;
		} catch (Exception e) {
			estado = false;
		}
		return estado;
	}

	@Override
	public boolean delete(Usuario usuario) {
		boolean estado = false;
		estado = usuarioDao.delete(usuario);
		return estado;
	}

	@Override
	public boolean update(Usuario usuario) {
		boolean estado = false;
		estado = usuarioDao.update(usuario);
		return estado;
	}
	
	@Override
	public PaginatedResponse<Usuario> readAll(int pagina) {
		
		return usuarioDao.readAll(pagina);
	}
	
	public int calcularSiguienteId() {
		return usuarioDao.calcularSiguienteId();
	}

	@Override
	public void reactivarUsuario(int id) throws SQLException {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			conexion.setAutoCommit(false);

			// get usuario
			Usuario usuario = usuarioDao.getUsuario(id);

			if (usuario == null) {
				throw new Exception("El usuario no existe");
			}

			// actualizar estado
			usuario.setEstado(true);
			usuarioDao.update(usuario);
			
			conexion.commit();

		}catch (Exception e) {
			e.printStackTrace();
			conexion.rollback();
			throw new RuntimeException("Hubo un error al reactivar el usuario: " + e.getMessage());
		}
	}


}
