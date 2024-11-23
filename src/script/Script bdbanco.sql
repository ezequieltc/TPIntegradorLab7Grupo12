create schema dbbanco;
 
use dbbanco;
 
create table tiposusuario
(
id_tipo_usuario int primary key not null auto_increment,
descripcion VARCHAR(30)
);
 
create table usuarios
(
id_usuario int primary key not null auto_increment,
id_tipo_usuario int not null,
usuario varchar(30) unique not null,
contrasena varchar(25) not null,
fecha_creacion date not null,
estado boolean not null,
constraint foreign key(id_tipo_usuario) references tiposusuario(id_tipo_usuario)
);
 
create table tipossexo
(
id_sexo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
descripcion VARCHAR(30) not null
);
 
create table personas
(
id_persona int primary key not null auto_increment,
id_usuario int not null,
id_sexo int not null,
dni varchar(10) unique not null,
cuil varchar(15) unique not null,
nombre varchar(40) not null,
apellido varchar(40) not null,
nacionalidad varchar(40) not null,
fecha_nacimiento date not null,
direccion varchar(100) not null,
localidad varchar(50) not null,
provincia varchar(25) not null,
email varchar(50) unique,
telefono varchar(20) not null,
estado boolean not null,
constraint foreign key(id_usuario) references usuarios(id_usuario),
constraint foreign key(id_sexo) references tipossexo(id_sexo)
);
 
create table tiposcuenta(
id_tipo_cuenta int primary key not null auto_increment,
descripcion varchar(30) not null
);
 
create table cuentas
(
id_cuenta int primary key not null auto_increment,
id_cliente int not null,
id_tipo_cuenta int not null,
numero_cuenta varchar(50) not null,
cbu varchar(24) unique not null,
saldo decimal not null CHECK (saldo >= 0),
fecha_creacion date not null,
estado boolean not null,
constraint foreign key(id_cliente) references usuarios(id_usuario),
constraint foreign key(id_tipo_cuenta) references tiposcuenta(id_tipo_cuenta)
);
 
create table tiposmovimiento
(
id_tipo_movimiento int primary key not null auto_increment,
descripcion varchar(40) not null
);
 
create table movimientos
(
id_movimiento int not null primary key auto_increment,
id_cuenta int not null,
id_tipo_movimiento int not null,
fecha date not null,
detalle varchar(100) not null,
importe decimal not null,
estado boolean not null,
constraint foreign key(id_cuenta) references cuentas(id_cuenta),
constraint foreign key(id_tipo_movimiento) references tiposmovimiento(id_tipo_movimiento)
);
 
 
create table transferencias
(
id_transferencia int primary key not null auto_increment,
id_movimiento_origen int not null,
id_movimiento_destino int not null,
constraint foreign key(id_movimiento_origen) references movimientos(id_movimiento),
constraint foreign key(id_movimiento_destino) references movimientos(id_movimiento)
);
 
create table  prestamos
(
id_prestamo int primary key not null auto_increment,
id_cliente int not null,
id_cuenta int not null,
fecha_alta date not null,
importe decimal not null,
cuota_mensual decimal not null,
cuotas_total decimal not null,
cantidad_cuotas int not null,
status_prestamo ENUM('PAGO', 'PENDIENTE', 'DEUDA', 'RECHAZADO', 'EN_CURSO') NOT NULL,
estado boolean not null,
constraint foreign key(id_cliente) references personas(id_usuario),
constraint foreign key(id_cuenta) references cuentas(id_cuenta)
);
 
create table cuotas
(
id_cuota int primary key not null auto_increment,
id_prestamo int not null,
numero_cuota int not null,
importe decimal not null,
fecha_pago date not null,
estado boolean not null,
constraint foreign key(id_prestamo) references prestamos(id_prestamo)
);
 
CREATE OR REPLACE VIEW VW_Prestamos AS
SELECT Pres.id_Prestamo, P.id_persona, P.id_usuario, P.nombre, P.apellido, P.dni, P.cuil, C.id_cuenta, C.numero_cuenta, C.cbu, TC.descripcion,  
C.saldo, Pres.importe, Pres.cuotas_total, Pres.cuota_mensual, Pres.cantidad_cuotas, Pres.fecha_alta, Pres.status_prestamo, Pres.estado from Prestamos Pres
INNER JOIN personas P on P.id_usuario = Pres.id_cliente
INNER JOIN cuentas C on C.id_cuenta = Pres.id_cuenta
INNER JOIN usuarios U on U.id_usuario = P.id_usuario
INNER JOIN tiposcuenta TC on TC.id_tipo_cuenta = C.id_tipo_cuenta;
 
