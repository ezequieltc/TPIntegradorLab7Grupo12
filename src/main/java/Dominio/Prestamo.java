package Dominio;

import java.util.Date;

import tipos.PrestamosStatus;

public class Prestamo {
	int id;
	Cuenta cuenta;
	Persona persona;
	Date fecha_alta;
	float importe;
	float cuota_mensual;
	float total_pagado;
	int cantidad_cuotas;
	PrestamosStatus status;
	boolean estado;
	
	public Prestamo() {
		
	}
	
	public Prestamo(int id, Cuenta cuenta, Persona persona, Date fecha_alta, float importe, float cuota_mensual, float total_pagado, PrestamosStatus status, boolean estado) {
		this.id = id;
		this.cuenta = cuenta;
		this.persona = persona;
		this.fecha_alta = fecha_alta;
		this.importe = importe;
		this.cuota_mensual = cuota_mensual;
		this.total_pagado = total_pagado;
		this.status = status;
		this.estado = estado;
	}

	public Cuenta getCuenta() {
		return cuenta;
	}

	public void setCuenta(Cuenta cuenta) {
		this.cuenta = cuenta;
	}

	public Persona getPersona() {
		return persona;
	}

	public void setPersona(Persona persona) {
		this.persona = persona;
	}

	public Date getFecha_alta() {
		return fecha_alta;
	}

	public void setFecha_alta(Date fecha_alta) {
		this.fecha_alta = fecha_alta;
	}

	public float getImporte() {
		return importe;
	}

	public void setImporte(float importe) {
		this.importe = importe;
	}

	public float getCuota_mensual() {
		return cuota_mensual;
	}

	public void setCuota_mensual(float cuota_mensual) {
		this.cuota_mensual = cuota_mensual;
	}

	public float getTotal_pagado() {
		return total_pagado;
	}

	public void setTotal_pagado(float total_pagado) {
		this.total_pagado = total_pagado;
	}

	public int getCantidad_cuotas() {
		return cantidad_cuotas;
	}

	public void setCantidad_cuotas(int cantidad_cuotas) {
		this.cantidad_cuotas = cantidad_cuotas;
	}

	public PrestamosStatus getStatus() {
		return status;
	}

	public void setStatus(PrestamosStatus status) {
		this.status = status;
	}

	public boolean isEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "Prestamo [cuenta=" + cuenta + ", persona=" + persona + ", fecha_alta=" + fecha_alta + ", importe="
				+ importe + ", cuota_mensual=" + cuota_mensual + ", total_pagado=" + total_pagado + ", cantidad_cuotas="
				+ cantidad_cuotas + ", status=" + status + ", estado=" + estado + "]";
	}
	
	
}
