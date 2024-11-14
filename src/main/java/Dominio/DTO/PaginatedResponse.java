package Dominio.DTO;

import java.util.List;

public class PaginatedResponse<T> {

	private List<T> data;
	private int totalRegistros;
	private int paginaActual;
	private int tamanoPagina;
	
	public PaginatedResponse(List<T> data, int totalRegistros, int paginaActual, int tamanoPagina){
		this.data = data;
		this.totalRegistros = totalRegistros;
		this.paginaActual = paginaActual;
		this.tamanoPagina = tamanoPagina;
	}

    public List<T> getData(){
    	return data;
    }


    public int getTotalRegistros() {
    	return totalRegistros;
    }


    public int getPaginaActual() {
    	return paginaActual;
    }


    public int getTamanoPagina() {
    	return tamanoPagina;
    }


    public int getTotalPaginas() {
        int totalRegistros = getTotalRegistros();
        int tamanoPagina = getTamanoPagina();
        return (int) Math.ceil((double) totalRegistros / tamanoPagina);
    }
}