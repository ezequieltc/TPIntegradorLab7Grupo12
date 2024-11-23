<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Dominio.Cuenta"%>
<%@page import="Dominio.Persona"%>
<!DOCTYPE html>
<html>
  <%
    request.setAttribute("pageTitle", "Nueva Transferencia");

    Integer paso = (Integer) request.getSession().getAttribute("paso");
    if (paso == null) {
      paso = 1;
    }
    Cuenta cuentaDestino = (Cuenta) request.getSession().getAttribute("cuentaDestino");
    ArrayList<Cuenta> cuentasCliente = (ArrayList<Cuenta>) request.getSession().getAttribute("cuentasCliente");

    // remove session attributes
    request.getSession().removeAttribute("cuentaDestino");
    request.getSession().removeAttribute("cuentasCliente");
    request.getSession().removeAttribute("paso");
  %>
<head>

	<%@include  file="../../components/header.jsp"%>

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

      #amountError, #accountError {
        color: red;
        font-size: 0.875em;
        margin-top: 5px;
        display: block;
      }
      .is-invalid {
        border-color: red;
        background-color: #ffe6e6;
      }
  </style>

</head>
<body>
<%@include  file="../../components/pre-body.jsp"%>

<h2 class="my-4">Nueva Transferencia</h2>
<div id="transferForm" class="w-100">
  <div class="step step-1">
    <h4>Paso 1: Ingrese CBU</h4>
    <form action="${pageContext.request.contextPath}/Usuarios/Transferencias/NuevaTransferencia/SvBuscarCuenta" method="post">
      <div class="form-group">
        <label for="cbuDestino">CBU de Cuenta Destino</label>
        <input type="text" name="cbuDestino" id="cbuDestino" class="form-control" placeholder="Ingrese CBU de Cuenta Destino">
      </div>
      <div class="step-actions">
        <button type="submit" class="btn btn-primary mt-3" id="nextStep1">Siguiente</button>
      </div>
    </form>
  </div>

  <div class="step step-2 d-none">
    <h4>Paso 2: Detalle del Beneficiario</h4>
    <div class="beneficiary-details card p-4 mb-4">
    <% if (cuentaDestino != null) { %>
      <p><strong>Cuenta:</strong> <span id="accountNumber"><%=cuentaDestino.getNumeroCuenta()%></span></p>
      <p><strong>CBU:</strong> <span id="accountCBU"><%=cuentaDestino.getCbu()%></span></p>
      <p><strong>Tipo de Cuenta:</strong> <span id="accountType"><%=cuentaDestino.getTipoCuenta().getDescripcion()%></span></p>
      <p><strong>Nombre del titular:</strong> <span id="accountHolderName"><%=cuentaDestino.getPersona().getNombre()%> <%=cuentaDestino.getPersona().getApellido()%></span></p>
      <% } else { %>
      <p><strong>Cuenta:</strong> Sin cuenta</p>
      <p><strong>CBU:</strong> Sin CBU</p>
      <p><strong>Tipo de Cuenta:</strong> Sin tipo de cuenta</p>
      <p><strong>Nombre del titular:</strong> Sin nombre</p>
      <% } %>
    </div>
    <div class="step-actions">
      <button type="button" class="btn btn-secondary" id="prevStep2">Anterior</button>
      <button type="button" class="btn btn-primary" id="nextStep2">Siguiente</button>
    </div>
  </div>

  <div class="step step-3 d-none">
    <h4>Paso 3: Monto y Cuenta de Origen</h4>
    <form action="${pageContext.request.contextPath}/Usuarios/Transferencias/NuevaTransferencia/SvConfirmarTransferencia" method="post">
    <% if (cuentaDestino != null) { %>
      <input type="hidden" name="cbuDestino" id="cbuDestino" value="<%= cuentaDestino.getCbu() %>">
      <% } %>
      <div class="form-group">
       <label for="amount">Monto a Transferir</label>
        <input type="number" id="amount" name="amount" class="form-control" placeholder="Ingrese el monto">
        <span id="amountError"></span>
      </div>
      <div class="form-group">
        <label for="sourceAccount">Cuenta de Origen</label>
        <select id="sourceAccount" name="sourceAccount" class="form-control">
          <%-- <option value="1234567890">Caja de Ahorro - $25,000.00</option> --%>
          <%-- <option value="0987654321">Cuenta Corriente - $10,000.00</option> --%>
          <% 
          if (cuentasCliente != null) {
          for (Cuenta cuenta : cuentasCliente){%>
            <option  value="<%= cuenta.getNumeroCuenta() %>" data-saldo="<%= cuenta.getSaldo() %>">Cuenta <%= cuenta.getNumeroCuenta() %> - <%= cuenta.getTipoCuenta().getDescripcion() %> - <%= cuenta.getSaldo() %></option>         	              	
          <% 
          }}%>
        </select>
        <span id="accountError"></span>
      </div>
      <div class="step-actions">
        <button type="button" class="btn btn-secondary" id="prevStep3">Anterior</button>
        <button type="submit" class="btn btn-success" id="confirmTransfer">Confirmar Transferencia</button>
      </div>
    </form>
  </div>
