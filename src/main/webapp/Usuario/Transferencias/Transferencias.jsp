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
	  .btn {
	  margin-top: 25px;
	  	float: right;
	  }
      .transferForm {
          height: calc(100% - 100px);
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
    <h2 class="my-4">Historial de Transferencias</h2>
    <a href="NuevaTransferencia.jsp" class="btn btn-primary">Nueva transferencia</a>

	<table id="example" class="display" style="width:85%">
        <thead>
            <tr>
                <th>Fecha</th>
                <th>Destinatario</th>
                <th>importe</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>2011-04-25</td>
                <td>Tiger Nixon</td>
                <td>$320,800</td>
            </tr>
            <tr>
                <td>2011-07-25</td>
                <td>Garrett Winters</td>
                <td>$170,750</td>
            </tr>
            <tr>
                <td>2009-01-12</td>
                <td>Ashton Cox</td>
                <td>$86,000</td>
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