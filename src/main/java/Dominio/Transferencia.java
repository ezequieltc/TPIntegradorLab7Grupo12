package Dominio;

public class Transferencia {
    public int id;
    public Movimiento movimientoOrigen;
    public Movimiento movimientoDestino;

    public Cuenta cuentaOrigen;
    public Cuenta cuentaDestino;
    

    public Transferencia() {
    };

    public Transferencia(int id, Movimiento movimientoOrigen, Movimiento movimientoDestino) {
        this.id = id;
        this.movimientoOrigen = movimientoOrigen;
        this.movimientoDestino = movimientoDestino;
    }
    public Transferencia(Movimiento movimientoOrigen, Movimiento movimientoDestino) {
        this.movimientoOrigen = movimientoOrigen;
        this.movimientoDestino = movimientoDestino;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Movimiento getMovimientoOrigen() {
        return movimientoOrigen;
    }

    public void setMovimientoOrigen(Movimiento movimientoOrigen) {
        this.movimientoOrigen = movimientoOrigen;
    }

    public Movimiento getMovimientoDestino() {
        return movimientoDestino;
    }

    public void setMovimientoDestino(Movimiento movimientoDestino) {
        this.movimientoDestino = movimientoDestino;
    }

    public Cuenta getCuentaOrigen() {
        return cuentaOrigen;
    }

    public void setCuentaOrigen(Cuenta cuentaOrigen) {
        this.cuentaOrigen = cuentaOrigen;
    }

    public Cuenta getCuentaDestino() {
        return cuentaDestino;
    }

    public void setCuentaDestino(Cuenta cuentaDestino) {
        this.cuentaDestino = cuentaDestino;
    }

}
