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

select * from alumnos;	
SELECT Nombre, Altura FROM Alumnos;

SELECT Altura FROM Alumnos;

/*###-------------------------------------------------------------------------###
# QUE SE HACE CON LOS REPETIDOS -- UN SOLO CAMPO*/

SELECT ALL Altura from Alumnos; -- ALL viene por defecto

SELECT DISTINCT Altura from Alumnos; -- distinct muestra las diferentes

/*###-------------------------------------------------------------------------###
# QUE SE HACE CON LOS REPETIDOS -- VARIOS CAMPOS*/

SELECT Altura, Peso FROM Alumnos; -- original

SELECT ALL Altura, Peso FROM Alumnos; --all no influye

SELECT DISTINCT Altura, Peso FROM Alumnos; -- mostrará combinaciones únicas!

SELECT ALL nombre, altura FROM alumnos;
SELECT ALL altura, nombre FROM alumnos;

SELECT DISTINCT nombre, altura FROM alumnos; -- no hay cambios porque nombre es "primary key" / ó "unique"
--# es más lento --> usar distinct solo cuando haga falta

/*
###-------------------------------------------------------------------------###
# USO DE EXPRESIONES -- Funciones matemáticas (ver en la web)*/

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

--# string functions in sql (googlear!)

SELECT 'Hola' || 'chic@s' , 7, nombre FROM alumnos; -- todo junto

SELECT 'Hola' || '  ' ||'chic@s' as saludo, 7 as depto, nombre FROM alumnos; -- separado según espacios dentro de ''

--# Concatenamos atributos
select * from alumnos;
SELECT 'Hola ' || nombre, * FROM alumnos; 
SELECT 'Hola ' || altura, * FROM alumnos; 

--# Repetimos esto, pero por favor no lo hagan! cambia la clase de la columna!
SELECT nombre, round(peso/(altura*altura),2) as peso, round(altura/0.3048,2)||' pies' as altura_pies, 
round(peso/0.4536,2)||' libras' as peso
FROM alumnos;

--# Agregando el título a la columna como un caracter separado por espacio pero nada más

SELECT nombre, round(peso/(altura*altura),2) as IMC, round(altura/0.3048,2)||' pies' as Altura, 
round(peso/0.4536,2)||' libras' as Peso 
FROM alumnos;

/*	
###-------------------------------------------------------------------------###
###-------------------------------------------------------------------------###
# HOJA NUEVA! #
###-------------------------------------------------------------------------###
# TRABAJAMOS CON OPERACIONES DE TIEMPO
*/
	
select * from alumnos;

select *, current_date from alumnos;

select *, current_date, current_date+7, current_date-7 from alumnos;

select *, current_date as hoy, current_date+7 as proxima_semana, current_date-7 as semana_pasada  from alumnos;

--# Rango de días... resta entre fechas

select *, current_date as hoy, current_date+7 as próxima_semana, current_date-7 as semana_pasada, current_date - '5-10-2020' as dias  from alumnos;
/*
###-------------------------------------------------------------------------###
# CERRAMOS LA HOJA NUEVA! #
###-------------------------------------------------------------------------###
*/

/*
###-------------------------------------------------------------------------###
###-------------------------------------------------------------------------###
### VIDEOS PRACTICA #2 PARTE #2 ###
###-------------------------------------------------------------------------###

# Continuamos con el código anterior PR2-02.sql
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
-- where altura_cm > peso; -- uso de expresiones
WHERE (altura-1)*100 > peso; -- uso de expresiones

-- mas correcto?
/*
SELECT nombre, (altura-1)*100 as alt_cm, peso
FROM alumnos
where (altura-1)*100 as alt_cm > peso;
	
*/
/*
###-------------------------------------------------------------------------###
# CONECTORES LÓGICOS
# NOT, AND, OR
*/
SELECT * FROM Alumnos; --SEE ALL

SELECT nombre
FROM Alumnos
WHERE peso=67
AND altura=1.70;

/*###-------------------------------------------------------------------------###*/
--# ORDEN DE LOS CONECTORES LÓGICOS 
--# PRIMERO EJECUTA EL AND

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
--# PARENTESIS PRIMERO LUEGO EL NOT

-- el nombre de alumnos donde el peso = 67 y altura = 1.70 ó que el peso > 80 y nombre no sea Juan
SELECT * --nombre
FROM Alumnos
WHERE (peso=67 AND altura=1.70)
OR peso > 80 
	AND NOT nombre = 'Juan';

--# REDUNDANDO EN LA IMPORTANCIA DE NOT
SELECT nombre
FROM Alumnos
WHERE (peso=67 AND altura=1.70)
OR peso > 80
AND (NOT nombre = 'Juan');

/*###-------------------------------------------------------------------------###*/
--# COMPARADOR COMPLEMENTARIO

--# NOT
SELECT *
FROM Alumnos
WHERE (peso=67 AND altura=1.70)
OR peso>80
AND nombre != 'Juan';

SELECT Nombre
FROM Alumnos
WHERE nombre >= 'Juan';

SELECT Nombre
FROM Alumnos
WHERE nombre > 'Juan'; -- orden alfabético


/*
###-------------------------------------------------------------------------###*/
--# ORDER BY

SELECT Nombre, altura, peso
FROM Alumnos
--ORDER BY altura;
ORDER BY altura desc;

