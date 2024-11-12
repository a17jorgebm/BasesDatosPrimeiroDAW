use nominas;

select * from departamento;
select * from empleado;
select * from just_nomina;
select * from linea;
select * from trabajan;

#1. Código y nombre de todos los departamentos.
select * from departamento;
#2. Mes y ejercicio de los justificantes de nómina pertenecientes al empleado cuyo código es 1.
select mes, ejercicio 
from just_nomina 
where cod_emp=1;
#3. Código y nombre de los empleados ordenados ascendentemente por nombre.
select codigo,nombre 
from empleado 
order by nombre asc;
#4. Código y número de cuenta de los empleados cuyo nombre empiece por 'A' o por 'J'.
select codigo,cuenta 
from empleado 
where nombre like 'A%' or nombre like 'J%';
#5. Número de empleados que hay en la base de datos.
select count(*) as cantidad_empleados 
from empleado;
#6. Nombre y número de hijos de los empleados cuya retención es: 8, 10 o 12.
select nombre,hijos 
from empleado 
where retencion in (8,10,12);
#7. Número de hijos y número de empleados agrupados por hijos, mostrando sólo los grupos cuyo número de empleados sea mayor que 1.
select hijos as numero_hijos, count(*) as numero_empleados 
from empleado 
group by numero_hijos
having count(*)>1;
#8. Número de hijos, retención máxima, mínima y media de los empleados agrupados por hijos.
#9. Nombre y función de los empleados que han trabajado en el departamento 1.
select e.nombre,t.funcion
from empleado e
join trabajan t on t.cod_emp=e.codigo
where t.cod_dep=1;
#10. Nombre del empleado y nombre del departamento en el que han trabajado empleados que no tienen hijos.
select e.nombre,d.nombre
from empleado e 
join trabajan t on t.cod_emp=e.codigo
join departamento d on d.codigo=t.cod_dep
where e.hijos=0;
#11. Nombre del empleado, mes y ejercicio de sus justificantes de nómina, número de línea y cantidad de las líneas de los justificantes para el empleado cuyo código=1.
#12. Nombre del empleado e ingresos totales percibidos agrupados por nombre.
#13. Número de empleados cuyo número de hijos es superior a la media de hijos de los empleados.
select count(*)
from empleado
where hijos>(select avg(hijos) from empleado)
;
#14. Nombre de los empleados que más hijos tienen o que menos hijos tienen.
#15. Nombre de los empleados que no tienen justificante de nóminas.
#16. Nombre de los empleados, nombre de los departamentos en los que ha trabajado y función en mayúsculas que ha realizado en cada departamento.
#17. Nombre, fecha de nacimiento y nombre del día de la semana de su fecha de nacimiento de todos los empleados.
#18. Nombre y edad de los empleados.
#19. Nombre, edad y número de hijos de los empleados que tienen menos de 40 años y tienen hijos.
#20. Nombre e ingresos percibidos empleado más joven y del más longevo.