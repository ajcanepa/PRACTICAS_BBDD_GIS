/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* GUIA CODIGOS TEMA 5 */
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Manipulación de valores nulos */ 
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Los nulos y las operaciones de SQL */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
drop table if exists miTabla;

create table miTabla(
  campo1 char(20),
  campo2 char(20),
  campo3 char(20) default 'por defecto'
 );

select * from miTabla;

/*----------------------------------------------------------------------------------*/
/* Agregando valores NULL */

-- Agregando campos y valores y dejando uno sin "tocar"
INSERT INTO miTabla (Campo1, Campo3)
VALUES ('Valor Campo 1', 'Valor Campo 3');
select * from miTabla;

-- Tocando un valor de un atributo y forzándole a que sea null por declararlo como tal 
INSERT INTO miTabla ( Campo1, Campo3 )
VALUES ('Valor Campo 1', null);
select * from miTabla;

-- En este caso no se crean los NULL porque el campo3 tiene un default.
-- Pregunta participación
INSERT INTO miTabla
VALUES ('Valor Campo 1', 'Valor Campo 2');
select * from miTabla;

/*----------------------------------------------------------------------------------*/
/* Actualizando la tabla con NULL */

-- Cambiamos el campo1 a nulo usando UPDATE
UPDATE miTabla
SET Campo1=null
WHERE campo2='Valor Campo 2';

select * from miTabla;

/*----------------------------------------------------------------------------------*/
/* Añadiendo una columna a una tabla (más exótico) */

-- Añadiendo una columna a una tabla con ADD COLUMN. 
-- Si no hay valor por defecto, entonces todos los valores serán null
ALTER TABLE miTabla
ADD COLUMN Campo4 CHAR(5);

select * from miTabla;

-- Agregando una columna, pero esta vez SÍ seleccionamos un DEFAULT
ALTER TABLE miTabla
ADD COLUMN Campo5 CHAR(5) DEFAULT 'x';

select * from miTabla;

INSERT INTO miTabla ( Campo1, Campo2, Campo3 )
VALUES ('', ' ', null);

select * from miTabla;

/*----------------------------------------------------------------------------------*/
/* Cálculos usando null */

drop table if exists Facturas cascade;
create table facturas (
 numFactura 	integer primary key,
 razonSocial    char(40),
 total		numeric(8,2)
);

insert into facturas values (1, null, null), (2, 'Pepe', 10);

select * from facturas;

-- casi cualquier operación con un null dará un null.
SELECT numFactura, 
	total*1.15, 
	'A la atencion de ' || razonSocial , 
	cos(total), 
	substr(razonSocial, 2, 3)
FROM Facturas;
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* La lógica trivaluada */ 
/*----------------------------------------------------------------------------------*/

/*
Casi cualquier operación con un null dará un null, con algunas excepciones que son las que revisaremos.

Nota: Abrir páginas 9 y 10 de la Guía del Tema 5 y pdf de "Trivaluada".

OR:
Verdadero OR null = Verdadero  (T OR NULL = TRUE)
Falso OR null = null           (FALSE OR NULL = NULL)

AND:
Verdadero AND null = null      (TRUE AND NULL = NULL)
Falso AND null = FALSO         (FALSE AND NULL = FALSE)

NOT:
NOT TRUE = FALSE
NOT FALSE = TRUE
NOT NULL = NULL

Importante para entender lo que va a mostrar un predicado WHERE
*/
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Predicados WHERE SQL y el nulo */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
drop table if exists empleados cascade;

create table empleados(
	id 	integer primary key,
	nombre  char(20),
	salario numeric(8,2)
);

insert into empleados values ( 1, 'Pepe', 50), (2, 'Juan', null), ( 3, 'Ana', 200);

select * from empleados;
/*----------------------------------------------------------------------------------*/
/* WHERE y NULL */

-- Testamos por mayores que un valor fijo
--Pepe>100=FALSE // Ana>100 = TRUE // Juan (null)>100 = NULL
SELECT nombre FROM empleados WHERE salario>100;

--Si queremos seleccionar a aquellos NULL...
SELECT nombre FROM empleados WHERE salario=NULL;

