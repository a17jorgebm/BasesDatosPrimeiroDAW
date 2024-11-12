#1
INSERT INTO profesorado(Codigo,Nombre,Apellidos,DNI,Especialidad,Fecha_Nac,Antiguedad)
VALUES(1,'NURIA','ANERO GONZALEZ','58328033X','MATEMATICAS','1972-02-22',9);

#2
INSERT INTO profesorado(Codigo,Nombre,Apellidos,DNI,Especialidad,Fecha_Nac,Antiguedad)
VALUES
(2,'MARIA LUISA','FABRE BERDUN','51083099F','TECNOLOGIA','1975-03-31',4),
(3,'JAVIER','JIMENEZ HERNANDO',null,'LENGUA','1969-05-04',10),
(4,'ESTEFANIA','FERNANDEZ MARTINEZ','19964324W','INGLES','1973-06-22',5),
(5,'JOSE M.','ANERO PAYAN',null,null,null,null);

#3
UPDATE cursos SET Cod_profe=4 WHERE Codigo=1;
UPDATE cursos SET Cod_profe=2 WHERE Codigo=2;
UPDATE cursos SET Cod_profe=2 WHERE Codigo=3;
UPDATE cursos SET Cod_profe=1 WHERE Codigo=4;
UPDATE cursos SET Cod_profe=1 WHERE Codigo=5;
UPDATE cursos SET Cod_profe=3 WHERE Codigo=6;

#4
UPDATE profesorado
SET especialidad='INFORMÁTICA',DNI='9876543C'
WHERE Codigo=3;

#5
UPDATE profesorado
SET Antiguedad=(Antiguedad-2)
WHERE Antiguedad>5;

#6
DELETE FROM cursos where Codigo=6;

#7
DELETE FROM alumnado where Cod_Curso=2 and Sexo='H';

#8
INSERT INTO alumnado(Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso)
select Nombre,Apellidos,Sexo,Fecha_Nac,1 from alumnado_nuevo;

#9
UPDATE cursos 
SET Max_Alumn=(select count(*) from alumnado where Cod_Curso=1)
WHERE Codigo=1;

#10
DELETE FROM alumnado
WHERE Codigo in (
	SELECT * FROM(
		SELECT a.Codigo
		FROM alumnado a
		JOIN cursos c on c.Codigo=a.Cod_Curso
		WHERE c.Cod_Profe=1
	) as ALUMNOS_ELIMINAR
);