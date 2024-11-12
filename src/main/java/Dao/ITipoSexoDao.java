package Dao;

import java.util.ArrayList;

import Dominio.TipoSexo;

public interface ITipoSexoDao {

	public TipoSexo getTipoSexo(int id);
	
	public ArrayList<TipoSexo> getTipoSexo();
	
}
