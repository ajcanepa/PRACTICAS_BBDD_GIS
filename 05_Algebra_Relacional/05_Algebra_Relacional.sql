/* -------------------------------------------------------------------------- */
/* ### TEMA 3 (Teoría BBDD-GIS) ### */
/* ### ÁLGEBRA RELACIONAL ### */
/* -------------------------------------------------------------------------- */
-- PRÁCTICA: operaciones de conjunto y AR
-- Objetivo: Entender el concepto de conjunto y sus operaciones.

/* ###-------------------------------------------------------------------------###
# Operaciones UNARIAS
###-------------------------------------------------------------------------### */
/* CREAMOS BBDD para trabajar */

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

-- atributo comparador constante: Salarios mayores que 1000
select salario from empleados 
where salario > 1000;

select distinct salario from empleados 
where salario > 1000;

-- atributo comparador atributo: salario > ventas

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

-- con duplicados
select categoria, salario from empleados;

-- sin duplicados
select distinct categoria, salario from empleados;

-- proyeccion incluyendo los atributos dentro de select lista 1 subconjunto lista 2 
select distinct categoria, salario, ciudad from empleados
where ciudad = 'Burgos';

/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* Operaciones de Conjuntos */
/* -------------------------------------------------------------------------- */
/* 
Operaciones de Conjuntos U (unión) ∩ (intersección) - (diferencia)
en SQL --> Union = union // Intersección = intersect // diferencia = except
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

-- Ciudades que tienen vendedores o tienen menos de 100.000 habitantes
select ciudad from empleados where categoria='Vendedor'
union
select ciudad, habitantes from Ciudades where habitantes < 100000;


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

--Nombre y apellidos de profesores que no son alumnos S/Repetidos

--Nombre y apellidos de profesores que no son alumnos C/Repetidos

--Nombre y apellidos de alumnos q no son profesores (probar ALL, da lo mismo)

/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* ORDER BY en las operaciones de Conjunto */
/* -------------------------------------------------------------------------- */

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
ORDER BY Nro, Ape1, Ape2; 

SELECT Nro as id, Nombre, Apellido1 as Ape1, Apellido2 as Ape2
FROM profesores
WHERE apellido2 ='Alvarez'
UNION
SELECT Matricula as id, Nombre, Ape1, Ape2
FROM alumnos
ORDER BY id, Ape1, Ape2; 

/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* Producto Cartesiano (PC) */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */
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

SELECT * 
FROM oficina, empleado;

SELECT *
FROM oficina, empleado, categoria;

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
--SELECT *, categoria.cargo 
FROM oficina, empleado;

SELECT oficina.n_oficina, oficina.ventas, empleado.cargo
FROM oficina, empleado;

select * 
FROM oficina, empleado;

/* ###-------------------------------------------------------------------------###
# Operaciones BINARIAS (JOINS)
###-------------------------------------------------------------------------### */
/* -------------------------------------------------------------------------- */
/* Theta Join  */
/* -------------------------------------------------------------------------- */
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

/* -------------------------------------------------------------------------- */
/* Join Derivado --> "a mano" */
/*
Sintaxis similar al producto cartesiano
*/
/* -------------------------------------------------------------------------- */

SELECT DISTINCT *
FROM empleado, oficina;

SELECT DISTINCT nombre, población
FROM empleado, oficina;

SELECT DISTINCT nombre, población 
FROM empleado, oficina
WHERE Oficina = n_Oficina; 

SELECT DISTINCT * 
FROM empleado, oficina
--WHERE empleado.Oficina = oficina.n_Oficina;
WHERE Oficina = n_Oficina;

-- Usando un Theta (no equi) join 
SELECT DISTINCT nombre 
FROM empleado, oficina
WHERE comision*ventas/100 > objetivo/8;

-- Cuidado que este theta join no evita las filas espúrias
SELECT DISTINCT * 
FROM empleado, oficina
WHERE comision*ventas/100 > objetivo/8;


-- Condicion de Theta después de producto cartesiano con Otros campos
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

/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

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
SELECT *
FROM Empleado, Oficina
where oficina = n_oficina;


/* -------------------------------------------------------------------------- */
/* Join usando atributos de == nombre */

SELECT *
FROM Empleado, Categoria
where cargo = cargo;  

SELECT *
FROM Empleado, Categoria
where Empleado.cargo = Categoria.cargo; 

SELECT *
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina 
AND categoria.cargo = empleado.cargo; 
/* -------------------------------------------------------------------------- */


/* -------------------------------------------------------------------------- */
/* AHORA CON CLAVE COMPUESTA */
/* -------------------------------------------------------------------------- */
/* CREAMOS BBDD para trabajar */

drop table if exists oficina, empleado, categoria cascade;

