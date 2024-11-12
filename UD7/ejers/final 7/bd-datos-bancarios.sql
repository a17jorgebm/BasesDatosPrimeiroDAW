drop database if exists datos_bancarios;
create database datos_bancarios;

use datos_bancarios;

create table cliente (
	id int primary key auto_increment,
    nombre varchar(100)
);

insert into cliente(nombre) values ('Jorge'), ('Alicia');

create table cuenta (
	numero varchar(5) primary key,
    id_cliente int,
	saldo decimal(10,3),
	foreign key (id_cliente) references cliente(id)
);

insert into cuenta values ('ES111', 1, 1000), ('ES222', 2, 2000);

create table registro_movimientos (
	id_cliente int not null,
    numero_cuenta varchar(5) not null,
    operacion enum('INGRESO', 'RETIRO') not null, # Tipo de operacion
    fecha datetime not null,
    cantidad decimal(10,3) not null, # Cantidad transferida
    saldo_antiguo decimal(10,3) not null, # Saldo antes de la operación
    saldo_nuevo decimal(10,3) not null, # Saldo después de la operación
    primary key (id_cliente, numero_cuenta, fecha),
    foreign key (id_cliente) references cliente(id),
    foreign key (numero_cuenta) references cuenta(numero)
);