/* -------------------------------------------------------------------------- */
/* ### TEMA 3 (Teoría BBDD-GIS) ### */
/* ### ÁLGEBRA RELACIONAL ### */
/* -------------------------------------------------------------------------- */
-- PRÁCTICA 5: operaciones de conjunto y AR
-- Objetivo: Entender el concepto de conjunto y sus operaciones.

/* ###-------------------------------------------------------------------------###
# Operaciones UNARIAS
###-------------------------------------------------------------------------### */
/* CREAMOS BBDD para trabajar */

-- limpiar las tablas
-- drop table if exists alumnos, ciudades, ejemplo_tiempos, empleados, profesores;

drop table if exists empleados; 

create table empleados (
	dni   		numeric(8) primary key,
	nombre		varchar(15),
	salario   	numeric(8,2),
	ventas 		numeric(10,2),
	ciudad		varchar(15),
	categoria	varchar(15));


insert into empleados values
    (1,   'Pepe',  	1000,	2000,	'Burgos', 'Vendedor'),
    (2,   'Juan',  	1500,	2000,	'Burgos', 'Jefe'),
    (3,   'Ana',	750,	2000,	'Soria',  'Jefe'),
    (4,   'Maria',	1500,	2000,	'Madrid', 'Vendedor'),
    (5,   'Luis',	1000,	0,	'Burgos', 'Vendedor');
	
select * from empleados;
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* Selección -- WHERE (Sigma) */
/* -------------------------------------------------------------------------- */
/* 
selecciona un subconjunto de filas de la relación original
se debe utilizar distinct para evitar duplicados
*/

-- atributo comparador constante: Salarios mayores que 1000
select salario from empleados 
where salario > 1000;

select distinct salario from empleados 
where salario > 1000;

/* En el caso de que se consulte más de un atributo, 
distinct operará sobre la  combinación de esos atributos */
select dni, salario from empleados 
where salario > 1000;

select distinct dni, salario from empleados 
where salario > 1000;

/* forma correcta para igualar AR, si no hay PK!
select distinct * from empleados 
where salario > 1000;
*/

-- atributo comparador atributo: salario > ventas
select distinct categoria from empleados 
where salario < ventas;

-- predicado logico de negación: salario no es = 1000
select distinct * from empleados 
where salario != 1000;

-- predicado lógico, conector lógico, predicado lógico: salario > 1000 > ventas
select distinct * from empleados 
where salario >= 1000 -- replace >= by > and comment 
and salario > ventas;
/* -------------------------------------------------------------------------- */


/* -------------------------------------------------------------------------- */
/* Proyección -- SELECT (pi) */
/* -------------------------------------------------------------------------- */
/* 
selecciona un subconjunto de atributos de la relación original
se debe utilizar distinct para evitar duplicados
*/

-- con duplicados
select categoria, salario from empleados;

-- sin duplicados
select distinct categoria, salario from empleados;

-- proyeccion incluyendo los atributos dentro de select lista 1 subconjunto lista 2 
select distinct categoria, salario, ciudad from empleados
where ciudad = 'Burgos';

-- proyeccion sin atributos dentro de select lista1 NO es subconjunto lista 2
-- fallará en otros lenguajes como en R!
select distinct categoria, salario from empleados
where ciudad = 'Burgos';

-- También sirve para permutar orden de atributos
-- select * from empleados;
select ciudad, dni, nombre, categoria, salario, ventas 
from empleados;
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* Operaciones de Conjuntos */
/* -------------------------------------------------------------------------- */
/* 
Operaciones de Conjuntos U (unión) ∩ (intersección) - (diferencia)
en SQL --> Union = union // Intersección = intersect // diferencia = except

Las operaciones de conjuntos eliminan las filas repetidas

Estas relaciones han de verificar la llamada "Compatibilidad de Unión". 

Esto es en SQL: 
* Igual grado (numero de atributos/columnas resultantes!) 
* Atributos / columnas a unificar sean del mismo tipo 	

Nota: El material de esta sección está en 1.4a Operaciones de Conjuntos.sql 
*/

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

drop table if exists Ciudades, Empleados;

create table Ciudades(
	ciudad 	varchar(15) primary key,
	habitantes numeric(8));
	
insert into Ciudades values('Burgos', 200000),
	('Soria',   25000),	('Madrid', 4000000);


create table Empleados (
	dni   		numeric(8) primary key,
	nombre		varchar(15),
	salario   	numeric(8,2),
	ventas 	numeric(10,2),
	ciudad		varchar(15),
	categoria	varchar(15));


insert into empleados values
    (1,   'Pepe',  	1000,	2000,	'Burgos', 'Vendedor'),
    (2,   'Juan',  	1500,	2000,	'Burgos', 'Jefe'),
    (3,   'Ana',	750,	2000,	'Soria',  'Jefe'),
    (4,   'Maria',	1500,	2000,	'Madrid', 'Vendedor'),
    (5,   'Luis',	1000,	0,	'Burgos', 'Vendedor');
    

-- revisar atributos en común
select * from Ciudades; 
select * from Empleados;

/* -------------------------------------------------------------------------- */
/* UNION U */
/* -------------------------------------------------------------------------- */
/*
Se comporta como AR y quita filas repetidas (DISTINCT no es necesario)
select requiere = numero de columnas
solo variables con = dominio (no así precisiones char(1) = char (5) = varchar(5))
*/

-- Ciudades que tienen vendedores o tienen menos de 100.000 habitantes
-- Error por incompatibilidad de Unión
select ciudad from empleados where categoria='Vendedor'
union
select ciudad, habitantes from Ciudades where habitantes < 100000;


select ciudad from empleados where categoria='Vendedor'
union
select ciudad from Ciudades where habitantes < 100000;

-- sin que se quiten los repetidos, ya que union quita repetidos (¡y costoso para el sistema!)
-- si la proyección es a PK el uso de ALL da igual, de lo contrario es más rápido
select ciudad from empleados where categoria='Vendedor'
union all
select ciudad from Ciudades where habitantes<100000;


/* -------------------------------------------------------------------------- */
/* Intersección INTERSECT */
/* -------------------------------------------------------------------------- */
/* Todas las tuplas que están en A y en B simultáneamente.*/

/*Ciudades que tienen tanto jefes como vendedores*/

-- visualizamos completa BBDD de empleados 
select * from empleados;

-- usando intersect
select ciudad from empleados where categoria='Jefe'
intersect 
select ciudad from empleados where categoria='Vendedor';


/* -------------------------------------------------------------------------- */
/* Diferencia EXCEPT */
/*Ciudades que no tienen Jefe*/
/* -------------------------------------------------------------------------- */
-- visualizamos completa BBDD ciudad 
select * from empleados;

-- usando except
select ciudad from empleados
except
select ciudad from empleados where categoria='Jefe';

/* -------------------------------------------------------------------------- */


/* -------------------------------------------------------------------------- */
/* El modificador ALL en las operaciones de Conjunto */
/* -------------------------------------------------------------------------- */
/* 
El modificador ALL en las operaciones de Conjunto
las ordenaciones son unas de las operaciones más costosas para el sistema, y debemos evitarlas
*/

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

drop table if exists alumnos, profesores;

create table alumnos(
	dni	integer primary key,
	Nombre		char(20),
	Ape1		char(20),
	Ape2		char(20),
	matricula	numeric(8) not null unique
);