create table OFICINA (
 n_oficina 	integer,
 población	char(15),
 region	char(15),
 ventas	numeric(10,2),
 objetivo	numeric(10,2),
 
 primary key(n_oficina, region) 
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
 
 foreign key (oficina, region) references oficina 
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

SELECT *
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina AND empleado.region = oficina.region -- Une Empleado y Oficina 
AND categoria.cargo = empleado.cargo; -- une Categoria con Empleado


SELECT *
FROM Categoria, Empleado, Oficina
WHERE Empleado.oficina = Oficina.n_oficina AND Empleado.region = Oficina.region -- Une Empleado y Oficina 
AND categoria.cargo = empleado.cargo; -- une Categoria con Empleado

/* -------------------------------------------------------------------------- */
/* Del Join anterior filtramos algunas filas según criterios */


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

-- Aquellos salarios mayores que 2000 ó ventas mayores que 50000
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

-- revisamos empleados nuevamente
SELECT * FROM Empleado;

SELECT *
FROM Categoria, Empleado, Oficina
WHERE oficina = n_oficina -- une Empleado y Oficina
AND categoria.cargo = empleado.cargo; -- une Categoria y Empleado

/* -------------------------------------------------------------------------- */
/* outer join -- JOIN Externo */

select * from oficina;
select * from empleado;


SELECT Oficina.* 
FROM Oficina, Empleado
WHERE Oficina = n_Oficina;

SELECT * FROM Oficina
EXCEPT
SELECT Oficina.*
FROM Oficina, Empleado
WHERE Oficina = n_Oficina;

-- Guardamos esta consulta anterior en un "objeto" llamado Vista.
-- Una vista no se materializa solo se ejecuta cada vez que se le llama
-- La vista será OficinasSinEmpleados

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


/* -------------------------------------------------------------------------- */
/* Joins Cualificados en SQL */
/* -------------------------------------------------------------------------- */
/*
Nueva Sintaxis a partir de 1992
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
FROM Oficina LEFT OUTER JOIN Empleado ON (Oficina = n_Oficina);

-- comparativa con un inner join clásico de las 2 maneras
SELECT Oficina.*, Empleado.*
FROM Oficina, Empleado
where oficina = n_oficina;

SELECT Oficina.*, Empleado.*
FROM Oficina JOIN Empleado ON (Oficina = n_Oficina);

-- tambien se puede omitir OUTER al señalar LEFT and/or RIGHT
SELECT Oficina.*, Empleado.*
FROM Oficina LEFT JOIN Empleado ON (Oficina = n_Oficina);

-- De igual manera se pueden pedir las oficinas incluso que no tengan empleados 
SELECT Oficina.*, Empleado.*
FROM Empleado RIGHT OUTER JOIN Oficina ON (Oficina = n_Oficina);

-- Efecto de la proyección parcial v/s la total en el orden de los atributos
SELECT *
FROM Empleado RIGHT OUTER JOIN Oficina ON (Oficina = n_Oficina);

-- todas las oficinas con empleados que cumplan con esos objetivos (condición theta join cualquiera)
SELECT Oficina.*, Empleado.*
FROM Oficina LEFT OUTER JOIN Empleado ON (
			oficina=n_oficina and comision*ventas/100 > objetivo/8
			);

/* -------------------------------------------------------------------------- */
/* 8.1.4 (FULL) OUTER JOIN */
/* -------------------------------------------------------------------------- */

SELECT Oficina.*, Empleado.*
FROM Oficina FULL OUTER JOIN Empleado
	ON (Oficina = n_Oficina);

-- también acepta un theta join y por ser más restrictivo dejará más null(s) 
SELECT Oficina.*, Empleado.*
FROM Oficina FULL OUTER JOIN Empleado ON (
			comision*ventas/100 > objetivo/8
			and oficina=n_oficina);

/* -------------------------------------------------------------------------- */
/* JOIN USING lista de campos */
/* -------------------------------------------------------------------------- */
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
FROM Categoria LEFT JOIN Empleado USING (Cargo); 

SELECT *
FROM Categoria LEFT JOIN Empleado USING (Cargo); 

-- todas las categorias aunque no tenga empleados

-- las categorias sin empleados, pero también salen empleados sin categorias


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

/* -------------------------------------------------------------------------- */
/* Ejercicios de Joins*/
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* Ejercicio 1 */
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
/* Utilizando USING y proyectando ( a1, a2, a3, a4, b3, b4) */

/* -------------------------------------------------------------------------- */
/* Utilizando NATURAL y proyectando ( a1, a2, a3, a4, b3, b4) */

-- NATURAL
select *
from a natural join b;
/* -------------------------------------------------------------------------- */


/* -------------------------------------------------------------------------- */
/* Ejercicio 2 */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
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
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* 3.2.

Igual que el anterior pero forzando a que salgan todos los proyectos, solo que uno de ellos no podrá ejecutar ningún proyecto y dará como resultado null.
*/

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

/* -------------------------------------------------------------------------- */
/* 4.2.
Listado de asignatura(s) con su(s) profesore(s), incluyendo las asignaturas que no se imparten
*/

/* -------------------------------------------------------------------------- */
/* 4.3.
Listado de asignatura(s) con su(s) profesore(s), incluyendo las asignaturas que no se imparten y los profesores que no imparten
*/


/* -------------------------------------------------------------------------- */
/* 4.4.
Profesores que con su contrato NO podrían cubrir alguna asignatura.
Horas de contrato menores que las horas de alguna asignatura (theta-join)
*/


/* -------------------------------------------------------------------------- */
/* Comprobamos que el SQL es AR Completo, ya que se pueden ejecutar todas las operaciones del AR*/
/* -------------------------------------------------------------------------- */



/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */