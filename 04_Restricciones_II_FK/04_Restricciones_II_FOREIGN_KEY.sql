/*----------------------------------------------------------------------------------*/
/* 2.3 Declaración de claves ajenas */
/*----------------------------------------------------------------------------------*/
/* VIDEOS PRACTICA #3 PARTE #2 */
/*----------------------------------------------------------------------------------*/
/* CLave Ajena Sencilla en Línea */

/*
Para mantener la F1N es necesario descomponer la tabla en más de una y es allí donde usamos las FK

Explicar al cargar las tablas cómo se mete la restricción de FK (References) y que no es necesario indicar con qué campo se hace la referencia porque ha de ser siempre la primary key (PK).

El orden de creación SÍ importa, se deben crear las tablas padres antes que las hijas! --probar

Nota: El material está en la web en Ejemplos_FK_SQL.sql
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
insert into estrellas values
('estrellaNull', 'nombreEstrellaNull', 'ape1EstrellaNull', 'ape2EstrellaNull', null);

select * from estrellas;
select * from estudios;

-- la FK restringe insertar un dominio/valor que no esté en el padre ("Estrella Huérfana")

insert into estrellas values
('estrella¿?', 'nombreEstrella¿?', 'ape1Estrella¿?', 'ape2Estrella¿?', '¿?');


-- Tampoco se puede actualizar una entrada con un padre que no existe (no puede ser huérfano)

update estrellas set numEstudio='¿?'
where nombre= 'nombreEstrella1WB' and ape1= 'ape1Estrella1WB' and ape2= 'ape2Estrella1WB';

-- Tampoco puedo cambiar el dominio del padre (y que pierda sus hijos)
-- sucede solo si hay hijos
update estudios set estudio = '¿?'
where estudio='WB';

-- Tampoco se puede borrar un padre (deja hijos huérfanos), sí se pueden borrar hijos

delete from estudios
where estudio='WB';

select * from estrellas;
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

-- Con restricción en línea
-- NO SE USA!
-- Pero define las acciones en este caso "NO ACTION" vienen por defecto y son los errores
drop table if exists estrellas;
CREATE TABLE estrellas (
nombre_artistico CHAR(30),
nombre CHAR(35),
ape1 CHAR(35),
ape2 CHAR(35),
numEstudio CHAR(2) 
	CONSTRAINT FK_estrella_estudio REFERENCES estudios 
		ON DELETE NO ACTION ON UPDATE NO ACTION,-------------------Ojo
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
FOREIGN KEY (numEstudio) REFERENCES estudios-------------------Ojo
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
	ON DELETE CASCADE -- borra a la fila padre, se borran los hijos
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

--Podíamos haber declarado primero ON UPDATE y luego ON DELETE
--Podíamos haber quitado ON UPDATE NO ACTION --default behaviour
--Podíamos haber declarado la restricción fuera de linea (o como restricción de tabla), con/sin NO ACTION

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
		ON UPDATE CASCADE, --definimos la cascada
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


--Podíamos haber declarado primero ON UPDATE y luego ON DELETE
--Podíamos haber quitado ON DELETE NO ACTION
--Podíamos haber declarado la restricción fuera de linea (o como restricción de tabla), con/sin NO ACTION
--Podríamos haber declarado ON DELETE CASCADE y ON UPDATE CASCADE simultáneamente
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* 2.3 Declaración de claves ajenas */
/*----------------------------------------------------------------------------------*/
/* VIDEOS PRACTICA #3 PARTE #2 */
/*----------------------------------------------------------------------------------*/
/* CLAVES AJENAS COMPUESTAS */

/*
Atributos han de estar declarados en el mismo orden que cómo estan declarados en la clave primaria.

Atributos deben ser del mismo tipo y longitud (características)

Atributos NO tienen porqué llamarse igual

Nota: El material está en la web en Ejemplos_FK_SQL.sql
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

/*
Respeta orden de los campos en la PK del padre!!!
		PRIMARY KEY ( nombre, ape1, ape2)

Respetamos también los tipos de datos (y sus carcaterístcas)

Podemos no respetar el nombre del atributo (mejor si coinciden, pero no necesario)
*/

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

/*
Para borrar tablas con dependencias, no se pueden borrar en cualquier orden, deberían borarrse los nietos, luego los hijos y finalmente los padres.

Una regla nemotécnica es borrarlas inversamente a cómo fueron creadas.
*/


-- Falla porque tiene FK con estrellas y no deja borrar porque dejaría hijos huérfanos.
-- si se borra el 1º) y el 2º), entonces en último lugar puedo borrar estudios.
drop table if exists estudios;

-- Falla porque tiene FK con películas. 
-- Si se borra películas, entonces el 2º paso podría ser borrar esta tabla
drop table if exists estrellas;

-- Esto funcionaría y tendría que ser la 1º) en ejecución
drop table if exists peliculas;


/* Creamos nuevamente las 3 tablas!! */

/* 
Se pueden borrar en cualquier orden siempre y cuando se use CASCADE

Borra todas las claves ajenas (FK)
 */

-- orden malo, pero funciona porque hay "CASCADE"
drop table if exists estudios cascade;
drop table if exists estrellas cascade;
drop table if exists peliculas cascade; -- no hace falta porque nadie depende de ellas

--select * from peliculas;	
	
/* Creamos nuevamente las 3 tablas!! */


-- Lo más común es borrar todos a la vez.
-- No necesitaría el cascade porque se borran todo a la vez.
-- Se debe usar por si estás dejando otras tablas fuera que sí tengan dependencia.
drop table if exists estudios, estrellas, peliculas cascade;