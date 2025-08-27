/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* GUIA CODIGOS TEMA 2 */
/*----------------------------------------------------------------------------------*/
-- PRÁCTICA 4: FOREIGN KEY
-- Objetivo: Entender el uso y las restricciones del comando FOREIGN KEY

/*----------------------------------------------------------------------------------*/
/* Declaración de claves ajenas FOREIGN KEY */
/*----------------------------------------------------------------------------------*/
/* CLave Ajena Sencilla en Línea */
/*
Para mantener la F1N es necesario descomponer la tabla en más de una y es allí donde usamos las FK
*/

/*----------------------------------------------------------------------------------*/
/* Creamos DDBB para trabajar */
drop table if exists estudios, estrellas cascade;

-- creamos la tabla padre "estudios" con info de estudios de cine
create table estudios (
	estudio	char(2) primary key,
	nombre  varchar(30) unique not null,
	web		varchar(100)
);


insert into estudios values
('WB', 'Warner Bros. Studios', 'https://www.warnerbros.es/'),
('CP', 'Columbia Pictures',    'https://www.sonypictures.com/'),
('20', '20th Century-Fox',     'https://www.20thcenturystudios.com/');


-- Tabla hija (de estudios) 
CREATE TABLE estrellas (
 nombre_artistico	CHAR(30),
 nombre			CHAR(35),
 ape1			CHAR(35),
 ape2			CHAR(35),
 numEstudio		CHAR(2) CONSTRAINT FK_estrella_estudio REFERENCES estudios, -- es la FK

CONSTRAINT PK_estrellas PRIMARY KEY (nombre, ape1, ape2) -- restricción de tabla
);

-- el dominio de numEstudio debe ser igual al de la PK (ver último campo)
insert into estrellas values
('estrella1WB', 'nombreEstrella1WB', 'ape1Estrella1WB', 'ape2Estrella1WB', 'WB'),
('estrella2WB', 'nombreEstrella2WB', 'ape1Estrella2WB', 'ape2Estrella2WB', 'WB'),

('estrella1CP', 'nombreEstrella1CP', 'ape1Estrella1CP', 'ape2Estrella1CP', 'CP'),
('estrella2CP', 'nombreEstrella2CP', 'ape1Estrella2CP', 'ape2Estrella2CP', 'CP'),

('estrella120', 'nombreEstrella120', 'ape1Estrella120', 'ape2Estrella120', '20'),
('estrella220', 'nombreEstrella220', 'ape1Estrella220', 'ape2Estrella220', '20');

select * from estudios;
select * from estrellas;
/*----------------------------------------------------------------------------------*/
/* Agregando campos null y no existentes */

-- se pueden insertar un null en la FK, a veces combiene un not null para evitarlo

-- la FK restringe insertar un dominio/valor que no esté en el padre ("Estrella Huérfana")

-- Tampoco se puede actualizar una entrada con un padre que no existe (no puede ser huérfano)

-- Tampoco puedo cambiar el dominio del padre (y que pierda sus hijos)

-- Tampoco se puede borrar un padre (deja hijos huérfanos), sí se pueden borrar hijos

/*----------------------------------------------------------------------------------*/
/* Clave Ajena Compuesta -> RESTRICCIÓN DE TABLA  */
/*
Para utilizar la restricción de tabla (y no en línea) sí que deberemos inlcuir el atributo.
la sintaxis usa: FOREIGN KEY (<nombre de atributo>)

*/

-- agregando la restricción de tabla indicando campos
drop table if exists estrellas;

CREATE TABLE estrellas (
 nombre_artistico	CHAR(30),
 nombre			CHAR(35),
 ape1			CHAR(35),
 ape2			CHAR(35),
 numEstudio		CHAR(2),

CONSTRAINT PK_estrellas PRIMARY KEY ( nombre, ape1, ape2),
CONSTRAINT FK_estrella_estudio FOREIGN KEY (numEstudio) REFERENCES estudios --indica campo 

);

/*----------------------------------------------------------------------------------*/
/* DEFINIR ACCIONES CON "ON DELETE" ó "ON UPDATE"  */

