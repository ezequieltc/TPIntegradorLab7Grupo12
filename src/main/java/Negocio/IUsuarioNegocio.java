package Negocio;

import java.util.ArrayList;

import Dominio.Usuario;
import Dominio.DTO.PaginatedResponse;

public interface IUsuarioNegocio {
	public boolean insert(Usuario usuario);
	public boolean delete(Usuario usuario);
	public boolean update(Usuario usuario);
	public PaginatedResponse<Usuario> readAll(int pagina);
}
