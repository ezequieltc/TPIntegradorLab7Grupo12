package Dominio;

public class TipoCuenta {
	
	public int id;
	public String descripcion;
	
	
	public TipoCuenta() {}


	public TipoCuenta(int id, String descripcion) {
		this.id = id;
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
	};
	
}
