package Dominio;

public class TipoSexo {

	int id;
	String descripcion;
	
	public TipoSexo() {}
	
	public TipoSexo(String descripcion) {
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
		return "Tipo Sexo: [id=" + id + ", descripcion=" + descripcion + "]";
	}
}
