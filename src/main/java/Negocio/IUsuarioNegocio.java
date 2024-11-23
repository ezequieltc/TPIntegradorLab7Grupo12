package Negocio;

import java.sql.SQLException;
import java.util.ArrayList;

import Dominio.Usuario;
import Dominio.DTO.PaginatedResponse;

public interface IUsuarioNegocio {
	public boolean insert(Usuario usuario);
	public boolean delete(Usuario usuario);
	public boolean update(Usuario usuario);
	public PaginatedResponse<Usuario> readAll(int pagina);
	public void reactivarUsuario(int id) throws SQLException;
}