insert into alumnos values ( 1, 'Pepe', 'Alvarez', 'Alvarez', 1),
			   ( 2, 'Juan', 'Alvarez', 'Alvarez', 2),
			   ( 3, 'Pepe', 'Alvarez', 'Garcia',  3);


create table profesores(
	dni	Numeric(3) primary key, --es compatible integer
	nombre  varchar(30), --es compatible char(20)
	Ape1	char(20),
	Ape2	char(20),
	nro	numeric(8) not null unique	
);


insert into profesores values	( 1, 'Pepe', 'Alvarez', 'Alvarez', 4),
				( 3, 'Juan', 'Alvarez', 'Lopez',   5),
				( 2, 'Pepe', 'Alvarez', 'Garcia',  6),
				( 4, 'Juan', 'Alvarez', 'Lopez',   7);


select * from alumnos;
select * from profesores;

/* -------------------------------------------------------------------------- */
/* UNION ALL, EXCEPT ALL, etc */
/* -------------------------------------------------------------------------- */
/*
Revisar la velocidad a la que se ejecutan ambos comandos
*/

-- evitando repetidos en la combinación
SELECT dni, Nombre, Ape1, Ape2
FROM profesores
UNION
SELECT dni, Nombre, Ape1, Ape2
FROM alumnos;


-- incluyendo repetidos en la combinación
SELECT dni, Nombre, Ape1, Ape2
FROM profesores
UNION ALL
SELECT dni, Nombre, Ape1, Ape2
FROM alumnos;

-- Ejemplo 2 sin repetidos
SELECT Ape1, Ape2
FROM profesores
UNION
SELECT Ape1, Ape2
FROM alumnos;

-- Ejemplo 2 con repetidos
SELECT Ape1, Ape2
FROM profesores
UNION ALL
SELECT Ape1, Ape2
FROM alumnos;

--Nombre y apellidos de profesores que no son alumnos S/Repetidos
SELECT Nombre, Ape1, Ape2
FROM profesores
EXCEPT
SELECT Nombre, Ape1, Ape2
FROM alumnos;

--Nombre y apellidos de profesores que no son alumnos C/Repetidos
SELECT Nombre, Ape1, Ape2
FROM profesores
EXCEPT ALL
SELECT Nombre, Ape1, Ape2
FROM alumnos;

--Nombre y apellidos de alumnos q no son profesores (probar ALL, da lo mismo)
SELECT Nombre, Ape1, Ape2
FROM alumnos
EXCEPT
SELECT Nombre, Ape1, Ape2
FROM profesores;

/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* ORDER BY en las operaciones de Conjunto */
/* -------------------------------------------------------------------------- */
/*
el SGBD interpreta que el ORDER BY afecta a toda la unión en su conjunto:
-- ORDER BY --> siempre al final, como cláusla global
-- order by= lento y se pierde el efecto "ALL"
*/

--Order by erroneo
/*
SELECT dni, Nombre, Ape1, Ape2
FROM profesores
WHERE Ape2 ='Alvarez'
ORDER BY dni
UNION
SELECT dni, Nombre, Ape1, Ape2
FROM alumnos;
*/

SELECT dni, Nombre, Ape1, Ape2
FROM profesores
WHERE Ape2 ='Alvarez'
UNION
SELECT dni, Nombre, Ape1, Ape2
FROM alumnos
ORDER BY dni;

-- orden descendiente
SELECT dni, Nombre, Ape1, Ape2
FROM profesores
WHERE Ape2 ='Alvarez'
UNION
SELECT dni, Nombre, Ape1, Ape2
FROM alumnos
ORDER BY dni desc;
/* -------------------------------------------------------------------------- */


/* -------------------------------------------------------------------------- */
/* Renombrar los Atributos de las Relaciones */
/* -------------------------------------------------------------------------- */
/* 
Un problema en AR y en operaciones de conjunto, es que no está claro cuál 
es el nombre de los atributos de la relación resultante.

es conveniente haberlos renombrado previamente para asegurarnos de que los 
atributos de A y B tienen el mismo nombre
*/
/* -------------------------------------------------------------------------- */

/* CREAMOS BBDD para trabajar */
-- CASCADE: will automatically delete records in a child table where a foreign key relationship is in place

DROP TABLE IF EXISTS Ciudades CASCADE; 
DROP TABLE IF EXISTS Empleados CASCADE;

create table Ciudades(
	ciudad     varchar(15) primary key,
	habitantes numeric(8));
	
insert into Ciudades values('Burgos', 200000),
	('Soria',   25000),	('Madrid', 4000000);


create table Empleados (
	dni   		numeric(8) primary key,
	nombre		varchar(15),
	salario   	numeric(8,2),
	ventas 	numeric(10,2),
	ciudad		varchar(15),
	categoria	varchar(15));


insert into empleados values
    (1,   'Pepe',  	1000,	2000,	'Burgos', 'Vendedor'),
    (2,   'Juan',  	1500,	2000,	'Burgos', 'Jefe'),
    (3,   'Ana',	750,	2000,	'Soria',  'Jefe'),
    (4,   'Maria',	1500,	2000,	'Madrid', 'Vendedor'),
    (5,   'Luis',	1000,	0,	'Burgos', 'Vendedor');


select * from Ciudades;
select * from Empleados;

/* -------------------------------------------------------------------------- */
/* Select & Select as */
/* -------------------------------------------------------------------------- */

-- sin coma entre categoria y rango se interpreta como un rename
SELECT DISTINCT categoria rango, salario euros
FROM empleados
WHERE ciudad='Burgos';

-- usando argumento AS
SELECT DISTINCT categoria as rango, salario as euros
FROM empleados
WHERE ciudad='Burgos';

-- MODIFICAMOS BBDD para PROBAR
DROP TABLE IF EXISTS alumnos CASCADE;
DROP TABLE IF EXISTS profesores CASCADE;

create table alumnos(
	dni	integer primary key,
	Nombre		char(20),
	Ape1		char(20),
	Ape2		char(20),
	matricula	numeric(8) not null unique
);

insert into alumnos values ( 1, 'Pepe', 'Alvarez', 'Alvarez', 1),
			   ( 2, 'Juan', 'Alvarez', 'Alvarez', 2),
			   ( 3, 'Pepe', 'Alvarez', 'Garcia',  3);

create table profesores(
	dni		Numeric(8) primary key, --es compatible integer
	nombre  	varchar(30), --es compatible char(20)
	apellido1	char(20),
	apellido2	char(20),
	nro		numeric(8) not null unique	
);

insert into profesores values 	( 1, 'Pepe', 'Alvarez', 'Alvarez', 4),
				( 3, 'Juan', 'Alvarez', 'Lopez',   5),
				( 2, 'Pepe', 'Alvarez', 'Garcia',  6),
				( 4, 'Juan', 'Alvarez', 'Lopez',   7);


select * from alumnos;
select * from profesores;

/* -------------------------------------------------------------------------- */
--Esto funciona en postgreSQL (mirar por separado) toma los valores de la primera relación
-- comentar la compatibilidad de la unión entre integer-numeric // char-varchar
--select * from profesores;
SELECT nro, Nombre, Apellido1, Apellido2
FROM profesores
WHERE apellido2 ='Alvarez'
UNION
SELECT matricula, Nombre, Ape2, Ape1
FROM alumnos
ORDER BY nro;


--Pero es mas correcto renombrar los campos, el algebra lo exige
SELECT Nro as id, Nombre, Apellido1 as Ape1, Apellido2 as Ape2
FROM profesores
WHERE apellido2 ='Alvarez'
UNION
SELECT Matricula as id, Nombre, Ape1, Ape2
FROM alumnos
ORDER BY Nro, Ape1, Ape2; -- este order by toma los valores despues de "as", por que falla en encontrar Nro

