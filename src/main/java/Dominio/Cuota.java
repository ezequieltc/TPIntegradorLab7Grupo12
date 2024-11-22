package Dominio;

import java.util.Date;

public class Cuota {
	
	int id;
	int id_prestamo;
	int numero_cuota;
	double importe;
	Date fecha_pago;
	boolean estado;
	
	public Cuota() {
		
	}
	
	public Cuota(int id_cuota, int id_prestamo, int numero_cuota, double importe, Date fecha_pago, boolean estado) {
		this.id = id_cuota;
		this.id_prestamo = id_prestamo;
		this.numero_cuota = numero_cuota;
		this.importe = importe;
		this.fecha_pago = fecha_pago;
		this.estado = estado;
	}

	public int getId() {
		return id;
	}

	public void setId(int id_cuota) {
		this.id = id_cuota;
	}

	public int getId_prestamo() {
		return id_prestamo;
	}

	public void setId_prestamo(int id_prestamo) {
		this.id_prestamo = id_prestamo;
	}

	public int getNumero_cuota() {
		return numero_cuota;
	}

	public void setNumero_cuota(int numero_cuota) {
		this.numero_cuota = numero_cuota;
	}

	public double getImporte() {
		return importe;
	}

	public void setImporte(double importe) {
		this.importe = importe;
	}

	public Date getFecha_pago() {
		return fecha_pago;
	}

	public void setFecha_pago(Date fecha_pago) {
		this.fecha_pago = fecha_pago;
	}

	public boolean isEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	@Override
	public String toString() {
		return "Cuota [id_cuota=" + id + ", id_prestamo=" + id_prestamo + ", numero_cuota=" + numero_cuota
				+ ", importe=" + importe + ", fecha_pago=" + fecha_pago + ", estado=" + estado + "]";
	}
	
	

}
