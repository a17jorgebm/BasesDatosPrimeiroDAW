DROP DATABASE IF EXISTS INSTITUTO;

CREATE DATABASE INSTITUTO;

USE INSTITUTO;

CREATE TABLE PROFESORADO
( Codigo INT, 
  Nombre VARCHAR(30), 
  Apellidos VARCHAR(30), 
  DNI CHAR(9), 
  Especialidad VARCHAR(20),
  Fecha_Nac DATE,
  Antiguedad INT,
  PRIMARY KEY (Codigo)
);  

CREATE TABLE CURSOS
( Codigo INT, 
  Nombre VARCHAR(20), 
  Cod_Profe INT, 
  Max_Alumn INT, 
  Fecha_Inic DATE, 
  Fecha_Fin DATE, 
  Num_Horas INT,
  PRIMARY KEY (Codigo),    
  CONSTRAINT Cod_Profe_FK FOREIGN KEY (Cod_Profe) REFERENCES PROFESORADO(Codigo)
);
                    
CREATE TABLE ALUMNADO_NUEVO
( Nombre VARCHAR(30), 
  Apellidos VARCHAR(30), 
  Sexo VARCHAR(1), 
  Fecha_Nac DATE
);
              
CREATE TABLE ALUMNADO
( Codigo INT AUTO_INCREMENT, 
  Nombre VARCHAR(30), 
  Apellidos VARCHAR(30), 
  Sexo VARCHAR(1), 
  Fecha_Nac DATE, 
  Cod_Curso INT,
  PRIMARY KEY (Codigo),    
  CONSTRAINT Cod_Curso_FK FOREIGN KEY (Cod_Curso) REFERENCES CURSOS(Codigo)
);
 

INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(1, 'Curso 1', 30, '2011-01-01', '2011-12-31', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(2, 'Curso 2', 30, '2011-01-01', '2011-12-31', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(3, 'Curso 3', 30, '2011-01-01', '2011-12-31', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(4, 'Curso 4', 30, '2011-01-01', '2011-12-31', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(5, 'Curso 5', 30, '2011-01-01', '2011-12-31', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(6, 'Curso 6', 30, '2011-01-01', '2011-12-31', 100);
   
    
    
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MANUELA','SUAREZ IBAÑEZ','M','1990-06-30',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MILAGROSA','DIAZ PEREZ','M','1984-10-28',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE','CRESPO DE HERMOSO','H','1993-03-02',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANTONIO JESUS','MARTIN BOLLO','H','1999-11-04',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('BARBARA','PELAEZ VALENCIA','M','1967-08-27',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JUAN PEDRO','GALVE GONZALEZ','H','1991-11-10',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA ISABEL','PEREZ GUILLEN','M','1962-11-14',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('PATRICIA','ROMAN GOMEZ','M','1979-04-26',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','TAPIA SOLANS','H','1980-06-05',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA','FERREIRO SANTOS','M','1969-01-29',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JAVIER','LAMA DEL REY','H','1977-02-26',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ALEJANDRA','CALDERON VALDIVIA','M','1960-11-16',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANA DOLORES','ESCUDERO ENCISO','M','1975-09-07',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JUAN CARLOS','RODRIGUEZ PADILLA','H','1963-11-15',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('CECILIO','SASTRE GONZALEZ','H','1969-11-23',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JUAN','MARTINEZ SANCHEZ','H','1974-10-23',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA','LAFUENTE FERNANDEZ','M','1986-11-21',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MANUELA','MARTINEZ ALBA','M','1962-11-26',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ROSA NIEVES','SANCHEZ CANO','M','1979-12-12',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('BELEN','RAMOS ANGUITA','M','1967-12-30',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JULIAN','GARCIA ZABALA','H','1963-01-04',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DIEGO JESUS','CANO SALVADOR','H','1970-05-18',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE IGNACIO','HARO FANECA','H','1981-05-08',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSEFA','CASTELLANOS DIEZ','M','1998-05-01',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('BEATRIZ','RUBIO BERMEJO','M','1970-04-29',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JAVIER','CASTRO GOMEZ','H','1967-08-20',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','GAY GARCIA DEL VALLE','H','1989-07-22',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','TOCADOS GARCIA','H','1961-01-18',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ELISA ISABEL','BRUNO CALVO','M','1998-05-13',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DIANA','GUILLAMON POSADA','M','1980-04-29',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','RANILLA URRUTIA','H','1964-11-22',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JAVIER','LUENGO HERRERO','H','1963-04-22',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','VALENCIA MEDINA','H','1981-03-27',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('RAFAEL','DIAZ LAMA','H','1979-06-01',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('CAROLINA','RIVAS MENDIA','M','1974-07-30',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE MANUEL','GARCIA ZAPICO','H','1963-03-03',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MIGUEL','IBARROLA DIEZ','H','1985-08-12',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ENCARNACION','ASENJO HERNANDO','M','1962-04-03',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('FRANCISCO','CALVO BONO','H','1974-06-17',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE ANTONIO','CALVO RODRIGUEZ','H','1989-05-04',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANTONIA','MORENO RAYA','M','1976-08-04',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE MARIA','FUENTEMILLA ALBERT','H','1979-12-27',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('BELEN','PORTERO GRACIA','M','1991-10-28',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('LUIS ANTONIO','SUAREZ GARCIA','H','1997-10-24',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('FRANCISCO ANTONIO','BAUTISTA LAMENCA','H','1992-09-09',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('SILVIA','PEÑA CASTAN','M','1977-07-20',5);


INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MARIA','GOMEZ ANDRES','M','1985-05-04');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('JOSE MANUEL','PADILLA VEGAS','H','1999-05-19');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('RICARDO','MARQUINA HERNANDO','H','1982-02-20');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MIGUEL','DIAZ FABRE','H','1985-04-17');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('LUIS MIGUEL','AGURRUZA RODRIGUEZ','H','1983-04-25');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('NICOLAS','LOBATO BARRANCO','H','1961-06-25');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MIGUEL','BURGOS ZAPICO','H','1986-04-13');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('JOSE JESUS','VALDIVIESO JIMENEZ','H','1985-12-23');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('ANA MARIA','BEAMONTE GOMEZ','M','1968-07-25');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MARIA','LOPEZ CARREÑO','M','1963-11-18');