SELECT Nro as id, Nombre, Apellido1 as Ape1, Apellido2 as Ape2
FROM profesores
WHERE apellido2 ='Alvarez'
UNION
SELECT Matricula as id, Nombre, Ape1, Ape2
FROM alumnos
ORDER BY id, Ape1, Ape2; --este order by toma los valores despues de "as"

/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* Producto Cartesiano (PC) */
/* -------------------------------------------------------------------------- */
/* 
Nueva relación con:
1) Todos los atributos de A X B (si hay campos comunes se repiten)
2) Todas las combinaciones posibles entre las filas de las tablas A X B
*/

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

/* CASCADE: will automatically delete records in a child table where a foreign key relationship is in place
*/

drop table if exists EMPLEADO, CATEGORIA, OFICINA cascade;

create table OFICINA (
 n_oficina 	integer primary key,
 población	char(15),
 región		char(15),
 ventas		numeric(10,2),
 objetivo	numeric(10,2)
 );

insert into oficina values
	( 1, 'Madrid', 'CENTRO', 1000000, 1200000),
	( 2, 'Bilbao', 'NORTE',   900000, 1000000);


create table CATEGORIA ( 
 cargo 		char(15) primary key,
 sal 		numeric(6,2)
);

insert into categoria values
	( 'VENDEDOR',	    2000),
	( 'ADMINISTRATIVO', 1000),
	( 'JEFE',	    4000);

create table EMPLEADO(
 cod 		integer primary key,
 nombre		char(15), 
 oficina 	integer references oficina,
 cargo 		char(15) references categoria,
 comisión	numeric(2)
 );

insert into EMPLEADO values
	( 1, 'Pepe',  1,  'VENDEDOR', 10),
	( 2, 'Maria', 1,  'VENDEDOR', 15),
	( 3, 'Juan',  1,  'JEFE',     25),
	( 4, 'Carlos',2,  'JEFE',     20),
	( 5, 'Luis',  2,  'ADMINISTRATIVO', null);

-- inspeccion de cada base de datos
SELECT * from oficina; -- {2,5}
SELECT * from empleado; -- {5,5}                    
SELECT * from categoria;--{3,2}


/* -------------------------------------------------------------------------- */
/* Producto cartesiano (PC) de Oficinas X Empleado */
/* -------------------------------------------------------------------------- */
-- Haciendo un PC completo basta con agregar más tablas/relaciones en el FROM
-- Revisar número de columnas (suma de atributos = suma de grados)
-- Revisar número de filas (multiplicación de cardinalidades --> 2 oficinas X 5 empleados = 10 filas)
SELECT * 
FROM oficina, empleado;


-- Agregando todas las combinaciones posibles
-- Revisar atributo "Cargo" Sale duplicado resaltar diferencia con R!
SELECT *
FROM oficina, empleado, categoria;


-- Qué pasa si sólo queremos un campo y es uno duplicado --error!
--SELECT *
SELECT *, cargo
--SELECT cargo
FROM oficina, empleado, categoria;

/* -------------------------------------------------------------------------- */
/* ALIAS DE TABLA */
/* -------------------------------------------------------------------------- */
/* 
Para seleccionar una (o más) columnas de tablas independientes, el indexador es el punto.
*/

SELECT *, empleado.cargo
SELECT categoria.cargo
--SELECT *, categoria.cargo -- comparar (lista 2 (from) debe ser subconjunto de lista 1 (select)).
FROM oficina, empleado;

SELECT oficina.n_oficina, oficina.ventas, empleado.cargo
FROM oficina, empleado;

select * 
FROM oficina, empleado;

/*
EQUIVALENTES

SELECT *
FROM oficina, empleado, categoria;

SELECT oficina.*, empleado.*, categoria.*
FROM oficina, empleado, categoria;
*/
/* -------------------------------------------------------------------------- */


/* ###-------------------------------------------------------------------------###
# Operaciones BINARIAS (JOINS)
###-------------------------------------------------------------------------### */
/* -------------------------------------------------------------------------- */
/* Theta Join  */
/* -------------------------------------------------------------------------- */

/* 
Permite fusionar dos tablas en función de la condición representada por theta (>, <, =, !=, etc).
Sintaxis similar a Prod. Cartesiano pero con un Where selectivo (para incluir el theta)

El equi-join es igual pero solo para igualdades (theta solo puede ser "=").

*/

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

/* CASCADE: will automatically delete records in a child table where a foreign key relationship is in place
*/

drop table if exists EMPLEADO, CATEGORIA, OFICINA cascade;

create table OFICINA (
 n_oficina 	integer primary key,
 población	char(15),
 región		char(15),
 ventas		numeric(10,2),
 objetivo	numeric(10,2)
 );

insert into oficina values
	( 1, 'Madrid', 'CENTRO', 1000000, 1200000),
	( 2, 'Bilbao', 'NORTE',   900000, 1000000);


create table CATEGORIA ( 
 cargo 		char(15) primary key,
 sal 		numeric(6,2)
);

insert into categoria values
	( 'VENDEDOR',	    2000),
	( 'ADMINISTRATIVO', 1000),
	( 'JEFE',	    4000);

create table EMPLEADO(
 cod 		integer primary key,
 nombre		char(15), 
 oficina 	integer references oficina,
 cargo 		char(15) references categoria,
 comision	numeric(2)
 );

insert into EMPLEADO values
	( 1, 'Pepe',  1,  'VENDEDOR', 10),
	( 2, 'Maria', 1,  'VENDEDOR', 15),
	( 3, 'Juan',  1,  'JEFE',     25),
	( 4, 'Carlos',2,  'JEFE',     20),
	( 5, 'Luis',  2,  'ADMINISTRATIVO', 0);


select * from oficina;
select * from categoria;
select * from empleado;
/* -------------------------------------------------------------------------- */
/* Join Derivado --> "a mano" */
/*
Sintaxis similar al producto cartesiano
*/

-- Producto cartesiano. Aparecen todas las combinaciones
-- Revisar a Pepe alineado con diferentes oficinas
SELECT DISTINCT *
FROM empleado, oficina;

-- Para hacer lo más claro, revisar a Carlos en ambas oficinas (Bilbao y Madrid)
SELECT DISTINCT nombre, población
FROM empleado, oficina;

-- Para pedir que salgan aquellas asociaciones con oficinas de manera correcta, pido una igualdad entre oficinas
-- Realizando el Equi-Join (theta join de igualdades)	
SELECT DISTINCT nombre, población -- DISTINCT mantiene equivalencia con AR
FROM empleado, oficina
WHERE Oficina = n_Oficina; -- condición de join

SELECT DISTINCT * 
FROM empleado, oficina
--WHERE empleado.Oficina = oficina.n_Oficina;
WHERE Oficina = n_Oficina;

-- Usando un Theta (no equi) join 
-- Condicion de Theta después de producto cartesiano.
SELECT DISTINCT nombre 
FROM empleado, oficina
WHERE comision*ventas/100 > objetivo/8;

-- Cuidado que este theta join no evita las filas espúrias
SELECT DISTINCT * 
FROM empleado, oficina
WHERE comision*ventas/100 > objetivo/8;


