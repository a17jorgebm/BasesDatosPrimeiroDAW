drop database if exists nominas;
create database nominas;

use nominas;

create table empleado (
	codigo		integer(5),
	nombre		varchar(30) not null,
	hijos		integer(2) not null,
	retencion	integer(2) not null,
	cuenta		char(20) not null unique,
	primary key (codigo));
    
create table departamento (
	codigo		integer(5),
	nombre		varchar(20) not null unique,
	primary key (codigo));
    
create table trabajan (
	cod_emp		integer(5),
	cod_dep		integer(5),
	funcion		varchar(30) not null,
	primary key (cod_emp, cod_dep),
	foreign key (cod_emp) references empleado(codigo),
	foreign key (cod_dep) references departamento(codigo));
    
create table just_nomina (
	mes		integer(2),
	ejercicio	integer(4),
	ingreso		integer(8) not null,
	descuento	integer(8) not null,
	cod_emp		integer(8),
	primary key (mes, ejercicio, cod_emp),
	foreign key (cod_emp) references empleado(codigo));
    
create table linea (
	numero	integer(5),
	cantidad	integer(8) not null,
	base		integer(8),
	porcentaje	integer(2),
	mes		integer(2),
	ejercicio	integer(4),
	cod_emp	integer(5),
	primary key (numero, mes, ejercicio, cod_emp),
	foreign key (mes, ejercicio, cod_emp) references just_nomina(mes, ejercicio, cod_emp));
    
    
insert into empleado values (00011, 'Juan Ignacio Martinez', 0, 10, '12341234121234567890');
insert into empleado values (00001, 'José Luis Pérez', 2, 12, '12342233121122334455');
insert into empleado values (02341, 'Fernando Romero Días', 1, 8, '21341234560987654321');
insert into empleado values (11223, 'Manuel Lopez Marín', 0, 10, '55443322110099887766');
insert into empleado values (67890, 'Alfonso Gutierrez Lopez', 1, 12, '12563478001234567890');
insert into empleado values (00111, 'Encarna Lopez Lopez', 0, 10, '99118822773344665500');
insert into empleado values (02031, 'Ines Montero Zafra', 1, 8, '42341534129234567890');
insert into empleado values (09876, 'Rosa Lorite Lopez', 0, 10, '52341234521214567890');
insert into empleado values (96352, 'Lola Martinez Contreras', 1, 11, '22341224121224567820');
insert into empleado values (76543, 'Francisca Colate Gonzalez', 3, 7, '12343234121334567893');
insert into empleado values (73152, 'María Pascual Rojo', 3, 7, '12351234151234567590');
insert into empleado values (64738, 'Andrés Morales Martín', 3, 7, '22341154116231563690');


insert into departamento values (00001, 'Ventas');
insert into departamento values (00002, 'Compras');
insert into departamento values (00003, 'Marketing');
insert into departamento values (00004, 'Recursos Humanos');
insert into departamento values (00005, 'Administración');
insert into departamento values (00006, 'Dirección');


insert into trabajan values (00001, 00001, 'Vendedor');
insert into trabajan values (00001, 00003, 'Diseñador');
insert into trabajan values (02341, 00005, 'Administrativo');
insert into trabajan values (11223, 00006, 'Asesor Dirección');
insert into trabajan values (11223, 00005, 'Administrativo');
insert into trabajan values (11223, 00004, 'Selección de Personal');
insert into trabajan values (67890, 00002, 'Gestor de compras');
insert into trabajan values (00111, 00001, 'Vendedor');
insert into trabajan values (02031, 00001, 'Vendedor');
insert into trabajan values (09876, 00006, 'Director');
insert into trabajan values (96352, 00003, 'Publicista');
insert into trabajan values (96352, 00004, 'Encuestador');
insert into trabajan values (96352, 00005, 'Secretaria de Dirección');
insert into trabajan values (76543, 00001, 'Vendedor');
insert into trabajan values (73152, 00005, 'Administrativo');
insert into trabajan values (73152, 00003, 'Publicista');
insert into trabajan values (64738, 00001, 'Vendedor');
insert into trabajan values (64738, 00004, 'Selección de Personal');
insert into trabajan values (64738, 00002, 'Gestor de compras');
insert into trabajan values (64738, 00003, 'Diseñador');


