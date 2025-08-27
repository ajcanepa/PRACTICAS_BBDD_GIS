/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* GUIA CODIGOS TEMA 2 */
/*----------------------------------------------------------------------------------*/
-- PRÁCTICA 3: SELECT, WHERE, Filtrado y condiciones lógicas
-- Objetivo: Familiarizarse con los operadores SELECT y WHERE

/*###-------------------------------------------------------------------------###
# UTILIZACIÓN DE SELECT
###-------------------------------------------------------------------------###

###-------------------------------------------------------------------------###
# SELECCIONAMOS Y EJECUTAMOS SOLAMENTE:
*/
	
DROP TABLE IF EXISTS alumnos;

CREATE TABLE alumnos (
    nombre	char(10) primary key,
    altura	numeric(3,2),
    peso	numeric(3)
);

insert into alumnos values 	( 'Pepe', 1.70, 67),
				( 'Ana', 1.72, 67),
				( 'Juan', 1.70, 83),
				( 'Luis', 1.70, 83);


SELECT * FROM alumnos;

/*###-------------------------------------------------------------------------###
# SELECCIONAMOS LOS CAMPOS SELECCIONADOS POR COLUMNA*/

SELECT * FROM alumnos;	

/*###-------------------------------------------------------------------------###
# QUE SE HACE CON LOS REPETIDOS -- UN SOLO CAMPO*/

/*###-------------------------------------------------------------------------###
# QUE SE HACE CON LOS REPETIDOS -- VARIOS CAMPOS*/

/*
###-------------------------------------------------------------------------###
# USO DE EXPRESIONES 
*/

--# Calculo con aritmeticas
SELECT nombre, peso/(altura*altura), altura/0.3048, peso/0.4536
FROM alumnos;

--# Redondeo
SELECT nombre, round(peso/(altura*altura),2), round(altura/0.3048,2), round(peso/0.4536,2)
FROM alumnos;

SELECT nombre, round(peso/(altura*altura),2) as IMC, round(altura/0.3048,2) as Altura, round(peso/0.4536,2) as Peso
FROM alumnos;

/*
###-------------------------------------------------------------------------###
# USO DE EXPRESIONES -- "CONCATENACIÓN"*/

--# Usando el || Concatenación
SELECT 'Hola', nombre FROM alumnos; -- muestra la constante caracter 'Hola'

SELECT 'Hola' , 7 , nombre FROM alumnos; -- agrega otra constante

--# Concatenamos atributos
select * from alumnos;
SELECT 'Hola ' || nombre, * FROM alumnos; 


/*	
###-------------------------------------------------------------------------###
# TRABAJAMOS CON OPERACIONES DE TIEMPO
*/
	
select * from alumnos;

select *, current_date from alumnos;

select *, current_date, current_date+7, current_date-7 from alumnos;

/*
###-------------------------------------------------------------------------###
# Filtra las filas (Tuplas)
*/

select * from alumnos;
	
SELECT DISTINCT Altura, Peso 
FROM Alumnos
WHERE peso=67; -- >, <, >=, <=, !=, =

/*
###-------------------------------------------------------------------------###
# Expresiones*/

SELECT nombre, (altura-1)*100 as altura_cm, peso
FROM alumnos
-- WHERE altura_cm > peso; 
WHERE (altura-1)*100 > peso; 


/*
###-------------------------------------------------------------------------###
# CONECTORES LÓGICOS
# NOT, AND, OR
*/

SELECT * FROM Alumnos; 

SELECT nombre
FROM Alumnos
WHERE peso=67
AND altura=1.70;

/*###-------------------------------------------------------------------------###*/
--# ORDEN DE LOS CONECTORES LÓGICOS 

SELECT  * --nombre
FROM Alumnos
WHERE peso=67 AND altura=1.70
OR peso > 80;

SELECT *  -- nombre
FROM Alumnos
WHERE peso=67
AND (altura=1.70 OR peso > 80);

/*###-------------------------------------------------------------------------###*/
--# SEGUNDO EJEMPLO

-- el nombre de alumnos donde el peso = 67 y altura = 1.70 ó que el peso > 80 y nombre no sea Juan
SELECT * --nombre
FROM Alumnos
WHERE (peso=67 AND altura=1.70)
OR peso > 80 
	AND NOT nombre = 'Juan';

