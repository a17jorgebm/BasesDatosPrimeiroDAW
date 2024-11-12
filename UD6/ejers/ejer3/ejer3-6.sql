#ejercicio 1
drop procedure if exists ejer1;
delimiter //
create procedure ejer1()
begin
declare vNumero int;
set vNumero=45;
if vNumero>0 then 
	select 'positivo';
elseif vNumero<0 then 
	select 'negativo';
else 
	select 'cero';
end if;
end;
//
delimiter ;
call ejer1();

#ejercicio 2
drop procedure if exists ejer2;
delimiter //
create procedure ejer2()
begin
declare vCodigo char;
set vCodigo='U';
case vCodigo
	when 'S' then select 'Soltero';
    when 'C' then select 'Casado';
    when 'D' then select 'Divorciado';
    when 'V' then select 'Viudo';
    when 'U' then select 'Unión Libre/a';
    when 'P' then select 'Separado/a';
    else select 'Erro no codigo';
end case;
end;
//
delimiter ;
call ejer2();

#ejer 3
drop procedure if exists ejer3;
delimiter //
create procedure ejer3()
begin
	declare vNumeroInicio int unsigned default 5;
	declare vNumeroFinal int unsigned default 7;
    declare vNumeroDePares int unsigned default 0;
	bucleWhile:while vNumeroInicio<(vNumeroFinal-1) do
		set vNumeroInicio=vNumeroInicio+1;
        if vNumeroInicio%2=0 then 
			set vNumeroDePares=vNumeroDePares+1;
		end if;
	end while bucleWhile;
    select vNumeroDePares as 'Numero de pares';
end;
//
delimiter ;
call ejer3();

#ejercicio 4
drop procedure if exists ejer4;
delimiter //
create procedure ejer4()
begin
declare vNumero smallint unsigned default 35;
declare vNumeroPuesto smallint unsigned;
declare vContador int unsigned default 0;
repeat
	set vContador=vContador+1;
	set vNumeroPuesto=floor(1+rand()*99);
until vNumero=vNumeroPuesto
end repeat;
select vContador as 'Numero intentos',vNumero as 'Numero acertado';
end;
//
delimiter ;
call ejer4();