SELECT Nombre, altura, peso
FROM Alumnos
ORDER BY altura, peso;

SELECT Nombre, altura, peso
FROM Alumnos
WHERE Nombre != 'Juan'
ORDER BY altura, peso;

SELECT Nombre, altura, peso
FROM Alumnos
WHERE Nombre != 'Juan'
ORDER BY altura DESC, peso;

SELECT Nombre, altura, peso
FROM Alumnos
WHERE Nombre !='Juan'
ORDER BY altura DESC, peso DESC;

SELECT Nombre, altura, peso
FROM Alumnos
WHERE Nombre !='Juan'
ORDER BY altura, peso DESC;

SELECT Nombre, altura, peso
FROM Alumnos
WHERE Nombre !='Juan'
ORDER BY altura ASC, peso DESC;

SELECT Nombre, altura, peso
FROM Alumnos
WHERE Nombre !='Juan'
ORDER BY peso/(altura*altura) DESC;

/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* VIDEOS PRACTICA #2 PARTE #3 */
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* 2.2.8 Eliminación de filas con DELETE */
/*----------------------------------------------------------------------------------*/

/*
Delete se usa para borar filas que (podrían) cumplir una condición.

Nota: Casi todas las consultas de esta sección están en PR2-05.sql
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
SELECT *, round(peso/(altura*altura),3) as imc FROM alumnos
order by imc desc;

-- Ordenando por operación de atributo (name not given)
SELECT *, round(peso/(altura*altura),3) FROM alumnos
order by round(peso/(altura*altura),3) desc;

-- Ordenando por posición de atributo
select * from alumnos;

SELECT *, round(peso/(altura*altura),3) FROM alumnos
order by 4 desc;

DELETE FROM alumnos
WHERE round(peso/(altura*altura),3) > 28.7;

SELECT * FROM alumnos;

/*----------------------------------------------------------------------------------*/
/* 2.2.9 Modificaciones de valores con UPDATE */
/*----------------------------------------------------------------------------------*/

/*
Modifica por filas los valores de cada columna identificada con SET
Tiene una opción where (opcional) paraver en qué filas se modifica el valor

Nota: Casi todas las consultas de esta sección están en PR2-05.sql
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
SET peso=peso * 1.20;

SELECT * FROM alumnos;

-- Transformar los valores a UPPERCASE con la función upper
UPDATE alumnos
SET nombre=upper(nombre);

SELECT * FROM alumnos;

UPDATE alumnos
SET nombre=lower(nombre);
SELECT * FROM alumnos;

SELECT * FROM alumnos;

/* HASTA AQUI MARTES 15 y JUEVES 17 DE OCTUBRE */
/*----------------------------------------------------------------------------------*/
/* 2.2.10 INSERT con sub-SELECT */
/*----------------------------------------------------------------------------------*/
/* VIDEOS PRACTICA #2 PARTE #4 */
/*----------------------------------------------------------------------------------*/


/*
Si a INSERT se adjunta una SELECT, y así las filas que devuelve dicha SELECT serán las que se inserten.

Sirve además para copiar de una tabla a otra.

Nota: Casi todas las consultas de esta sección están en PR2-05.sql
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

-- Como estamos rellenando todas las columnas, podríamos NO mencionarlas
-- ejemplo igual que anterior pero dejando columnas en blanco = todas
-- solo se usa si el Select (subconsulta) da valores a todos los campos
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
/* Usando CREATE TABLE ... AS  */

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

/*
select * from alumnos;
select *, peso/0.5 as nuevopeso from alumnos;
*/

/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* 2.3 CREATE VIEW y DROP VIEW */
/*----------------------------------------------------------------------------------*/
/* VIDEOS PRACTICA #2 PARTE #5 */
/*----------------------------------------------------------------------------------*/


/*
Una vista es una tabla virtual, no tiene filas propias y las calcula a pedido.
Se crean con una sintaxis similar al anterior "SELECT AS" --> "CREATE VIEW AS"
No es una copia de los datos (no hay tuplas) es una instrucción y puede servir para guardar una consulta.

Nota: Casi todas las consultas de esta sección están en PR2-05.sql
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

-- si se modifican los datos en la tabla original (alumnos) sí se ven modificados en la vista

/*
DELETE FROM alumnos
WHERE nombre='Ana';
*/
select * from alumnos;

-- Ya no hay valores porque se volvió a ejecutar y ahora ANA no estaba
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

-- Ya no aparece porque el "CREATE VIEW" tiene un Where asociado y Ana ya NO cumple ese where
select * from altos_v;
/*----------------------------------------------------------------------------------*/
/* BORRAR UNA VISTA --> DROP VIEW */

-- borra la vista pero no la ejecutemos aún
DROP VIEW altos_v ;

-- qué pasa si quiero borrar una tabla de dónde depende una vista?
DROP TABLE alumnos; -- error de dependencia

-- Primero borramos la vista y luego...
DROP VIEW altos_v;

-- sí podemos borrar la tabla
DROP TABLE alumnos;
DROP TABLE alumnos cascade;

-- TAREA CASA:
/*----------------------------------------------------------------------------------*/
/*
La idea es ver qué pasa al revés, si al modificar una view, estaremos afectando a una tabla

Para ello deberán continuar en el Vídeo Practica_02_Parte_6(Tema2)
*/
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
