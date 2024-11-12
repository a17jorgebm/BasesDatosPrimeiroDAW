use empleados;

#1
create or replace view ejer1
as
	select concat('En el departamento ',d.numDepto,' trabajan ',count(*),' empleados.') as 'Num empleados por departamento'
	from emp e
	right join depto d using (numDepto)
	group by d.numDepto
;
select * from ejer1;
#2
create or replace view ejer2
as
	select *
	from emp
	where salario>=(select avg(salario) from emp)
	order by salario desc
;
select * from ejer2;

#3
drop procedure if exists ejer3;
delimiter //
create procedure ejer3(num_empleado int,porcentaje_incremento smallint)
begin
	declare salarioActualEmp decimal(19,4);
    select salario into salarioActualEmp from emp where numEmp=num_empleado;
	update emp set salario=(salarioActualEmp+(salarioActualEmp*(porcentaje_incremento/100))) where numEmp=num_empleado;
end;
//
delimiter ;
call ejer3(250,8000);

#4
drop function if exists ejer4;
delimiter //
create function ejer4(cod_empleado int) returns bool
deterministic
begin
	declare edad tinyint unsigned;
    select timestampdiff(YEAR,fecNacimiento,CURDATE()) into edad from emp where numEmp=cod_empleado;
    if edad>=18 then 
		return true;
    end if;
    return false;
end;
//
delimiter ;

select *,ejer4(numEmp) as 'Mayor edad' from emp;






