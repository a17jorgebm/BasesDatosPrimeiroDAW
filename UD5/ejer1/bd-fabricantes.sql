-- Creación de la base de datos fabricantes
create database if not exists fabricantes
	default character set utf8
	default collate utf8_spanish_ci;

-- Usamos la base de datos
use fabricantes;

-- Borramos la tabla fabricante si ya existía, porque sino nos dará un error
drop table if exists fabricante;

-- Creamos la tabla fabricante
create table fabricante (
	idFabricante char(5) not null,
	nombre varchar(80) not null,
	primary key (idFabricante)
);