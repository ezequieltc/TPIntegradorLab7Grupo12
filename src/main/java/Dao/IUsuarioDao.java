package Dao;

import java.sql.SQLException;
import java.util.ArrayList;

import Dominio.Usuario;
import Dominio.DTO.PaginatedResponse;

public interface IUsuarioDao {

	public void insert(Usuario usuario) throws SQLException;
	public boolean delete(Usuario usuario);
	public boolean update(Usuario usuario);
	public PaginatedResponse<Usuario> readAll(int pagina);
	public Usuario getUsuario(int id);
	public Usuario getUsuario(String user);
	public int calcularSiguienteId();
}
