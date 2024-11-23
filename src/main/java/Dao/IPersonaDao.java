package Dao;

import java.sql.SQLException;
import java.util.ArrayList;

import Dominio.Persona;
import Dominio.DTO.PaginatedResponse;

public interface IPersonaDao {
	public void insert(Persona persona) throws SQLException;
	public boolean delete(int id);
	public boolean update(Persona persona);
	public Persona getPersona(int id);
	public Persona getPersonaPorDni(String dni);
	public PaginatedResponse<Persona> readAll(int pagina);
	public int calcularSiguienteId();
}