-- Condicion de Theta después de producto cartesiano con Otros campos
-- Quienes cumplen una condicion pero que pueda suceder en cualquier oficina
SELECT DISTINCT nombre, oficina, n_oficina 
FROM empleado, oficina
WHERE comision*ventas/100 > objetivo/8;


-- Igual que anterior, pero asegurando que salga la oficina correspondiente y no en cualquiera
SELECT DISTINCT nombre, oficina, n_oficina 
FROM empleado, oficina
WHERE Oficina = n_Oficina
AND comision*ventas/100 > objetivo/8;

-- Mostrando todos los campos
SELECT DISTINCT *
FROM empleado, oficina
WHERE Oficina = n_Oficina
AND comision*ventas/100 > objetivo/8;

/* -------------------------------------------------------------------------- */
/* Join Natural */
/* -------------------------------------------------------------------------- */

/* 
Consiste en un equi-join sobre los atributos con igual nombre de las dos relaciones, 
sobre los que luego quitamos mediante una proyección una de las apariciones de esos atributos comunes.

El theta join más habitual es un Equi-Join (condición de Join es una igualdad)

Se igualan los valores del PK de la Tabla Padre con los FK de la tabla Hija.

Los campos en los que se unen deberían ser de igual nombre pero no siempre es así

*/


/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

--PARTE 1: Oficinas tiene una clave simple

-- OFICINA es Padre de EMPLEADO, porque cada empleado tiene una oficina
-- EMPLEADO también es hijo de CATGORIA, con un campo que se llama igual

drop table if exists EMPLEADO, CATEGORIA, OFICINA cascade;

create table OFICINA (
 n_oficina 	integer primary key,
 población	char(15),
 region	char(15),
 ventas	numeric(10,2),
 objetivo	numeric(10,2)
 );

insert into oficina values
	( 1, 'Madrid', 'CENTRO', 1000000, 1200000),
	( 2, 'Bilbao', 'NORTE',   400000, 1000000);


create table CATEGORIA ( 
 cargo 	char(15) primary key,
 sal 		numeric(6,2)
);

insert into categoria values
	( 'VENDEDOR',	    2000),
	( 'ADMINISTRATIVO', 1000),
	( 'JEFE',	    4000);

create table EMPLEADO(
 cod 		integer primary key,
 nombre	char(15), 
 oficina 	integer references oficina, --FK
 cargo 	char(15) references categoria, --FK
 comision	numeric(2)
 );

insert into EMPLEADO values
	( 1, 'Pepe',  1,  'VENDEDOR', 10),
	( 2, 'Maria', 1,  'VENDEDOR', 15),
	( 3, 'Juan',  1,  'JEFE',     25),
	( 4, 'Carlos',2,  'JEFE',     20),
	( 5, 'Luis',  2,  'ADMINISTRATIVO', 0);

select * from EMPLEADO;
select * from CATEGORIA;
select * from OFICINA;

/* -------------------------------------------------------------------------- */
-- Producto Cartesiano de Empleado X oficina (1º empleado) = 10 filas!
SELECT *
FROM Empleado, Oficina;


/* -------------------------------------------------------------------------- */
/* Join usando atributos de diferente nombre */
-- Cada empleado debe salir con su oficina, por lo que agregamos la condicion de theta join
-- Cada empleado sale solo con su padre por lo que Nº Filas = Nº Empleados --> 5 filas!
SELECT *
FROM Empleado, Oficina
where oficina = n_oficina;


/* -------------------------------------------------------------------------- */
/* Join usando atributos de == nombre */
/* Recalcar diferencias con R que no permite la indexación de tabla, pero sí el cambio de nombres */

-- Ahora queremos cada empleado con su categoría (cargo)
SELECT *
FROM Empleado, Categoria
where cargo = cargo;  -- ERROR: ambiguo porque se llaman igual

-- Indexacion
SELECT *
FROM Empleado, Categoria
where Empleado.cargo = Categoria.cargo; 


-- para juntar más de una relación se necesitan más de un enganche (3 vagones y 2 enganches)
-- deben salir solo 5 filas ya que hay 5 empleados
SELECT *
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina -- enganche entre empleados y oficinas
AND categoria.cargo = empleado.cargo; -- enganche entre categoria y empleado 
/* -------------------------------------------------------------------------- */


/* -------------------------------------------------------------------------- */
/* AHORA CON CLAVE COMPUESTA */
/* -------------------------------------------------------------------------- */
--PARTE 2: Redefino las tablas haciendo que la clave de oficinas sea compuesta

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

-- a Oficinas le agregamos un campo Región para clave compuesta
-- EXPLICAR LOS VALORES REPETIDOS DE OFICINA

drop table if exists oficina, empleado, categoria cascade;

create table OFICINA (
 n_oficina 	integer,
 población	char(15),
 region	char(15),
 ventas	numeric(10,2),
 objetivo	numeric(10,2),
 
 primary key(n_oficina, region) -- el orden de esta PK se debe repetir en el hijo
 );

insert into oficina values
	( 1, 'Madrid', 'CENTRO', 1000000, 1200000),
	( 1, 'Bilbao', 'NORTE',   400000, 1000000),
	( 2, 'Burgos', 'CENTRO',  400000,  800000);


create table CATEGORIA ( 
 cargo 	char(15) primary key,
 sal 		numeric(6,2)
);

insert into categoria values
	( 'VENDEDOR',	    2000),
	( 'ADMINISTRATIVO', 1000),
	( 'JEFE',	    4000);
	
	
create table EMPLEADO(
 cod 		integer primary key,
 nombre	char(15), 
 oficina 	integer ,
 region	char(15),
 cargo 	char(15) references categoria,
 comision	numeric(2), 
 
 foreign key (oficina, region) references oficina -- sigue el orden (que no el nombre) del padre
 );

insert into EMPLEADO values
	( 1, 'Pepe',  1, 'CENTRO', 'VENDEDOR', 10),
	( 2, 'Maria', 1, 'CENTRO', 'VENDEDOR', 15),
	( 3, 'Juan',  1, 'CENTRO', 'JEFE',     25),
	( 4, 'Carlos',1, 'NORTE',  'JEFE',     20),
	( 5, 'Luis',  2, 'CENTRO', 'ADMINISTRATIVO', 0);
	

select * from OFICINA;
select * from CATEGORIA;
select * from EMPLEADO;
/* -------------------------------------------------------------------------- */

/* 
Join similar al anterior (== nombre) por lo que necesitamos indexación, pero como además
una de las conexiones es una PK compuesta, necesitamos 2 Joins (un WHERE y un AND)
*/

-- dos conexiones con = nombre		
-- muestra la info para los 5 empleados pero uniendo correctamente las relaciones.
SELECT *
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina AND empleado.region = oficina.region -- Une Empleado y Oficina 
AND categoria.cargo = empleado.cargo; -- une Categoria con Empleado


-- igual pero con clave compuesta indexada (no es necesario)
SELECT *
FROM Categoria, Empleado, Oficina
WHERE Empleado.oficina = Oficina.n_oficina AND Empleado.region = Oficina.region -- Une Empleado y Oficina 
AND categoria.cargo = empleado.cargo; -- une Categoria con Empleado

/* -------------------------------------------------------------------------- */
/* Del Join anterior filtramos algunas filas según criterios */

/* Debido a la precedencia entre operadores lógicos, si en el WHERE añadiésemos un OR 
deberemos de usar paréntesis que garanticen que todas las filas cumplen la condición
de join*/

