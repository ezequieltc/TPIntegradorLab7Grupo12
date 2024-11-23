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
 
insert into tipossexo (descripcion) values 
('Masculino'),
('Femenino'),
('Otro');
 
 
insert into tiposcuenta (descripcion) values 
('Cuenta corriente'),
('Caja de ahorro');
 
insert into tiposmovimiento (descripcion) values 
('Deposito'),
('Pago'),
('Transferencia');



insert into usuarios (id_usuario, id_tipo_usuario, usuario, contrasena, fecha_creacion, estado) values
(1, 1, 'jose_admin', 'admin123', '2024-11-23', true),
(2, 2, 'juan_perez', 'cliente123', '2024-11-23', true),
(3, 2, 'maria_gomez', 'cliente123', '2024-11-23', true),
(4, 2, 'alex_sosa', 'cliente123', '2024-11-23', true),
(5, 2, 'ana_lopez', 'cliente123', '2024-11-23', true),
(6, 2, 'carlos_fernandez', 'cliente123', '2024-11-23', true),
(7, 2, 'taylor_diaz', 'cliente123', '2024-11-23', true),
(8, 2, 'lucia_martinez', 'cliente123', '2024-11-23', true),
(9, 2, 'santiago_rodriguez', 'cliente123', '2024-11-23', true),
(10, 2, 'isabel_gutierrez', 'cliente123', '2024-11-23', true),
(11, 2, 'diego_silva', 'cliente123', '2024-11-23', true),
(12, 2, 'jordan_torres', 'cliente123', '2024-11-23', true),
(13, 2, 'valeria_romero', 'cliente123', '2024-11-23', true),
(14, 2, 'mateo_ramos', 'cliente123', '2024-11-23', true),
(15, 2, 'alexis_navarro', 'cliente123', '2024-11-23', true),
(16, 2, 'florencia_vega', 'cliente123', '2024-11-23', true),
(17, 2, 'martin_ruiz', 'cliente123', '2024-11-23', true),
(18, 2, 'camila_molina', 'cliente123', '2024-11-23', true),
(19, 2, 'chris_farias', 'cliente123', '2024-11-23', true);

insert into personas (id_usuario, id_sexo, dni, cuil, nombre, apellido, nacionalidad, fecha_nacimiento, direccion, localidad, provincia, email, telefono, estado) values
(1, 1, '1111111', '20-12345678-0', 'Jose', 'Administrador', 'argentina', '1990-05-15', 'calle falsa 123', 'buenos aires', 'buenos aires', 'joseadministrador@email.com', '123456789', true),
(2, 1, '12345678', '20-12345678-5', 'juan', 'perez', 'argentina', '1990-05-15', 'calle falsa 123', 'buenos aires', 'buenos aires', 'juan.perez@email.com', '123456789', true),
(3, 2, '87654321', '20-87654321-1', 'maria', 'gomez', 'argentina', '1985-08-22', 'avenida siempre viva 742', 'cordoba', 'cordoba', 'maria.gomez@email.com', '987654321', true),
(4, 3, '55555555', '20-55555555-2', 'alex', 'sosa', 'argentina', '1995-12-03', 'avenida libertad 102', 'mendoza', 'mendoza', 'alex.sosa@email.com', '123987456', true),
(5, 2, '11222333', '27-11222333-3', 'Ana', 'Lopez', 'argentina', '1988-03-12', 'calle las flores 23', 'rosario', 'santa fe', 'ana.lopez@email.com', '1122334455', true),
(6, 1, '22334455', '20-22334455-4', 'Carlos', 'Fernandez', 'argentina', '1992-07-08', 'calle sol 45', 'san miguel', 'buenos aires', 'carlos.fernandez@email.com', '123987654', true),
(7, 3, '33445566', '20-33445566-6', 'Taylor', 'Diaz', 'argentina', '1994-09-17', 'calle luna 78', 'la plata', 'buenos aires', 'taylor.diaz@email.com', '129874563', true),
(8, 2, '44556677', '27-44556677-7', 'Lucia', 'Martinez', 'argentina', '1987-01-25', 'avenida verde 10', 'bariloche', 'rio negro', 'lucia.martinez@email.com', '147258369', true),
(9, 1, '55667788', '20-55667788-8', 'Santiago', 'Rodriguez', 'argentina', '1989-04-30', 'calle azul 99', 'mar del plata', 'buenos aires', 'santiago.rodriguez@email.com', '963852741', true),
(10, 2, '66778899', '27-66778899-9', 'Isabel', 'Gutierrez', 'argentina', '1993-06-15', 'avenida roja 21', 'salta', 'salta', 'isabel.gutierrez@email.com', '951753456', true),
(11, 1, '77889900', '20-77889900-0', 'Diego', 'Silva', 'argentina', '1990-02-14', 'calle gris 34', 'san juan', 'san juan', 'diego.silva@email.com', '753159846', true),
(12, 3, '88990011', '20-88990011-1', 'Jordan', 'Torres', 'argentina', '1997-11-23', 'calle blanca 56', 'neuquen', 'neuquen', 'jordan.torres@email.com', '951456789', true),
(13, 2, '99001122', '27-99001122-2', 'Valeria', 'Romero', 'argentina', '1986-05-06', 'calle rosa 78', 'tucuman', 'tucuman', 'valeria.romero@email.com', '753951486', true),
(14, 1, '10011223', '20-10011223-3', 'Mateo', 'Ramos', 'argentina', '1991-10-19', 'avenida amarilla 23', 'formosa', 'formosa', 'mateo.ramos@email.com', '456123789', true),
(15, 3, '11022334', '20-11022334-4', 'Alexis', 'Navarro', 'argentina', '1985-09-11', 'avenida marron 99', 'catamarca', 'catamarca', 'alexis.navarro@email.com', '123456741', true),
(16, 2, '12033445', '27-12033445-5', 'Florencia', 'Vega', 'argentina', '1996-08-28', 'calle celeste 89', 'corrientes', 'corrientes', 'florencia.vega@email.com', '951753123', true),
(17, 1, '13044556', '20-13044556-6', 'Martin', 'Ruiz', 'argentina', '1984-07-20', 'calle negra 65', 'resistencia', 'chaco', 'martin.ruiz@email.com', '987654321', true),
(18, 2, '14055667', '27-14055667-7', 'Camila', 'Molina', 'argentina', '1992-12-02', 'avenida dorada 32', 'parana', 'entre rios', 'camila.molina@email.com', '123789654', true),
(19, 3, '15066778', '20-15066778-8', 'Chris', 'Farias', 'argentina', '1998-03-09', 'calle plateada 55', 'ushuaia', 'tierra del fuego', 'chris.farias@email.com', '852963741', true);


