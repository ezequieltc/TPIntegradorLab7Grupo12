package Dao;

import java.util.ArrayList;

import Dominio.Usuario;
import Dominio.DTO.PaginatedResponse;

public interface IUsuarioDao {

	public boolean insert(Usuario usuario);
	public boolean delete(Usuario usuario);
	public boolean update(Usuario usuario);
	public PaginatedResponse<Usuario> readAll(int pagina);
	public Usuario getUsuario(int id);
	public int calcularSiguienteId();
}
