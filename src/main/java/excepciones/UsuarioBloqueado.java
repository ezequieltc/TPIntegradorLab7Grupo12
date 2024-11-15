package excepciones;

public class UsuarioBloqueado extends Exception{

	private static final long serialVersionUID = 1L;

	public UsuarioBloqueado(String mensaje) {
		super(mensaje);
	}

}
