/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* GUIA CODIGOS TEMA 2 */
/*----------------------------------------------------------------------------------*/
-- PRÁCTICA 2: Restricciones en SQL
-- Objetivo: Familiarizarse con el concepto de restricción y los tipos más comunes

/*###-------------------------------------------------------------------------###*/
--RESTRICCIONES
/*###-------------------------------------------------------------------------###*/

/* Restricciones en SQL
NOT NULL: Sirve para prohibir que un valor tome un valor nulo (`null`)
PRIMARY KEY: identificador individual de la tupla. Evita valores repetidos y nulos
UNIQUE: No permite valores repetidos
CHECK:  Para determinar posibles rangos factibles de valores (notas 0-10) o elementos específicos
FOREIGN KEY: Llave de unión entre dos tablas

Se escriben al final de la Declaración del Campo.
*/


/*###-------------------------------------------------------------------------###*/
--# NOT Null #1
drop table if exists alumnos;

create table alumnos (
cod smallint not null default 0,  
nombre varchar (20),
ciudad char(20) default 'Soria',
telefono numeric(9),
nota     numeric(4,2) 
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 
insert into alumnos values (4, 'Maria', 'León');
select * from alumnos;
--Insert null opción 1
insert into alumnos values (5, null, 'Burgos'); 
insert into alumnos values (null, 'Pedro', 'Burgos', 551, 4.75); 

--Insert null opción 2
insert into alumnos (cod, ciudad) values (6, 'Burgos'); 
insert into alumnos (nota, ciudad) values (6.00, 'Burgos'); 
select * from alumnos;
--1: Insertamos meter un valor mayor de decimales para ver el redondeo
insert into alumnos values (7, 'Antonio', null, null, 9.6666666); 

insert into alumnos values (null, 'Juan', null, null, 9.6666666); -- error NOT NULL (comment --)

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--# NOT Null #2 Prohibimos el null donde efectivamente hay un null

drop table if exists alumnos;

create table alumnos (
cod smallint not null,  
nombre varchar (20) not null,
ciudad char(20) default 'Soria',
telefono numeric(9),
nota     numeric(4,2) 
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

--Insert null opción 1
insert into alumnos values (5, null, 'Burgos'); -- error NOT NULL (Comment --)

--Insert null opción 2
insert into alumnos (cod, ciudad) values (6, 'Burgos'); -- error NOT NULL (Comment --)

--1: Insertamos meter un valor mayor de decimales para ver el redondeo
insert into alumnos values (7, 'Antonio', null, null, 9.6666666); 

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--# PRIMARY KEY Campo o combinacion de campos
--# 1 No permite valores repetidos

--# En nuestro caso el código del alumno.

drop table if exists alumnos;

create table alumnos (
cod smallint primary key,  
nombre varchar (20) not null,
ciudad char(20) default 'Soria',
telefono numeric(9) unique,
nota     numeric(4,2) 
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');
--insert into alumnos values (5, null, 'Burgos'); -- error NOT NULL (Comment --)
--insert into alumnos (cod, ciudad) values (6, 'Burgos'); -- error NOT NULL (Comment --)
insert into alumnos values (7, 'Antonio', null, null, 9.6666666); 
select * from alumnos;
--# Impide valores repetidos (probar)
insert into alumnos values (8, 'Luisa', null, 123, 9.5); --Error PK 
insert into alumnos values (9, 'Ximena', null, null, 9.5); 

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--# PRIMARY KEY Campo o combinacion de campos
--# 2 No permite NOT NULL, lo contiene! así que not null está de sobra

--# En nuestro caso el código del alumno.

drop table if exists alumnos;

create table alumnos (
cod smallint primary key,  
nombre varchar (20) not null,
ciudad char(20) default 'Soria',
telefono numeric(9),
nota     numeric(4,2) 
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

--insert into alumnos values (5, null, 'Burgos'); -- error NOT NULL (Comment --)

--insert into alumnos (cod, ciudad) values (6, 'Burgos'); -- error NOT NULL (Comment --)

insert into alumnos values (7, 'Antonio', null, null, 9.6666666); 

--# Impide valores repetidos (probar)
--insert into alumnos values (7, 'Luisa', null, null, 9.5); --Error PK 

--# Impide valores null
insert into alumnos values (null, 'lucho', null, null, 9.5); --Error PK 


select * from alumnos;

/*###-------------------------------------------------------------------------###*/
--# UNIQUE
--# NO PUEDEN HABER MAS DE 1 PK, intentar con teléfono y fallará

--# Para evitar que el teléfono se repita se puede usar un UNIQUE (o cuantos haga falta!)

drop table if exists alumnos;

create table alumnos (
cod smallint primary key,  
nombre varchar (20) not null,
ciudad char(20) default 'Soria',
telefono numeric(9) not null unique,
nota     numeric(4,2) 
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan'); 
select * from alumnos;

insert into alumnos values (4, 'Maria', 'León');

--insert into alumnos values (5, null, 'Burgos'); -- error NOT NULL (Comment --)

--insert into alumnos (cod, ciudad) values (6, 'Burgos'); -- error NOT NULL (Comment --)

insert into alumnos values (7, 'Antonio', null, null, 9.6666666); 

--# Impide valores repetidos (probar)
--insert into alumnos values (7, 'Luisa', null, null, 9.5); --Error PK 

--# Impide valores null
--insert into alumnos values (null, 'lucho', null, null, 9.5); --Error PK 

--# METEMOS TELEFONO 1
insert into alumnos values (7, 'Antonio', null, 947123123, 9.6666666); 

--# METEMOS TELEFONO 2
insert into alumnos values (8, 'Luisa', null, 947123123, 9.6666666); --Error UNIQUE 

select * from alumnos;

/*###-------------------------------------------------------------------------###*/
--# UNIQUE
--# REPETIR UNIQUE y conversar acerca de los NULL porque parece que se repite el null, pero en realidad no es un valor!

--# Para evitar que el teléfono se repita se puede usar un UNIQUE (o cuantos haga falta!)

drop table if exists alumnos;

create table alumnos (
cod smallint primary key,  
nombre varchar (20) not null unique,
ciudad char(20) default 'Soria',
telefono numeric(9) unique,
nota     numeric(4,2) 
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

--insert into alumnos values (5, null, 'Burgos'); -- error NOT NULL (Comment --)

--insert into alumnos (cod, ciudad) values (6, 'Burgos'); -- error NOT NULL (Comment --)

insert into alumnos values (7, 'Antonio', null, null, 9.6666666); 

--# Impide valores repetidos (probar)
--insert into alumnos values (7, 'Luisa', null, null, 9.5); --Error PK 

--# Impide valores null
--insert into alumnos values (null, 'lucho', null, null, 9.5); --Error PK 

--# METEMOS TELEFONO 1
insert into alumnos values (7, 'Antonio', null, 947123123, 9.6666666); 

--# METEMOS TELEFONO 2
insert into alumnos values (8, 'Luisa', null, 947123124, 9.6666666); 

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--# CHECK
--# Para que la nota esté determinada por unos valores (mayor, menor, igual, etc)
--# Carcateres iguales o diferentes a un caracter base.

drop table if exists alumnos;

create table alumnos (
cod smallint primary key,  
nombre varchar (20) not null unique,
ciudad char(20) default 'Soria' check (ciudad !='Londres'), -- check siempre después de default!,
telefono numeric(9) unique,
nota     numeric(4,2) check(nota >=0) -- >, <, >=, <=, =, !=
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 
insert into alumnos values (4, 'Maria', 'León');
insert into alumnos values (5, 'Ximena', null);
insert into alumnos values (6, 'Alberto', 'LOndres');
insert into alumnos values (7, 'Fran', null, null, 0);
select * from alumnos;


--insert into alumnos values (5, null, 'Burgos'); -- error NOT NULL (Comment --)
--insert into alumnos (cod, ciudad) values (6, 'Burgos'); -- error NOT NULL (Comment --)

insert into alumnos values (7, 'Antonio', null, null, 9.6666666); 
insert into alumnos values (9, 'Jacinta', 'Manhattan', null, 0); 
select * from alumnos;
--# Impide valores repetidos (probar)
--insert into alumnos values (7, 'Luisa', null, null, 9.5); --Error PK 

--# Impide valores null
--insert into alumnos values (null, 'lucho', null, null, 9.5); --Error PK 

--# METEMOS TELEFONO 1
insert into alumnos values (7, 'Antonio', null, 947123123, 9.6666666); 

--# METEMOS TELEFONO 2
insert into alumnos values (8, 'Luisa', null, 947123124, 9.6666666); 

select * from alumnos;


/*###-------------------------------------------------------------------------###*/
--# CHECK 2 --> Probando un RANGO de valores para nota

drop table if exists alumnos;

create table alumnos (
cod smallint primary key,  
nombre varchar (20) not null unique,
ciudad char(20) default 'Soria' check (ciudad !='Londres'), -- check siempre después de default!
telefono numeric(9) unique,
nota     numeric(4,2) check(nota >=0 and nota <=10) -- >, <, >=, <=, =, !=
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

--insert into alumnos values (5, null, 'Burgos'); -- error NOT NULL (Comment --)

--insert into alumnos (cod, ciudad) values (6, 'Burgos'); -- error NOT NULL (Comment --)

insert into alumnos values (7, 'Antonio', null, null, 9.6666666); 

--# Impide valores repetidos (probar)
--insert into alumnos values (7, 'Luisa', null, null, 9.5); --Error PK 

--# Impide valores null
--insert into alumnos values (null, 'lucho', null, null, 9.5); --Error PK 

--# METEMOS TELEFONO 1
insert into alumnos values (7, 'Antonio', null, 947123123, 9.6666666); 

--# METEMOS TELEFONO 2
insert into alumnos values (8, 'Luisa', null, 947123124, 12); -- error CHECK

select * from alumnos;

/*###-------------------------------------------------------------------------###
# CAMBIO DE HOJA A LA DE Time

###-------------------------------------------------------------------------###
--# DATE time/Data 
--¡En hoja nueva!
*/

drop table if exists ejemplo_tiempos;

create table ejemplo_tiempos (
fecha date,
hora time, /* Se utiliza muy poco */
fecha_hora timestamp 
);

insert into ejemplo_tiempos values ('04-06-2018');

insert into ejemplo_tiempos values ('04-06-2018', '21:20:56', '04-06-2018 21:20:56.36');

select * from ejemplo_tiempos; 

select current_date; -- selecciona fecha del sistema

select current_date, current_timestamp; -- selecciona fecha y fecha/hora del sistema

/*###-------------------------------------------------------------------------###*/
--# CHECK CON DAT / TIME/ TIMESTAMP

drop table if exists ejemplo_tiempos;

create table ejemplo_tiempos (
fecha date,
hora time, /* Se utiliza muy poco */
fecha_hora timestamp check (fecha_hora >= current_timestamp)
);

--# 1: metemos hora con date y sin date para forzar el reconocimiento de hora
insert into ejemplo_tiempos values ('04-06-2018');
select * from ejemplo_tiempos;
	
--# 2: metemos también un tiempo
--insert into ejemplo_tiempos values ('04-06-2018','21:20:56');
insert into ejemplo_tiempos values ('04-06-2018', '21:20:56', '2023-10-05 18:36:47.687262+02');
select * from ejemplo_tiempos;

--# 3: metemos también un timestamp
--insert into ejemplo_tiempos values ('04-06-2018', '21:20:56', '2023-10-02 18:49');
insert into ejemplo_tiempos values ('04-06-2018', '21:20:56', current_timestamp);
select * from ejemplo_tiempos;
	

/*###-------------------------------------------------------------------------###*/
--# CURRENT current_timestamp como valor por defecto

drop table if exists registro;

create table registro (
idEmpleado integer,
hora_entrada timestamp default current_timestamp
);

insert into registro values (100); -- el valor de la hora lo coge del sistema
select * from registro;
	
--# Manera correcta para que no coja el valor por defecto!
insert into registro (idEmpleado, hora_entrada) values (2, null);
select * from registro;


/*###-------------------------------------------------------------------------###
# NOMBRANDO LAS RESTRICCIONES#
# EL NOMBRE SE ATRIBUÍA AUTOMÁTICAMENTE - so far!
*/

/*###-------------------------------------------------------------------------###*/
--# CONSTRAINT

drop table if exists alumnos;

create table alumnos (
cod smallint primary key,  
nombre varchar (20) not null unique,
ciudad char(20) default 'Soria' check (ciudad !='Londres'), -- check siempre después de default!
telefono numeric(9) unique,
nota     numeric(4,2) constraint chk_alumnos_nota check(nota >=0 and nota <=10) -- >, <, >=, <=, =, !=
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

--insert into alumnos values (5, null, 'Burgos'); -- error NOT NULL (Comment --)

--insert into alumnos (cod, ciudad) values (6, 'Burgos'); -- error NOT NULL (Comment --)

insert into alumnos values (7, 'Antonio', null, null, 5.01); 
insert into alumnos values (8, 'Pepe', null, null, 11.00); 
select * from alumnos;

--# Impide valores repetidos (probar)
--insert into alumnos values (7, 'Luisa', null, null, 9.5); --Error PK 

--# Impide valores null
--insert into alumnos values (null, 'lucho', null, null, 9.5); --Error PK 

--# METEMOS TELEFONO 1
insert into alumnos values (7, 'Antonio', null, 947123123, 9.6666666); 

--# METEMOS TELEFONO 2
--insert into alumnos values (8, 'Luisa', null, 947123124, 12); -- error CHECK MIRAR EL NOMBRE DEL ERROR

select * from alumnos;

/*###-------------------------------------------------------------------------###*/
--# CONSTRAINT 2 a la primary key/not null, etc


drop table if exists alumnos;

create table alumnos (
cod smallint constraint Error_En_la_Clave_primaria primary key,  
nombre varchar (20) constraint nn_alumos_nombre not null constraint unq_alumnos_nombre unique,
ciudad char(20) default 'Soria' check (ciudad !='Londres'), -- check ciempre después de default!
telefono numeric(9) constraint unq_alumnos_telefono unique,
nota     numeric(4,2) constraint chk_alumnos_nota check(nota >=0 and nota <=10) -- >, <, >=, <=, =, !=
);

insert into alumnos values (1, 'Pepe'),  (2, 'Ana'),  (3, 'Juan') ; 

insert into alumnos values (4, 'Maria', 'León');

select * from alumnos;

insert into alumnos values (5, null, 'Burgos'); -- error NOT NULL (Comment --)
insert into alumnos (cod, ciudad) values (6, 'Burgos'); -- error NOT NULL (Comment --)

insert into alumnos values (7, 'Antonio', null, null, 9.6666666);
insert into alumnos values (8, 'Antonio', null, null, 9.6666666);

--# Impide valores repetidos (probar)
insert into alumnos values (7, 'Luisa', null, null, 9.5); --Error PK 

--# Impide valores null
--insert into alumnos values (null, 'lucho', null, null, 9.5); --Error PK 

--# METEMOS TELEFONO 1
insert into alumnos values (7, 'Antonio', null, 947123123, 9.6666666); 

--# METEMOS TELEFONO 2
insert into alumnos values (8, 'Luisa', null, 947123124, 12); -- error CHECK MIRAR EL NOMBRE DEL ERROR y probar otros!

select * from alumnos;

/*
###-------------------------------------------------------------------------###
# RESTRICCIONES COMPUESTAS # VIDEO Pracica 1 parte 6
# AQUELLAS QUE AFECTAN A VARIOS CAMPOS SIMULTANEAMENTE, ES DECIR QUE NO EXISTAN DÚPLICAS EN COMBINACIONES DE ATRIBUTOS
# EJEMPLO TABLA DE Asignaturas EN LOS APUNTES TEMA2 (Copiar/Pegar en hoja nueva de la página 22)
*/

/*###-------------------------------------------------------------------------###*/
--# Ejemplo Pagina 22 apuntes, quitamos los primary key

drop table if exists Asignaturas;

CREATE TABLE Asignaturas(
	IdTitulacion SMALLINT,
	IdAsignatura INTEGER,
	Nombre CHAR(20) NOT NULL,
	nCreditos SMALLINT default 6 NOT NULL CHECK (nCreditos >0)
);

insert into Asignaturas values (1, 1, 'Algebra'), (1, 2, 'Programacion'), (2,1, 'Materiales');


select * from Asignaturas;


/*###-------------------------------------------------------------------------###*/
--# RESTRICCION 1
--# IMPEDIR REPETIDOS MULTIPLES

insert into Asignaturas values (1,2, 'Calculo'); -- funciona, pero hay que prohibirlo

select * from Asignaturas;


/*###-------------------------------------------------------------------------###*/
--# RESTRICCION 1 USANDO PRIMARY KEY -- no pueden haber 2!
--# IMPEDIR REPETIDOS MULTIPLES

drop table if exists Asignatura;

CREATE TABLE Asignaturas(
	IdTitulacion SMALLINT primary key,
	IdAsignatura INTEGER primary key,
	Nombre CHAR(20) NOT NULL,
	nCreditos SMALLINT default 6 NOT NULL CHECK (nCreditos >0)
);

insert into Asignaturas values (1, 1, 'Algebra'), (1, 2, 'Programacion'), (2,1, 'Materiales');

insert into Asignaturas values (1,2, 'Calculo'); -- da error (comment -- and evaluate)
select * from Asignatura;


/*###-------------------------------------------------------------------------###*/
--# RESTRICCION 1 USANDO PRIMARY KEY -- MANERA CORRECTA
--# RESTRICCIONES DE TABLA! NO EN LINEA SINO QUE INCORPORAN VARIAS LÍNEAS

drop table if exists Asignaturas;

CREATE TABLE Asignaturas(
	IdTitulacion SMALLINT,
	IdAsignatura INTEGER,
	Nombre CHAR(20) NOT NULL,
	nCreditos SMALLINT default 6 NOT NULL CHECK (nCreditos >0),
		primary key (IdTitulacion, IdAsignatura)
);

insert into Asignaturas values (1, 1, 'Algebra'), (1, 2, 'Programacion'), (2,1, 'Materiales');

select * from asignaturas;

insert into Asignaturas values (1,3, 'Calculo');
select * from asignaturas;

insert into Asignaturas values (2,1, 'MePro'); -- ahora si da error (comment -- and evaluate)

select * from Asignaturas;


/*###-------------------------------------------------------------------------###*/
--# RESTRICCION 1 USANDO PRIMARY KEY -- MANERA CORRECTA
--# RESTRICCIONES DE TABLA! NO EN LINEA SINO QUE INCORPORAN VARIAS LÍNEAS
--# NOMBRAMOS LA RESTRICCION DE TABLA

drop table if exists Asignaturas;

CREATE TABLE Asignaturas(
	IdTitulacion SMALLINT ,
	IdAsignatura INTEGER ,
	Nombre CHAR(20) NOT NULL,
	nCreditos SMALLINT default 6 NOT NULL CHECK (nCreditos >0),
	
	constraint Mala_LLave primary key (IdTitulacion, IdAsignatura)
);

insert into Asignaturas values (1, 1, 'Algebra'), (1, 2, 'Programacion'), (2,1, 'Materiales');

--insert into Asignaturas values (1,2, 'Calculo'); -- descomentar para evaluar el error

select * from Asignaturas;

/*###-------------------------------------------------------------------------###
###-------------------------------------------------------------------------###*/
-- # Ejemplo de los apuntes página 24 de los apuntes

drop table if exists problema;

CREATE TABLE problema (
	Ciudad CHAR (13),
	FechaMuestra DATE NOT NULL,
	Mediodía NUMERIC( 3, 1),
	Medianoche NUMERIC( 3, 1),
	Precipitación NUMERIC( 3, 1)
);

insert into problema values ('Burgos', current_date, 25, 15, 0);

select * from problema;


/*###-------------------------------------------------------------------------###*/
--# Ejemplo de los apuntes página 24 de los apuntes
--# CREAMOS UNA PRIMARY KEY! SIEMPRE DEBE HABER UNA QUE IDENTIFIQUE CADA OBSERVACIÓN

drop table if exists problema;

CREATE TABLE problema (
	cod integer primary key,
	Ciudad CHAR (13),
	FechaMuestra DATE NOT NULL,
	Mediodía NUMERIC( 3, 1),
	Medianoche NUMERIC( 3, 1),
	Precipitación NUMERIC( 3, 1)
);

insert into problema values (1, 'Burgos', current_date, 25, 15, 0);

select * from problema;


/*###-------------------------------------------------------------------------###*/
--# Ejemplo de los apuntes página 24 de los apuntes
--# CREAMOS UNA PRIMARY KEY! SIEMPRE DEBE HABER UNA QUE IDENTIFIQUE CADA OBSERVACIÓN
--# Luego intentamos meter un segundo registro con un duplicado de ciudad y fecha que es el que hay que evitar

drop table if exists problema;

CREATE TABLE problema (
	cod integer primary key,
	Ciudad CHAR (13),
	FechaMuestra DATE NOT NULL,
	Mediodía NUMERIC( 3, 1),
	Medianoche NUMERIC( 3, 1),
	Precipitación NUMERIC( 3, 1)
);

insert into problema values (1, 'Burgos', current_date, 25, 15, 0);
insert into problema values (2, 'Burgos', current_date, 25, 15, 0); -- works but shouldn't

select * from problema;

/*###-------------------------------------------------------------------------###*/
--# Ejemplo de los apuntes página 24 de los apuntes
--# UNIQUE COMPUESTO

drop table if exists problema;

CREATE TABLE problema (
	cod integer primary key,
	Ciudad CHAR (13) not null,
	FechaMuestra DATE not null,
	Mediodía NUMERIC( 3, 1),
	Medianoche NUMERIC( 3, 1),
	Precipitación NUMERIC( 3, 1),	
	constraint "las has liado" unique (Ciudad, FechaMuestra)
);

insert into problema values (1, 'Burgos', current_date, 25, 15, 0);
insert into problema values (2, 'Burgos', current_date, 25, 15, 0); -- now it fails
insert into problema values (2, 'Burgos', current_date+1, 25, 15, 0);
insert into problema values (3, 'Burgos', null, 25, 15, 0);
insert into problema values (4, 'Burgos', null, 25, 15, 0);
insert into problema values (5, 'Burgos', current_date, 25, 15, 0); --it fails
select * from problema;

/*###-------------------------------------------------------------------------###*/
--# Ejemplo de los apuntes página 24 de los apuntes
--# CREAMOS UNA PRIMARY KEY! SIEMPRE DEBE HABER UNA QUE IDENTIFIQUE CADA OBSERVACIÓN
--# Luego intentamos meter un segundo registro con un duplicado de ciudad y fecha que es el que hay que evitar
--# Probamos nuevos valores que sí funcionaran

drop table if exists problema;

CREATE TABLE problema (
	cod integer primary key,
	Ciudad CHAR (13),
	FechaMuestra DATE NOT NULL,
	Mediodía NUMERIC( 3, 1),
	Medianoche NUMERIC( 3, 1),
	Precipitación NUMERIC( 3, 1),
	
	constraint unq_FechaCiudad unique (Ciudad, FechaMuestra)
);

insert into problema values (1, 'Burgos', current_date-1, 25, 15, 0); --yesterday
insert into problema values (2, 'Burgos', current_date, 25, 15, 0); 
insert into problema values (3, 'Leon', current_date, 25, 15, 0);
insert into problema values (4, 'Leon', null, 25, 15, 0);

select * from problema;

/*###-------------------------------------------------------------------------###*/
--# Ejemplo de los apuntes página 24 de los apuntes
--# CREAMOS UNA PRIMARY KEY! SIEMPRE DEBE HABER UNA QUE IDENTIFIQUE CADA OBSERVACIÓN
--# Luego intentamos meter un segundo registro con un duplicado de ciudad y fecha que es el que hay que evitar
--# Probamos nuevos valores que sí funcionaran
--# Duplicamos el NULL ya que sí funciona!

drop table if exists problema;

CREATE TABLE problema (
	cod integer primary key,
	Ciudad CHAR (13),
	FechaMuestra DATE NOT NULL,
	Mediodía NUMERIC( 3, 1),
	Medianoche NUMERIC( 3, 1),
	Precipitación NUMERIC( 3, 1),
	
	constraint unq_FechaCiudad unique (Ciudad, FechaMuestra)
);

insert into problema values (1, 'Burgos', current_date-1, 25, 15, 0); --yesterday
insert into problema values (2, 'Burgos', current_date, 25, 15, 0); 
insert into problema values (3, 'Leon', current_date, 25, 15, 0); 

insert into problema values (4, null, current_date, 25, 15, 0); 
insert into problema values (5, null, current_date, 25, 15, 0); 

select * from problema;

/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* CHECK COMPUESTOS  */
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Controlaremos que la fecha de salida no pueda ser inferior a la de entrada (sin máquina del tiempo a lo menos.) */

drop table if exists registro;

create table registro (
	id integer primary key,
	fecha_entrada timestamp check (fecha_entrada < fecha_salida), -- it works
	fecha_salida timestamp 
);

select * from registro;


/*----------------------------------------------------------------------------------*/
/* Agregamos datos ya que el check solo se evalua cuando se cambia el predicado 'fecha_entrada', en este caso*/

insert into registro values (1, '21-4-2020 8:30', '21-4-2020 17:30'); -- it works
select * from registro;
--# Reemplazamos el valor para provocar el fallo (podemos copiar/pegar y comentar la otra
insert into registro values (2, '21-4-2020 8:30', '21-4-2020 8:30:00'); -- it fails
select * from registro;

/*----------------------------------------------------------------------------------*/
/* Forma correcta de usar una restricción compuesta es: */

drop table if exists registro;

create table registro (
	id integer primary key,
	fecha_entrada timestamp /*check (fecha_entrada < fecha_salida)*/, -- wrong approach
	fecha_salida timestamp,

	constraint chk_delta_entrada_salida check (fecha_entrada < fecha_salida)		
);

--insert into registro values (1, '21-4-2020 8:30', '21-4-2020 8:30'); --error
insert into registro values (1, '21-4-2020 8:30', '21-4-2020 12:30'); --It works
select * from registro;


/*