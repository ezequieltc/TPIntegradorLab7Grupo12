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
  </style>

</head>
<body>
<%@include  file="../../components/pre-body.jsp"%>





    <h2 class="my-4">Historial de Prestamos</h2>
    <a href="${pageContext.request.contextPath}/Usuarios/Prestamos/ServletSolicitarPrestamo" class="btn btn-primary">Nuevo Prestamo</a>

	<table id="example" class="display" style="width:85%">
        <thead>
            <tr>
                <th>Fecha</th>
                <th>importe</th>
                <th>Cuota Mensual</th>
                <th>Cuotas Totales</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
        
            <tr>
                <td style="text-align: center;">2011-04-25</td>
                <td style="text-align: center;">$320,800</td>
                <td style="text-align: center;">15</td>
                <td style="text-align: center;">24</td>
                <td><div class="tagDeuda">Deuda</div></td>
            </tr>
            <tr>
                <td style="text-align: center;">2020-07-12</td>
                <td style="text-align: center;">$20,000</td>
                <td style="text-align: center;">12</td>
                <td style="text-align: center;">12</td>
                <td><div class="tagPago">Pago</div></td>
            </tr>
            <tr>
                <td style="text-align: center;">2024-01-05</td>
                <td style="text-align: center;">$1.020.800</td>
                <td style="text-align: center;">5</td>
                <td style="text-align: center;">84</td>
                <td><div class="tagDeuda">Deuda</div></td>
            </tr>
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
	                input.addEventListener('keyup', () => {
	                    if (column.search() !== this.value) {
	                        column.search(input.value).draw();
	                    }
	                });
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