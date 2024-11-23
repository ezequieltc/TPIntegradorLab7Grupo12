<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dominio.Persona" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>

<head>
<%@include file="../../components/header.jsp"%>
<style>
    .card {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 16px;
        background-color: #f9f9f9;
        margin-bottom: 20px;
    }
    .card h4 {
        margin-bottom: 12px;
    }
    .card p {
        margin: 4px 0;
    }
</style>
</head>
<body>
<%@include file="../../components/pre-body.jsp"%>
<%
    // Establecer el título de la página
    request.setAttribute("pageTitle", "Modificar Usuario");
	Persona personaModificada = (Persona) request.getAttribute("personaModificada");
    boolean isUserActive = personaModificada.getUsuario().getEstado(); // Ajustar según cómo se obtenga el estado
%>
    <h2 class="my-4">Modificar Usuario</h2>

    <!-- Información Personal como Card -->
    <div class="card">
        <h4>Información Personal</h4>
        <p><strong>DNI:</strong> ${personaModificada.getDni()}</p>
        <p><strong>Cuil:</strong> ${personaModificada.getCuil()}</p>
        <p><strong>Nombre:</strong> ${personaModificada.getNombre()}</p>
        <p><strong>Apellido:</strong> ${personaModificada.getApellido()}</p>
        <p><strong>Sexo:</strong> ${personaModificada.getTipoSexo().getDescripcion()}</p>
        
       	
        <p><strong>Nacionalidad:</strong> ${personaModificada.getNacionalidad()}</p>
        <p><strong>Fecha de Nacimiento:</strong> ${personaModificada.getFechaNacimiento()}</p>
        <p><strong>Usuario:</strong> ${personaModificada.getUsuario().getUsuario()}</p>
        <p><strong>Estado:</strong> 
            <span style="color: <%= isUserActive ? "green" : "red" %>;">
                <%= isUserActive ? "Activo" : "Bloqueado" %>
            </span>
        </p>
    </div>

    <!-- Formulario Editable -->
    <div id="registrationForm" class="w-100">
        <div class="step step-1">
            <h4>Información de Contacto</h4>
            <form action="${pageContext.request.contextPath}/Administrador/Usuarios/ServletModificarUsuario" method="post">
                <input type="hidden" name="id" value="${personaModificada.getId()}">
				<input type="hidden" name="sexo" value="${personaModificada.getTipoSexo().getId() }">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="direccion">Dirección</label>
                            <input type="text" name="direccion" class="form-control" value="${personaModificada.getDireccion()}">
                        </div>
                        <div class="form-group">
                            <label for="localidad">Localidad</label>
                            <input type="text" name="localidad" class="form-control" value="${personaModificada.getLocalidad()}">
                        </div>
                        <div class="form-group">
                            <label for="provincia">Provincia</label>
                            <input type="text" name="provincia" class="form-control" value="${personaModificada.getProvincia()}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="email">Correo Electrónico</label>
                            <input type="text" name="email" class="form-control" value="${personaModificada.getEmail()}">
                        </div>
                        <div class="form-group">
                            <label for="telefono">Teléfono</label>
                            <input type="text" name="telefono" class="form-control" value="${personaModificada.getTelefono()}">
                        </div>
                    </div>
                </div>

                <!-- Botones de Acción -->
                <div class="step-actions" style="margin-top: 10px">
                    <button type="submit" class="btn btn-success" name="btnConfirmarModificacionUsuario">Guardar Cambios</button>
                    
                    <% if (personaModificada.isEstado()) { %>
                        <button type="button" class="btn btn-danger" onclick="confirmarDesactivacion()">Eliminar Usuario</button>
                    <% } if (!personaModificada.getUsuario().getEstado()) { %>
                        <button type="button" class="btn btn-primary" onclick="confirmarReactivacion()">Reactivar Usuario</button>
                    <% } %>
                </div>
            </form>
        </div>
    </div>
	<%@include file="../../components/post-body.jsp"%>
    <script>
        function confirmarDesactivacion() {
            if (confirm('¿Está seguro de que desea desactivar este usuario?')) {
                window.location.href = '<%= request.getContextPath() %>/Administrador/Usuarios/ServletEliminarPersona?id=<%= personaModificada.getId() %>';
            }
        }
        function confirmarReactivacion() {
            if (confirm('¿Está seguro de que desea reactivar este usuario?')) {
                window.location.href = "<%= request.getContextPath() %>/Administrador/Usuarios/ServletReactivarUsuario?id=<%= personaModificada.getUsuario().getId() %>";
            }
        }
    </script>

</body>
</html>
