use tenda;
/*
Ejercicio 1
Crear una vista con los siguientes datos, referidos a los artículos: código y nombre del artículo y
nombre de proveedor que lo suministra. Utilizar la vista para consultar los datos ordenados 
alfabéticamente por el nombre del artículo.
*/
create or replace
view ejer1
as 
	select a.art_codigo,a.art_nome,p.prv_nome
	from artigos a
    join provedores p on p.prv_id=a.art_provedor;
    
select * from ejer1
order by a.art_nome;
/*
Ejercicio 2
Crear una vista asociada a la tabla detalle_vendas que muestra código de artículo y número total de
unidades vendidas ordenados por código. Utilizar la vista para consultar los datos y comprobar si es
posible utilizarla con INSERT, DELETE o UPDATE
*/
create or replace
view ejer2
as
	select dev_artigo as codigo_artigo, sum(dev_cantidade) as numero_ventas
    from detalle_vendas
    group by codigo_artigo
    order by codigo_artigo
;
select * from ejer2;
show create view ejer2;
select * from information_schema.views where table_name='ejer2'; #is_updatable es NO
/*
Ejercicio 3
Crear una vista que permita ver los datos de las ventas realizadas en la tienda 30. Utilizar la vista
para:
a) Modificar el cliente de la venta 98 que existe en la tabla creada por la vista, asignándole el 
cliente 101 (que no existe en la tabla de clientes).
b) Utilizar la vista para modificar el cliente de la venta 200 (que no existe en la tabla
creada por la vista) asignándole el cliente 100.
c) Modificar el cliente de la venta 98 que existe en la tabla creada por la vista poniendo
el cliente 100.
*/
create or replace
view ejer3
as
	select * from vendas
    where ven_tenda=30
with check option;
#a
update ejer3 set ven_cliente=101 where ven_id=98; #non funciona dado que o cliente non existe na tabla clientes
#b
update ejer3 set ven_cliente=100 where ven_id=200; #non cambia nada dado que o id da venta non existe, pero non da erro
#c
update ejer3 set ven_cliente=100 where ven_id=98; #funciona e modifica o cliente da taboa vendas

/*
Ejercicio 4
Crear una vista que permita mostrar código, nombre, stock, fecha de alta y proveedor de los artículos 
dados de alta antes del 1-1-2010, ordenados por proveedor, stock (de forma descendente) y código.
*/
create or replace
view ejer4
as
	select art_codigo,art_nome,art_stock,art_alta,art_provedor
    from artigos
	where art_alta<DATE('2010-1-1')
    order by art_provedor,art_stock desc,art_codigo;
    
select * from ejer4;

