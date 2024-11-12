package Dao;

import java.util.ArrayList;

import Dominio.Usuario;

public interface IUsuarioDao {

	public boolean insert(Usuario usuario);
	public boolean delete(Usuario usuario);
	public ArrayList<Usuario> readAll();
	public int calcularSiguienteId();
}