--Si queremos seleccionar a aquellos NULL usamos correctamente...
SELECT nombre FROM empleados WHERE salario IS NULL;

--Tampoco muestra filas para la negación de null, porque como uno de los miembros es null, entonces el resultado tiene un null y por ende no lo muestra 
SELECT nombre FROM empleados WHERE salario!=NULL;

--Manera correcta de preguntar por los NOT NULL
SELECT nombre FROM empleados WHERE salario IS NOT NULL;

-- También se puede usar
--SELECT nombre FROM empleados WHERE NOT salario IS NULL;

/*----------------------------------------------------------------------------------*/
/* WHERE, AND, OR y NULL */
/*----------------------------------------------------------------------------------*/

-- creamos una tabla especial con combinaciones de null y el resultado como comentarios
drop table if exists alumnos cascade;

create table alumnos(	
	nombre  char(20) primary key,
	altura  numeric(3,2),
	peso	numeric(3,1)
);

insert into alumnos values --peso>67  altura>1.70	peso>67 OR altura>1.70  sale?
( 'Pepe', null, 70),       --V			N			V						Si
('Juan', 1.80, null),	   --N			V			V						Si
('Ana', null, null),	   --N			N			N						No
('Luis', 1.50, null),      --N			F			N						No
('Maria', null, 60);       --F			N			N						No

select* from alumnos;

/*----------------------------------------------------------------------------------*/
/* WHERE, OR y NULL */
/*----------------------------------------------------------------------------------*/

--seleccionamos aquellos que peso sea mayor que 67 ó que la altura mayor que 1.7 

--Si sólo pedimos los nombres

--Deberían salir todos, pero no es así. Sólo sale Pepe y Ana, poque tienen algun valor

--Si queremos que aparezcan los null deberemos llamarlos usando IS NULL.

/*----------------------------------------------------------------------------------*/
/* WHERE, AND y NULL */
/*----------------------------------------------------------------------------------*/

-- Borramos valores
delete from alumnos;

--Agregamos nuevos valores
insert into alumnos values --peso>67  altura>1.70	peso>67 AND altura>1.70  sale?
( 'Pepe', null, 70),       --V			N			N						No
('Juan', 1.80, null),	   --N			V			N						No
('Ana', null, null),	   --N			N			N						No
('Luis', 1.50, null),      --N			F			F						No
('Maria', null, 60);       --F			N			F						No

select * from alumnos; --no es tan importante ahora

--No devuelve nada porque en combinación con el AND hay solo NULL y FALSE y no se muestran 
SELECT nombre FROM alumnos
WHERE peso>67 AND altura>1.70;

/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Los nulos y CREATE TABLE */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* NULL y CHECK */
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */

drop table if exists empleados cascade;

create table empleados(
	id 		integer primary key,	
	nombre  	char(20),
	salario 	numeric(8,2) not null check ( salario > 100),
	comision 	numeric(8,2) check ( comision > 10)
);

-- Permite agregar un null porque comision solo tiene un check
insert into empleados values ( 1, 'Pepe', 1000, null); -- null es válido
select * from empleados;

-- No permite esto porque hemos especificado un not null
insert into empleados values ( 2, 'Pepe', null, 20); -- null no es válido


-- Falla porque estamos ingresando un valor menor
insert into empleados values ( 3, 'Pepe', 50, 20);

/*----------------------------------------------------------------------------------*/
/* Not Null dentro del check como predicados lógicos, similar a anterior */

drop table if exists empleados cascade;

create table empleados(
	id 		integer primary key,
	nombre  	char(20),
	salario NUMERIC( 8,2)	CHECK (salario IS NOT NULL AND salario>100),
	comision NUMERIC( 8,2)	CHECK (comision IS NULL OR comision>10)
);

-- Falla igual que anterior, por meter un valor menos a 100
insert into empleados values ( 1, 'Pepe', 50, 20);

-- Falla porque mete un salario not null
insert into empleados values ( 1, 'Pepe', null, 20);

-- Funciona porque tenemos un is null
insert into empleados values ( 2, 'Pepe', 1000, null);
select * from empleados;


/*----------------------------------------------------------------------------------*/
/* UNIQUE */
/*----------------------------------------------------------------------------------*/
/* UNIQUE con clave simple */

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */

