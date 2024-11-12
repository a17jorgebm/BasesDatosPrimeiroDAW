use tenda;

-- Ejercicio 1
# Creamos la vista
create or replace view ejercicio1_artigos as
	select ar.art_codigo, ar.art_nome, ar.art_provedor
	from artigos ar inner join provedores pr on ar.art_provedor = pr.prv_id;

# Consultamos los artículos
select * from ejercicio1_artigos order by art_nome;


-- Ejercicio 2
# Creamos la vista
create or replace view ejercicio2_artigos as
	select dv.dev_artigo, count(*)
	from artigos ar inner join detalle_vendas dv on dv.dev_artigo = ar.art_codigo
	group by dv.dev_artigo;
    
# Visualizamos los datos
select * from ejercicio2_artigos;

# Comprobamos si es posible utilizarla con INSERT, DELETE o UPDATE
select * from information_schema.VIEWS; # Vemos que no se puede en la columna IS_UPDATABLE


-- Ejercicio 3
create or replace view ejercicio3_vendas as
     select * from vendas
     where ven_tenda = 30;
     
# Apartado 3.a)
update ejercicio3_vendas set ven_cliente = 101 ### Provoca un error por no existir el cliente 101
where ven_id = 98;

# Apartado 3.b)
update ejercicio3_vendas set ven_cliente = 100 ### La actualización no afecta a ninguna fila
where ven_id = 200;

# Apartado 3.c)
update ejercicio3_vendas set ven_cliente = 100
where ven_id = 98; ### Se realizan los cambios


-- Ejercicio 4
create or replace view ejercicio4_artigos as
	select art_codigo, art_nome, art_stock, art_alta, art_provedor
    from artigos 
	where art_alta < '2010-01-01'or art_alta is null
	order by art_provedor, art_stock desc, art_codigo;