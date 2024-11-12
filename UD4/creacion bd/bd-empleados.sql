/* 	Deshabilitamos temporalmente la comprobación de referencias en las foreign keys
	para que no nos dé error al crear la columna 'dni_jefe' de la tabla 'empleado'.
    Si no lo hacemos daría un error, porque estamos haciendo referencia a la tabla empleado
    cuando todavía no está creada.
*/
SET @@foreign_key_checks = 0;

-- Creamos la BD
DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados;
USE empleados;

-- Creamos la tabla PROVINCIA e insertamos varios datos de ejemplo
CREATE TABLE provincia (
  id SMALLINT AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(45) NOT NULL
);

INSERT INTO provincia(nombre)
VALUES 	('Albacete'), ('Alicante'), ('Almería'), ('Álava'), ('Asturias'),
		('Ávila'), ('Badajoz'), ('Islas Baleares'), ('Barcelona'), ('Bizkaia'),
		('Burgos'), ('Cáceres'), ('Cádiz'), ('Cantabria'), ('Castellón'), ('Ceuta'),
		('Ciudad Real'), ('Córdoba'), ('A Coruña'), ('Cuenca'), ('Gipuzkoa'),
		('Girona'), ('Granada'), ('Guadalajara'), ('Huelva'), ('Huesca'),
		('Jaén'), ('León'), ('Lugo'), ('Lleida'), ('Madrid'),
		('Málaga'), ('Melilla'), ('Murcia'), ('Navarra'), ('Ourense'),
		('Palencia'), ('Las Palmas'), ('Pontevedra'), ('La Rioja'), ('Salamanca'),
		('Santa Cruz de Tenerife'), ('Segovia'), ('Sevilla'), ('Soria'), ('Tarragona'),
		('Teruel'), ('Toledo'), ('Valencia'), ('Valladolid'), ('Zamora'), ('Zaragoza');

-- Creamos la tabla DEPARTAMENTO e insertamos varios datos de ejemplo
CREATE TABLE departamento (
  codigo TINYINT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(45) NOT NULL,
  tipo ENUM('H','B','A') NOT NULL,
  ciudad VARCHAR(45) NOT NULL,
  id_provincia SMALLINT NOT NULL,
   CONSTRAINT fk_departamento_provincia FOREIGN KEY (id_provincia) REFERENCES provincia(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO departamento (nombre, tipo, ciudad, id_provincia)
VALUES 	('Central','H','Lugo',29),
		('Oficina1','H','Monforte',29),
		('Oficina2','B','Ferrol',19),
		('Oficina3','H','Vigo',39),
		('Oficina4','A','Ourense',36),
		('Oficina5','A','Villalba',29),
		('Oficina6','H','Ourense',36),
		('Oficina7','H','Lugo',29),
		('Oficina8','A','Coruña',19),
		('Oficina9','B','Villalba',29);


-- Creamos la tabla EMPLEADO e insertamos varios datos de ejemplo
CREATE TABLE empleado (
  dni CHAR(9) PRIMARY KEY,
  apellidos VARCHAR(100) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  cod_departamento TINYINT,
  salario_bruto DECIMAL(10, 2),
  dni_jefe CHAR(9),
  CONSTRAINT fk_empleado_departamento FOREIGN KEY (cod_departamento) REFERENCES departamento(codigo) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_empleado_jefe FOREIGN KEY (dni_jefe) REFERENCES empleado(dni) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO empleado(dni, apellidos, nombre, cod_departamento, salario_bruto, dni_jefe)
VALUES 	('11111111A','Case Rodriguez','Fernanda',4,35520.00,'44444444D'),
		('22222222B','Martinez Iglesias','Benito',1,25000.00,'44444444D'),
		('33333333C','Nuñez Bernardez','Antonia',2,42000.00,'77777777G'),
		('44444444D','Fernandez Lopez','Jose Luis',1,160000.00,NULL),
		('55555555E','Ruiz Macias','Dario',10,32000.00, NULL),
		('66666666F','Hernandez Valin','Valentina',3,26000.00,'55555555E'),
		('77777777G','Martinez Diaz','Carlos',2,31500.00, NULL),
		('88888888H','Iglesias Dominguez','Adolfo',NULL,52500.00,'55555555E'),
		('99999999I','Villar Bernal','Teolindo',5,17500.00,'44444444D');

-- Creamos la tabla IRPF e insertamos varios datos de ejemplo
CREATE TABLE irpf (
	limite_inferior DECIMAL(10, 2) NOT NULL,
	limite_superior DECIMAL(10, 2) NOT NULL,
    tipo_impuesto DECIMAL(4, 2) PRIMARY KEY
);

INSERT INTO irpf(limite_inferior, limite_superior, tipo_impuesto)
VALUES 	(0.00,17707.00,15.75),
		(17707.00,33007.00,21.00),
		(33007.00,53407.00,27.00),
		(53407.00,120000.00,30.00),
		(120000.00,175000.00,35.00),
		(175000.00,300000.00,42.00),
		(300000.00,99999999.99,55.00);
 
-- Habilitamos de nuevo la comprobación de foreign keys
SET @@foreign_key_checks = 1;