drop table if exists empleados cascade;

create table empleados(
	id integer primary key,
	dni numeric(8) unique
);


-- Falla porque prmary key implica a not null
insert into empleados values (null, 1);

-- Funciona porque unique NO implica not null y los null por ser comodines sí se pueden repetir
insert into empleados values ( 1, null), (2, null);

select * from empleados;

/*----------------------------------------------------------------------------------*/
/* UNIQUE con clave Compuesta */
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */


drop table if exists vecinos;

CREATE TABLE vecinos (
	nombre	CHAR(20),
	ape1	CHAR(20),
	ape2	CHAR(20),
	planta	SMALLINT,
	letra	CHAR(1),
	tfno	NUMERIC(9),
	PRIMARY KEY (nombre, ape1, ape2), -- ninguno soporta nulos
	UNIQUE ( planta, letra) -- soportan nulos y repeticiones en cada una por separado
);

-- Fallan porque una PK compuesta require not null en cada una de las combinaciones
insert into vecinos ( nombre, ape1, ape2 ) values (null, 'Garcia', 'Fernandez');	
insert into vecinos ( nombre, ape1, ape2 ) values ('Pedro', null, 'Fernandez');	
insert into vecinos ( nombre, ape1, ape2 ) values ('Pedro', 'Garcia', null);	


-- Funciona porque en los UNIQUE compuestos NO necesita not null en ninguno!
-- Además UNIQUE combinado solo necesita únicos en el combinado no en c/u de los atributos.
insert into vecinos ( nombre, ape1, ape2, planta, letra ) values ('Pedro', 'Garcia', 'Fernandez', 1, null);	
insert into vecinos ( nombre, ape1, ape2, planta, letra ) values ('Ana', 'Garcia', 'Fernandez', 1, null);	
insert into vecinos ( nombre, ape1, ape2, planta, letra ) values ('Pedro', 'Gomez', 'Fernandez', null, 'A');	
insert into vecinos ( nombre, ape1, ape2, planta, letra ) values ('Ana', 'Gomez', 'Fernandez', null, 'A');	
insert into vecinos ( nombre, ape1, ape2, planta, letra ) values ('Pedro', 'Gomez', 'Rodriguez', null, null);	
insert into vecinos ( nombre, ape1, ape2, planta, letra ) values ('Ana', 'Gomez', 'Rodriguez', null, null);	

select * from vecinos;
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Los nulos y el join externo */ 
/*----------------------------------------------------------------------------------*/
/* Outer join sobre varias tablas */ 
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
drop table if exists alquila, inmuebles, inquilinos cascade;

create table inquilinos(
	dni numeric(8) primary key,
	nombre varchar(15),
	tfno numeric(9) );

insert into inquilinos values
	( 1, 'Pepe',   123456789),
	( 2, 'Maria',  123456789),
	( 3, 'Enrique',333333333);

create table inmuebles(
	planta	numeric(2),
	letra	char(1),	
	alquiler numeric(6,2),
	primary key ( planta, letra )
);

insert into inmuebles values
	( 1, 'A', 400),
	( 1, 'B', 500),
	( 2, 'A', 300),
	( 2, 'B', 400);

create table alquila (
	dni numeric(8) references inquilinos,
	planta	numeric(2),
	letra	char(1),	
	foreign key ( planta, letra ) references inmuebles,
	primary key ( dni, planta, letra )
);

insert into alquila values
	( 1, 1, 'B'), (2, 1, 'B'), --Maria y Pepe viven en el 1-B
	( 1, 2, 'A');              --Pepe tiene el 2A como despacho


--Maria y Pepe viven en el 1-B
--Pepe tiene el 2A como despacho
select * from alquila;

-- enrique no vive en ninguna casa (no está dado de alta a lo menos)
select * from inquilinos;

-- 1º A y 2º B están vacías, no hay nadie 
select * from inmuebles;


/*----------------------------------------------------------------------------------*/
/* 
Mostrar cada inmueble (TODOS los inmuebles), su alquiler y el nombre del inquilino
 */
