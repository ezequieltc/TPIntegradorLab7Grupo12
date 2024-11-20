package Dominio;

import java.util.Date;

public class Cuenta {

	public int id;
	public Persona persona;
	public TipoCuenta tipoCuenta;
	public String numeroCuenta;
	public String cbu;
	public Double saldo;
	public Date fechaCreacion;
	public boolean estado;
	
	
	public Cuenta() {};
	
	public Cuenta(int id, Persona persona, TipoCuenta tipoCuenta, String numeroCuenta, String cbu, Double saldo, Date fechaCreacion, boolean estado) {
        this.id = id;
        this.persona = persona;
        this.tipoCuenta = tipoCuenta;
        this.numeroCuenta = numeroCuenta;
        this.cbu = cbu;
        this.saldo = saldo;
        this.fechaCreacion = fechaCreacion;
        this.estado = estado;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Persona getPersona() {
		return persona;
	}

	public void setPersona(Persona persona) {
		this.persona = persona;
	}

	public TipoCuenta getTipoCuenta() {
		return tipoCuenta;
	}

	public void setTipoCuenta(TipoCuenta tipoCuenta) {
		this.tipoCuenta = tipoCuenta;
	}

	public String getNumeroCuenta() {
		return numeroCuenta;
	}

	public void setNumeroCuenta(String numeroCuenta) {
		this.numeroCuenta = numeroCuenta;
	}

	public String getCbu() {
		return cbu;
	}

	public void setCbu(String cbu) {
		this.cbu = cbu;
	}

	public double getSaldo() {
		return saldo;
	}

	public void setSaldo(double saldo) {
		this.saldo = saldo;
	}

	public Date getFechaCreacion() {
		return fechaCreacion;
	}

	public void setFechaCreacion(Date fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}

	public boolean isEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	@Override
	public String toString() {
		return "Cuenta [id=" + id + ", persona=" + persona.getNombre() + persona.getApellido() + ", tipoCuenta=" + tipoCuenta.getDescripcion() + ", numeroCuenta="
				+ numeroCuenta + ", cbu=" + cbu + ", saldo=" + saldo + ", fechaCreacion=" + fechaCreacion + ", estado="
				+ estado + "]";
	}
	
}
