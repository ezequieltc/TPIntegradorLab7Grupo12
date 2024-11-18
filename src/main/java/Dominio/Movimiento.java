package Dominio;

import java.sql.Date;

public class Movimiento {
    private int id;
    private int idCuenta;
    private TipoMovimiento tipoMovimiento;
    private Date fecha;
    private String detalle;
    private Double importe;
    private Boolean estado;

    public Movimiento(int idCuenta, TipoMovimiento tipoMovimiento, Date fecha,
                      String detalle, Double importe, Boolean estado) {
        this.idCuenta = idCuenta;
        this.tipoMovimiento = tipoMovimiento;
        this.fecha = fecha;
        this.detalle = detalle;
        this.importe = importe;
        this.estado = estado;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCuenta() {
        return idCuenta;
    }

    public void setIdCuenta(int idCuenta) {
        this.idCuenta = idCuenta;
    }

    public TipoMovimiento getTipoMovimiento() {
        return tipoMovimiento;
    }

    public void setTipoMovimiento(TipoMovimiento tipoMovimiento) {
        this.tipoMovimiento = tipoMovimiento;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getDetalle() {
        return detalle;
    }

    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }

    public Double getImporte() {
        return importe;
    }

    public void setImporte(Double importe) {
        this.importe = importe;
    }

    public Boolean getEstado() {
        return estado;
    }

    public void setEstado(Boolean estado) {
        this.estado = estado;
    }

    @Override
    public String toString() {
        return "Movimiento{" +
                "id=" + id +
                ", idCuenta=" + idCuenta +
                ", tipoMovimiento=" + tipoMovimiento +
                ", fecha=" + fecha +
                ", detalle='" + detalle + '\'' +
                ", importe=" + importe +
                ", estado=" + estado +
                '}';
    }
}