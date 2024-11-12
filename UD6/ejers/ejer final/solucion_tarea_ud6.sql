use empleados;

### EJERCICIO 1
drop view if exists ejercicio1;
create view ejercicio1 as
	select concat('En el departamento ', nomDepto, ' trabajan ', count(e.numDepto), ' empleados.')
    from emp e right join depto d on e.numDepto = d.numDepto
    group by d.numDepto;
    
select * from ejercicio1;

### EJERCICIO 2
drop view if exists ejercicio2;
create view ejercicio2 as
	select * from emp 
    where salario >= (select avg(salario) from emp)
    order by salario desc;

select * from ejercicio2;


### EJERCICIO 3
drop procedure if exists ejercicio3;
delimiter //
create procedure ejercicio3 (codigo integer, incremento integer)
begin
	update emp set salario = salario * (1 + incremento / 100) where numEmp = codigo;
end
//
delimiter ;

call ejercicio3(120, 20);


### EJERCICIO 4
delimiter //
drop function if exists ejercicio4 //
create function ejercicio4(pNumEmp int) returns boolean
deterministic
begin
	declare vFecha date;
    select fecNacimiento into vFecha from emp where numEmp = pNumEmp;
    return (timestampdiff(YEAR, vFecha, curdate()) >= 18);
end //
delimiter ;

select ejercicio4(110);
