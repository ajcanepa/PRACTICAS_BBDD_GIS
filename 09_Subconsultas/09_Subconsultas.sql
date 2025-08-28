/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* GUIA CODIGOS TEMA 5 */
/*----------------------------------------------------------------------------------*/
/* Subconsultas*/
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Subconsultas no correlacionadas */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */ 
drop table if exists oficinas cascade;
drop table if exists categorias cascade;
drop table if exists empleados cascade;

create table oficinas(
	n_oficina 	char(5) primary key,
	poblacion	char(40),
	ventas		numeric(8),
	objetivo	numeric(8)
);

create table categorias(
	cargo 		char(10) primary key,
	sal 		numeric(5)
);

create table empleados(
	cod 		integer primary key,
	nombre		char(40),
	oficina 	char(5) references oficinas,
	cargo 		char(10) references categorias,
	comision	numeric(4,2)
);


insert into oficinas values ( 'OFI_1', 'Burgos', 10000, 10000),
			    ( 'OFI_2', 'Leon', 20000,   20000),
			    ( 'OFI_3', 'Burgos', null, 30000);

insert into categorias values ('GERENTE', 10000), ('SECRETARIO', 1000), ('VENDEDOR', 3000);

insert into empleados values 	( 1, 'Pepe', 'OFI_1', 'VENDEDOR', 10),
				( 2, 'Juan', 'OFI_1', 'VENDEDOR', 20),
				( 3, 'Alicia','OFI_1', 'GERENTE', 30),
				( 4, 'Luis', 'OFI_2', null, 15);

select * from oficinas;
select * from categorias;
select * from empleados;

/*----------------------------------------------------------------------------------*/
/* Subconsultas en la SELECT */
/*----------------------------------------------------------------------------------*/

-- la cuarta columna es constante y parece poco útil.
select cod, nombre, comision, (select comision from empleados 
				where nombre like 'Alicia%')
from empleados;

-- Si no hay un nombre que haga el WHERE, entonces devuelve NULL
select cod, nombre, comision, (select comision from empleados 
				where nombre='ataulfo')
from empleados;

-- Si el WHERE es muy general y hay más de una fila resultante, entonces falla
select cod, nombre, comision, (select comision from empleados 
				where nombre like '%a%')
from empleados;


/*----------------------------------------------------------------------------------*/
-- mostrar los nombres de los empleados junto con la desviación de su comisión respecto de la comisión media de los empleados de Burgos

-- obtenemos una fila por cada empleado con su nombre y la diferencia entre su comisión y la media de las comisiones que se pagan en las oficinas de Madrid
-- Primero: Calculamos el promedio 
SELECT AVG(comision)
FROM empleados, oficinas
WHERE oficina=n_oficina
AND poblacion='Burgos';

-- Restamos a cada comisión ese valor promedio (usando una subconsulta)
select * from empleados;
SELECT nombre, comision, comision - (SELECT AVG(comision)
				FROM empleados, oficinas
				WHERE oficina=n_oficina
				AND poblacion='Burgos' )
FROM empleados;


/*----------------------------------------------------------------------------------*/
/* Subconsultas en el FROM */
/*----------------------------------------------------------------------------------*/
-- Se le entrega un nombre a la tabla temporal creada
SELECT * FROM empleados;
	  
SELECT nombre, comision
FROM (SELECT * FROM empleados
		WHERE comision > 20) temporal;

-- Se puede llamar expresamente a esa tabla temporal mediante el uso de AS 
SELECT nombre, comision
FROM (SELECT * FROM empleados
		WHERE comision > 20) AS temporal;

-- También se puede poner este nombre como restricción de tabla.
SELECT nombre, porcentaje
FROM (SELECT nombre, comision AS porcentaje
	FROM empleados
	WHERE comision > 20) temporal;

-- funciona cuando se hacen operaciones matemáticas antes de ponerle nombre a los campos.
SELECT cargo, comision*1.15 
FROM (SELECT * FROM empleados
	WHERE comision > 20) temporal;
	
SELECT cargo, comision*1.15 as comision
FROM (SELECT * FROM empleados
	WHERE comision > 20) temporal;
	--WHERE comision >= 20) temporal; 
	
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/*Ejercicio 9
Haz una consulta que calcule la desviación estándar de las comisiones utilizando ambas fórmulas
ver apuntes pág. 55
*/
/*----------------------------------------------------------------------------------*/

