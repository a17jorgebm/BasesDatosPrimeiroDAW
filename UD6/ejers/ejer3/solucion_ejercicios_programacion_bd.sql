-- Ejercicio 1
# Creamos un procedimiento para probar el funcionamiento
drop procedure if exists ejercicio1;
delimiter //
create procedure ejercicio1()
begin
	declare vNumero integer;
	set vNumero = -90;
	if vNumero = 0 then select 'cero';
	elseif vNumero > 0 then select 'positivo';
	else select 'negativo'; # Esta será la salida en este ejemplo
	end if;
end;
//
delimiter ;

# Probamos el procedimiento
call ejercicio1();



-- Ejercicio 2
drop procedure if exists ejercicio2;
delimiter //
create procedure ejercicio2()
  begin
	  declare vCodigo varchar(1) default 'b';
    case vCodigo
        when 'S' then select 'Soltero/a';
        when 'C' then select 'Casado/a';
        when 'D' then select 'Divorciado/a';
        when 'V' then select 'Viúdo/a';
        when 'U' then select 'Unión Libre';
        when 'P' then select 'Separado/a';
        else select 'Error en el código'; # Esta será la salida en este ejemplo
    end case;
  end
//
delimiter ;

# Probamos el funcionamiento
call ejercicio2();


-- Ejercicio 3
drop procedure if exists ejercicio3;
delimiter //
create procedure ejercicio3()
  begin
  declare vNumero, vNumeroInicio, vNumeroFinal smallint unsigned;
  declare vContadorPares smallint unsigned default 0;
  set vNumeroInicio = 0;
  set vNumeroFinal = 10;
  set vNumero = vNumeroInicio;
  while vNumero <= vNumeroFinal do
   if vNumero % 2 = 0 then
    set vContadorPares = vContadorPares + 1;
   end if;
   set vNumero = vNumero +1;
  end while;
  select vNumeroInicio, vNumeroFinal, vContadorPares;
  end;
//
delimiter ;
call ejercicio3();


-- Ejercicio 4
drop procedure if exists ejercicio4;
delimiter //
create procedure ejercicio4()
  begin
  declare vNumero, vNumeroAleatorio tinyint unsigned default 0;
  declare vContadorIntentos smallint unsigned default 0;
  set vNumero = 25;
  repeat
   /*seleccionar un número aleatorio entre 1 y 100*/
    set vNumeroAleatorio = floor(1 + (rand() * 99));
    set vContadorIntentos = vContadorIntentos + 1;
  until vNumero = vNumeroAleatorio
  end repeat;
  select vNumero, vNumeroAleatorio, vContadorIntentos;
  end;
//
delimiter ;
call ejercicio4();
