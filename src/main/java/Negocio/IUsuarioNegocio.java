package Negocio;

import java.util.ArrayList;

import Dominio.Usuario;

public interface IUsuarioNegocio {
	public boolean insert(Usuario usuario);
	public boolean delete(Usuario usuario);
	public ArrayList<Usuario> readAll();
}