-- Primera fórmula --> Directa (usando sqrt y POW)
SELECT sqrt(AVG(POW( comision, 2)) - POW(AVG( comision ), 2 ) )
FROM empleados;

-- Segunda fórmula, paso a paso

/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
--Las subconsultas en el FROM para emular el anidamiento de funciones sumarias
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */ 
drop table if exists datosMetereologicos;

CREATE TABLE datosMetereologicos(
	provincia	CHAR(11),
	localidad	CHAR(20),
	fecha		DATE,
	temperatura	NUMERIC(4,2),	
PRIMARY KEY( provincia, localidad, fecha)
);

INSERT INTO datosMetereologicos VALUES ( 'BURGOS', 'BURGOS',  CURRENT_DATE-1, 15);
INSERT INTO datosMetereologicos VALUES ( 'BURGOS', 'ARANDA',  CURRENT_DATE-1, 16);
INSERT INTO datosMetereologicos VALUES ( 'BURGOS', 'MIRANDA', CURRENT_DATE-1, 17);
INSERT INTO datosMetereologicos VALUES ( 'MADRID', 'MADRID',  CURRENT_DATE-2, 21);
INSERT INTO datosMetereologicos VALUES ( 'MADRID', 'GETAFE',  CURRENT_DATE-2, 23);

select * from datosMetereologicos;
/*----------------------------------------------------------------------------------*/

SELECT fecha, AVG(temperatura)
FROM datosMetereologicos
GROUP BY fecha;

SELECT MAX(promedio) FROM (
	SELECT fecha, AVG(temperatura) promedio
	FROM datosMetereologicos
	GROUP BY fecha
	) AS promedios;
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/*Ejercicio 11
1). Hallar la mínima comisión de entre las comisiones máximas de cada ciudad. 


/*----------------------------------------------------------------------------------*/
/* Subconsultas en el WHERE */
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Fila Única */

-- Siempre es mejor hacer un JOIN cuando se puede resolver con un JOIN
select * from empleados;
select * from oficinas;

SELECT cod, nombre FROM empleados
WHERE Oficina = (SELECT n_Oficina
			FROM oficinas
			WHERE poblacion = 'Leon');

-- similar solución pero más eficiente
SELECT cod, nombre FROM empleados, oficinas
WHERE Oficina = n_Oficina
AND poblacion = 'Leon';


-- ERROR porque hay más de una fila
--Mal porque hay 2 oficinas en Burgos
SELECT cod, nombre FROM empleados
WHERE Oficina = (SELECT n_Oficina
			FROM oficinas
			WHERE poblacion = 'Burgos');

--Bien, pero no devuelve nada porque no hay oficinas en Aranda
SELECT cod, nombre FROM empleados
WHERE Oficina = (SELECT n_Oficina
			FROM oficinas
			WHERE poblacion = 'Aranda');

--Correcto: sólo hay una oficina en Leon
SELECT cod, nombre FROM empleados
WHERE Oficina = (SELECT n_Oficina
			FROM oficinas
			WHERE poblacion = 'Leon');

	
-- SIEMPRE CORRECTO: La subconsulta devuelve una función sumaria y no tiene agrupamiento

-- Qué empleados tienen un valor en el campo salario por encima de la media

-- SIEMPRE CORRECTO: La subconsulta filtre por una clave, ya que el valor de una clave sólo puede tomarlo una fila a lo sumo

-- Qué empleados tienen un salario superior al 50% de las ventas de la oficina OFI_1

/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/*Ejercicio 12
1. Obtener el nombre del empleado con la comisión máxima.


2. Hallar el empleado que más gana, teniendo en cuenta que el sueldo se calcula como
sal+comisión*ventas/100.

*/
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Fila Múltiples */
/*
Para poder operar con subconsultas que devuelven varias filas tenemos varios operadores: ANY, ALL, EXISTS, IN y SOME.

Todos van acompañados de un comparador (<, >, <=, >=, =, !=). 

-- ANY, IN y SOME son similares
-- ALL es un poco diferente ya que:
-- No tiene sentido usarlo con un = (no se puede ser iguala todo)
Si un valor es > que ALL, significa que es > que el máximo
Si un valor es >= que ALL, significa que es >= que el máximo
Si un valor es < que ALL, significa que es < que el mínimo
Si un valor es <= que ALL, significa que es <= que el mínimo
*/

--los empleados que tienen un salario superior que el 50% de las ventas de alguna oficina.
select * from categorias;
select * from empleados;
select * from oficinas;


