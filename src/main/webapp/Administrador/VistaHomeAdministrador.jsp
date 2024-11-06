<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>BancArg - Home Administrador</title>
  	<link rel="stylesheet" type="text/css" href="../css/layout.css" />
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" 
  	rel="stylesheet">
    <style>
      body {
        background-color: #e0f0ff;
        margin: 0;
      }
      .sidebar {
        background-color: #007bff;
        height: 100vh;
        padding-top: 20px;
        color: white;
        position: fixed;
        width: 200px;
      }
      .sidebar a {
        color: white;
        text-decoration: none;
        font-size: 1.2em;
        padding: 10px;
        display: block;
      }
      .sidebar a:hover {
        background-color: #0056b3;
      }
      .content {
        margin-left: 200px;
        padding: 20px;
      }
      .header-bar {
        background-color: #007bff;
        padding: 10px 20px;
        color: white;
        font-size: 1.2em;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-left: 200px;
      }
      footer {
        text-align: center;
        color: #666;
        padding: 10px;
        background-color: #f8f9fa;
        width: 100%;
        position: absolute;
        bottom: 0;
        left: 0;
      }
    </style>
  </head>
  <body>
    <div class="sidebar">
      <h2 class="text-center">BancArg</h2>
      <a href="#">Alta Usuarios</a>
      <a href="#">Alta Cuentas</a>
      <a href="#">Autorizacion Prestamos</a>
      <a href="#">Informes/Reportes</a>
    </div>

    <div class="header-bar">
      <div>BancArg - Home Administrador</div>
      <div>Usuario: Admin</div>
    </div>

    <div class="content">
      <h3 class="text-center">Usted es un usuario Administrador</h3>
    </div>

    <footer>
      <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
    </footer>
  </body>
</html>
