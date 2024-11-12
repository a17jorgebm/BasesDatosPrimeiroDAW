-- EJERCICIO 1
# Creamos el procedimiento
use tenda;
drop procedure if exists ejercicio1;
delimiter //
create procedure ejercicio1 (pFilas integer)
begin
	declare vCliente, vEmpregado  smallint unsigned;
	declare vTenda tinyint unsigned;
	declare vCcontador tinyint unsigned default 0;
	while vCcontador < pFilas do
		/*seleccionamos un empleado aleatoriamente*/
		select emp_id into vEmpregado
			from empregados
			order by rand()
			limit 1;
		/*seleccionamos un cliente aleatoriamente*/
		select clt_id into vCliente
			from clientes
			order by rand()
			limit 1;
		/*seleccionamos una tienda aleatoriamente*/
		select tda_id into vTenda
			from tendas
			order by rand()
			limit 1;
		/*insertamos una fila en la tabla de ventas*/
		insert into vendas(ven_tenda,ven_empregado,ven_cliente,ven_data)
			values (vTenda, vEmpregado, vCliente, now());
		/*contamos la fila insertada*/
		set vCcontador = vCcontador + 1;
	end while;
end
//
delimiter ;

# Ahora vamos a probar el funcionamiento del procedimiento
/*Consultamos el número de filas que hay antes de ejecutarlo, y el id de la última venta*/
select count(*), max(ven_id) from vendas;

/*Ejecutamos el procedimiento insertando 10 filas*/
call ejercicio1(10);

/*Comprobamos si fueron insertadas*/
select count(*), max(ven_id) from vendas;


-- EJERCICIO 2
# Definimos la función
use tenda;
delimiter //
drop function if exists ejercicio2 //
create function ejercicio2(pNota decimal(4,2)) returns char(20)
deterministic
begin
    declare vTexto char(20);
        if pNota >= 0 and pNota < 5 then set vTexto = 'suspenso';
	      elseif pNota >= 5 and pNota < 6 then set vTexto = 'aprobado';	
        elseif pNota >= 6 and pNota < 7 then set vTexto = 'bien';
        elseif pNota >= 7 and pNota < 9 then set vTexto = 'notable';
        elseif pNota >= 9 and pNota <= 10 then set vTexto = 'sobresaliente';
        else set vTexto = 'Error en la valoración';
    end if;
    return vTexto;
end //
delimiter ;

# Probamos el funcionamiento de la función
select ejercicio2(0); # suspenso
select ejercicio2(1); # suspenso
select ejercicio2(5); # aprobado
select ejercicio2(6.9); # bien
select ejercicio2(8.5); # notable
select ejercicio2(10); # sobresaliente
select ejercicio2(11); # error en la nota