-- Aquellos empleados, sus nombres, las ventas y salarios mayores que 2000
SELECT nombre, sal, ventas
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina AND empleado.region=oficina.region
AND categoria.cargo = empleado.cargo
AND sal > 2000;

-- Aquellos salarios mayores que 2000 ó ventas mayores que 50000
SELECT nombre, sal, ventas
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina
AND empleado.region=oficina.region
AND categoria.cargo = empleado.cargo
AND sal > 2000 
OR ventas >500000;

-- Mal sin parentesis. Deberían salir como máximo 5 filas y salen 16!

/*
-- Paréntesis definidos a mano pero igual que la conducta por defecto= 16 filas!
SELECT nombre, sal, ventas
FROM Categoria, Empleado, Oficina
WHERE (oficina = n_oficina
AND empleado.region=oficina.region
AND categoria.cargo = empleado.cargo
AND sal > 2000)
OR ventas >500000;
*/

-- Aquellos salarios mayores que 2000 ó ventas mayores que 50000
-- Ahora bien con un parentesis que fuerce al último AND y OR a ejecutarse conjuntamente
SELECT nombre, sal, ventas
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina
AND empleado.region=oficina.region
AND categoria.cargo = empleado.cargo
AND (sal > 2000 OR ventas >500000);


-- Explicación de la conducta por defecto = 16 filas!
SELECT nombre, sal, ventas 
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina
AND empleado.region=oficina.region
AND categoria.cargo = empleado.cargo
AND sal > 2000
UNION
SELECT nombre, sal, ventas 
FROM Categoria, Empleado, Oficina
WHERE ventas > 500000;
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* Join Externo (OUTER JOIN)*/
/* -------------------------------------------------------------------------- */

/* 
Cuando se unen relaciones a través de un join y que no existe combinación de tuplas, en un 
join interno no se mostrarán las celdas "vacías". En un Join externo forzaremos a que sí se muestren.

Ejemplo Oficinas: 
"Por defecto las oficinas sin empleados no salen en un join, porque el join por defecto es el interno, pero en la práctica nos pueden pedir que sí que salgan (join externo)."

*/

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

drop table if exists EMPLEADO, CATEGORIA, OFICINA cascade;

create table OFICINA (
 n_oficina 	integer primary key,
 poblacion	char(15),
 region	char(15),
 ventas	numeric(10,2),
 objetivo	numeric(10,2)
 );

insert into oficina values
	( 1, 'Madrid', 'CENTRO', 1000000, 1200000),
	( 2, 'Bilbao', 'NORTE',   900000, 1000000),
	( 3, 'Burgos', 'CENTRO',  500000,  800000);


create table CATEGORIA ( 
 cargo 	char(15) primary key,
 sal 		numeric(6,2)
);

insert into categoria values
	( 'VENDEDOR',	    2000),
	( 'ADMINISTRATIVO', 1000),
	( 'JEFE',	    4000),
	( 'RECADERO', 1000);

create table EMPLEADO(
 cod 		integer primary key,
 nombre	char(15), 
 oficina 	integer references oficina, 
 cargo 	char(15) references categoria,
 comision	numeric(2)
 );

insert into EMPLEADO values
	( 1, 'Pepe',  1,  'VENDEDOR', 10),
	( 2, 'Maria', 1,  'VENDEDOR', 15),
	( 3, 'Juan',  1,  'JEFE',     25),
	( 4, 'Carlos',2,  'JEFE',     20),
	( 5, 'Luis',  2,  'ADMINISTRATIVO', 0),
	( 6, 'Alberto', null, 'VENDEDOR', 10),--sin oficina
	( 7, 'Pedro', null, 'VENDEDOR', 15),--sin oficina
	( 8, 'Rodrigo', 1, null, 15); --sin cargo


select * from oficina;
select * from categoria;
select * from empleado;
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* inner join tradicional */
/* 
Consiste en igualar clave ajena (oficina) con clave primaria (n_oficina) por cada dos tablas

El WHERE va a unir Empleado y Oficina y el AND unirá Categoria y Empleado
*/

-- revisamos empleados nuevamente
SELECT * FROM Empleado;

-- En R/dplyr no se ejecuta igual ya que en parte sí salen los NA en el primer where
SELECT *
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina -- une Empleado y Oficina
AND categoria.cargo = empleado.cargo; -- une Categoria y Empleado

-- no se muestra ni Alberto, ni Pedro ni Rodrigo (tienen null en algún campo)

/* -------------------------------------------------------------------------- */
/* outer join -- JOIN Externo */
/* SIN CÓDIGO DE R */

/* 
Con operaciones fundamentales usando tablas temporales o vistas
Vamos a hacer paso a paso las operaciones fundamentales
*/

-- Filas que caen dentro del join interno
-- Atributos de una sola tabla (Oficina)
-- Son las oficinas con empleados porque caen dentro del Join interno
select * from oficina;
select * from empleado;


SELECT Oficina.* 
FROM Oficina, Empleado
WHERE Oficina = n_Oficina;

-- Si a todas las oficinas les quitamos aquellas en las que Sí hay empleados
-- Nos quedamos con las oficinas en que NO hay empleados (solo 1, n_oficina = 3)
SELECT * FROM Oficina
EXCEPT
SELECT Oficina.*
FROM Oficina, Empleado
WHERE Oficina = n_Oficina;

-- Guardamos esta consulta anterior en un "objeto" llamado Vista.
-- Una vista no se materializa solo se ejecuta cada vez que se le llama
-- La vista será OficinasSinEmpleados

--drop table if exists  OficinasSinEmpleados;
--CREATE local temporary table OficinasSinEmpleados AS

drop view if exists OficinasSinEmpleados;

CREATE VIEW OficinasSinEmpleados AS
SELECT * FROM Oficina
EXCEPT
SELECT Oficina.*
FROM Oficina, Empleado
WHERE Oficina = n_Oficina;

select * from OficinasSinEmpleados;

-- Para terminar el JOIN externo hacemos la unión del join interno con el View "OficinasSinEmpleados" recién creado.
-- daremos un valor nulo (null) a los 4 campos de empleados. Se puede probrar eliminarlos para ver que da error
SELECT n_oficina, poblacion, region, ventas, objetivo, cod, nombre, cargo, comision
FROM Oficina, Empleado
WHERE Oficina = n_Oficina
UNION
SELECT n_oficina, poblacion, region, ventas, objetivo, null, null, null, null
FROM OficinasSinEmpleados;

/* 
Outer join en un solo paso (Sin usar la Vista) --YA NO SE USA!!
Explicación Paso a paso, pero saltarla!

-- Este es el join interno
SELECT n_oficina, poblacion, region, ventas, objetivo, cod, nombre, cargo, comision
FROM Oficina, Empleado
WHERE Oficina = n_Oficina


-- Fabrico a Oficinas sin empleados 
-- usando la union de oficinas menos (except) oficinas con empleados
-- Necesito agregar los null para que la UNION pueda combinar con nombre
SELECT Oficina.*, null, null, null, null
FROM Oficina
EXCEPT
SELECT Oficina.*, null, null, null, null
FROM Oficina, Empleado
WHERE Oficina = n_Oficina;


-- Unión final entre las 2 sub-consultas 
SELECT n_oficina, poblacion, region, ventas, objetivo, cod, nombre, cargo, comision
FROM Oficina, Empleado
WHERE Oficina = n_Oficina
UNION
SELECT Oficina.*, null, null, null, null
FROM Oficina
EXCEPT
SELECT Oficina.*, null, null, null, null
FROM Oficina, Empleado
WHERE Oficina = n_Oficina;
*/