drop table if exists estrellas;
CREATE TABLE estrellas (
nombre_artistico CHAR(30),
nombre CHAR(35),
ape1 CHAR(35),
ape2 CHAR(35),
numEstudio CHAR(2) 
	CONSTRAINT FK_estrella_estudio REFERENCES estudios 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT PK_estrellas PRIMARY KEY (nombre, ape1, ape2)
);


-- Con restricción de tabla
--Podíamos haber declarado primero ON UPDATE y luego ON DELETE
drop table if exists estrellas;
CREATE TABLE estrellas (
nombre_artistico CHAR(30),
nombre CHAR(35),
ape1 CHAR(35),
ape2 CHAR(35),
numEstudio CHAR(2),
CONSTRAINT PK_estrellas PRIMARY KEY ( nombre, ape1, ape2),
FOREIGN KEY (numEstudio) REFERENCES estudios 
	ON DELETE NO ACTION ON UPDATE NO ACTION
);


/*----------------------------------------------------------------------------------*/
/* DEFINIR ACCIONES EN CASCADAS "ON DELETE" ó "ON UPDATE"  */

/*----------------------------------------------------------------------------------*/
/* BORRADO EN CASCADA */

-- permite evitar hijos huérfanos porque al borar el padre borro todos los hijos 
drop table if exists estrellas;
CREATE TABLE estrellas (
nombre_artistico CHAR(30),
nombre CHAR(35),
ape1 CHAR(35),
ape2 CHAR(35),
numEstudio CHAR(2)
CONSTRAINT FK_estrella_estudio REFERENCES estudios
	ON DELETE CASCADE 
	ON UPDATE NO ACTION,
CONSTRAINT PK_estrellas
PRIMARY KEY ( nombre, ape1, ape2)
);

-- agregamos valores y revisamos 
insert into estrellas values
('estrella1WB', 'nombreEstrella1WB', 'ape1Estrella1WB', 'ape2Estrella1WB', 'WB'),
('estrella2WB', 'nombreEstrella2WB', 'ape1Estrella2WB', 'ape2Estrella2WB', 'WB'),

('estrella1CP', 'nombreEstrella1CP', 'ape1Estrella1CP', 'ape2Estrella1CP', 'CP'),
('estrella2CP', 'nombreEstrella2CP', 'ape1Estrella2CP', 'ape2Estrella2CP', 'CP'),

('estrella120', 'nombreEstrella120', 'ape1Estrella120', 'ape2Estrella120', '20'),
('estrella220', 'nombreEstrella220', 'ape1Estrella220', 'ape2Estrella220', '20');

select * from estrellas;
	
insert into estrellas values
('estrellaNull', 'nombreEstrellaNull', 'ape1EstrellaNull', 'ape2EstrellaNull', null);

select * from estrellas;


-- Borramos al padre (estudio warner bross) y evaluamos que se hayan borrado los hijos
-- Debería dar error porque hay hjos en WB

select * from estudios;

delete from estudios
where estudio='WB'; 

select * from estudios;
select * from estrellas;

-- Podemos recuperar la línea borrada
insert into estudios values
('WB', 'Warner Bros. Studios', 'https://www.warnerbros.es/');

select * from estudios;
select * from estrellas; -- no se restaura la FK
/*----------------------------------------------------------------------------------*/
/* Actualización en cascada (ON UPDATE CASCADE */


--creamos la tabla nuevamente
drop table if exists estrellas;

CREATE TABLE estrellas (
	nombre_artistico CHAR(30),
	nombre CHAR(35),
	ape1 CHAR(35),
	ape2 CHAR(35),
	numEstudio CHAR(2)
	CONSTRAINT FK_estrella_estudio REFERENCES estudios
		ON DELETE NO ACTION
		ON UPDATE CASCADE, 
	CONSTRAINT PK_estrellas
	PRIMARY KEY (nombre, ape1, ape2)
);

-- insertamos valores y miramos
insert into estrellas values
('estrella1WB', 'nombreEstrella1WB', 'ape1Estrella1WB', 'ape2Estrella1WB', 'WB'),
('estrella2WB', 'nombreEstrella2WB', 'ape1Estrella2WB', 'ape2Estrella2WB', 'WB'),

('estrella1CP', 'nombreEstrella1CP', 'ape1Estrella1CP', 'ape2Estrella1CP', 'CP'),
('estrella2CP', 'nombreEstrella2CP', 'ape1Estrella2CP', 'ape2Estrella2CP', 'CP'),