SELECT * FROM empleados natural join categorias
WHERE sal > ANY (SELECT 0.5*ventas FROM oficinas);

-- Igual pero usando SOME
SELECT * FROM empleados natural join categorias
WHERE sal > SOME (SELECT 0.5*ventas FROM oficinas);


-- Si algun acondición NO se cumple (ninguna fila cumple el WHERE), la primera consulta no devuelve nada.(OJO No es error, sino NADA)
SELECT * FROM empleados natural join categorias
WHERE sal > ANY (SELECT ventas FROM oficinas
			WHERE ventas=-1);


-- EL ANY también se puede escribir como un IN, pero OJO. Las subconsultas con IN se pueden hacer de manera más sencilla con un JOIN, prefiere el JOIN!
SELECT * FROM empleados
WHERE oficina =  ANY (SELECT n_oficina
			FROM oficinas
			WHERE ventas > 10000);


/*Ejericios por puntos (0.5 c/u)
-- Realizar Ejercicio anterior usando a) Producto Cartesiano y b) Left JOIN
a) -- Ya ESTÁ EN LOS APUNTES


b)

*/

-- Igual pero usando IN
SELECT * FROM empleados
WHERE oficina IN (SELECT n_oficina
			FROM oficinas
			WHERE ventas >= 10000);

/* USO DEL ALL
Si un valor es > que ALL, significa que es > que el máximo
Si un valor es >= que ALL, significa que es >= que el máximo
Si un valor es < que ALL, significa que es < que el mínimo
Si un valor es <= que ALL, significa que es <= que el mínimo
*/

-- Empleados que tienen un salario menor que las ventas de cualquiera de las oficinas
SELECT * FROM empleados natural join categorias
WHERE sal < ALL (SELECT ventas FROM oficinas);

-- No tiene sentido usarlo con la igualdad, porque no se puede ser igual a dos cosas que son distintas
SELECT * FROM empleados natural join categorias
WHERE sal = ALL (SELECT ventas FROM oficinas);

-- Curiosidad: Cuando la subconsulta no devuelve ninguna fila (el WHERE de la subconsulta nadie lo verifica = satisface), pasa que muestra todo lo del primer select
SELECT empleados.* FROM empleados natural join categorias
WHERE sal < ALL (SELECT ventas FROM oficinas
		WHERE ventas < 0);
		
--por lo que es igual a:
SELECT * FROM empleados natural join categorias;


/*Ejercicio 13
Repetir el ejercicio anterior utilizando ALL en lugar de MAX:

1. Obtener el nombre del empleado con la comisión máxima.


2. Hallar el empleado que más gana, teniendo en cuenta que el sueldo se calcula como
sal+comisión*ventas/100.

*/


*/
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Subconsultas en el HAVING */
/*----------------------------------------------------------------------------------*/

-- se pide hallar las oficinas cuyo sueldo máximo de empleado (que se calcula como sal+comisión*ventas/100) es mayor que lo que vende la oficina que menos vende.
--SELECT *
SELECT oficina
FROM empleados	JOIN categorias USING(cargo)
		JOIN oficinas ON (oficina=n_oficina)
GROUP BY oficina
HAVING 
  MAX(sal+comision*ventas/100) > (SELECT MIN(ventas)
				   FROM oficinas);

*/

/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* La clausula WITH */
/*----------------------------------------------------------------------------------*/
-- Pej. el máximo de la temperatura promedio se podría reformular así:
WITH promedios AS (
	SELECT fecha, AVG(temperatura) as promedio
	FROM datosMetereologicos
	GROUP BY fecha
	) 
SELECT MAX(promedio) FROM promedios;

-- WITH es útil si la misma subconsulta hay que utilizarla varias veces, pues con el WITH sólo es necesario definirla una vez.

--P.Ej. los nombres de los empleados que ganan más que la media
select nombre, sal+comision*ventas/100
from empleados join oficinas on(oficina=n_oficina) natural join categorias
where sal+comision*ventas/100 > (select avg(sal+comision*ventas/100)
					from empleados join oficinas on(oficina=n_oficina) natural join categorias); -- ver código repetido en el segundo select


-- Evitamos el código repetido usando WITH
with empleadosConSuSueldo as (
	select *, sal+comision*ventas/100 totalSueldo
	from empleados join oficinas on(oficina=n_oficina) natural join categorias)
