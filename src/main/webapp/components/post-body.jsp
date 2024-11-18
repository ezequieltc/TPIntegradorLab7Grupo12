<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String mensajeExito = (String) session.getAttribute("mensajeExito");
	String mensajeError = (String) session.getAttribute("mensajeError"); 
	Boolean mostrarPopUp = (Boolean) session.getAttribute("mostrarPopUp");
	String popUpStatus = (String) session.getAttribute("popUpStatus");
	
	// Limpiar los atributos de la sesión para que no se muestren después de un refresh
	session.removeAttribute("mensajeExito");
	session.removeAttribute("mensajeError");
	session.removeAttribute("mostrarPopUp");
	session.removeAttribute("popUpStatus");
%>

	<!-- Modales de éxito y error -->
	<div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content success">
				<div class="modal-header success">
					<h5 class="modal-title">Éxito</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<%= mensajeExito != null ? mensajeExito : "¡Cuenta creada exitosamente!" %>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content error">
				<div class="modal-header error">
					<h5 class="modal-title">Error</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<%= mensajeError != null ? mensajeError : "Hubo un error al crear la cuenta. Por favor, inténtelo nuevamente." %>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>
  
    
	  	</div>
	  </div>
	<footer class="footer">
	  <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
	</footer>
	
	
	
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
	
	<script>
	$(document).ready(function(){
	       <% if (mostrarPopUp != null && "success".equals(popUpStatus)) { %>
	           var successModal = new bootstrap.Modal(document.getElementById('successModal'));
	           successModal.show();
	       <% } else if (mostrarPopUp != null && "error".equals(popUpStatus)) { %>
	           var errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
	           errorModal.show();
	       <% } %>
	   });
	</script>
	
