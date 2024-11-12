package Dao;

import java.util.ArrayList;

import Dominio.Persona;

public interface IPersonaDao {
	public boolean insert(Persona persona);
	public boolean delete(Persona persona);
	public ArrayList<Persona> readAll();
	public int calcularSiguienteId();
}
