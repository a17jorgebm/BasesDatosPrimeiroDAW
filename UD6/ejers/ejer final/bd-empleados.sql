DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados;

USE empleados;

CREATE TABLE centro (
	numCentro INT NOT NULL,
	nomCentro VARCHAR(255),
	ciudad VARCHAR(255),
	PRIMARY KEY (numCentro)
);

CREATE TABLE depto (
	numDepto INT NOT NULL,
	numCentro INT,
	nomDepto VARCHAR(50),
	PRIMARY KEY (numDepto),
    FOREIGN KEY (numCentro) REFERENCES centro(numCentro)
);

CREATE TABLE emp (
	numEmp INT NOT NULL,
    numDepto INT,
    fecNacimiento DATE,
    salario DECIMAL(19,4),
    PRIMARY KEY (numEmp),
    FOREIGN KEY (numDepto) REFERENCES depto(numDepto)
);

INSERT INTO centro VALUES (10, 	'SEDE CENTRAL',	'C. ALCALA, 820, MADRID');
INSERT INTO centro VALUES (20, 	'RELACION CON CLIENTES', 'C. ATOCHA, 405, MADRID');


INSERT INTO depto VALUES (110,  20, 'DIRECC. COMERCIAL');
INSERT INTO depto VALUES (122,  10, 'PROCESO DE DATOS');
INSERT INTO depto VALUES (100,  20, 'DIRECCION GENERAL');
INSERT INTO depto VALUES (111,  20, 'SECTOR INDUSTRIAL');
INSERT INTO depto VALUES (112,  20, 'SECTOR SERVICIOS');
INSERT INTO depto VALUES (120,  10, 'ORGANIZACION');
INSERT INTO depto VALUES (121,  10, 'PERSONAL');
INSERT INTO depto VALUES (130,  10, 'FINANZAS');
INSERT INTO depto VALUES (140,  10, 'Marketing');


INSERT INTO emp VALUES (110, 112,  '1950-02-05', 987);
INSERT INTO emp VALUES (120, 112,   '1968-10-01', 350);
INSERT INTO emp VALUES (130, 112, '1969-02-01', 290);
INSERT INTO emp VALUES (150, 121,  '1948-01-15', 440);
INSERT INTO emp VALUES (160, 110,  '1968-11-11', 310);
INSERT INTO emp VALUES (180, 110,   '1956-03-18', 480);
INSERT INTO emp VALUES (190, 121,   '1962-02-11', 300);
INSERT INTO emp VALUES (210, 100,   '1959-01-23', 380);
INSERT INTO emp VALUES (240, 111,  '1966-02-24', 280);
INSERT INTO emp VALUES (250, 100,   '1967-03-01', 450);
INSERT INTO emp VALUES (260, 100,   '1968-07-12', 720);
INSERT INTO emp VALUES (270, 112,   '1966-10-10', 380);
INSERT INTO emp VALUES (280, 130,   '1971-10-08', 290);
INSERT INTO emp VALUES (285, 122,   '1968-02-15', 380);
INSERT INTO emp VALUES (290, 120,    '1968-02-19', 270);
INSERT INTO emp VALUES (310, 130,    '1971-01-15', 420);
INSERT INTO emp VALUES (320, 122,   '1978-02-05', 405);
INSERT INTO emp VALUES (330, 112,  '1972-03-01', 280);

