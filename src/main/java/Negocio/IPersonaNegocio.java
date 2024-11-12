package Negocio;

import java.util.ArrayList;

import Dominio.Persona;

public interface IPersonaNegocio {
	public boolean insert(Persona persona);
	public boolean delete(Persona persona);
	public ArrayList<Persona> readAll();
}