</div>

<%@include  file="../../components/post-body.jsp"%>
<script>

  var paso = <%= paso %>

  if (paso == 1) {
    document.querySelector('.step-1').classList.remove('d-none');
    document.querySelector('.step-2').classList.add('d-none');
    document.querySelector('.step-3').classList.add('d-none');
  }

  if (paso == 2) {
    document.querySelector('.step-1').classList.add('d-none');
    document.querySelector('.step-2').classList.remove('d-none');
    document.querySelector('.step-3').classList.add('d-none');
  }

  if (paso == 3) {
    document.querySelector('.step-1').classList.add('d-none');
    document.querySelector('.step-2').classList.add('d-none');
    document.querySelector('.step-3').classList.remove('d-none');
  }


  document.getElementById('prevStep2').addEventListener('click', function() {
    document.querySelector('.step-2').classList.add('d-none');
    document.querySelector('.step-1').classList.remove('d-none');
  });

  document.getElementById('nextStep2').addEventListener('click', function() {
    document.querySelector('.step-2').classList.add('d-none');
    document.querySelector('.step-3').classList.remove('d-none');
  });

  document.getElementById('prevStep3').addEventListener('click', function() {
    document.querySelector('.step-3').classList.add('d-none');
    document.querySelector('.step-2').classList.remove('d-none');
  });

document.getElementById("confirmTransfer").addEventListener("click", function (event) {
  event.preventDefault(); // Evita el envío del formulario por defecto

  const amountInput = document.getElementById("amount");
  const amountValue = parseFloat(amountInput.value.trim());
  const errorAmount = document.getElementById("amountError");

  const accountSelect = document.getElementById("sourceAccount");
  const selectedAccount = accountSelect.value; // Número de cuenta seleccionada
  const errorAccount = document.getElementById("accountError");

  const destinationAccountNumber = document.getElementById("accountNumber").textContent.trim(); // Número de cuenta destino

  let isValid = true;

  // Validar monto
  if (isNaN(amountValue) || amountValue <= 0 || !/^[0-9]+(\.[0-9]{1,2})?$/.test(amountValue)) {
    errorAmount.textContent = "El monto debe ser mayor que 0 y con hasta 2 decimales.";
    amountInput.classList.add("is-invalid");
    isValid = false;
  } else {
    errorAmount.textContent = "";
    amountInput.classList.remove("is-invalid");
  }

  // Validar cuenta seleccionada
  if (!selectedAccount) {
    errorAccount.textContent = "Debe seleccionar una cuenta de origen.";
    accountSelect.classList.add("is-invalid");
    isValid = false;
  } else {
    errorAccount.textContent = "";
    accountSelect.classList.remove("is-invalid");

    // Validar que no sea la misma cuenta de destino
    if (destinationAccountNumber === selectedAccount) {
      errorAccount.textContent = "La cuenta de origen no puede ser la misma que la cuenta de destino.";
      accountSelect.classList.add("is-invalid");
      isValid = false;
    } else {
      errorAccount.textContent = "";
      accountSelect.classList.remove("is-invalid");

      // Validar saldo de la cuenta seleccionada
      const selectedOption = accountSelect.options[accountSelect.selectedIndex];
      const saldoAttribute = selectedOption.getAttribute("data-saldo");
      const saldoCuenta = parseFloat(saldoAttribute);
      
      console.log(selectedOption, saldoAttribute, saldoCuenta, accountSelect)

      if (saldoCuenta < amountValue) {
        errorAccount.textContent = "El saldo de la cuenta seleccionada no es suficiente.";
        accountSelect.classList.add("is-invalid");
        isValid = false;
      } else {
        errorAccount.textContent = "";
        accountSelect.classList.remove("is-invalid");
      }
    }
  }

  // Si todo es válido, enviar el formulario
  if (isValid) {
    amountInput.closest("form").submit();
  }
});
</script>


</body>
</html>