insert into just_nomina values (10, 2006, 1200, 200, 00001);
insert into just_nomina values (11, 2006, 1200, 200, 00001);
insert into just_nomina values (12, 2006, 1200, 200, 00001);
insert into just_nomina values (01, 2007, 1200, 200, 00001);
insert into just_nomina values (10, 2006, 1500, 300, 02341);
insert into just_nomina values (11, 2006, 1500, 300, 02341);
insert into just_nomina values (12, 2006, 1500, 300, 02341);
insert into just_nomina values (01, 2007, 1500, 300, 02341);
insert into just_nomina values (10, 2006, 1000, 100, 11223);
insert into just_nomina values (11, 2006, 1000, 100, 11223);
insert into just_nomina values (12, 2006, 1000, 100, 11223);
insert into just_nomina values (01, 2007, 1000, 100, 11223);
insert into just_nomina values (10, 2006, 1200, 200, 67890);
insert into just_nomina values (11, 2006, 1200, 200, 67890);
insert into just_nomina values (12, 2006, 1200, 200, 67890);
insert into just_nomina values (01, 2007, 1200, 200, 67890);
insert into just_nomina values (10, 2006, 1200, 200, 00111);
insert into just_nomina values (11, 2006, 1200, 200, 00111);
insert into just_nomina values (12, 2006, 1200, 200, 00111);
insert into just_nomina values (01, 2007, 1200, 200, 00111);
insert into just_nomina values (10, 2006, 1200, 200, 02031);
insert into just_nomina values (11, 2006, 1200, 200, 02031);
insert into just_nomina values (12, 2006, 1200, 200, 02031);
insert into just_nomina values (01, 2007, 1200, 200, 02031);
insert into just_nomina values (10, 2006, 1200, 200, 09876);
insert into just_nomina values (11, 2006, 1200, 200, 09876);
insert into just_nomina values (12, 2006, 1200, 200, 09876);
insert into just_nomina values (01, 2007, 1200, 200, 09876);
insert into just_nomina values (10, 2006, 1200, 200, 96352);
insert into just_nomina values (11, 2006, 1200, 200, 96352);
insert into just_nomina values (12, 2006, 1200, 200, 96352);
insert into just_nomina values (01, 2007, 1200, 200, 96352);
insert into just_nomina values (10, 2006, 1200, 200, 76543);
insert into just_nomina values (11, 2006, 1200, 200, 76543);
insert into just_nomina values (12, 2006, 1200, 200, 76543);
insert into just_nomina values (01, 2007, 1200, 200, 76543);
insert into just_nomina values (10, 2006, 1200, 200, 73152);
insert into just_nomina values (11, 2006, 1200, 200, 73152);
insert into just_nomina values (12, 2006, 1200, 200, 73152);
insert into just_nomina values (01, 2007, 1200, 200, 73152);
insert into just_nomina values (10, 2006, 1200, 200, 64738);
insert into just_nomina values (11, 2006, 1200, 200, 64738);
insert into just_nomina values (12, 2006, 1200, 200, 64738);
insert into just_nomina values (01, 2007, 1200, 200, 64738);


insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 00001);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 00001);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 00001);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 00001);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 00001);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 00001);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 00001);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 00001);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 02341);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 02341);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 02341);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 02341);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 02341);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 02341);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 02341);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 02341);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 11223);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 11223);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 11223);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 11223);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 11223);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 11223);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 11223);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 11223);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 67890);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 67890);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 67890);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 67890);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 67890);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 67890);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 67890);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 67890);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 00111);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 00111);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 00111);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 00111);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 00111);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 00111);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 00111);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 00111);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 02031);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 02031);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 02031);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 02031);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 02031);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 02031);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 02031);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 02031);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 09876);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 09876);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 09876);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 09876);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 09876);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 09876);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 09876);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 09876);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 96352);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 96352);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 96352);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 96352);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 96352);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 96352);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 96352);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 96352);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 76543);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 76543);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 76543);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 76543);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 76543);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 76543);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 76543);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 76543);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 73152);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 73152);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 73152);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 73152);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 73152);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 73152);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 73152);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 73152);
insert into linea values (00001, 1200, NULL, NULL, 10, 2006, 64738);
insert into linea values (00002, -200, 1200, 10, 10, 2006, 64738);
insert into linea values (00001, 1200, NULL, NULL, 11, 2006, 64738);
insert into linea values (00002, -200, 1200, 10, 11, 2006, 64738);
insert into linea values (00001, 1200, NULL, NULL, 12, 2006, 64738);
insert into linea values (00002, -200, 1200, 10, 12, 2006, 64738);
insert into linea values (00001, 1200, NULL, NULL, 01, 2007, 64738);
insert into linea values (00002, -200, 1200, 10, 01, 2007, 64738);


alter table empleado add fnacimiento date;

update empleado set fnacimiento = '1960-02-01' where codigo = 00011;
update empleado set fnacimiento = '1964-04-12' where codigo = 00001;
update empleado set fnacimiento = '1955-09-25' where codigo = 02341;
update empleado set fnacimiento = '1963-12-13' where codigo = 11223;
update empleado set fnacimiento = '1967-11-05' where codigo = 67890;
update empleado set fnacimiento = '1968-03-15' where codigo = 00111;
update empleado set fnacimiento = '1972-02-22' where codigo = 02031;
update empleado set fnacimiento = '1975-08-18' where codigo = 09876;
update empleado set fnacimiento = '1975-03-09' where codigo = 96352;
update empleado set fnacimiento = '1969-03-02' where codigo = 76543;
update empleado set fnacimiento = '1973-12-09' where codigo = 73152;
update empleado set fnacimiento = '1964-01-20' where codigo = 64738;