select nombre, totalSueldo
from empleadosConSuSueldo
where totalSueldo > (select avg(totalSueldo)
		     from empleadosConSuSueldo);


-- Vendedores que tienen una comisión por debajo de la comisión promedio de los vendedores y desviación de su comisión respecto a ese promedio
-- SIN WITH

-- CON WITH

-- listado con todos los empleados y 
-- (1) la desviación de su comisión respecto al promedio de las comisiones que hay en su cargo,
-- (2) la desviación de su comisión respecto al promedio de las comisiones que hay en las oficinas de su población.

/*
Ejercicio 14
Rehaz el Ejercicio 10 utilizando subconsultas WITH en lugar de subconsultas en el FROM
Utiliza una subconsulta llamada "producto" para el producto cartesiano,
otra llamada "join_interno" para el join interno,
y otra llamada "resta" para hacer la resta entre el producto y el join interno

Oficinas que tienen todos los cargos
 delete from categorias where cargo='SECRETARIO';
*/
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Referencias Externas y Subconsultas Correlacionadas */
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */ 
DROP TABLE IF EXISTS oficinas CASCADE;
DROP TABLE IF EXISTS vendedores CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;

CREATE TABLE oficinas(
 n_oficina  integer primary key,
 poblacion     char(20),
 objetivo   integer,
 ventas     integer
 );

INSERT INTO oficinas VALUES ( 1, 'Burgos',     200, 400);
INSERT INTO oficinas VALUES ( 2, 'Madrid',    1000, 1000);
INSERT INTO oficinas VALUES ( 3, 'Barcelona', 1000, 0);

 CREATE TABLE categorias(
  cargo char(20) primary key,
  sal   integer
 );

INSERT INTO categorias VALUES ('COMERCIAL',          100);
INSERT INTO categorias VALUES ('TECNICO COMERCIAL',  150);
INSERT INTO categorias VALUES ('DIRECTOR COMERCIAL', 250);

 CREATE TABLE vendedores(
  idVendedor integer primary key,
  nombre     char(20),
  cuota      integer,
  comision   integer,
  oficina    integer  references oficinas,
  cargo      char(20) references categorias
 );

INSERT INTO vendedores VALUES ( 1, 'Pepe', 100, 20, 1, 'DIRECTOR COMERCIAL');
INSERT INTO vendedores VALUES ( 2, 'Juan', 100, 10, 1, 'TECNICO COMERCIAL');
INSERT INTO vendedores VALUES ( 3, 'Ana',  100, 0, 1, 'COMERCIAL');

INSERT INTO vendedores VALUES ( 4, 'Maria', 100, 7, 2, 'DIRECTOR COMERCIAL');
INSERT INTO vendedores VALUES ( 5, 'Luis',  100, 7, 2, 'COMERCIAL');


select * from oficinas;
select * from categorias;
select * from vendedores;
/*----------------------------------------------------------------------------------*/

-- la población de las oficinas cuyo objetivo sea mayor que la suma de la cuota de los vendedores de esa oficina.
-- el campo n_oficina no está en el FROM de la subconsulta (vendedores) y se le llama "REFERENCIA EXTERNA"
SELECT poblacion FROM oficinas 
WHERE objetivo >(SELECT SUM(cuota)
		FROM vendedores
		WHERE oficina=n_oficina); -- sql busca primero en la sub-cons y sino en la cons.

SELECT * FROM oficinas; -- posee el campo n_oficina pero vive en el primer select
SELECT * FROM vendedores; -- posee el campo oficina y vive solo en la subconsulta


-- si el campo existe en la subconsulta, pero necesito que sea el campo de la consulta principal, entonces deberé forzar la "REFERENCIA EXTERNA"

-- los cargos en los que el salario es mayor que la suma de las cuotas de los vendedores “de esas categoría”.

-- sin Referenciar
select * from vendedores;
select * from categorias;

SELECT cargo FROM categorias
WHERE sal > (SELECT SUM(cuota)
		FROM vendedores
		WHERE cargo=cargo); 

-- Incluyendo la referencia a la tabla de la consulta
SELECT cargo FROM categorias
WHERE sal > (SELECT SUM(cuota)
		FROM vendedores
		WHERE cargo=categorias.cargo); 

/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Cómo interpretar una subconsulta correlacionada */
/*----------------------------------------------------------------------------------*/

-- Se estudiará a partir de la consulta anterior:

SELECT poblacion FROM oficinas 
WHERE objetivo > (SELECT SUM(cuota)
			FROM vendedores
			WHERE oficina = n_oficina);
			

