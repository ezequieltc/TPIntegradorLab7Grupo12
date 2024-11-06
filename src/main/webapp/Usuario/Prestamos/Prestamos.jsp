<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>BancArg - Nueva Transferencia</title>
  <link rel="stylesheet" type="text/css" href="../../css/layout.css" />
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"
  />
  <link rel="stylesheet" href="https://cdn.datatables.net/2.1.8/css/dataTables.dataTables.css" />
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script type="text/javascript" src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
  
  <script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
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
      .transferForm {
          height: calc(100% - 100px);
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
<nav class="navbar">
  <a class="navbar-brand" href="#">BancArg</a>
  <div class="justify-content-end">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="#">Usuario: Pepito Pistolero</a>
      </li>
    </ul>
  </div>
</nav>

<div class="d-flex">
  <div class="sidebar">
    <a href="#">Inicio</a>
    <a href="#">Cuentas</a>
    <a href="#">Transferencias</a>
    <a href="#">Préstamos</a>
    <a href="#">Ajustes</a>
  </div>

  <div class="content-container">
    <h2 class="my-4">Historial de Prestamos</h2>
    <a href="NuevaTransferencia.jsp" class="btn btn-primary">Nuevo Prestamo</a>

	<table id="example" class="display compact" style="width:85%">
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

  </div>
</div>



<footer class="footer">
  <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
new DataTable('#example', {
    language: {
        info: 'Mostrando pagina _PAGE_ de _PAGES_',
        infoEmpty: 'No hay resultados disponibles',
        infoFiltered: '(filtrados desde _MAX_ resultados totales)',
        lengthMenu: ' _MENU_ Resultados por Pagina',
        zeroRecords: 'Ups! Parece que no hay nada',
        search: 'Buscar'
    }
});
</script>


</body>
</html>