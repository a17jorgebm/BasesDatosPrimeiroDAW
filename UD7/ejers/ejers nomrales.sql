use tenda;
#1
/*
Crea un disparador que valide el contenido de la columna emp_dni de la tabla empregados antes de insertar un 
nuevo empleado. El dni debe tener una longitud exacta de 9 caracteres. 
Si el dni no cumple esta condición, se debe abortar la operación y mostrar el mensaje “DNI no válido”.
*/
drop trigger if exists ejer1;
delimiter //
create trigger ejer1
before insert
on empregados for each row
begin
	if LENGTH(new.emp_dni)<9 then
		signal sqlstate '45000' set message_text='DNI no válido';
    end if;
end;
//
delimiter ;

insert into empregados(emp_dni) values('3432');
#2
/*
Consulta los disparadores asociados a la base de datos tenda y 
muestra información del disparador creado en el ejercicio anterior.
*/
show triggers from tenda;
show create trigger ejer1;
#3
/*
Crea los disparadores necesarios para poder mantener actualizado el valor de las columnas clt_vendas y clt_ultima_venda 
en la tabla clientes 
cuando se realiza una nueva venta. La columna clt_vendas guarda información del número de ventas que se le hicieron al cliente. 
La columna clt_ultima_venda guarda información de la fecha en la que se le hizo la última venta.
Es decir, debes crear un disparador para la tabla vendas, de forma que cada vez que se inserte una venta, se actualicen los 
valores de clt_vendas y clt_ultima_venda.
*/
drop trigger if exists ejer3;
delimiter //
create trigger ejer3
after insert
on vendas for each row
begin
	update clientes set clt_vendas=clt_vendas+1,clt_ultima_venda=new.ven_data where clt_id=new.ven_cliente;
end;
//
delimiter ;

insert into vendas(ven_tenda,ven_empregado,ven_cliente) values(1,1,1);
#4
/*
Crea los disparadores necesarios para llevar un registro de todas las operaciones que modifiquen (insert, update, delete) los 
datos almacenados en la tabla de empregados. Para eso, debes crear una nueva tabla en la base de datos para el registro de las 
operaciones, en la que se almacene el nombre del usuario que realizó la operación, 
la fecha y hora y el tipo de operación (puede ser un texto del tipo: “INSERT”, “UPDATE” o “DELETE”).
*/
create table if not exists modificaciones_empregados(
	mod_emp_id int unsigned not null auto_increment,
    mod_emp_nombre_usuario varchar(50) not null,
    mod_emp_data datetime not null,
    mod_emp_tipo_operacion char(6) not null,
    primary key (mod_emp_id)
);

drop trigger if exists ejer4_update;
delimiter //
create trigger ejer4_update
after update
on empregados for each row
begin
	insert into modificaciones_empregados(mod_emp_nombre_usuario,mod_emp_data,mod_emp_tipo_operacion)
    values(user(),now(),'UPDATE');
end;
//
delimiter ;

drop trigger if exists ejer4_insert;
delimiter //
create trigger ejer4_insert
after insert
on empregados for each row
begin
	insert into modificaciones_empregados(mod_emp_nombre_usuario,mod_emp_data,mod_emp_tipo_operacion)
    values(user(),now(),'INSERT');
end;
//
delimiter ;

drop trigger if exists ejer4_delete;
delimiter //
create trigger ejer4_delete
after delete
on empregados for each row
begin
	insert into modificaciones_empregados(mod_emp_nombre_usuario,mod_emp_data,mod_emp_tipo_operacion)
    values(user(),now(),'DELETE');
end;
//
delimiter ;

update empregados set emp_dni='49324324F' where emp_id=1;
select * from modificaciones_empregados;

#5
#Borra el disparador creado en el ejercicio 1.
drop trigger if exists ejer1;