-- Analizamos fila por fila
select * from oficinas;

select * from vendedores;

-- susituimos el valor de la primera oficina (n_oficina=1), porque lo conocemos...veamos:
SELECT n_oficina, poblacion, objetivo FROM oficinas;

-- Oficinas.n_oficina=1, objetivo=200
-- La suma de la cuota de los vendedores de la oficina 1 es 300, y 
-- el objetivo de esa oficina es 200, por tanto esa oficina no saldrá en el resultado.
SELECT poblacion FROM oficinas 
WHERE objetivo > (	SELECT SUM(cuota)
			FROM vendedores
			WHERE oficina=1)
AND n_oficina=1;


--Oficinas.n_oficina=2, objetivo=1000
-- En este caso el objetivo es 1000 y la suma de las cuotas es 200, luego esta oficina 2 sí saldrá
SELECT poblacion FROM oficinas 
WHERE objetivo > (	SELECT SUM(cuota)
			FROM vendedores
			WHERE oficina=2)
AND n_oficina=2;


--Oficinas.n_oficina=3, objetivo=1000
-- Como no hay vendedores en la oficina 3, la subconsulta devuelve vacío (nulo en los apuntes).
SELECT poblacion FROM oficinas 
WHERE objetivo > (	SELECT SUM(cuota)
			FROM vendedores
			WHERE oficina=3)
AND n_oficina=3;
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Subconsultas correlacionadas en la SELECT */
/*----------------------------------------------------------------------------------*/

/* 
Podemos tener una correlacionada en la SELECT con la misma restricción que las no
correlacionadas: (i.e., siempre que devuelva una fila como máximo). 

Importante, en el primer caso veremos que dice que la oficina de la subconsulta es la misma que la de la consulta principal.

*/

-- el nombre de cada empleado con la diferencia de la comisión respecto del promedio de su oficina (observa como el “de su” delata/sugiere que necesitamos una correlacionada).

-- Calcular manualmente el la comisión - promedio por oficina (Maria y Luis = 0)
SELECT nombre, comision, oficina 
FROM vendedores;

-- Si no indexamos la variable, la calcula como el promedio general de todas las filas (no por oficina)
SELECT nombre, comision - (SELECT AVG(comision)
                            FROM vendedores
                            WHERE oficina = oficina)
FROM vendedores;

-- observa como el “de su” delata/sugiere que necesitamos una correlacionada y para ello además agregamos un índice (puede ser cualqueira) tanto en la subconsulta como en el FROM de la consulta principal.
SELECT nombre, comision - (SELECT AVG(comision)
                            FROM vendedores
                            WHERE oficina = v.oficina)
FROM vendedores v;




/*Deshacer la correlación oficina de vendedor por oficina de vendedor

SELECT nombre, comision, comision - ( SELECT AVG(comision)
                            FROM vendedores
                            WHERE oficina = 1)
FROM vendedores e
WHERE oficina=1

union

SELECT nombre, comision, comision - ( SELECT AVG(comision)
                            FROM vendedores
                            WHERE oficina = 2)
FROM vendedores e
WHERE oficina=2

union

SELECT nombre, comision, comision - ( SELECT AVG(comision)
                            FROM vendedores
                            WHERE oficina = 3)
FROM vendedores e
WHERE oficina=3;

*/

/*******************************************
SELECT * FROM vendedores;

while haya vendedores que leer{
	e := siguiente vendedor;

        sP_nombre   := e.nombre;
        sP_comision := e.comision;
        sP_oficina  := e.oficina;
        
        avg_comison := SELECT AVG(comision)
                            FROM vendedores
                            WHERE oficina = [sP_oficina];

        mostrar( sP_nombre, sP_comision, sP_comision-avg_comison );
}

*******************************************/

/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Subconsultas correlacionadas en el WHERE */
/*----------------------------------------------------------------------------------*/
/* Correlacionadas en el where con ANY/ALL */

--las ciudades de las oficinas que venden por debajo de la comisión multiplicada por un cien de alguno de sus vendedores (nuevamente observa el “sus”).
select * from oficinas;
select * from vendedores;


SELECT poblacion FROM oficinas                                         
WHERE ventas < ANY (SELECT comision*100
                    FROM vendedores
                    WHERE oficina=n_oficina); -- reconoce que n_oficina viene de oficinas
                    
