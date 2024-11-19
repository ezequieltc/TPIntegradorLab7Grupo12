<%@ page import="Dominio.Cuenta" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="es">
<%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Solicitar Prestamo");
%>
<head>
<%@include file="../../components/header.jsp"%>
  <link rel="stylesheet" type="text/css" href="../../css/layout.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    .main-content {
      flex: 1;
      padding: 2rem;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .cajaPrestamo {
      background-color: #FFFFFF;
      padding: 2rem;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      width: 100%;
      max-width: 600px;
    }
  </style>
</head>
<body>
	<%@include file="../../components/pre-body.jsp"%>
	<%
		ArrayList<Cuenta> cuentasCliente = new ArrayList<Cuenta>();
		cuentasCliente = (ArrayList<Cuenta>)request.getAttribute("cuentasCliente");
	
	%>
  <div class="content-container">
	<div class="main-content">
      <div class="cajaPrestamo">
        <h2 class="text-center text-primary mb-4">Solicitar un Préstamo</h2>
        <form id="PrestamoForm" action="${pageContext.request.contextPath}/Usuarios/Prestamos/ServletSolicitarPrestamo" method="POST" novalidate>
          <div class="mb-3">
            <label for="montoPrestamo" class="form-label">Monto del Préstamo</label>
            <input type="number" class="form-control" name="montoPrestamo" id="montoPrestamo" placeholder="Ingrese el monto" required>
          </div>
          <div class="mb-3">
			<label for="cantCuotas" class="form-label">Cantidad de Cuotas</label>
			  <select class="form-control" name="cantCuotas" id="cantCuotas" required>
			    <option value="" disabled selected>Seleccione la cantidad de cuotas</option>
			    <option value="6">6</option>
			    <option value="12">12</option>
			    <option value="24">24</option>
			    <option value="36">36</option>
			    <option value="48">48</option>
			    <option value="72">72</option>
			  </select>
          </div>
          <div class="mb-3">
            <label for="cuenta" class="form-label">Cuenta para el Depósito</label>
            <select name="cuentaDropDown" class="form-control" id="cuenta" required>
            <% %>
              <option value="" disabled selected>Seleccione una cuenta</option>
              <% for (Cuenta cuenta : cuentasCliente){%>
            	  <option  value="<%= cuenta.getId() %>">Cuenta <%= cuenta.getNumeroCuenta() %> - <%= cuenta.getTipoCuenta().getDescripcion() %></option>         	              	  
            	  <% }%>
            </select>
          </div>
          <div class="d-grid gap-2">
            <button type="button" class="btn btn-primary btn-block" onclick="simularPrestamo()">Simular Prestamo</button>
          </div>
	        <div class="text-center mt-4" id="resultContainer" style="display: none;">
	          <p><strong>Resultado de la Simulación:</strong></p>
	          <p>Cuota Mensual: <span id="pagoMensual">-</span></p>
	          <p>Total a Pagar: <span id="pagoTotal">-</span></p>
	          <p>Intereses: <span id="intereses">-</span></p>          
	        </div>
	        <div class="text-center mt-4" id="containerSolicitar" style="display: none;">
	        	<div class="d-grid gap-2">
	       			<button type="submit" id="buttonSolicitar" class="btn btn-primary btn-block" hidden="true">Solicitar Prestamo</button>
	       			<!-- <p id="mensajeAprobacion" class="text-success mt-3" hidden="true"></p> -->
	       		</div>
	        </div>
        </form>
      </div>
    </div>
  </div>

<%@include file="../../components/post-body.jsp"%>

<script>
  function simularPrestamo() {
	    // Obtener los valores de entrada
	    const montoPrestamo = parseFloat(document.getElementById('montoPrestamo').value);  // Monto del préstamo
	    const cantCuotas = parseInt(document.getElementById('cantCuotas').value);  // Cantidad de cuotas
	    const cuenta = document.getElementById('cuenta').value;  // Cuenta seleccionada

	    // Validar que los campos son correctos
	    if (isNaN(montoPrestamo) || isNaN(cantCuotas) || !cuenta) {
	      alert("Por favor, complete todos los campos correctamente.");
	      return;
	    }

	    const tasaAnual = 0.72;  // Tasa efectiva anual del 72%

	    // Convertir la tasa anual efectiva a tasa mensual
	    const tasaMensual = Math.pow(1 + tasaAnual, 1 / 12) - 1;

	    // Calcular el pago mensual usando la fórmula de amortización
	    const pagoMensual = montoPrestamo * (tasaMensual / (1 - Math.pow(1 + tasaMensual, -cantCuotas)));

	    // Calcular el monto total a pagar (pago mensual * número de cuotas)
	    const pagoTotal = pagoMensual * cantCuotas;

	    // Calcular los intereses ganados
	    const interesTotalPagado = pagoTotal - montoPrestamo;

	    // Calcular el porcentaje de intereses sobre el monto prestado
	    const porcentajeInteresReal = (interesTotalPagado / montoPrestamo) * 100;

	    // Mostrar los resultados
	    document.getElementById('resultContainer').style.display = "block";
	    document.getElementById('containerSolicitar').style.display = "block";
	    document.getElementById('pagoMensual').textContent = "$" + pagoMensual.toFixed(2);
	    document.getElementById('pagoTotal').textContent = "$" + pagoTotal.toFixed(2);
	    document.getElementById('intereses').textContent = porcentajeInteresReal.toFixed(2) + "%";
	    document.getElementById('buttonSolicitar').hidden = false;
  }
  function solicitarPrestamo(){
	document.getElementById('mensajeAprobacion').hidden = false;
	document.getElementById('mensajeAprobacion').textContent = "Solicitud de préstamo enviada. Espere la aprobación del banco.";
  }
</script>
</body>
</html>
