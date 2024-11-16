package excepciones;

public class PersonaExistenteExcepcion extends Exception{

	private static final long serialVersionUID = 1L;
	
	public PersonaExistenteExcepcion(String mensaje) {
		super(mensaje);
	}

}