/* -------------------------------------------------------------------------- */
/* Joins Cualificados en SQL */
/* -------------------------------------------------------------------------- */
/*
Nueva Sintaxis a partir de 1992
Vuelve a existir la equivalencia con R!
El tipo de Join se especifica en la cláusula FROM
*/

/* -------------------------------------------------------------------------- */
/* CROSS JOIN */
/* -------------------------------------------------------------------------- */

-- representa el producto cartesiano
-- prod.cartesiano empleados X oficina = 24 filas (8 empleadosX 3 Oficinas)
SELECT Oficina.*, Empleado.*
FROM Oficina CROSS JOIN Empleado;

-- Se puede usar básicamente usando una coma, por lo que es más rápido.
SELECT Oficina.*, Empleado.*
FROM Oficina, Empleado;


/* -------------------------------------------------------------------------- */
/* INNER JOIN */
/* Vuelve a haber código de R */
/* -------------------------------------------------------------------------- */
-- se puede hacer de la manera tradicional
select * from oficina;
select * from empleado;

SELECT Oficina.*, Empleado.*
FROM Oficina, Empleado
WHERE Oficina = n_Oficina;

-- también se puede usar con INNER JOIN y usando la condición del Join ()
select * from Oficina;
select * from empleado;

SELECT Oficina.*, Empleado.*
FROM Oficina INNER JOIN Empleado ON (Oficina = n_Oficina);

-- También podemos omitir la palabra INNER porque por defecto los JOIN son internos
SELECT Oficina.*, Empleado.*
FROM Oficina JOIN Empleado ON (Oficina = n_Oficina); -- igualdad = equijoin

-- El Join puede ser cualquier valor TRUE/FALSE como un producto cartesiano
SELECT Oficina.*, Empleado.*
FROM Oficina JOIN Empleado ON (TRUE); -- es un producto cartesiano --> 24 filas!

-- Si no hay igualdad sería un theta join
-- comisión es campo de empleado / ventas es campo de oficina / objetivo de oficina

-- se selecciona primero que ese empleado sea de esa oficina (oficina=n_oficina)
--y luego dentro de esos casos lo que cumplan la condición de la comisión. --> EN R se usa un filter().
--SELECT Oficina.*, Empleado.*
SELECT *
FROM Oficina INNER JOIN Empleado ON (oficina=n_oficina and comision*ventas/100 > objetivo/8);


/* -------------------------------------------------------------------------- */
/* OUTER JOIN (Left/right/full) */
/* -------------------------------------------------------------------------- */
-- Permite seleccionar qué tabla aporta el outer
-- en este caso para que salgan todas las oficinas (incluso las que no tienen empleado --> n_oficina = 3)

select * from Oficina;
select * from empleado;

-- Outter Join
--SELECT Oficina.*, Empleado.*
SELECT *
FROM Oficina LEFT OUTER JOIN Empleado
	ON (Oficina = n_Oficina);

-- comparativa con un inner join clásico de las 2 maneras
SELECT Oficina.*, Empleado.*
FROM Oficina, Empleado
where oficina = n_oficina;

SELECT Oficina.*, Empleado.*
FROM Oficina JOIN Empleado
	ON (Oficina = n_Oficina);

-- tambien se puede omitir OUTER al señalar LEFT and/or RIGHT
SELECT Oficina.*, Empleado.*
FROM Oficina LEFT JOIN Empleado
	ON (Oficina = n_Oficina);

-- De igual manera se pueden pedir las oficinas incluso que no tengan empleados 
SELECT Oficina.*, Empleado.*
FROM Empleado RIGHT OUTER JOIN Oficina
	ON (Oficina = n_Oficina);

-- Efecto de la proyección parcial v/s la total en el orden de los atributos
SELECT *
FROM Empleado RIGHT OUTER JOIN Oficina
	ON (Oficina = n_Oficina);

-- todas las oficinas con empleados que cumplan con esos objetivos (condición theta join cualquiera) --> No hay equivalencia en R
--las oficinas que no tienen empleados que cumplan esa condición aparecen pero con valores null.
SELECT Oficina.*, Empleado.*
FROM Oficina LEFT OUTER JOIN Empleado ON (
			oficina=n_oficina and comision*ventas/100 > objetivo/8
			);

/* El orden de restricciones dentro del ON, da igual
SELECT Oficina.*, Empleado.*
FROM Oficina LEFT OUTER JOIN Empleado ON (
			comision*ventas/100 > objetivo/8
			and oficina=n_oficina);
*/

/* -------------------------------------------------------------------------- */
/* 8.1.4 (FULL) OUTER JOIN */
/* -------------------------------------------------------------------------- */

-- Ya que una FK no representa NOT NULL, es posible que haya elementos "NULL" en ambas partes de la unión
-- todas las oficinas aunque no tengan empleados y todos los empleados aunque no tengan oficina

SELECT Oficina.*, Empleado.*
FROM Oficina FULL OUTER JOIN Empleado
	ON (Oficina = n_Oficina);

-- también acepta un theta join y por ser más restrictivo dejará más null(s) --> No funciona como en R
SELECT Oficina.*, Empleado.*
FROM Oficina FULL OUTER JOIN Empleado ON (
			comision*ventas/100 > objetivo/8
			and oficina=n_oficina);

/* -------------------------------------------------------------------------- */
/* JOIN USING lista de campos */
/* -------------------------------------------------------------------------- */
/*
Además de usar el ON se puede usar el USING y dar una lista de campos comunes separados por comas.

Permite hacer equi-Joins
Para usarlo necesita que los campos que se llamen igual
Casi un Join Natural (elimna campos repetidos)
*/

-- Join Interno usando el campo común que es Cargo
select * from categoria;
select * from empleado;

SELECT Categoria.*, Empleado.*
FROM Categoria INNER JOIN Empleado USING (Cargo); -- cargo duplicado

-- Igual pero quitando la palabra INNER
SELECT Categoria.*, Empleado.*
FROM Categoria JOIN Empleado USING (Cargo); -- cargo duplicado


-- Al usar un LEFT JOIN, aplicamos un OUTER JOIN, aparecen valores sin conexión (cargo = RECADERO)
SELECT Categoria.*, Empleado.*
FROM Categoria LEFT JOIN Empleado USING (Cargo); -- cargo duplicado

-- Si no forzamos la seleccion de atributos y usamos SELECT * y USING,
-- los atributos comunes desaparecen --> Join Natural del Álgebra
SELECT *
FROM Categoria LEFT JOIN Empleado USING (Cargo); -- cargo ya no está duplicado

-- Combinando con los Left/right/full OUTER
-- todas las categorias aunque no tenga empleados
SELECT Categoria.*, Empleado.*
FROM Categoria LEFT OUTER JOIN Empleado USING (Cargo);

-- las categorias sin empleados, pero también salen empleados sin categorias
SELECT Categoria.*, Empleado.*
FROM Categoria FULL JOIN Empleado USING (Cargo);

-- Si usamos ON, no hay diferencias entre Select XX.*, YY.* v/s select *
-- Si usamos USING sí que hay diferencias

/*
esto por que el ON es un theta join, mientras que el USING es "casi" un Join natural
*/

-- ON --> se repite cargo
SELECT Categoria.*, Empleado.*
FROM Categoria INNER JOIN Empleado
	ON (Categoria.Cargo=Empleado.Cargo);
	