use dbbanco;
 
insert into tiposusuario (descripcion) values 
('Administrador'),
('Cliente');
 
insert into usuarios (id_tipo_usuario, usuario, contrasena, fecha_creacion, estado) values 
(1, 'admin', 'admin123', '2024-01-01', true),
(2, 'cliente1', 'cliente123', '2024-02-01', true),
(2, 'cliente2', 'cliente456', '2024-02-10', true),
(2, 'empleado1', 'empleado123', '2024-01-15', true);
 
insert into tipossexo (descripcion) values 
('Masculino'),
('Femenino'),
('Otro');
 
insert into personas (id_usuario, id_sexo, dni, cuil, nombre, apellido, nacionalidad, fecha_nacimiento, direccion, localidad, provincia, email, telefono, estado) values 
(1, 1, '1111111', '20-12345678-0', 'Jose', 'Administrador', 'argentina', '1990-05-15', 'calle falsa 123', 'buenos aires', 'buenos aires', 'joseadministrador@email.com', '123456789', true),
(2, 1, '12345678', '20-12345678-5', 'juan', 'perez', 'argentina', '1990-05-15', 'calle falsa 123', 'buenos aires', 'buenos aires', 'juan.perez@email.com', '123456789', true),
(3, 2, '87654321', '20-87654321-1', 'maria', 'gomez', 'argentina', '1985-08-22', 'avenida siempre viva 742', 'cordoba', 'cordoba', 'maria.gomez@email.com', '987654321', true),
(4, 3, '55555555', '20-55555555-2', 'alex', 'sosa', 'argentina', '1995-12-03', 'avenida libertad 102', 'mendoza', 'mendoza', 'alex.sosa@email.com', '123987456', true);
 
insert into tiposcuenta (descripcion) values 
('Cuenta corriente'),
('Caja de ahorro');
 
insert into cuentas (id_cliente, id_tipo_cuenta, numero_cuenta, cbu, saldo, fecha_creacion, estado) values 
(2, 2, '1234567890', '0001234567890123456789', 10000.00, '2024-02-01', true),
(3, 1, '1234567891', '0001234567890123456788', 5000.00, '2024-02-02', true),
(4, 2, '1234567892', '0001234567890123456787', 7500.00, '2024-02-03', true);
 
insert into tiposmovimiento (descripcion) values 
('Deposito'),
('Pago'),
('Transferencia recibida'),
('Transferencia enviada');
 
insert into movimientos (id_cuenta, id_tipo_movimiento, fecha, detalle, importe, estado) values 
(1, 1, '2024-02-05', 'deposito inicial', 1000.00, true),
(1, 2, '2024-02-10', 'retiro en cajero', 500.00, true),
(2, 3, '2024-02-12', 'transferencia recibida', 2000.00, true),
(2, 4, '2024-02-14', 'transferencia enviada', 1500.00, true),
(3, 1, '2024-03-01', 'deposito ahorro', 3000.00, true);
 
insert into transferencias (cuenta_origen, cuenta_destino, importe, fecha, estado) values 
(1, 2, 200.00, '2024-02-15', true),
(2, 3, 300.00, '2024-03-01', true),
(3, 1, 500.00, '2024-03-05', true);
 
insert into transferencias_x_cuenta (id_transferencia, id_cuenta) values 
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 3),
(3, 1);
 
insert into prestamos (id_cliente, id_cuenta, fecha_alta, importe, cuota_mensual, cuotas_total, cantidad_cuotas, status_prestamo, estado) values 
(2, 1, '2024-03-01', 5000.00, 450.00, 0, 12, "EN_CURSO", true),
(3, 2, '2024-03-05', 10000.00, 900.00, 0, 12 , "EN_CURSO", true),
(4, 3, '2024-03-10', 20000.00, 1800.00, 0, 12, "EN_CURSO", true);

 
insert into cuotas (id_prestamo, numero_cuota, importe, fecha_pago, estado) values 
(1, 1, 450.00, '2024-04-01', true),
(1, 2, 450.00, '2024-05-01', true),
(2, 1, 900.00, '2024-04-05', true),
(2, 2, 900.00, '2024-05-05', true),
(3, 1, 1800.00, '2024-04-10', true),
(3, 2, 1800.00, '2024-05-10', true);