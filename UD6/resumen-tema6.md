**Indice**
1. [Vistas](#tema6-1-vistas)
2. [Transaccions](#tema6-2-transaccions)
2. [Programacion](#tema6-3-programacion)

<div id="tema6-1-vistas">

# 1. Vistas
As vistas son tablas virtuales que non teñen existencia física, basicamente son filtros para configurar o que ven ou non os usuarios sobre a tabla base.

* As vistas solo almacenan a **definición da estructura**
*  As tablas base almacenan a info

#### Permisos que debe ter o usuario para crear unha vista
* ``CREATE VIEW``
* Privilegios adecuados sobre as columnas as que se fai referencia no ``SELECT``
* Se se utiliza ``OR REPLACE`` -> ten que ter o privilegio ``DROP VIEW``


## Sentencias

### Create view
Permite crear novas vistas ou sustituir vistas que xa existen.
````mysql
CREATE [OR REPLACE]
[DEFINER = usuario]
[SQL SECURITY { DEFINER | INVOKER }]
VIEW nombre_vista [(lista_columnas)]
AS sentencia_select
[WITH [CASCADED | LOCAL] CHECK OPTION]
````
``CREATE [OR REPLACE]`` : a clausula opcional OR REPLACE permite que se existe unha vista co mismo nombre sea reemplazada. Se non se pon e se da este caso daría un error.

``[DEFINER]``:opcional, permite indicar o usuario que creou a vista. Se non se indica tomase o CURRENT_USER, osea o usuario actual que ta creando a vista.

```[SQL_SECURITY]```:opcional, permite indicar se no momento da ejecución da vista se utilizan privilegios do creador de esta(DEFINER, por defecto) ou o usuario que a chama(INVOKER).

``sentencia_select``:selecciona os datos de definición da vista, de unha tabla ou de outra vista. Ten 3 restriccións:
 * Non pode ter subconsultas na cláusula FROM
 * Non pode ter referencias a variables do sistema ou de usuario
 * Non pode facer referencias a tablas temporales nin a vistas temporales

``[WITH CHECK OPTION]``: utilizase para crear vistas actualizables, que poden utilizarse para insertar ou modificar datos.
* Se se usa esta cláusula solo permitirá insertar ou modificar filas que cumplan as condicións da cláusula WHERE de ``sentencia_select``
* Opciones LOCAL e CASCADED: utilizanse cando na definición da vista se utilizán outras vistas.
  * ``LOCAL``: CHECK OPTION solo comproba as condicións de ``sentencia_select`` da vista que se ta creando
  * ``CASCADED``(por defecto): comproba as condicións de todas as vistas que interveñen da definición.

#### EJEMPLO 1
Creación vista para ver información sobre departamentos que pertenecen a provincia de Lugo(*id_provincia*=27). Solo se usan as cláusulas obligatorias.
````mysql
create view departamentos_lugo
as
select codigo,nome,tipo,cidade,id_provincia
from departamento
where id_provincia=27;
````
Cando se fai esta consulta coa vista de ejemplo como filtro, solo se mostran os departamentos con id_provincia 27. As columnas terán o nome da tabla departamentos, ou o que lle puxeramos na sentencia SELECT da vista (``codigo as cod_departamento``)
````mysql
select * from departamentos_lugo;
````

#### EJEMPLO 2
````mysql
CREATE
    ALGORITHM=UNDEFINED
    DEFINER='root@localhost'
    SQL SECUTIRY DEFINER
VIEW departamentos_lugo
AS 
    select codigo as dl_codigo,nome as dl_nome,tipo as dl_tipo,ciudad as dl_ciudad,id_provincia as dl_provincia
    from departamento
    where id_provincia=27
WITH CASCADED CHECK OPTION
````

### SHOW CREATE VIEW
A info das vistas gardase no diccionario de datos e podese consultar mediante un SELECT  a *information_schema.views*.

Tamen dispon da sentencia:
````mysql
SHOW CREATE VIEW departamento_lugo
````
Esta sentencia devolvería 4 un resultado con 4 columnas:
* **View**: nome da vista
* **Create View**: sentencia de creación da vista
* **character_set_client**: o xogo de caracteres asociado
* **colation_connection**: sistema de colación

### ALTER VIEW
É o mismo que facer ``CREATE OR REPLACE VIEW``, modifica unha vista que xa esta creada e ten a misma sintaxis.
````mysql
ALTER VIEW departamentos_lugo
  as
select codigo as cod_dep,nome,tipo,cidade,id_provincia
from departamento
where id_provincia=2232;
````
O usuario ten que ter permisos de CREATE VIEW, DROP VIEW e os privilegios adecuados sobre as columnas do SELECT.

### DROP VIEW
Permite borrar vistas. ``DROP VIEW nome_vista`` ou ``DROP VIEW IF EXISTS`` para evitar erros se a vista non existe.
````mysql
DROP VIEW departamentos_lugo;
DROP VIEW IF EXISTS departamentos_lugo;
````

</div>

<div id="tema6-2-transaccions">

---

# 2. TRANSACCIÓNS
Permiten executar un grupo de queries como se foran unha sola, facendo que ou se apliquen todos os cambios ou non se aplique ningún. Son mazo útiles porque se ocurre un erro no medio podense cancelar as operacións anteriores.

Deben cumplir as 4 propiedades ACID(*Atomicity, Consitency, Isolation, Durability*)
* **Atomicidad**: asegura que se executen todas as operacións ou ningunha
* **Consistencia**: asegura que solo se empeza o que se pode acabar
* **Aislamiento**: ningunha operación afecta as outras. Varias operacións sobre a misma información son independientes e non generan erro.
* **Durabilidad**: unha vez realizada a operación, esta non poderá cambiar e os cambios permanecerán.

Os sistemas gestores permiten ou non o uso de transaccións. No caso de MySql esto depende do tipo de tablas que se usen. Para facelas teremos que usar o tipo de tablas ``InnoDB``.

Decir que as tablas que soportan transaccions:
* Son moito mais seguras e faciles de recuperar se se produce algún fallo, xa que as queries executanse ou non.
* Poden aumentar o tempo das queries.

## Uso de transaccións
Pasos a seguir:
1. Iniciar unha transacción usando ```START TRANSITION``` ou ``BEGIN``
2. Facer as operacións que necesitemos
3. Poderanse reflejar os cambios con ```COMMIT``` ou cancelalos con ``ROLLBACK``

Por defecto, mysql trae activado o modo **autcommit**, osea que cada vez que se fai unha transacción confimase automaticamente.
Para desactivalo (non recomendado): 
````mysql
SET AUTOCOMMIT=0;
SHOW VARIABLES  LIKE 'autocommit'; //para saber o estado da variable autocommit
````
De esta maneira, sería como se o usuario sempre tivese unha transacción aberta, ata que se faga `COMMIT` ou `ROLLBACK`.

</div>

---

<div id="tema6-3-programacion">

# 3. PROGRAMACIÓN EN BD
## Programas almacenados y rutinas almacenadas TEORIA
As apliacións do lenguaje SQL permite crear varios tipos de objetos:
* **Procedimientos almacenados**: conxunto de sentencias que permiten automatizar tarefas que poden facer calculos ou almacenar conxuntos de resultados.
* **Funcions definidas por os usuarios(UDF)**: conxunto de sentencias que siempre devolven o resultado de un calculo. PODEN usarse en expresions como as funcións de SQL
* **Disparadores(_triggers_)**: conxunto de sentencias que se executan automaticamente cando se fai unha determinada operación de manipulación de datos.
* **Eventos**: permiten a execución diferida de sentencias, tendo en conta un calendario determinado. É dicir que podes indicar en que momento queres que se executen.

#### Conceptos que debemos saber
* **Programas almacenados**: todos os tipos de obxetos almacenados no servidor(os 4 de arriba).
* **Rutinas almacenadas**: fai referencia aos procedimientos almacenados e as funcions. A sintaxis destes é muy similar e non teñen unha execución automatica.
* **Subrutina**: fai referencia a unha rutina usada dentro de un programa almacenado.
### Que ventajas teñen??
* **Seguridad**: ocultan os nomes das tablas a usuarios que non teñan privilexios para manipular os datos. Simplemente usan os procedimientos sen conocer a estructura da bd.
* **Estándares de código**: un equipo de programadores pode compartir programas almacenados no servidor de bd. Facendo que todos usen o mismo e que perdan menos tempo
*  **Velocidad**: almacenanse no lado do servidor, polo que o código necesario para definilos solo se manda por rede cando se crea o programa. Esto reduce a carga na red pero aumentaa no servidor de bd.
* **Control de errores**: proporcionan un mecanismo para control de errores gestionado polo admin da bd, distinto do que proporcionan os logs.
### Principal desventaja??
Que os lenguajes procedimentales de distintos fabricantes non son compatibles entre si.

---
## Creación de programas almacenados
1. Para crealo é necesario escribir un _script SQL_ e gardalo con extension `.sql`.
2. Ao executar as sentencias compilase o programa almacenado e crease o objeto correspondiente no servidor.

Sentencias para crear, modificar e borrar programas almacenados:
````mysql
[CREATE,DROP,ALTER] PROCEDURE;
[CREATE,DROP,ALTER] FUNCTION;
[CREATE,DROP] TRIGGER;
[CREATE,DROP,ALTER] EVENT ;
````
Para borrar tamen se pode facer `DROP PROCEDURE IF EXISTS  nome `
## Bloques de programación
No caso de que o programa conteña varias sentencias estas agrupanse en **bloques de programacion** ou **sentencias compuestas**. Empezan por unha sentencia `begin` e acaba por `end`.

Pode haber un bloque dentro de outro.

````mysql
[etiqueta_inicio:] BEGIN 
    [lista_sentencias]
END [etiqueta_fin]
````
* _lista_sentencias_ é unha lista de sentencias SQL
* Se o bloque solo ten unha instrucción non fai falta usar begin e end
* Cada sentencia ten que acabar en `;`
* As etiquetas de inicio e fin son optativas, pero podense utilizar de referencias a ese bloque en calquer parte do programa.

## Delimitadores de final de sentencia
Ok hai un problema cos procedimientos almacenados, ao usar como delimitador o `;` ao final de cada sentencia o servidor ao atoparse co primeiro `;` pensa que o procedimiento acabou.

Para arreglar esto hai que cambiar o delimitador a outro caracter ou conxunto de caracteres que non se usen no procedimiento. Para facelo:
````mysql
DELIMITER caracter_final_sentencia
````
Por exemplo:
````mysql
DELIMITER //  #cambiamos o caracter delimitador de sentencia
CREATE PROCEDURE decirHola() #creamos o procedimiento co nome decirHola
BEGIN #iniciase o bloque de programación
    select 'hola que tal'; #sentencias do bloque de programación
end; #finaliza o bloque de programacion
// #finaliza a sentencia CREATE PROCEDURE
DELIMITER ; #volvese a poñer o delimitador ao ; por defecto
````
## Parametros
Algunhas rutinas almacenadas necesitan de algún parametro para poder funcionar ou devolven algún parámetro:
* Parametro de entrada: parametros que recibe
* Parametro de salida: parametro que devolve

É boa práctica diferenciar o nome destes parámetros das variables ou nomes de columnas. Podese por exemplo poñerlles unha _p_ ao inicio. Exemplo `pDNI`.

## Execución de programas almacenados
Os distintos programas almacenados tamen se diferencian según a forma na que se chaman:
* **Procedimiento almacenado**: executase unha chamada `call` co nome do procedimiento e pasandolle opcionalmente os parámetros.
  ````mysql
  call holaMundo();
  ````
* **Función**: utilizase igual que as funcións que xa veñen en SQL
* **Disparador(_trigger_)**: sempre está asociado a unha operación de manipulación de datos, polo que se executa el solo.
* **Evento**: indicase cando se vai executar no momento da creación do evento, polo que tamen se executa solo.

## Sentencias de declaración e manexo de variables e manipuladores
### Declare
As sentencias de declaración teñen que ir SEMPRE ao inicio do bloque de programación despois da sentencia _begin_, neste orden:
1. Variables
2. Condicions de error
3. Manipuladores de errores

Todos se poderán declarar con `DECLARE`
#### Variables
O tipo de dato pode ser calquera dos utilizados nas columnas e con `DEFAULT` asignaselle un valor.

Decir que as variables declaradas asi solo se poderán usar dentro do programa almacenado como se verá no siguiente apartado.
````mysql
DECLARE nombre_variable tipo_dato [DEFAULT valor] [,..... podense declarar mais na misma liña]
````
#### Condiciones
Podese poñerlle nombres a errores relacionandoo con un codigo de error ou un estado SQL. Usaranse para facer referencia a eles nos manipuladores e manexar a extepción.
````mysql
DECLARE nombre_condicion CONDITION FOR valor_condicion
    #donde valor_condicion pode ser
SQLSTATE [VALUE] codigo_sqlstate | codigo_error_mysql
````
Exemplo de creación dunha condición
````mysql
#Facendo referencia ao codigo de estado
DECLARE claveDuplicada CONDITION FOR SQLSTATE '23000';
#Facendo referencia ao codigo de error
DECLARE claveDuplicada2 CONDITION FOR 1062;
````
#### Manipuladores
Indican as accions a executar no caso de que se produza un erro determinado. Solo se poden usar en un bloque de programación.
````mysql
DECLARE accion_manipulador HANDLER FOR valor_condicion[,...] lista_sentencias
````
* O valor de _accion_manipulador_ pode ser:
  * `CONTINUE`: para errores leves que permiten que se siga coa execución.
  * `EXIT`: para errores graves que interrumpen a execución.
* O _valor_condicion_ especifica unha ou varias condicions que activan o manipulador:
  * `SQLSTATE [VALUE] codigo_sqlstate`
  * `codigo_error_mysql`
  * `nombre_condicion`
  * `SQLWARNING, NOT FOUND ou SQLEXCEPTION`
* _lista_sentencias_ pode ter unha ou mais sentencias a executar, no caso de ter mais de unha usase `begin` e `end`.

EJEMPLO DOS 3
````mysql
drop procedure if exists manipuladorDemo; #eliminase o procedimiento se existe
delimiter // #cambiase o delimitador
create procedure manipuladorDemo() #crease o procedimiento
begin
  declare vFinal bit default 0; #declarase a variable vFinal como bit inicializandoa con valor 0
  declare claveDuplicada condition for sqlstate '23000'; #crease unha condicion para o codigo de estado 23000
  declare continue handler for claveDuplicada set vFinal=1; #crease un handler para que poña a variable a 1 no caso de que se dea a condicion anterior
  insert into utilidades.provincia values('27','Lugo');
  select 'Primeiro intento',vFinal; #a variable terá valor 0
  insert into utilidades.provincia values('27','Lugo'); #aqui salta o error dado que xa existe, e executase o handler
  select 'Segundo Intento',vFinal; #a variable terá valor 1
end;
//
delimiter ; #volvese a poñer o limitador a como estaba anteriormente
call manipuladorDemo(); #chamase ao procedimiento
````
### SET
Permite asignar valores as variables do procedimiento.
````mysql
SET nombre_variable=expresion [,....]
````
Tipos de variables que se poden usar:
* **Variables locales**: declaranse coa sentencia `declare` e solo existen dentro do bloque de código. O nome non ten que levar nada pero recomendase unha _v_ ao principio.
* **Variables de usuario**: poden declararse con `set` directamente. Poden crearse, verse e modificarse dentro e fora do procedimiento ata que o usuarios non cerre sesión. No nome levan un _@_ ao inicio.
  * Tamen se lles pode asignar o valor co operador `:=` nunha sentencia SELECT.
* **Variables de sistema**: manexaas o **SBGD** para configurar os servidor.
  * Creanse e inicializanse cando se inicia o servidor
  * Podese cambiar o seu valor a nivel _session_(solo cambia na sesión actual) ou _global_(cambia para todas as sesións que se inicien dende ese momento)
  * Levan _@@_ ao inicio do nome dentro dun bloque de código, fora de el non é necesario poñelo.

````mysql
#locales
declare vNumero bit;
set vNumero=0;
#de usuario
set @mes=3;
select @mes:=@mes+1;  #devolvería o valor da suma e a variable numero pasaría a valer tamen ese valor
#de sistema
set session @@foreing_key_checks=0;
set global @@variable_global=56;
````

### SELECT ... INTO
Permite almacenar os valores das columnas dunha consulta que solo devolve unha fila.
````mysql
SELECT nombre_columna [,...] INTO nombre_variable [,...]

#ejemplo con varias variables nun select
set @vNombre=null, @vEdad=null, @vHijos=null;
SELECT nombre,hijos,edad 
into @vNombre,@vHijos,@vEdad 
from empleado 
where id=1;
````

## Estructuras de control de flujo
### If
Executa sentencias en función de unha condición:
````mysql
IF condicion1 THEN lista_sentencias
[ELSEIF condicion2 THEN lista_sentencias2]...
[ELSE lista_sentencias3]
END IF;
````
Exemplo:
````mysql
drop procedure if exists evaluarNumero;
delimiter //
create procedure evaluarNumero()
begin
  declare vNumero int;
  set vNumero=92;
  if vNumero%2=0 then
    if vNumero%10=0 then
      select 'Numero par múltiplo de 10';
    else
      select 'Número par non múltplido de 10';
    end if;
  else
    select 'Número impar';
  end if;
end;
//
delimiter ;

call evaluarNumero();
````
### Sentencia alternativa CASE
É basicamente un switch.
````mysql
CASE expresión
    [WHEN valor THEN sentencias_a_ejecutar]...
    [ELSE sentencias_a_ejecutar]
````
Exemplo1:
````mysql
select dni,nombre,
       case sexo
            when 'h' then 'home' #se o sexo é h imprime home
            when 'm' then 'muller' #se o sexo é m imprime muller
      end as sexo
from empleado;
````
### WHILE
Executa sentencias ata que a condición sexa falsa:
````mysql
#calcula la suma de los primeros 100 numeros naturales
drop procedure if exists calculoSuma;
delimiter $$
create procedure calculoSuma()
begin
  declare vNumero tinyint default 1;
  declare vSumaNumeros smallint default 0;
  nombreBucle:while vNumero<=100 do
          set vSumaNumeros=vSumaNumeros+vNumero;
          set vNumero=vNumero+1;
    end while nombreBucle;
  select vSumaNumeros;
end	$$
delimiter ;
call calculoSuma();
````
O _nombre_bucle_ neste caso non se usa pero podese usar para facer referencia a el noutra parte do programa.

### REPEAT
Basicamente é un do-while, o mismo que o while pero executa as sentencias como mínimo 1 vez.

O mesmo exemplo de arriba pero con repeat, como se ve xa non se pon o = na comprobación, porque executa primeiro as sentencias que a comprobación.

````mysql
repeat
    set vSuma = vSuma + vNumero; 
    set vNumero = vNumero+1; 
UNTIL vNumero>100
end repeat;
````

## Sentencias preparadas
Basicamente permiten facer querys con sustitución de parámetros. Pasos a seguir:
1. `PREPARE`: preparamos a sentencia que queremos executar, indicando con ? os parámetros que se van sustituir.
2. `EXECUTE`: usamos a sentencia preparada indicandolle os valores dos parámetros.
3. `DEALLOCATE` ou `DROP`: eliminase a sentencia preparada.

````mysql
PREPARE nombre_sentencia_preparada FROM sentencia_preparada;
EXECUTE nombre_sentencia_preparada [USING @nombre_variable[,@nombre_variable2]...];
{DEALLOCATE |DROP} PREPARE nombre_sentencia_preparada;
````

Exemplo:
````mysql
set @n1=9;
set @n2=10;
prepare suma from 'select ?+? as suma';
execute suma using @n1,@n2; #vai imprimir 13 co nome de columna 'suma'
deallocate prepare suma;
````

</div>

---
# 4. Rutinas almacenadas
Fan referencia aos **procedimientos almacenados** como as **funcións definidas polo usuario**. Son un conxunto de sentencias as que se lle da un `nome` e podenselle pasar unha serie de `parametros`.

Cando se crea unha rutina almacenada, o conxunto de instruccions queda almacenado e optimizado no servidor.
* Mellora o rendimiento
* Reduce a carga na rede
* AUMENTA a carga de traballo para o servidor

## Creación de rutinas almacenadas
A hora de crear a rutina almacenada queda ligada a base de datos que se estea usando ou a que se indique con `nombre_bd.nombreRutina`.
* Cando se queira utilizar o procedimiento ou función ten que estar activa a bd asociada ou ben indicar o nome da bd como arriba.
* Non pode haber duas rutinas almacenadas iguales
* Cando se borra a bd borranse todas as rutinas almacenadas asociadas.

Debido a este último punto, as veces é útil ter unha base de datos solo para as rutinas almacenadas, por se se queren usar en múltiples bases de datos. De esta maneira ainda que borremos algunha das bd que as usan non se borrarán, solo cando borremos a bd de rutinas almacenadas.

As info sobre as rutinas almacenadas gardase no diccionario de datos. Podese consultar con `mysql.proc` e `information_schema.routines`

### CREATE PROCEDURE y CREATE FUNCTION

````mysql
#Prodecimiento
CREATE [DEFINER={usuario | CURRENT_USER}]
PROCEDURE nome_procedemento ([parametro_procedemento [,...]])
[caracteristica ...]
sentencias
        
#Funcion
CREATE [DEFINER= {usuario | CURRENT_USER}]
FUNCTION nombre_funcion (parametro_funcion [,...])
RETURNS tipo_dato
[caracteristica ...]  corpo_rutina
````
* `DEFINER e SQL SECURITY`: con DEFINER indicase quen é o creador da rutina, podese poñer un usuario en concreto ou o usuario actual(CURRENT_USER)
* os parentesis que van despois do nome son obligatorios e son para os parametros, se  non hai deixanse vacios
* _parametro_procedimiento_: `[IN|OUT|INOUT] nombre_parametro tipo_dato`
  * `IN`: (por defecto)pasase para ser usado no procedemento, pode cambiar de valor pero o usuario non o vai saber
  * `OUT`: pasase unha variable na que se almacenará o resultado que devolve o parámetro. Valor inicial null.
  * `INOUT`: pasase para usarse durante o proceso e gardase o resultado do parámetro despois de executarse o procedimiento.
* _parametro_funcion_: `nombre_parametro tipo_dato`
* `RETURNS`: obligatoria, solo pode usarse en funcións. 
  * Indica o tipo de dato que devolve a función
  * Unha función solo pode retornar un valor

No caso de necesitar devolver mais de un valor necesitaremos usar un procedimiento con varios parámetros de salida(OUT)

## Uso de rutinas almacenadas
Procedimiento: usando `CALL nombre_procedimiento([parametros])`.
Funcións: como o resto de funcións de Mysql.

## Modificación de procedimentos e funcions
### ALTER PROCEDURE e ALTER FUNCTION
Permiten cambiar as características dunha rutina almacenada. Sen embargo NON permite cambiar:
* Parametros
* O corpo da rutina

Para esto hai que borralas e crealas de novo.

### DROP PROCEDURE e DROP FUNCTION
Permiten borrar procedimientos e funcións.



