insert into cuentas (id_cliente, id_tipo_cuenta, numero_cuenta, cbu, saldo, fecha_creacion, estado) values
(2, 2, '1234567890', '1234567890', 10000.00, '2024-11-23', true),
(3, 1, '1234567891', '1234567891', 5000.00, '2024-11-23', true),
(4, 2, '1234567892', '1234567892', 7500.00, '2024-11-23', true),
(5, 2, '1234567893', '1234567893', 2000.00, '2024-11-23', true),
(6, 1, '1234567894', '1234567894', 15000.00, '2024-11-23', true),
(7, 2, '1234567895', '1234567895', 12000.00, '2024-11-23', true),
(8, 1, '1234567896', '1234567896', 4500.00, '2024-11-23', true),
(9, 2, '1234567897', '1234567897', 1000.00, '2024-11-23', true),
(10, 2, '1234567898', '1234567898', 8000.00, '2024-11-23', true),
(11, 1, '1234567899', '1234567899', 5500.00, '2024-11-23', true),
(12, 2, '1234567900', '1234567900', 3000.00, '2024-11-23', true),
(13, 1, '1234567901', '1234567901', 11000.00, '2024-11-23', true),
(14, 2, '1234567902', '1234567902', 9500.00, '2024-11-23', true),
(15, 1, '1234567903', '1234567903', 7000.00, '2024-11-23', true),
(16, 2, '1234567904', '1234567904', 4000.00, '2024-11-23', true),
(17, 1, '1234567905', '1234567905', 22000.00, '2024-11-23', true),
(18, 2, '1234567906', '1234567906', 13500.00, '2024-11-23', true),
(19, 2, '1234567907', '1234567907', 8000.00, '2024-11-23', true);

INSERT INTO prestamos (id_prestamo, id_cliente, id_cuenta, fecha_alta, importe, cuota_mensual, cuotas_total, cantidad_cuotas, status_prestamo, estado) VALUES
(1,2, 1, '2024-11-23', 50000, 4166.67, 50000, 12, 'PENDIENTE', true),
(2,3, 2, '2024-11-23', 30000, 5000, 30000, 6, 'PENDIENTE', true),
(3,4, 3, '2024-11-23', 50000, 4166.67, 100000, 6, 'PENDIENTE', true);


INSERT INTO cuotas (id_prestamo, numero_cuota, importe, fecha_pago, estado) VALUES
(1, 1, 4167, '2024-12-23',true),
(1, 2, 4167, '2025-01-23',true),
(1, 3, 4167, '2025-02-23',true),
(1, 4, 4167, '2025-03-23',true),
(1, 5, 4167, '2025-04-23',true),
(1, 6, 4167, '2025-05-23',true),
(1, 7, 4167, '2025-06-23',true),
(1, 8, 4167, '2025-07-23',true),
(1, 9, 4167, '2025-08-23',true),
(1, 10, 4167, '2025-09-23',true),
(1, 11, 4167, '2025-10-23',true),
(1, 12, 4167, '2025-11-23',true),
(2, 1, 5000, '2024-12-23',true),
(2, 2, 5000, '2024-01-23',true),
(2, 3, 5000, '2024-02-23',true),
(2, 4, 5000, '2024-03-23',true),
(2, 5, 5000, '2024-04-23',true),
(2, 6, 5000, '2024-05-23',true);







