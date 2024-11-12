package Dominio;

import java.util.Date;

public class Usuario {
    private int id;
    private TipoUsuario tipoUsuario;
    private String usuario;
    private String contrasena;
    private Date fechaCreacion;
    private boolean estado;
    
    public Usuario() {}

    public Usuario(int id, TipoUsuario tipoUsuario, String usuario, String contrasena, Date fechaCreacion, boolean estado) {
    	this.id = id;
        this.tipoUsuario = tipoUsuario;
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.fechaCreacion = fechaCreacion;
        this.estado = estado;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public TipoUsuario getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(TipoUsuario tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
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
}