-- ON --> se sigue repitiendo cargo
SELECT *
FROM Categoria INNER JOIN Empleado
	ON (Categoria.Cargo=Empleado.Cargo);

-- USING --> se repite cargo
SELECT Categoria.*, Empleado.*
FROM Categoria INNER JOIN Empleado USING (cargo);

-- USING --> ya NO se repite cargo
SELECT *
FROM Categoria INNER JOIN Empleado USING (Cargo);


/* -------------------------------------------------------------------------- */
/* NATURAL JOIN */
/* -------------------------------------------------------------------------- */
/*
No necesitamos indicar por qué campos debe hacer la búsqueda, simplemente el algoritmo busca
aquellos campos comunes (nombre y dominio) y hace el Join
*/

-- INNER JOIN con USING
SELECT Categoria.*, Empleado.*
FROM Categoria INNER JOIN Empleado USING (cargo);

-- JOIN NATURAL el sólo sabe que Cargo se repite (= resultado)
SELECT Categoria.*, Empleado.*
FROM Categoria NATURAL INNER JOIN Empleado;

-- Para evitar que se repita el campo duplicado (cargo)
SELECT *
FROM Categoria NATURAL INNER JOIN Empleado;

-- JOIN NATURAL s/especificar el INNER que es default (= resultado)
SELECT Categoria.*, Empleado.*
FROM Categoria NATURAL JOIN Empleado;

-- También para Joint externos (todas las categorías aunque no tengan empleados)
SELECT Categoria.*, Empleado.*
FROM Categoria NATURAL LEFT JOIN Empleado;

-- Join Externo donde aparece todo:
-- categorias sin empleados + 
-- empleados sin cargo
SELECT Categoria.*, Empleado.*
FROM Categoria NATURAL FULL JOIN Empleado;

-- Efecto de la proyección (igual que antes, elimina atributo duplicado)
SELECT *
FROM Categoria NATURAL FULL JOIN Empleado;

/* -------------------------------------------------------------------------- */
/* Ejercicios de Joins*/
/* -------------------------------------------------------------------------- */
/*
Dejarles que lo desarrollen ellos y dar punto a quién los resuelve
Página 45 apuntes Tema 3
*/

/* -------------------------------------------------------------------------- */
/* Ejercicio 1 */

/*
2 Tablas con a1 y a2 dos campos en común.
*/

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

drop table if exists a, b cascade;

create table a (
a1 integer,
a2 integer,
a3 integer,
a4 integer,

primary key (a1, a2));


create table b (
a1 integer,
a2 integer,
b3 integer primary key,
b4 integer,

foreign key (a1, a2) references a);

select * from a;
select * from b;

/* -------------------------------------------------------------------------- */


/* -------------------------------------------------------------------------- */
/* Utilizando ON y proyectando ( a1, a2, a3, a4, b3, b4) */

/*
Atención que los campos repetidos a1 y a2 se solicitan sólo una vez.

el ON (ejercicio 1.1) no quita atributos duplicados (es un theta Join) a diferencia de 
usar el USING o el NATURAL dentro del Join
*/


-- Usamos el ON y SELECT *
-- deberemos igualar en el ON la clave compuesta de a1 y a2 de ambas tablas

-- Los campos a1 y a2 salen 2 veces!
select *
from a join b on (a.a1 = b.a1 and a.a2 = b.a2);


-- Quitamos los campos comunes, haciendo una proyección
select a.*, b3, b4
from a join b on (a.a1 = b.a1 and a.a2 = b.a2);

/* -------------------------------------------------------------------------- */
/* Utilizando USING y proyectando ( a1, a2, a3, a4, b3, b4) */

/*
En este caso, al usar USING los campos comunes se proyectan solo individualmente
*/

-- USING
select *
from a join b using (a1, a2);


/* -------------------------------------------------------------------------- */
/* Utilizando NATURAL y proyectando ( a1, a2, a3, a4, b3, b4) */

/*
En este caso, al usar NATURAL los campos comunes se proyectan solo individualmente
*/

-- NATURAL
select *
from a natural join b;
/* -------------------------------------------------------------------------- */


/* -------------------------------------------------------------------------- */
/* Ejercicio 2 */

/*
2 Tablas de profesores
*/

/* -------------------------------------------------------------------------- */
/* Respondemos la preguna sin más */

/*
-- se hace el JOIN usando IdProfesor que aparece en ambas, pero es PK en Profesores (identifica a c/profesor) y sin embargo es FK en asignaturas, ya que indica qué profe entrega cada asignatura pero puede repetirse ya que hay un profe que de más de una asignatura
*/

--128 filas
SELECT *
FROM profesores INNER JOIN asignaturas USING (IdProfesor);


-- Sin embargo con NATURAL salen 0 filas
SELECT *
FROM profesores NATURAL JOIN asignaturas;

/* RESPUESTA:
NATURAL busca todos los campos con el mismo nombre y además de IdProfesor hay otro campo que se llama igual, que es Nombre. Sin embargo en profesores el nombre indica el nombre del profe y en asignatura indica el nombre de la asignatura, por lo que nunca van a coincidir sus dominios.
*/

/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* Ejercicio 3 */

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

drop table if exists departamentos, proyectos cascade;

create table departamentos (
deptid smallint primary key,
nombre varchar(20) not null,
presupuesto numeric(8,2)
);


create table proyectos (
proyid smallint primary key,
nombre varchar(20) not null,
presupuesto numeric(8,2)
);

insert into departamentos values (1, 'dep1', 1000), (2, 'dep2', 2000), (3, 'dep3', 3000);

insert into proyectos values (1, 'proy1', 1500), (2, 'proy2', 2500), (3, 'proy3', 3500);
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* 3.1.

Si el departamento D tiene presupuesto suficiente como para abordar el proyecto P, salgan el
nombre del proyecto y del departamento. 

Es decir que el departamento cuyo presupuesto sea mayor que el presupuesto de cualquier proyecto. Como se llaman los campos iguales "presupuesto" hay que nombrarlos
*/

-- departamentos.presupuesto ha de ser mayo (>) que proyectos.presupuesto.
-- necesitamos seleccionar a partir del producto cartesiano aquellas que cumplan un ON

select departamentos.nombre as nombre_dept, proyectos.nombre as nombre_proy
from departamentos join proyectos
on (departamentos.presupuesto >= proyectos.presupuesto);
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* 3.2.

Igual que el anterior pero forzando a que salgan todos los proyectos, solo que uno de ellos no podrá ejecutar ningún proyecto y dará como resultado null.
*/

-- departamentos.presupuesto ha de ser mayo (>) que proyectos.presupuesto.
-- Para sacarlo necesitaremos hacer un join externo y ver el null del proy1 (son pobres!)
select departamentos.nombre as nombre_dept, proyectos.nombre as nombre_proy
from departamentos left join proyectos
on (departamentos.presupuesto >= proyectos.presupuesto);
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* Ejercicio 4 */

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

drop table if exists asignaturas, profesores, imparte cascade;

CREATE TABLE asignaturas (
id integer primary key,
nombre char(15),
horasclase integer
);


CREATE TABLE profesores (
dni integer primary key,
nombre char(15),
horasContrato integer
);

-- usadas porque representan relaciones varios a varios
CREATE TABLE imparte (
dni integer references profesores,
id integer references asignaturas,

primary key (dni, id)
);


insert into asignaturas values (1, 'Asig1', 80), (2, 'Asig2', 40), 
(3, 'Asig3', 20), (4, 'Asig4', 10);

