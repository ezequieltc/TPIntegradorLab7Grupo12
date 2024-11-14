package Dao;

import java.util.ArrayList;

import Dominio.Persona;
import Dominio.DTO.PaginatedResponse;

public interface IPersonaDao {
	public boolean insert(Persona persona);
	public boolean delete(int id);
	public boolean update(Persona persona);
	public Persona getPersona(int id);
	public PaginatedResponse<Persona> readAll(int pagina);
	public int calcularSiguienteId();
}
