package Negocio;

import java.sql.SQLException;
import java.util.ArrayList;

import Dominio.Persona;
import Dominio.DTO.PaginatedResponse;

public interface IPersonaNegocio {
	public void registrarCliente(Persona persona) throws RuntimeException, SQLException;
	public boolean delete(int id);
	public boolean update(Persona persona);
	public Persona getPersona(int id);
	public PaginatedResponse<Persona> readAll(int pagina);
}
