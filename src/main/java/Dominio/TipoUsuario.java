package Dominio;

public class TipoUsuario {
	private int id = 0;
	private String descripcion = "";
	
	public TipoUsuario() {}
	
	public TipoUsuario(String descripcion) {
		this.descripcion = descripcion;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	@Override
	public String toString() {
		return "Tipo Usuario: [id=" + id + ", descripcion=" + descripcion + "]";
	}
	
}