/*###-------------------------------------------------------------------------###*/
--# COMPARADOR COMPLEMENTARIO

--# NOT
SELECT *
FROM Alumnos
WHERE (peso=67 AND altura=1.70)
OR peso>80
AND nombre != 'Juan';

/*
###-------------------------------------------------------------------------###*/
--# ORDER BY

SELECT Nombre, altura, peso
FROM Alumnos
ORDER BY altura;
--ORDER BY altura desc;


/*----------------------------------------------------------------------------------*/
/* Eliminación de filas con DELETE */
/*----------------------------------------------------------------------------------*/
/*
DELETE se usa para borar filas que (podrían) cumplir una condición.
*/
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Creamos DDBB para trabajar */

--DROP VIEW IF EXISTS altos_v;
DROP TABLE IF EXISTS alumnos cascade;

CREATE TABLE alumnos (
    nombre	char(10) primary key,
    altura	numeric(3,2),
    peso	numeric(3)
);

insert into alumnos values 	( 'Pepe', 1.70, 67),
				( 'Ana', 1.72, 67),
				( 'Juan', 1.70, 83),
				( 'Luis', 1.70, 83);


SELECT * FROM alumnos;
/*----------------------------------------------------------------------------------*/
/* COMANDO DELETE */

-- Syntaxis condicional
-- Borrar aquellos que pesan más de 70
DELETE FROM alumnos 
WHERE peso > 70;

SELECT * FROM alumnos;

-- Borrado total (hay que cargar las filas nuevamente)
DELETE FROM alumnos;

SELECT * FROM alumnos;


--borramos al (los) que tenga(n) el mayor IMC
SELECT * FROM alumnos
order by peso/(altura*altura) desc; -- Buscar el primero

-- Ordenando por nombre de atributo (when given)

-- Ordenando por operación de atributo (name not given)

-- Ordenando por posición de atributo

/*----------------------------------------------------------------------------------*/
/* Modificaciones de valores con UPDATE */
/*----------------------------------------------------------------------------------*/
/*
UPDATE modifica por filas los valores de cada columna identificada con SET
Tiene una opción where (opcional) paraver en qué filas se modifica el valor
*/

/*----------------------------------------------------------------------------------*/
/* COMANDO UPDATE */

SELECT * FROM alumnos;

-- Reemplazamos valor con el where (condicional)
UPDATE alumnos
SET altura=1.90, peso=90
WHERE nombre='Pepe';

SELECT * FROM alumnos;

-- Reemplazamos un valor con un cálculo basado en el registro actual
UPDATE alumnos
SET altura=1.90, peso=peso * 1.20
WHERE nombre='Pepe';

SELECT * FROM alumnos;

-- Reemplazamos el valor de todas las filas (Asuencia de where)
UPDATE alumnos


-- Transformar los valores a UPPERCASE con la función upper

/*----------------------------------------------------------------------------------*/
/* INSERT con sub-SELECT */
/*----------------------------------------------------------------------------------*/
/*
Si a INSERT se adjunta una SELECT, y así las filas que devuelve dicha SELECT serán las que se inserten.
Sirve además para copiar de una tabla a otra.
*/
/*----------------------------------------------------------------------------------*/
/* Creamos DDBB para trabajar */
-- necesitamos rescatar la relación alumnos

DROP TABLE IF EXISTS alumnos;

CREATE TABLE alumnos (
    nombre	char(10) primary key,
    altura	numeric(3,2),
    peso	numeric(3)
);

insert into alumnos values 	( 'Pepe', 1.70, 67),
				( 'Ana', 1.72, 67),
				( 'Juan', 1.70, 83),
				( 'Luis', 1.70, 83);

select * from alumnos;

/*----------------------------------------------------------------------------------*/
/* COPIAR DATOS DE TABLA I  */
/* Usando un INSERT y luego SELECT  */

-- Creamos una relación donde almacenaremos los individuos altos de otra relacion
DROP TABLE IF EXISTS altos;

CREATE TABLE altos (
    nombre	char(10) primary key,
    pies	numeric(3,2)
);


select * from altos;
select * from alumnos;

