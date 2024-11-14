<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BancArg - Login</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
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

      #boxLogin h3 {
      	color: #007bff;
      	font-weight: bold;
      	text-align: center;
      	margin-bottom: 15px;
      }
      #boxLogin a {
      	margin: 35px 0px 0px 175px;
      	text-decoration: none;
      }
      #boxLogin {
      	width: 500px;
      	height:350px;
      	margin: auto;
      	margin-top: 120px;
      	border-radius: 12px;
      	background-color: #e8e9eb;
      	padding-top: 35px;
		box-shadow: 0px 0px 20px 4px rgba(0, 0, 0, 0.3);
      }
      .form-floating {
      	height: 60px;
      	margin: auto;
      }
      .btn{
      	margin: 35px 0px 0px 170px;
      	width: 180px;
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
    </div>

    <div class="header-bar">

    </div>

    <div class="content">
		<div id="boxLogin">
			<h3>Inicio de Sesión</h3>
			<form action="SvLogin" method="post">
				<div class="form-floating col-8 mb-4">
				  <input name="user" type="email" class="form-control" id="floatingInput" placeholder="nombre@mail.com">
				  <label for="floatingInput">Usuario</label>
				</div>
				<div class="form-floating col-8">
				  <input name="pass" type="password" class="form-control" id="floatingPassword" placeholder="Password">
				  <label for="floatingPassword">Password</label>
				</div>
				<button type="submit" class="btn btn-primary">Acceder</button>
				<br><br>
				<a href="">¿Olvido su contraseña?</a>
			</form>
		</div>

    </div>

    <footer>
      <p>&copy; 2024 BancArg. Todos los derechos reservados.</p>
    </footer>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>