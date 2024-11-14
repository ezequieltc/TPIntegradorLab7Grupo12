package Negocio;

import java.util.ArrayList;

import Dominio.Persona;

public interface IPersonaNegocio {
	public boolean insert(Persona persona);
	public boolean delete(int id);
	public boolean update(Persona persona);
	public Persona getPersona(int id);
	public ArrayList<Persona> readAll();
}
