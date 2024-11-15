<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Informes y Reportes");
  %>
  <%@include  file="../components/header.jsp"%>
<head>
  <style>
    .step {
          padding: 40px;
          background-color: #ffffff;
          border-radius: 5px;
          box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
          width: 100%;
          min-height: 450px;
          position: relative;
      }

      .step .form-group,
      .step .beneficiary-details {
          margin-bottom: 20px;
      }

      .step .step-actions {
          position: absolute;
          bottom: 20px;
          right: 20px;
      }

      .transferForm {
          height: calc(100% - 100px);
      }
</style>
</head>
<body>
  	<%@include  file="../components/pre-body.jsp"%>
  	<h2 class="my-4">Informes y Reportes</h2>
	  <div class="step">
	    <h4>Generar Informes y Reportes</h4>
	    <form>
	      <div class="form-group">
	        <label for="tipoReporte">Tipo de Reporte</label>
	        <select id="tipoReporte" class="form-control">
	          <option value="opción">Seleccione una opcion..</option>            
	          <option value="transacciones">Transacciones</option>
	          <option value="prestamos">Prestamos</option>
	          <option value="cuentas">Cuentas</option>
	          <option value="ingresos">Ingresos y comisiones</option>
	          
	        </select>
	      </div>
	      <div class="form-group">
	        <label for="fechaInicio">Fecha de Inicio</label>
	        <input type="date" id="fechaInicio" class="form-control">
	      </div>
	      <div class="form-group">
	        <label for="fechaFin">Fecha de Fin</label>
	        <input type="date" id="fechaFin" class="form-control">
	      </div>
	      <div>
	        <button type="button" class="btn btn-info btn-sm ms-2" data-bs-toggle="modal" data-bs-target="#infoModal1">Generar Reporte</button>           
	      </div>
	    </form>
	  </div>

	<div class="modal fade" id="infoModal1" tabindex="-1" aria-labelledby="infoModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="infoModalLabel">Informe de Transacciones</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <table class="table">
	          <thead>
	            <tr>
	              <th>Total transacciones</th>
	              <th>Transacciones exitosas</th>
	              <th>Transacciones no exitosas</th>             
	              <th>Montos totales transaccionado</th>
	              <th>Promedio de transacciones por cuenta</th>
	              <th>
	            </tr>
	          </thead>
	          <tbody>
	            <tr>
	              <td>267049</td>
	              <td>221478</td>
	              <td>45571</td>
	              <td>$501.219.491,49</td>
	              <td>$94000</td>              
	            </tr>            
	          </tbody>
	        </table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
	      </div>
	    </div>
	  </div>
	</div>
	<%@include  file="../components/post-body.jsp"%>
</body>
</html>
