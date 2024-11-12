# TEMA 7
## Disparadores (triggers)
Son programas almacenados asociados a unha tabla que se ejecutan cando sucede un determinado evento, normalmente unha manipulacion de datos da tabla.

### CREATE TRIGGER

````mysql
CREATE
    [DEFINER=user]
    TRIGGER [IF NOT EXISTS] nome_trigger
    {BEFORE | AFTER} {INSERT | DELETE | UPDATE} 
    ON nome_tabla FOR EACH ROW 
    [{FOLLOWS | PRECEDES} nome_outro_trigger]
        sentencias_do_trigger
````
* `DEFINER`: indica que usuario se vai considerar creador do trigger
* `TRIGGER [IF NOT EXISTS] nome_trigger`: indica o nome do trigger e co if not exists comproba que existe antes
* `{BEFORE | AFTER} {INSERT | DELETE | UPDATE}`: indica se se executa antes dou despois de facer insert,delete ou update
* `ON nome_tabla FOR EACH ROW`: indica a tabla do trigger, FOR EACH ROW quere decir que se vai executar por cada fila da tabla
* `[{FOLLOWS | PRECEDES} nome_outro_trigger]`: indicase o orden de execución se hai mais de un trigger co mismo evento(insert,delete,update) e co 
mismo tempo de execución(before,after). Por defecto vai por orden de creación(o que se crea antes executase antes).
* `sentencias_do_trigger`: se hai mais de unha van entre BEGIN e END

**NON se poden modificar, hai que borralos e crealos de novo cos cambios.**

### DROP TRIGGER
````mysql
DROP TRIGGER [IF EXISTS] [nome_esquema.]nome_trigger
#ejemplo
DROP TRIGGER IF EXISTS empleados.trigger_ao_borrar_empleado
````

### SHOW TRIGGERS e SHOW CREATE TRIGGER
````mysql
select * from information_schema.triggers;

SHOW TRIGGERS
    [{FROM | IN} nome_bd] #se non se especifica enseñanse os da bd activa
    [LIKE 'patron ejemplo' | WHERE expresion_ejemplo]
    
SHOW CREATE TRIGGER nome_trigger; #enseña a sentencia de creación do trigger
````

### Identificadores OLD e NEW
É obligatorio usalos no corpo do trigger cando se faga referencia a algunha columna da tabla usada
(ej. NEW.nomeDepartamento). Dependendo do evento:
* `INSERT`: solo pode usarse NEW, para facer referencia aos valores das filas que se estan insertando.
* `DELETE`: solo pode usarse OLD, para facer referencia aos valores que tiñas as filas que se estan borrando.
* `UPDATE`:
  * OLD: para facer referencia aos valores das filas antes de cambialos.
  * NEW: para facer referencia aos valores das filas despois de cambialos.

### EJEMPLOS DE USO DE TRIGGERS
#### 1. BEFORE INSERT------------------------------------
````mysql
use tenda;
drop trigger if exists detalle_vendasBI;
delimiter //
create trigger detalle_vendasBI
  before insert on detalle_vendas
  for each row
begin
  declare vStockActual smallint;
  set vStockActual = (select art_stock from artigos where art_codigo = new.dev_artigo);
  if new. dev_cantidade > vStockActual then
    signal sqlstate '45000' set message_text = 'No hay stock suficiente';
  end if;
end //
delimiter ;
````
Antes de que se inserte una fila en la tabla detalle_vendas, se comprueba si la cantidad pedida es mayor que el número de unidades que hay en el almacén. En el caso de no ser suficiente, se abortará la inserción provocando un error que se asocia a un código SQLSTATE, en este caso 45000, y se mostrará un mensaje de error. 

Se puede hacer la prueba ejecutando una sentencia INSERT como la siguiente:

`insert into tenda.detalle_vendas values (1,3,'0713242',50,300.50,0);`

Que provocaría un error con el mensaje “No hay stock suficiente”:

#### 2. AFTER INSERT------------------------------------
````mysql
use tenda; 
drop trigger if exists detalle_vendasAI; 
delimiter // 
create trigger detalle_vendasAI after insert on detalle_vendas 
for each row 
begin 
	update artigos 
	set art_stock = art_stock - new.dev_cantidade 
	where art_codigo = new.dev_artigo; 
end // 
delimiter ;
````
Después de insertar una fila en la tabla detalle_vendas, se hace una actualización de la columna art_stock en la tabla de artigos, restándole el contenido de la columna dev_cantidade de la tabla detalle_vendas en el artículo que tiene como código el valor almacenado en la columna dev_artigo. Hay que tener en cuenta que ya está creado el disparador del ejemplo anterior, por lo que antes de insertar la fila en la tabla deta-lle_vendas, ya se comprobó que el stock actual es suficiente para ese artículo. 

Se puede hacer la prueba ejecutando una sentencia INSERT como la siguiente:

`insert into tenda.detalle_vendas values (1,3,'0713242',1,300.50,0);`

Si comprobamos la columna art_stock del artículo con código 0713242, veremos que hay una unidad menos en stock tras la inserción.
#### 3. AFTER UPDATE------------------------------------
````mysql
use tendabd;
drop trigger if exists clientesAU; 
delimiter // 
-- creación del disparador 
create trigger clientesAU 
after update 
on clientes for each row 
begin 
	if new.clt_desconto != old.clt_desconto then
	insert into rexistro_cambios_desconto (usuario, valorVello, valorNovo) values (user(), old.clt_desconto, new.clt_desconto); 
	end if; 
end // 
delimiter ;
````
Llevar un registro de todos los cambios que se hagan en la columna clt_desconto de la tabla clientes. Cada vez que se hace un cambio en el contenido de la columna, se guarda una fila en la tabla rexistro_cambios_desconto con el nombre del usuario conectado, la fecha y hora en que se hace el cambio, valor de la columna antes de la modificación y el valor de la columna después de la modificación.