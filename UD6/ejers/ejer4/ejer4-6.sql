#ejercicio 1
drop procedure if exists ejer1;
delimiter //
create procedure ejer1(numeroFilas int)
begin
declare ven_cliente,ven_empregado smallint unsigned;
declare ven_tenda tinyint unsigned;
declare ven_data timestamp default current_timestamp();
insertarFilas:while (numeroFilas>0) do
	set numeroFilas=numeroFilas-1;
	select clt_id into ven_cliente from tenda.clientes order by rand() limit 1;
    select tda_id into ven_tenda from tenda.tendas order by rand() limit 1;
    select emp_id into ven_empregado from tenda.empregados order by rand() limit 1;
    
    insert into tenda.vendas(`ven_tenda`,`ven_empregado`,`ven_cliente`,`ven_data`) 
    values(ven_tenda,ven_empregado,ven_cliente,ven_data);
end while insertarFilas;
end;
//
delimiter ;
select * from vendas;
call ejer1(500);

#ejercicio 2
drop function if exists ejer2;
delimiter //
create function ejer2(v_Valoracion decimal(4,2)) returns char(22)
deterministic
begin
	declare texto char(22);
		if v_Valoracion >=0 and v_Valoracion<5 then set texto='suspenso';
		elseif v_Valoracion >=5 and v_Valoracion<6 then set texto='aprobado';
		elseif v_Valoracion >=6 and v_Valoracion<7 then set texto='bien';
		elseif v_Valoracion >=7 and v_Valoracion<9 then set texto='notable';
		elseif v_Valoracion >=9 and v_Valoracion<=10 then set texto='sobresaliente';
		else set texto='error en la validacion';
    end if;
    return texto;
end;
//
delimiter ;

select ejer2(11) as nota;








