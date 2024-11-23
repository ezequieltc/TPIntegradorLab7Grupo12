<%@page import="NegocioImpl.PrestamoNegocioImpl"%>
<%@page import="Negocio.IPrestamoNegocio"%>
<%@page import="Dominio.*"%>
<%@page import="DaoImpl.PrestamoDaoImpl"%>
<%@page import="Dao.IPrestamoDao"%>
<%@page import="tipos.PrestamosStatus" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@include  file="../../components/header.jsp"%>
  <link rel="stylesheet" href="https://cdn.datatables.net/2.1.8/css/dataTables.dataTables.css" />
  
  <style>

      h2 {
      	float:left;
      }
      .btn-sm {
      	width: 65%;
      	height: 75%;
      }
	  .btn {
	  margin-top: 25px;
	  	float: right;
	  }

      .tagDeuda, .tagPago{
      	width: 55%;
      	text-align: center;
      	color: white;
      	font-weight: bold;
      	font-size: 12px;
      	border-radius: 5px;
      	float: right;
      }
      .tagDeuda {
      	background-color: #fc5858;
      }
     .tagPago {
      	background-color: #58fc61;
      }
	 td {
	 text-align: center;
	 }
	   th, td {
    text-align: center; /* Centrado de texto */
    vertical-align: middle; /* Alineación vertical */
    padding: 0.5rem; /* Espaciado en las celdas */
  }

  .status-pendiente {
    background-color: #FFC107;
    color: #000;
    font-size: 0.8rem;
    padding: 0.25rem 0.5rem;
  }

  .status-autorizado {
    background-color: #28A745;
    color: #FFF;
    font-size: 0.8rem;
    padding: 0.25rem 0.5rem;
  }

  .status-rechazado {
    background-color: #DC3545;
    color: #FFF;
    font-size: 0.8rem;
    padding: 0.25rem 0.5rem;
  }

  .status-deuda {
    background-color: #FD7E14;
    color: #FFF;
    font-size: 0.8rem;
    padding: 0.25rem 0.5rem;
  }

  .status-en-curso {
    background-color: #007BFF;
    color: #FFF;
    font-size: 0.8rem;
    padding: 0.25rem 0.5rem;
  }
  </style>

</head>
<body>
<%@include  file="../../components/pre-body.jsp"%>





    <h2 class="my-4">Historial de Prestamos</h2>
    <a href="${pageContext.request.contextPath}/Usuarios/Prestamos/ServletSolicitarPrestamo" class="btn btn-primary">Nuevo Prestamo</a>

	<table id="example" class="display" style="width:85%">
        <thead class="table-light" style="text-align: center;">
            <tr>
                <th>Fecha</th>
                <th>importe</th>
                <th>Cuota Mensual</th>
                <th>Cuotas Totales</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
        <%
        ArrayList<Prestamo> prestamos = (ArrayList<Prestamo>)request.getAttribute("prestamos");
        for(Prestamo prestamo : prestamos){
        %>
            <tr>
                <td style="text-align: center;"><%=prestamo.getFecha_alta() %></td>
                <td style="text-align: center;"><%=prestamo.getImporte() %></td>
                <td style="text-align: center;"><%=prestamo.getCuota_mensual() %></td>
                <td style="text-align: center;"><%=prestamo.getCantidad_cuotas() %></td>
<% if(prestamo.getStatus().equals(PrestamosStatus.PAGO)){ %>
        <td><span class="listaPrestamos status-autorizado">Pago</span></td>
        <% }
        else if(prestamo.getStatus().equals(PrestamosStatus.PENDIENTE)){%>
        <td><span class="listaPrestamos status-pendiente">Pendiente</span></td>
        <% }
        else if(prestamo.getStatus().equals(PrestamosStatus.DEUDA)){
        %>
        <td><span class="listaPrestamos status-deuda">Deuda</span></td>
        <% }
        else if(prestamo.getStatus().equals(PrestamosStatus.RECHAZADO)){ %>
        <td><span class="listaPrestamos status-rechazado">Rechazado</span></td>
        <%} 
        else{ %>
        <td><span class="listaPrestamos status-en-curso">En Curso</span></td>
        <%}%></div></td>
            </tr>
		<%} %>
        </tbody>
    </table>

<%@include  file="../../components/post-body.jsp"%>
<script type="text/javascript" src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<script>
	new DataTable('#example', {
	    initComplete: function () {
	        this.api()
	            .columns()
	            .every(function () {
	                let column = this;
	                let title = column.header().textContent;
	 
	                // Create input element
	                let input = document.createElement('input');
	                input.placeholder = title;
	                column.header().replaceChildren(input);
	 
	                // Event listener for user input
	               /* input.addEventListener('keyup', () => {
	                    if (column.search() !== this.value) {
	                        column.search(input.value).draw();
	                    }
	                });*/
	            });
	    },
	    language: {
	        info: 'Mostrando pagina _PAGE_ de _PAGES_',
	        infoEmpty: 'No hay resultados disponibles',
	        infoFiltered: '(filtrados desde _MAX_ resultados totales)',
	        lengthMenu: ' _MENU_ Resultados por Pagina',
	        zeroRecords: 'Ups! Parece que no hay nada',
	        search: 'Buscar'
	    },
	        layout: {
	            topEnd: null
	        }
	    
	});
</script>


</body>
</html>