-- Igual pero especificando la tabla de donde viene el campo n_oficina
SELECT poblacion FROM oficinas                                         
WHERE ventas < ANY (SELECT comision*100
                    FROM vendedores
                    WHERE oficina= oficinas.n_oficina);


--explicación de la operacion
SELECT n_oficina, poblacion, ventas, comision*100 as "comision x 100"
FROM oficinas left join vendedores ON(oficina=n_oficina)
order by n_oficina;

-- poblaciones de las oficinas en las que para todos los empleados de esa oficina las ventas de la oficina sean menores que la comisión del empleado multiplicada por mil.

SELECT poblacion FROM oficinas 
WHERE ventas < ALL( SELECT comision*1000
		    FROM vendedores
		    WHERE oficina=n_oficina);

-- explicación de la operacion
SELECT n_oficina, poblacion, ventas, comision*1000 as "comision x 1000"
FROM oficinas left join vendedores ON(oficina=n_oficina)
order by n_oficina;

--Deshago la correlación razonando oficina por oficina
--Burgos->Ofi1->Ventas=400
--                     Pepe 20*1000=20000 
--                     Juan 10*1000=10000 
--                     Ana   0*1000=0 => Contraejemplo en el que ventas<comision*1000 no es verdadero => ALL no se cumple => Burgos no sale
--
--Madrid->Ofi2->Ventas=1000
--                     Maria 7*1000=7000 
--                     Luis  7*1000=7000 => No hay Contraejemplos => Madrid sale
--
--Barcelona->Ofi3->Ventas=0 sin empleados => No Contraejemplo => Barcelona sale
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Subconsultas correlacionadas en el HAVING */
/*----------------------------------------------------------------------------------*/

--Poblaciones en las que el promedio de la comision de sus oficinas es menor que el doble de la comision de todos sus empleados => hay mucha varianza en las comisiones (estan mal repartidas)

SELECT poblacion
FROM oficinas JOIN vendedores ON(oficina=n_oficina)
GROUP BY n_oficina, poblacion		--Podia haber habido 2 oficinas en la misma poblacion
HAVING AVG(comision) < ALL (SELECT comision*2
                            FROM vendedores
                            WHERE oficina=n_oficina);


-- Explicación de la Operación
SELECT n_oficina, poblacion, comision*2 "comision*2", 
      (select avg(comision) from vendedores where oficina=n_oficina) "avg(comision)"
FROM oficinas JOIN vendedores ON(oficina=n_oficina);	

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Subconsultas Correlacionadas con EXISTS */
/*----------------------------------------------------------------------------------*/
/* 

El test de existencia en SQL cuenta el número de filas en la subconsulta, si ese número es cero devuelve falso, y sino verdadero.

El EXISTS solo tiene sentido con las correlacionadas

La subselect se pone con *, porque da igual que campos devuelva
 */

