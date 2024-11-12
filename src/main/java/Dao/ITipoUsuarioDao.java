package Dao;

import java.util.ArrayList;

import Dominio.TipoUsuario;

public interface ITipoUsuarioDao {

	public TipoUsuario getTipoUsuario(int id);
	
	public ArrayList<TipoUsuario> getTipoUsuario();
	
}
