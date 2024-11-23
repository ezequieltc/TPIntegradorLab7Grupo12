package Negocio;

import java.sql.SQLException;
import java.util.ArrayList;

import Dominio.Persona;
import Dominio.DTO.PaginatedResponse;

public interface IPersonaNegocio {
	public void registrarCliente(Persona persona) throws RuntimeException, SQLException;
	public void eliminarPersona(int id) throws SQLException;
	public boolean update(Persona persona);
	public Persona getPersona(int id);
	public Persona getPersonaPorDni(String dni);
	public PaginatedResponse<Persona> readAll(int pagina);
}