-- Insert a partir de una consulta
INSERT INTO altos (nombre, pies)
SELECT nombre, altura/0.3048 -- comienza la subconsulta
FROM alumnos
WHERE altura > 1.70; -- filtro para que se cumpla esta condicion de tuplas

SELECT * FROM altos;


INSERT INTO altos -- (nombre, pies) 
SELECT nombre, peso/0.3048 
FROM alumnos
WHERE altura > 1.70; 
SELECT * FROM altos;

-- Cuántas filas se insertan así?
INSERT INTO altos (nombre, pies) 
SELECT nombre, altura/0.3048 -- comienza la subconsulta
--select *
FROM alumnos
WHERE altura <= 1.80
AND peso <= 80; -- filtro para que se cumpla esta condicion de tuplas (puede ser cero)

SELECT * FROM altos;

/*----------------------------------------------------------------------------------*/
/* COPIAR DATOS DE TABLA II  */
/* Usando CREATE TABLE <nombre_tabla> AS  */
/*
El comando CREATE TABLE posee una sintaxis alternativa donde usa AS para especificar los campos que se tomarán desde otra relación
*/

DROP TABLE IF EXISTS altos;

CREATE TABLE altos (nombre, pies) AS
SELECT nombre, altura/0.3048
FROM alumnos
WHERE altura > 1.70;

SELECT * FROM altos; -- Nº de decimales (máximo por defecto)

-- Usando el AS sin especificar los campos
-- usa el nombre de columna por defecto cuando hay expresiones

DROP TABLE IF EXISTS altos;

CREATE TABLE altos AS
--SELECT nombre, altura
SELECT nombre, altura/0.3048 --altura es una expresion y perderá el nombre del campo
FROM alumnos
WHERE altura > 1.70;

SELECT * FROM altos;

DROP TABLE IF EXISTS altos;

CREATE TABLE altos AS
SELECT nombre as new_name, altura/0.3048 as pies --otorgar nombre a la expresión matemática
FROM alumnos
WHERE altura > 1.70;
SELECT * FROM altos;

/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* 2.3 CREATE VIEW y DROP VIEW */
/*----------------------------------------------------------------------------------*/
/*
Una vista es una tabla virtual, no tiene filas propias y las calcula a pedido.
*/


/*----------------------------------------------------------------------------------*/
/* Creamos DDBB para trabajar */

-- necesitamos rescatar la relación alumnos
DROP TABLE IF EXISTS alumnos;

CREATE TABLE alumnos (
    nombre	char(10) primary key,
    altura	numeric(3,2),
    peso	numeric(3)
);

insert into alumnos values 	( 'Pepe', 1.70, 67),
				( 'Ana', 1.72, 67),
				( 'Juan', 1.70, 83),
				( 'Luis', 1.70, 83);

select * from alumnos;

/*----------------------------------------------------------------------------------*/
/* CREAR UNA VISTA --> CREATE VIEW */

-- A partir de alumnos creamos esta view
CREATE VIEW altos_v (nombre, pies) AS
SELECT nombre, altura/0.3048
FROM alumnos
WHERE altura > 1.70;

SELECT * FROM altos_v;


/*
DELETE FROM alumnos
WHERE nombre='Ana';
*/
select * from alumnos;


SELECT * FROM altos_v;

-- agregamos a ANA nuevamente
insert into alumnos values ( 'Ana', 1.72, 67);

-- sí aparece Ana nuevamente 
SELECT * FROM altos_v;

-- Qué pasa si actualizamos el valor de Ana reduciendo su tamaño a la mitad
update alumnos
set altura = altura/2
where nombre='Ana';

select * from alumnos;

select * from altos_v;

/*----------------------------------------------------------------------------------*/
/* BORRAR UNA VISTA --> DROP VIEW */

-- borra la vista pero no la ejecutemos aún
DROP VIEW altos_v ;

-- qué pasa si quiero borrar una tabla de dónde depende una vista?
DROP TABLE alumnos; 

-- Primero borramos la vista y luego...
DROP VIEW altos_v;

-- sí podemos borrar la tabla
DROP TABLE alumnos;
DROP TABLE alumnos cascade;

-- TAREA CASA:
/*----------------------------------------------------------------------------------*/
/*
La idea es ver qué pasa al revés, si al modificar una view, estaremos afectando a una tabla
/*----------------------------------------------------------------------------------*/