('estrella120', 'nombreEstrella120', 'ape1Estrella120', 'ape2Estrella120', '20'),
('estrella220', 'nombreEstrella220', 'ape1Estrella220', 'ape2Estrella220', '20');

insert into estrellas values
('estrellaNull', 'nombreEstrellaNull', 'ape1EstrellaNull', 'ape2EstrellaNull', null);

select * from estrellas;


-- realizamos el update y miramos
select * from estudios;

update estudios 
set estudio='FX'
where estudio='20';

select * from estudios;

-- como hay una cascada ahora en estrellas también se cambian en la tabla hija.
select * from estrellas;

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Declaración de claves ajenas FOREIGN KEY */
/*----------------------------------------------------------------------------------*/
/* CLAVES AJENAS COMPUESTAS */
/*----------------------------------------------------------------------------------*/
/*
Atributos han de estar declarados en el mismo orden que cómo estan declarados en la clave primaria.
Atributos deben ser del mismo tipo y longitud (características)
Atributos NO tienen porqué llamarse igual
*/

/*----------------------------------------------------------------------------------*/
/* Creamos DDBB para trabajar */
/* FKs compuestas */

-- Creamos una tabla peliculas que sea hija de las estrellas
-- tendrán un único protagoista por cada película

drop table if exists peliculas;
CREATE TABLE Peliculas (
	titulo CHAR(40) PRIMARY KEY,
	nombre_prota CHAR(35),
	ape1_prota CHAR(35),
	ape2_prota CHAR(35),
	
	FOREIGN KEY (nombre_prota, ape1_prota, ape2_prota) REFERENCES estrellas
);

-- agregamos esta película con una estrella que ya existe
insert into peliculas values ('Que gran pelicula!', 'nombreEstrella1WB', 'ape1Estrella1WB', 'ape2Estrella1WB');

-- agrega la fila sin problemas.
select * from peliculas;


/*----------------------------------------------------------------------------------*/
/* Cambiamos los atributos -- CUIDADO CON EL ORDEN!! */

-- modificamos la FK para que los atributos estén en otro orden a ver qué pasa (lío!)
drop table if exists peliculas;
CREATE TABLE Peliculas (
	titulo CHAR(40) PRIMARY KEY,
	nombre_prota CHAR(35),
	ape1_prota CHAR(35),
	ape2_prota CHAR(35),

	FOREIGN KEY (ape1_prota, nombre_prota,  ape2_prota) REFERENCES estrellas
);


-- agregamos esta película con una estrella que ya existe (pero con un orden que no corresponde)
insert into peliculas values ('Que gran pelicula!', 'nombreEstrella1WB', 'ape1Estrella1WB', 'ape2Estrella1WB');

-- error de violación de FK.
-- No se sabe los atributos y simplemente los compara por posición
-- y la FK necesita que coincidan los 3 atributos
select * from peliculas;

/*----------------------------------------------------------------------------------*/
/* VOLVEMOS A LA NORMALIDAD */

drop table if exists peliculas;
CREATE TABLE Peliculas (
	titulo CHAR(40) PRIMARY KEY,
	nombre_prota CHAR(35),
	ape1_prota CHAR(35),
	ape2_prota CHAR(35),

	FOREIGN KEY (nombre_prota, ape1_prota, ape2_prota) REFERENCES estrellas

);
insert into peliculas values ('Que gran pelicula!', 'nombreEstrella1WB', 'ape1Estrella1WB', 'ape2Estrella1WB');

select * from peliculas;
/*----------------------------------------------------------------------------------*/
/* BORRADO DE TABLAS */

drop table if exists estudios;

drop table if exists estrellas;

drop table if exists peliculas;

/*----------------------------------------------------------------------------------*/
/* Creamos nuevamente las 3 tablas!! */
/* 
Se pueden borrar en cualquier orden siempre y cuando se use CASCADE
Borra todas las claves ajenas (FK)
 */

-- orden malo, pero funciona porque hay "CASCADE"
drop table if exists estudios cascade;
drop table if exists estrellas cascade;
drop table if exists peliculas cascade; 

--select * from peliculas;	
	
/* Creamos nuevamente las 3 tablas!! */
drop table if exists estudios, estrellas, peliculas cascade;
