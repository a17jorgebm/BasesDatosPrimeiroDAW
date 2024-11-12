---
# TEMA 4
## SELECT
Sintaxis
````mysql
SELECT [ALL | DISTINCT | DISTINCTROW] lista_de_selección
[FROM tablas]
[WHERE expresión_condicional]
[GROUP BY {lista_columnas | expresión | posición}]
[HAVING expresión_condicional]
[ORDER BY {columna | expresión | posición} [ASC | DESC], ...]
[LIMIT intervalo]
[INTO OUTFILE 'nombre_archivo']
````[resumen-tema7.md](UD7%2Fresumen-tema7.md)
* DISTINCT e ALL especifican se hai que mostrar as filas duplicadas ou non
  *  ALL é por defecto e mostra todo
  * DISTINCT non mostra as filas duplicadas
* *lista de selección* é a relación dos datos que se queren obter da consulta, separados por comas


