<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dominio.Cuenta" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="Dominio.Cuota" %>
<%@ page import="Dominio.Prestamo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Pagar Cuotas");
	int prestamoSeleccionado = 0;
	ArrayList<Cuenta> cuentasCliente = new ArrayList<Cuenta>();
	cuentasCliente = (ArrayList<Cuenta>)request.getSession().getAttribute("cuentasCliente");
	ArrayList<Cuota> cuotasPrestamo = new ArrayList<Cuota>();
	cuotasPrestamo = (ArrayList<Cuota>)request.getSession().getAttribute("cuotasPrestamo");
	ArrayList<Prestamo> prestamosCliente = new ArrayList<Prestamo>();
	prestamosCliente = (ArrayList<Prestamo>)request.getSession().getAttribute("prestamosCliente");
	if(request.getSession().getAttribute("prestamoSeleccionado")!= null){
		String seleccion = request.getSession().getAttribute("prestamoSeleccionado").toString();
		prestamoSeleccionado = Integer.parseInt(seleccion); 
	}
	
	request.getSession().setAttribute("prestamoSeleccionado",null);
	
	

%>
<head>
<%@include file="../../components/header.jsp"%>
    <style>
      body {
        background-color: #e0f0ff;
        margin: 0;
      }
      .content {
        margin-left: 200px;
        padding: 0;
      }

      .card {
        max-width: 400px;
        margin: 50px auto;
        border: none;
      }
      .form-control {
        font-size: 1rem;
      }

    </style>
  </head>
  <body>
  <%@include file="../../components/pre-body.jsp"%>
    <div class="content">
      <div class="card shadow">
        <div class="card-body">
          <h3 class="card-title text-center">Pagar Cuota</h3>
          <form id="formPagarCuota" name="formPagarCuota" action="${pageContext.request.contextPath}/Usuarios/Prestamos/ServletPagarCuota" method="POST" novalidate>
          	<select id="selectPrestamoForm" name="selectPrestamo" class="form-select mb-3"  onchange="submitPrestamoForm()">
              <option value="0" selected>Seleccione el prestamo a pagar</option>
          	<% if (prestamosCliente != null){
          		for (Prestamo prestamo : prestamosCliente){ 
          		if(prestamoSeleccionado == prestamo.getId()){%>
	          		<option value="<%= prestamo.getId()%>" selected>Prestamo Numero: <%= prestamo.getId() %></option>
          		<%}
          		else{
          		%>
					<option value="<%= prestamo.getId()%>">Prestamo Numero: <%= prestamo.getId() %></option>
          			
          		<%}
          		}
          	}%>


            </select>
            <select id="selectCuota" name="selectCuota" class="form-select mb-3" required>
              <option value="0" selected>Seleccione cuota a pagar</option>
              <% if (cuotasPrestamo != null){
          		for (Cuota cuota : cuotasPrestamo){ 
          			SimpleDateFormat formatoFecha = new SimpleDateFormat("dd-MM-yyyy");
          			String fechaFormateada = formatoFecha.format(cuota.getFecha_pago());	
          				%>
          		<option value="<%= cuota.getId() %>">Cuota Numero: <%= cuota.getNumero_cuota() %> - Vencimiento: <%= fechaFormateada %></option>
          			
          		<% } %>
          	<% }%>
            </select>
            <select
              class="form-select mb-3"
              aria-label="Default select example"
              name= "selectCuenta"
              id="selectCuenta"
            >
              <option value="0" selected>Seleccione cuenta a debitar</option>
               	<% if (cuentasCliente != null){
          		for (Cuenta cuenta : cuentasCliente){ %>
          		<option value="<%= cuenta.getId()%>">Cuenta Numero: <%= cuenta.getNumeroCuenta() %> - <%= cuenta.getTipoCuenta().getDescripcion() %> </option>
          			
          		<%}
          	}%>
            </select>
            <button name="buttonSubmit" type="submit" value="pagar" class="btn btn-primary btn-block" onclick="verificarValores()">
              Pagar
            </button>
          </form>
        </div>
      </div>
<%@include file="../../components/post-body.jsp"%>
  </body>
  <script>
  // Función para enviar el formulario automáticamente
  function verificarValores() {
	  if(document.getElementById("selectPrestamoForm").value == 0 && document.getElementById("selectCuota").value == 0 && document.getElementById("selectCuenta").value == 0){
		alert("ERROR")		
}

</script>
</html>


