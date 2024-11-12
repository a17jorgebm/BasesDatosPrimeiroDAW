/*
Utilizando la base de datos de datos bancarios (bd-datos-bancarios.sql), crea un disparador que permita llevar un 
registro de los movimientos de un usuario en sus cuentas bancarias. Es decir, cada vez que un usuario
realice un movimiento en el saldo de alguna de sus cuentas, 
se debe dejar reflejado ese movimiento en la tabla registro_movimientos.
*/
use datos_bancarios;
drop trigger if exists ejer7;
delimiter //
create trigger ejer7
after update
on cuenta for each row
begin
	declare v_operacion enum('INGRESO','RETIRO');
    declare v_cantidad decimal(10,3) unsigned default abs(old.saldo-new.saldo);
    if old.saldo>new.saldo then
		set v_operacion='RETIRO';
	else 
		set v_operacion='INGRESO';
    end if;
    
    insert into registro_movimientos(id_cliente,numero_cuenta,operacion,fecha,cantidad,saldo_antiguo,saldo_nuevo)
		values (new.id_cliente,new.numero,v_operacion,now(),v_cantidad,old.saldo,new.saldo);
end;
//
delimiter ;

update cuenta set saldo=saldo-500 where numero='ES111';

select * from registro_movimientos;