-- Los nombres de los vendedores y de las oficinas con ventas mayor que 500
-- Usando un JOIN aparece todo (sirve para anticipar el resultado
select nombre, ventas
FROM oficinas JOIN vendedores ON(oficina=n_oficina);

-- Usando EXISTS
SELECT nombre, oficina FROM vendedores
WHERE EXISTS (SELECT * FROM oficinas
               WHERE oficina=n_oficina
               AND ventas > 500);

/*
--correlacion deshecha en SQL

SELECT nombre, oficina FROM vendedores
WHERE oficina=1
and EXISTS ( SELECT * FROM oficinas
               WHERE n_oficina=1
               AND ventas > 500)

union

SELECT nombre, oficina FROM vendedores
WHERE oficina=2
and EXISTS ( SELECT * FROM oficinas
               WHERE n_oficina=2
               AND ventas > 500)
union
               
SELECT nombre, oficina FROM vendedores
WHERE oficina=3
and EXISTS ( SELECT * FROM oficinas
               WHERE n_oficina=3
               AND ventas > 500)
;

*/

--Suelen tener una equivalente directa con join --> Se prefiere el JOIN
SELECT nombre, oficina
FROM vendedores join oficinas ON(oficina=n_oficina)
WHERE ventas > 500;

--Tambien son utiles para hacer intersecciones, P.Ej:
--Oficinas con tecnicos comerciales y directores comerciales
-- usando algebra relacional (intersect)
SELECT oficina FROM vendedores where cargo='COMERCIAL'
intersect
SELECT oficina FROM vendedores where cargo='DIRECTOR COMERCIAL';

--Es lo mismo que "las oficinas donde existan unos y otros" usando exists y AND
SELECT n_oficina FROM oficinas
where exists (select * from vendedores where cargo='COMERCIAL' and oficina=n_oficina)
and exists (select * from vendedores where cargo='DIRECTOR COMERCIAL' and oficina=n_oficina);


--Con el NOT tiene equivalencia con el EXCEPT (restas en Álgebra)
--Con Algebra: Vendedores de las oficinas donde no existen técnicos comerciales = Vendedores de todas las oficinas - vendedores de las oficinas con tecnicos

select nombre from vendedores, (select n_oficina
				from oficinas
				except
				select oficina
				from  vendedores
				where cargo = 'TECNICO COMERCIAL'
				) as ifSinTecnic
where oficina=n_oficina;

-- Con NOT Exists se puede pedir también las oficinas para las que no existe un cargo que sea técnico comercial
SELECT nombre, oficina FROM vendedores externa
WHERE NOT EXISTS ( SELECT * FROM vendedores 
                   WHERE externa.oficina=oficina
                   AND cargo='TECNICO COMERCIAL');

/*
-- Igualando el where con el cero
SELECT nombre, oficina FROM vendedores externa
WHERE 0=( SELECT count(*) FROM vendedores 
          WHERE externa.oficina=oficina
          AND cargo='TECNICO COMERCIAL');
*/

-- Incluso el cociente se pude plantear con NOT EXISTS. Por ejemplo, oficinas que tienen empleados de todos los cargos posibles

SELECT n_oficina from oficinas
WHERE not exists ( SELECT * FROM categorias
                   WHERE not exists ( SELECT * FROM vendedores
                                      WHERE oficina = n_oficina
                                      AND cargo = categorias.cargo));
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Ejercicio 16 */
/*----------------------------------------------------------------------------------*/
/* 
--Ejemplos reformular ANY, ALL, IN con EXISTS
 */


--poblaciones de las oficinas en las que las ventas sean menores que 10 veces la cuota de un vendedor

/*
SELECT poblacion FROM oficinas 
WHERE ventas < ANY(	SELECT cuota*10
			FROM vendedores
			WHERE oficina=n_oficina); 
		
               
SELECT poblacion FROM oficinas 
WHERE EXISTS(	SELECT *
		FROM vendedores
		WHERE oficina=n_oficina
		AND ventas < cuota*10); 

*/

/*O con all => que las ventas sean menor que el 10% de la cuota de todos sus vendedores
=> que en esa oficina no existe un vendedor que haga de contraejemplo 
en el que las ventas sean mayores o iguales que el 10% de la cuota de ese vendedor
*/

/*
SELECT poblacion FROM oficinas 
WHERE ventas < ALL(	SELECT cuota*10
			FROM vendedores
			WHERE oficina=n_oficina); 

SELECT poblacion FROM oficinas 
WHERE not EXISTS(	SELECT *
		FROM vendedores
		WHERE oficina=n_oficina
		AND ventas >= cuota*10); 

*/
--oficinas con empleados (de esa/su oficina) cuyo salario sea superior al 50% del objetivo de la oficina

/*
SELECT n_oficina FROM oficinas
WHERE (objetivo/2)< ANY(
	SELECT sal+comision*ventas/100
	FROM vendedores JOIN categorias USING(cargo)
	WHERE oficina=n_oficina	);

SELECT n_oficina FROM oficinas
WHERE EXISTS( SELECT *
	FROM vendedores JOIN categorias USING(cargo)
	WHERE oficina=n_oficina
	AND (objetivo/2)<sal+comision*ventas/100);
*/
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* 6.3 Caso de Estudio: El cociente relacional mediante subconsulta en el HAVING */
/*----------------------------------------------------------------------------------*/

/* 
Las subconsultas en la clausula HAVING nos proveen un mecanismo más sencillo, eficiente y
versátil de realizar la operación de cociente relacional que los vistos hasta ahora. (Ejemplo Chicos conocen chicas)
*/

-- La consulta que obtiene el cociente de los chicos que conocen a todas las chicas podría plantearse de una forma distinta a la que se mostró en el tema del álgebra relacional.

/*----------------------------------------------------------------------------------*/
/* Bases de datos para trabajar */

drop table if exists CHICOS, CHICAS, CONOCE;


create table CHICOS(
	DNIchico 	integer primary key,
	nombre	 	varchar(10),
	colorPelo 	varchar(10),
	instituto	varchar(20)
);

insert into CHICOS values	
	 (1, 'Pepe', 'Negro', 'Instituto 1'),
	 (2, 'Juan', 'Rubio', 'Instituto 2'),
	 (3, 'Luis', 'Negro', 'Instituto 2'),
	 (7, 'Martin', 'Marron', 'Instituto 3');

create table CHICAS(
	DNIchica 	integer primary key,
	nombre	 	varchar(10),
	colorPelo 	varchar(10),
	instituto	varchar(20)
);

insert into CHICAS values	
	 (4, 'Ana',	'Rojo',  'Instituto 1'),
	 (5, 'Maria',	'Rojo',  'Instituto 2'),
	 (6, 'Pepa',    'Negro', 'Instituto 2');

create table CONOCE( 
	DNIchico integer references CHICOS,
	DNIchica integer references CHICAS,
	PRIMARY KEY (DNIChico, DNIChica));
	
insert into CONOCE values
	 (1, 4),
	 (1, 5),
	 (1, 6),
	 (2, 4),
	 (2, 5),
	 (3, 5),
	 (3, 6),
	 (7, 4);

select * from CHICOS;
select * from CHICAS;
select * from CONOCE;
/*----------------------------------------------------------------------------------*/

-- Calculamos cuántas chicas hay, lo cual se puede calcular trivialmente haciendo:
SELECT COUNT(*) FROM Chicas;


-- El cociente de los chicos que conocen a todas las chicas, podría replantearse como chicos que conocen a n chicas
--DNI Chicos que conocen a todas las chicas
SELECT DNIchico FROM conoce
GROUP BY DNIchico
HAVING count(*) = ( SELECT COUNT(*) FROM Chicas);


-- Si además queremos el nombre de los chicos que conocen a todas las chicas, deberemos de apoyarnos en la tabla de chicos, para lo cual haremos join con la misma
SELECT DNIchico, nombre FROM conoce natural join chicos
GROUP BY DNIchico, nombre
HAVING count(*) = ( SELECT COUNT(*) FROM Chicas);


-- Aumentamos la complejidad de la pregunta:
--insertamos una chica que no conoce nadie
insert into CHICAS values	
	 (7, 'Luisa',	'Negro',  'Instituto 1');

-- en la tabla conocen, la misma chica puede parecer varias veces si es conocida por más de un chico.
-- para contar cuantas chicas conocidas hay, hay que utilizar un COUNT(DISTINCT DNIChica):
SELECT COUNT(DISTINCT DNIChica) FROM Conoce;

--Nombre chicos que conocen a todas las chicas que son conocidas por algun chico
SELECT DNIchico, nombre FROM conoce natural join chicos
GROUP BY DNIchico, nombre
HAVING count(*) = ( SELECT COUNT(distinct dniChica) FROM Conoce);

--borramos a la chica desconocida
delete from chicas where dniChica=7;

--los institutos tal que entre todos sus chicos conocen a todas las chicas
SELECT instituto FROM conoce natural join chicos
GROUP BY instituto
HAVING count(DISTINCT dniChica) = ( SELECT COUNT(*) FROM Chicas);

--Chicos que conocen a todas las pelirrojas

--MAL
SELECT DNIchico, nombre FROM conoce natural join chicos
GROUP BY DNIchico, nombre
HAVING count(*) = ( SELECT COUNT(*) FROM Chicas
			WHERE colorPelo='Rojo');

--BIEN
SELECT DNIchico, chicos.nombre 
FROM (conoce natural join chicos) join chicas using (DNIchica)
WHERE chicas.colorPelo='Rojo'
GROUP BY DNIchico, chicos.nombre 
HAVING count(*) = ( SELECT COUNT(*) FROM Chicas
			WHERE colorPelo='Rojo');

--Chicos del instituto 2 que conocen a todas las pelirrojas
SELECT DNIchico, chicos.nombre 
FROM (conoce natural join chicos) join chicas using (DNIchica)
WHERE chicas.colorPelo='Rojo'
AND chicos.instituto='Instituto 2'
GROUP BY DNIchico, chicos.nombre 
HAVING count(*) = ( SELECT COUNT(*) FROM Chicas
			WHERE colorPelo='Rojo');

--chicos que conocen a más del 50% de las chicas
SELECT DNIchico, nombre FROM conoce natural join chicos
GROUP BY DNIchico, nombre
HAVING count(*) >= 0.5*( SELECT COUNT(*) FROM Chicas);