/*----------------------------------------------------------------------------------*/
-- JOIN EXTERNO entre Inmuebles y Alquila

-- Salen todos los inmuebles incluso los 2 que están vacíos
select *
FROM (Inmuebles NATURAL LEFT JOIN Alquila);


--Hacemos ahora el segundo JOIN con Inquilinos (SIN ESPECIFICAR EXTERNO)
select *
FROM (Inmuebles NATURAL LEFT JOIN Alquila)
		NATURAL JOIN Inquilinos;

/*----------------------------------------------------------------------------------*/
-- Solución usando un segundo JOIN EXTERNO
--Arreglo 1: Arrastrar el join externo (en igual dirección) al siguiente join

--Saldrán las filas con match y las filas con null
--SELECT planta, letra, alquiler, dni, nombre, tfno
SELECT *
FROM ( Inmuebles NATURAL LEFT JOIN Alquila)
		NATURAL LEFT JOIN Inquilinos;

/*----------------------------------------------------------------------------------*/
--Arreglo 2 (menos frecuente y menos recomendado): 
--Cambiar el orden en el que se ejecutan los joins mediante los parentesis.

--primero hacemos join entre alquila e inquilinos ( A través del DNI)
SELECT *
FROM  (Alquila NATURAL JOIN Inquilinos); 


-- join con inmuebles, tomando la anterior como la tabla base
-- paréntesis indican qué join se hace primero
SELECT *
FROM  Inmuebles NATURAL LEFT JOIN (Alquila NATURAL JOIN Inquilinos);

-- hacemos la proyección y estamos listo!
SELECT planta, letra, alquiler, dni, nombre, tfno
FROM  Inmuebles NATURAL LEFT JOIN (Alquila
		NATURAL JOIN Inquilinos);

-- si NO uso los paréntesis y los pongo primero en orden, el JOIN ahora es Derecho
--cambiando la posición de las tablas en el from
SELECT planta, letra, alquiler, dni, nombre, tfno
FROM  Alquila NATURAL JOIN Inquilinos
NATURAL RIGHT JOIN Inmuebles;
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Los nulos y el join externo */ 
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
drop table if exists equipos, jugadoresInternacionales cascade;

create table equipos(
	nombre		varchar(30) primary key,
	ciudad		varchar(15)
);

insert into equipos values
	( 'Real Madrid', 'Madrid'),
	( 'F.C. Barcelona', 'Barcelona'),
	( 'Atleti', 'Madrid'),
	( 'CD Universidad de Burgos', 'Burgos');

create table jugadoresInternacionales(
	nombre		varchar(40) primary key,
	nombre_equipo	varchar(30) references equipos,
	nacionalidad	varchar(20)
);

insert into jugadoresInternacionales values
	('Leo Messi', 		'F.C. Barcelona', 	'Argentino'),
	('Cristiano Ronaldo', 	'Real Madrid', 		'Portuges'),
	('Sergio Ramos', 	'Real Madrid', 		'Español'),
	('Isco',		'Real Madrid', 		'Español'),
	('Andrés Iniesta', 	'F.C. Barcelona', 	'Español'),
	('Antoine Griezmann',	'Atleti',		'Frances');


select * from equipos;
select * from jugadoresInternacionales;


/*----------------------------------------------------------------------------------*/
/* 
Página 18 Guía:
Que se muestren todos los equipos, aunque no tengan jugadores internacionales (Join externo), y
Que en el resultado sólo salgan jugadores españoles.
*/

-- Forzamos primero a que salgan todos los equipos (hasta aquí bien)
select *
from equipos left join jugadoresInternacionales on (equipos.nombre = nombre_equipo);
--where nacionalidad = 'Español';

-- Cuando agregamos el WHERE, hace cosas buenas (saca a Mesi y Deja a Iniesta), pero hace cosas malas como quitar equipos (Atleti y Burgos).
select *
from equipos left join jugadoresInternacionales on (equipos.nombre = nombre_equipo)
where nacionalidad = 'Español';


/*----------------------------------------------------------------------------------*/
/* La solución es usar un JOIN con un ON y bajar el WHERE al propio join usando un AND */

-- solucion correcta
select *
from equipos left join jugadoresInternacionales
 on (equipos.nombre = nombre_equipo and nacionalidad = 'Español');
 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/*  Tratamiento de nulos con COALESCE */ 
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */ 
drop table if exists empleados;

create table empleados(
	dni	numeric(8)	primary key,	
	nombre	varchar(20),
	nacidoEn	char(8),
	ViveEn	char(8) ,
	salario	numeric(6,2),
	bonus	numeric(5));


insert into empleados values
	( 1, 'Pepe', 'Burgos', 'Madrid', 2000, null),
	( 2, 'Juan', 'Burgos', 'Burgos', null, null),
	( 3, 'Ana',  null,     'Soria',  null, 1500),
	( 4, 'Luis', null,      null,    500, 1000);

select * from empleados;

/*----------------------------------------------------------------------------------*/
/* Necesitamos que cuando salario sea NULL en realidad salga un cero (0) */ 

--Una primera forma de resolverlo (recordad la re-asignación) es usar un CASE / WHEN
-- No se usa así, porque para eso está coalesce
SELECT nombre,
	CASE
		WHEN salario IS NOT NULL THEN salario
		WHEN salario IS NULL THEN 0
	END
FROM Empleados;

--Coalesce automáticamente cambia un null del primer argumento (salario) y lo reemplaza por el segundo argumento (0)). 
SELECT nombre, coalesce(salario, 0)
FROM Empleados;

--Se puede renombrar no con un valor fijo, sino con el valor de otro parámetro (variable) y en este caso se pueden tantos parámetros como se necesiten.
-- Así coalesce transformará el null del  primer argumento (nacidoEn) en el valor del segundo argumento y si da null, entonces toma el del tercer argumento y así...
SELECT *, coalesce(nacidoEn, ViveEn, '¿?') as origen
FROM Empleados; --mirar Ana y Luis


-- no se puede preguntar por NULL usando una igualdad sino con un is null
SELECT * FROM empleados WHERE nacidoEn=null; --incorrecto

SELECT * FROM empleados WHERE nacidoEn is null; --correcto

--no se puede (aunque funciona) preguntar por los null usando coalesce
SELECT * FROM empleados 
WHERE coalesce(nacidoEn, '¿?')='¿?';

/*----------------------------------------------------------------------------------*/
/* Ordenaciones y NULL*/ 
/*----------------------------------------------------------------------------------*/

-- postgreSQL deja a los NULLs al último (otros SGBD no)
SELECT * FROM empleados order by bonus;

--ordena descendente los valores de bonus pero NULLs al final 
SELECT * FROM empleados order by bonus desc;

-- Aparecen las funciones nulls first // nulls last
-- Los NULLs primeros
SELECT * FROM empleados order by bonus nulls first;

-- Los NULLs al último pero bonus descendente
SELECT * FROM empleados order by bonus desc nulls last;


-- En SSGGBBDD que no poseen nulls last ó nulls first, seguro poseen COALESCE!
-- Lo mismo se puede conseguir con la función COALESCE al reemplazar los null por un valor muuuuy pequeño y muuuy negativo
SELECT * FROM empleados
order by COALESCE( bonus, -1000000);

--También podemos dejar los NULLs al final reemplazándolos por un número muuuy positivo 
SELECT * FROM empleados
order by COALESCE( bonus, 1000000);

-- Usando el DESC también funciona con coalesce
SELECT * FROM empleados
order by COALESCE( bonus, -1000000) DESC;

/*----------------------------------------------------------------------------------*/
/* Necesitamos que cuando salario sea NULL en realidad salga 'no tiene' */ 

-- si intentamos pasar el caracter 'no tiene' dentro del coalesce no funciona, porque:
-- Salario es de tipo numérico y 'no tiene' es de tipo caracter.
select nombre, coalesce(salario, 'no tiene')
from empleados;

-- debemos hacer conversión manual de tipo y para eso se utiliza CAST (variable as <Tipo nuevo>)
-- revisar página 22 guía diferentes CAST y que quepan dentro del nuevo tipo.
-- transformamos salario con 7 porque son 6 cifras más el punto de los decimales.

select nombre, coalesce(cast(salario as char(7)), 'no tiene')
from empleados;
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/