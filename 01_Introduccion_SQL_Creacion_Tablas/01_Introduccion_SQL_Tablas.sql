/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* GUIA CODIGOS TEMA 2 */
/*----------------------------------------------------------------------------------*/
-- PRÁCTICA 1: Introducción a SQL y creación de tablas
-- Objetivo: Familiarizarse con la sintaxis básica de SQL para la creación de tablas, inserción de datos y consultas simples.
/*----------------------------------------------------------------------------------*/
create table alumnos (
cod integer,
nombre varchar (20)
);

insert into alumnos values (1, 'Pepe'), (2, 'Ana'), (3, 'Juan') ;

select * from alumnos;

--GUARDAR COMO FICHERO
--Especificamos sql

-- EJECUTARLOS NUEVAMENTE 


/*###-------------------------------------------------------------------------###*/
-- COMENTANDO EL CÓDIGO
-- COMENTAR EN MULTIPLE LINEAS
-- Start (/*)
-- End (*/)

CREATE TABLE alumnos (
cod integer,
nombre varchar (20)
);

/*
insert into alumnos values (1, 'Pepe'), (2, 'Ana'), (3, 'Juan') ;

select * from alumnos;
*/


-- COMENTAR EN UNA SOLA LINEA
--Start (--)

CREATE TABLE alumnos ( -- crea una tabla de alumnos
cod integer,
nombre varchar (20) -- solo de longitud 20 caracteres
);

/*
insert into alumnos values (1, 'Pepe'), (2, 'Ana'), (3, 'Juan') ;

select * from alumnos;
*/


/*###-------------------------------------------------------------------------###*/
-- MAYUSCULAS v/s MINUSCULAS

drop table if exists alumnos;

CREATE TABLE Alumnos (
cod integer,
nombre varchar (20)
);

insert into alumnos values (1, 'Pepe'), (2, 'Ana'), (3, 'Juan') ; -- Nieveles sí se ven afectados 'pepe' no es 'PEPE'.

select * from alumnos;

/* ###-------------------------------------------------------------------------###*/
-- SEPARADORES (Espacio / Tab/ etc)insert into alumnos values (1,'Pepe'), (2, 'Ana'), (3, 'Juan'), (4, 'Francisco)');

select * from alumnos;

drop table if exists alumnos;

create table alumnos (cod integer,  nombre varchar (20) );

insert into alumnos values (1, 'Pepe'), 
(2, 'Ana'), 
(3, 'Juan') ;

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--INSERT LINEA INDIVIDUAL y hablar del orden

drop table if exists alumnos;

create table alumnos (cod integer,  nombre varchar (20) );

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ;

insert into alumnos values (4, 'Maria');

select * from alumnos; -- determina el orden según rapidez de ejecución


/*###-------------------------------------------------------------------------###*/
--TIPOS DE DATOS
--ENTEROS

drop table if exists alumnos;

create table alumnos (
cod smallint,  
nombre varchar (20) );

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ;

insert into alumnos values (4, 'Maria');

select * from alumnos; -- determina el orden según rapidez de ejecución

--Diferencias de tamaño entre integer o smallint revisarlos en:
-- https://www.postgresql.org/docs/current/datatype.html


/*###-------------------------------------------------------------------------###*/
--TIPOS DE DATOS
--ENTEROS -- uso del smallint y char

drop table if exists alumnos;

create table alumnos (
cod smallint,  
nombre char (20) );

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ;

insert into alumnos values (4, 'Maria');

select * from alumnos; -- determina el orden según rapidez de ejecución


/*###-------------------------------------------------------------------------###*/
--NULL 
--Agregamos el atributo ciudad

drop table if exists alumnos;

create table alumnos (
cod smallint,  
nombre varchar (20),
ciudad char(20)
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ;

insert into alumnos values (4, 'Maria');

--Saldrá null porque en el insert into no hay valores
select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--INSERT Multi-fila deben tener la misma estructura 

drop table if exists alumnos;

create table alumnos (
cod smallint,  
nombre varchar (20),
ciudad char(20)
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana', 'León'),  (3, 'Juan') ; --genera error por la estructura multifila

insert into alumnos values (4, 'Maria');

select * from alumnos;

/*###-------------------------------------------------------------------------###*/
--INSERT UNI-fila Sí se puede agregar un campo diferente 

drop table if exists alumnos;

create table alumnos (
cod smallint,  
nombre varchar (20),
ciudad char(20)
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

select * from alumnos;

/*###-------------------------------------------------------------------------###*/
--INSERT valor nulo --> 2 approaches

drop table if exists alumnos;

create table alumnos (
cod smallint,  
nombre varchar (20),
ciudad char(20)
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

--Insert null opción 1
insert into alumnos values (5, null, 'Burgos');

--Insert null opción 2
insert into alumnos (cod, ciudad) values (6, 'Burgos');

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--DEFAULT 

drop table if exists alumnos;

create table alumnos (
cod smallint,  
nombre varchar (20),
ciudad char(20) default 'Soria'
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

--Insert null opción 1
insert into alumnos values (5, null, 'Burgos'); 

--Insert null opción 2
insert into alumnos (cod, ciudad) values (6, 'Burgos');

--Insertamos luego un valor de ciudad forzando el null
insert into alumnos values (7, 'Antonio', null); 

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--NUMERIC con decimales

drop table if exists alumnos;

create table alumnos (
cod smallint,  
nombre varchar (20),
ciudad char(20) default 'Soria',
telefono numeric(9),
nota     numeric(3,2) 
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

--Insert null opción 1
insert into alumnos values (5, null, 'Burgos'); 

--Insert null opción 2
insert into alumnos (cod, ciudad) values (6, 'Burgos');

--Insertamos luego un valor de ciudad forzando el null
insert into alumnos values (7, 'Antonio', null, null, 10); 
insert into alumnos values (7, 'Antonio', null, null, 9.5); 

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--NUMERIC con decimales 

drop table if exists alumnos;

create table alumnos (
cod smallint,  
nombre varchar (20),
ciudad char(20) default 'Soria',
telefono numeric(9),
nota     numeric(4,2) 
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

--Insert null opción 1
insert into alumnos values (5, null, 'Burgos'); 

--Insert null opción 2
insert into alumnos (cod, ciudad) values (6, 'Burgos');

--1: Insertamos meter un valor mayor de decimales para ver el redondeo
insert into alumnos values (7, 'Antonio', null, null, 9.6666666); 

--2: Insertamos meter un valor mayor de caracteres para ver el error
insert into alumnos values (7, 'Antonio laaaaaaaaaaargo', null, null, 9.5); 

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--DATE time/Data 

drop table if exists ejemplo_tiempos;

create table ejemplo_tiempos (
fecha date,
hora time, /* Se utiliza muy poco */
fecha_hora timestamp
);

--1: metemos hora con date y sin date para forzar el reconocimiento de hora
insert into ejemplo_tiempos values ('04-06-2018');

--2: metemos también un tiempo
insert into ejemplo_tiempos values ('04-06-2018','21:20:56');

--3: metemos también un timestamp
insert into ejemplo_tiempos values ('04-06-2018', '21:20:56', '04-06-2018 21:20:56.36');

select * from ejemplo_tiempos; /* Ver el formato de fecha */