insert into profesores values (1, 'Prof1', 100), (2, 'Prof2', 50), 
(3, 'Prof3', 25), (4, 'Prof4', 10);

insert into imparte values (1, 1), (2, 2), (2, 3), (3, 3);


/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* 4.1.
Listado de profesores con su(s) asignatura(s), incluyendo los profesores que no dan clases de nada
*/

-- asignaturas y profesores no se pueden unir (auqnue nombre sea común) y requiere imparte

-- 1º) join de asignatura con imparte
select *
from imparte join asignaturas using (id);

-- 2º) join con los profesores, pero tengo que incluirlos a todos (left join) y hace join con un paréntesis que es toda l atabla anterior

select profesores.nombre, asignaturas.nombre
from profesores left join (imparte join asignaturas using (id))
		using (dni);


-- se puede hacer sin paréntesis usando inner y right join
select profesores.nombre, asignaturas.nombre
from imparte join asignaturas using (id)
	right join profesores using (dni);


-- se puede hacer también usando 2 left joins. En varios pasos:

-- se muestran todos los profes aunque no impartan nada (null porque no imparte asig)
select *
from profesores left join imparte using (dni)


-- si hacemos un join con las asignaturas, perdemos al profe 4!
select *
from profesores left join imparte using (dni)
join asignaturas using (id); -- se pierde porque el id es null.

-- necesitamos el segundo left join
select *
from profesores left join imparte using (dni)
left join asignaturas using (id);

-- por último proyectamos solo los nombres de profes y de asignaturas
select profesores.nombre, asignaturas.nombre
from profesores left join imparte using (dni)
left join asignaturas using (id);


/* -------------------------------------------------------------------------- */
/* 4.2.
Listado de asignatura(s) con su(s) profesore(s), incluyendo las asignaturas que no se imparten
*/
-- igual que anterior porque es simétrica
select asignaturas.nombre, profesores.nombre
from asignaturas left join imparte using (id)
		 left join profesores using (dni);


/* -------------------------------------------------------------------------- */
/* 4.3.
Listado de asignatura(s) con su(s) profesore(s), incluyendo las asignaturas que no se imparten y los profesores que no imparten
*/

-- primero asignaturas que no imparte nadie
select *
from asignaturas left join imparte using (id)

-- si hacemos un left join como antes no perdemos esa asignatura, pero el prof4 no aparece
select *
from asignaturas left join imparte using (id)
		 left join profesores using (dni);

-- necesitamos un left join y un full join y luego proyectamos (desconectamos)
select *
--select asignaturas.nombre, profesores.nombre
from asignaturas left join imparte using (id)
		 full join profesores using (dni);


/* -------------------------------------------------------------------------- */
/* 4.4.
Profesores que con su contrato NO podrían cubrir alguna asignatura.
Horas de contrato menores que las horas de alguna asignatura (theta-join)
*/


-- mirar horas de contrato y horas de clases
-- profesor 1 no sale porque tiene 100 horas y puede con todas 
select profesores.nombre, horascontrato, asignaturas.nombre, horasclase
from profesores join asignaturas on (horascontrato < horasclase);

-- para que salgan todos incluyendo el 1 relacioado con ninguna, porque no hay ninguna que no pueda cubrir con su contrato.
select profesores.nombre, horascontrato, asignaturas.nombre, horasclase
from profesores left join asignaturas on (horascontrato < horasclase);
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */


/* -------------------------------------------------------------------------- */
/* El cociente relacional  ¡NO! */
/* -------------------------------------------------------------------------- */

/* 
Es una operación Derivada y vamos a buscar una serie de pasos "elementales" para llevarlos a cabo.
¡NO EXISTE LA OPERACIÓN EN SQL COMO TAL!

Se revisa poco porque no se hace así...plop!

Se usan restas, proyecciones y Productos cartesianos.

*/


/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

/* Necesitamos conocer los chicos que conocen a todas las chicas y para eso haremos:
1) El DNI de todos los chicos - El DNI de los chicos que les falta por conocer alguna chica
2) El DNI de los chicos que les falta conocer a alguna chica = las parejas de chicos chicas que aún no se conocen
3) Las que añun no se conocen es la resta de todas las combinaciones menos las que sí se conocen

 */

--drop view parejasIreales, chicosQueNoConocenAtodas CASCADE;
drop table if exists CHICOS, CHICAS, CONOCE, parejasIreales, chicosQueNoConocenAtodas;


create table CHICOS(
	DNIchico integer primary key,
	nombre	 varchar(10));

insert into CHICOS values	
	 (1, 'Pepe'),
	 (2, 'Juan'),
	 (3, 'Luis');

create table CHICAS(
	DNIchica integer primary key,
	nombre	 varchar(10));

insert into CHICAS values	
	 (4, 'Ana'),
	 (5, 'Maria');

create table CONOCE( 
	DNIchico integer references CHICOS,
	DNIchica integer references CHICAS,
	PRIMARY KEY (DNIChico, DNIChica));
	
insert into CONOCE values
	 (1, 4),
	 (1, 5),
	 (2, 4);
	 
/* -------------------------------------------------------------------------- */

-- inspeccionamos las tres tablas
select * from chicos;
select * from chicas;	
select * from conoce;		
	

/* -------------------------------------------------------------------------- */
/*
Vamos a hacer:
1) Coger todas las combinaciones CHICO X CHICA (Producto Cartesiano) y restarle (RESTA = EXCEPT)
Las parejas que están en la tabla CONOCE.
2) De esta resta (Parejas que no se han conocido, no existen) la usamos para restarsela a CHICOS
*/

-- Todas las combinaciones chico X chica
SELECT DNIchico, DNIChica
FROM Chicos, Chicas;


-- Todas las combinaciones de la tabla conoce
SELECT DNIChico, DNIChica
FROM Conoce;

-- Restamos a Todas las combinaciones chico X chica, aquellas combinaciones de la tabla conoce
-- Estos son las parejas que no existem, que aún no se han conocido.
SELECT DNIchico, DNIChica
FROM Chicos, Chicas
EXCEPT
SELECT DNIChico, DNIChica
FROM Conoce;

-- Guardamos en una tabla las parejas de chicos que les falta conocer alguna chica
-- Podríamos haberlas guardado en un View, pero usaremos una tabla temporal

-- CREATE VIEW parejasIreales AS
create local temporary table parejasIreales as -- tabla temporal vive solo surante la sesión
SELECT DNIchico, DNIChica
FROM Chicos, Chicas
EXCEPT
SELECT DNIChico, DNIChica
FROM Conoce;

-- visualizamos las parejas irreales
select * from parejasIreales;


-- Para obtener el DNI de los chicos que no conocen a todas las chicas, hacemos una proyección

--CREATE VIEW chicosQueNoConocenAtodas AS
create local temporary table chicosQueNoConocenAtodas as
SELECT DNIChico FROM parejasIreales;

-- visualizamos los DNI de estos chicos
select * from chicosQueNoConocenAtodas;


-- Restamos de Todos los chicos, aquellos que no conocen a todas y tenemos a los CHICOS que conocen 
-- a todas las CHICAS

SELECT DNIchico FROM Chicos
EXCEPT
SELECT DNIchico FROM chicosQueNoConocenAtodas;


/* -------------------------------------------------------------------------- */
/* Comprobamos que el SQL es AR Completo, ya que se pueden ejecutar todas las operaciones del AR*/
/* -------------------------------------------------------------------------- */



/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */