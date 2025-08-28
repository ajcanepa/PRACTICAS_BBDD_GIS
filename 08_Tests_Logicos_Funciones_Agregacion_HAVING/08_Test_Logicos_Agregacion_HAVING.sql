/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* GUIA CODIGOS TEMA 5 */
/*----------------------------------------------------------------------------------*/
/* TESTS LÓGICOS */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* BETWEEN */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
drop table  if exists alumnos;

create table alumnos(
    nombre 		char(20),
    ape1         char(20),
    ape2         char(20),
    fecha_nacimiento	date,
    altura		numeric(3,2),
    primary key ( nombre, ape1, ape2 )
);

insert into alumnos values
( 'Pepe', 'Alvarez',   'Fernandez', current_date-365*17, 1.70),
( 'Pepe', 'Fernandez', 'Fernandez', current_date-365*18, 1.70),    
( 'Pepe', 'Garcia',    'Fernandez', current_date-365*19, 1.90),
( 'Pepe', 'Gonzalez',  'Fernandez', current_date-365*20, 1.70),
( 'Pepe', 'Lopez',     'Fernandez', current_date-365*21, 1.70),    
( 'Pepe', 'Rodriguez', 'Fernandez', current_date-365*22, 1.70);

select * from alumnos;

-- Selecciono los apellidos de los alumnos que nacieron entre 19 y 18 años atrás
-- SELECT ape1 FROM alumnos 
SELECT * FROM alumnos
WHERE fecha_nacimiento BETWEEN CURRENT_DATE-365*19 AND CURRENT_DATE-365*18;


-- Apellidos que están alfabéticamente entre García y López

-- Si se niega salen todos menos los comprendidos en el BETWEEN 

-- Además se les puede unir otro predicado lógico.

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* BETWEEN y CHECK*/
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
/* Sólo se discute la sintaxis, no se evaluarán ejemplos*/ 

drop table if exists ejemplo;

CREATE TABLE ejemplo (
 fiebre NUMERIC( 3, 1) CHECK (fiebre BETWEEN 36 AND 42),
 fechNacimiento	DATE CHECK(
  fechNacimiento BETWEEN DATE '1900-01-01' AND CURRENT_DATE),
 hepatitis CHAR(1) CHECK (hepatitis BETWEEN 'A' AND 'C')
);

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* LIKE ó Búsqueda con Comodines */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
drop table if exists alumnos;

create table alumnos(
	nombre varchar(20)  	
);

insert into alumnos values ('ANA'),(null),('PEDRO'),('ALBERTO'),('ALBERTA'),('MARIA'), ('PEPE'), ('PABLO');

select * from alumnos;

-- Seleccionamos los nombres que comienzen por P y terminen en O y que tengan cualquier numero de caracteres intermedios, incluso el cero ("Hola Po").
SELECT nombre FROM alumnos
WHERE nombre LIKE 'P%O';

-- Seleccionamos aquellos nombres que comiencen y terminen con A, pero que además su longitud total sea de 3 caracteres.
SELECT nombre FROM alumnos
WHERE nombre LIKE 'A_A';

-- Esto no tiene sentido y es más lento (Lo suyo es usar =)
SELECT nombre FROM alumnos
WHERE nombre LIKE 'PEDRO';

-- Devuelve todos los nombres porque todos tienen algún caracter, excepto los NULOS!
SELECT nombre FROM alumnos
WHERE nombre LIKE '%';

/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* USANDO CHAR en vez de VARCHAR */
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */

drop table if exists alumnos;
create table alumnos(
	nombre char(20)  
);

insert into alumnos values ('ANA'),(null),('PEDRO'),('ALBERTO'),('ALBERTA'),('MARIA'), ('PEPE'), ('PABLO');

select * from alumnos;

--comentar
SELECT nombre FROM alumnos
WHERE nombre LIKE 'P%O';  

--comentar
SELECT nombre FROM alumnos
WHERE trim(nombre) LIKE 'P%O';
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* USANDO ESCAPE para obviar los metacaracteres % y _ */
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */

drop table if exists peliculas;
create table peliculas(
   titulo varchar(40) primary key
);

insert into peliculas values ('The ten % solution'), ('Casablanca');

select * from peliculas;

-- Esto es lo mismo que seleccionar todas, o haber usado un único %. 
SELECT titulo FROM peliculas
WHERE titulo LIKE '%%%';

-- Escapando con almohadilla, para que lea el siguiente caracter de manera literal y no como el metacaracter de búsqueda de LIKE.
SELECT titulo FROM peliculas
WHERE titulo LIKE '%#%%' ESCAPE '#';

-- Puedes usar otro símbolo como el $. Importante que no esté dentro del string!
SELECT titulo FROM peliculas
WHERE titulo LIKE '%$%%' ESCAPE '$';
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
/* Trabajaremos con Passwords */

drop table if exists usuarios;
create table usuarios(
   login 	varchar(10) primary key,
   password	varchar(10))
;

insert into usuarios values ('Pepe', '12345'), ('Juan', '12%34'), ('Luis', '12$34'), ('Ana', '12%$34'), ('Maria', '123%%'), ('Raro', '123\\45') ;

select * from usuarios;

-- selecciono aquellos password que después de un 2 haya un % (sin importar caracteres antes y después)

-- passwords que acaben en 2 porcentages %

-- utilizando el acento circunflejo para aquellos passwords con un % seguido de un $

/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* SIMILAR TO */ 
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */

/* Volvemos a cargar la base de datos alumnos con VARCHAR() para no tener problemas de espacios en blanco */
drop table if exists alumnos;

create table alumnos(
	nombre varchar(20)  	
);

insert into alumnos values ('ANA'),(null),('PEDRO'),('ALBERTO'),('ALBERTA'),('MARIA'), ('PEPE'), ('PABLO');

select * from alumnos;

-- De igual manera que LIKE, SIMILAR TO encuentra a Pedro y Pablo
select * from alumnos
where nombre similar to 'P%O';

-- De igual manera que LIKE, SIMILAR TO encuentra a ANA
select * from alumnos
where nombre similar to 'A_A';

-- También sigue funcionando...
SELECT * FROM usuarios
WHERE password similar to '%^%$%' ESCAPE '^';
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Usaremos el SIMILAR TO para encontrar patrones como DNI, Matrícula, etc */
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
/*
-- Ejemplo con IP de ordenadores que son 4 dígitos separados por un punto
*/

drop table if exists ordenadores;

create table ordenadores(
	ip char(15) check( ip similar to '(([0-1][0-9]{2})|(2[0-4][0-9])|25[0-5]).'||
					 '(([0-1][0-9]{2})|(2[0-4][0-9])|25[0-5]).'||
					 '(([0-1][0-9]{2})|(2[0-4][0-9])|25[0-5]).'||
					 '(([0-1][0-9]{2})|(2[0-4][0-9])|25[0-5])'),
	nombre char(40));
	

-- Ya que la primera cadena de caracteres se repite tres veces, podemos multiplicar por 3 esa cadena usando {}.

drop table if exists ordenadores;
create table ordenadores(
	ip char(15) check( ip similar to '((([0-1][0-9]{2})|(2[0-4][0-9])|25[0-5]).){3}'||
					 '(([0-1][0-9]{2})|(2[0-4][0-9])|25[0-5])'),
	nombre char(40));


-- IPs que sí funcionan (porque son reales)
insert into ordenadores values
	('125.125.125.225', 'ordenador de Pepe'),
	('255.000.125.225', 'ordenador de Maria');		

select * from ordenadores;

-- IPs que NO funcionan porque son falsas.
insert into ordenadores values
	('125.125.125.225', 'ordenador de Pepe'),
	('349.295.125.225', 'ordenador de Maria');	

select * from ordenadores;


-- Busqueda más compleja que pide:
-- ordenadores que en los 3 primeros campos tenga dígitos cualesquiera, luego el primer dígito del segundo campo no sea un cero y luego más (o ninguno) caracter extra
select * from ordenadores where ip similar to '___.[^0]%'; -- solo sale el de Pepe 	
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Test de Pertenencia */ 
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
drop table if exists pacientes;

create table pacientes(
	nombre char(10) primary key,
	cama   integer  unique not null,
	peso   numeric(4,1) not null
);

insert into pacientes values ('Pepe', 1, 67), ('Juan', 2, 83), ('Luis', 3, 67), ('Ana', 4, 60);

select * from pacientes;

-- Seleccionamos las camas de los pacientes que o se llaman Pepe, ó Ana, ó Pedro.
SELECT cama FROM pacientes
WHERE nombre IN ( 'Pepe', 'Ana', 'Pedro');

-- Usando números es menos común por la precisión
SELECT * FROM pacientes;

SELECT nombre FROM pacientes
WHERE peso IN (67, 83, 61);

-- equivalente al anterior
SELECT nombre FROM pacientes
WHERE peso = 67 OR peso = 83  OR peso = 61;

-- en la negación se puede escribir de dos maneras.
-- Suena mas natural
SELECT nombre FROM pacientes
WHERE peso NOT IN (67, 83);

-- Pero literal sería
SELECT nombre FROM pacientes
WHERE NOT peso IN ( 67, 83);
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* CHECK con IN y su decodificación */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */

drop table if exists socios;

CREATE TABLE socios(
	DNI NUMERIC(8) PRIMARY KEY,
	nombre CHAR(20),
	tipo	CHAR(1) CHECK (tipo IN ( 'N', 'T', 'J', 'V'))
);

insert into socios values
	( 1, 'Pepe', 'N'),
	( 2, 'Ana',  'T'),
	( 3, 'Luis', 'J'),
	( 4, 'Maria', 'V');

select * from socios;

-- Solo se ejecuta, lo importante está en el CHECK (tipo IN...)
select nombre, case
		when tipo='N' then 'Niño'
		WHEN tipo='T' THEN 'Trabajador'
		WHEN tipo='J' THEN 'Jubilado'
		WHEN tipo='V' THEN 'VIP'
		ELSE 'Valor incorrecto o nulo'
	       end
from socios;

-- NO se ejecuta, lo importante está en el CHECK (tipo IN...)
select nombre, case tipo
		when 'N' then 'Niño'
		WHEN 'T' THEN 'Trabajador'
		WHEN 'J' THEN 'Jubilado'
		WHEN 'V' THEN 'VIP'
		ELSE 'Valor incorrecto o nulo'
	       end
from socios;
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Funciones de Agregación */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Funciones de Agregación sin Group By */ 
/*----------------------------------------------------------------------------------*/

/* Creamos BBDD para trabajar */
drop table if exists empleados cascade;

create table empleados (
	nombre		char(20) primary key,
	salario	   	numeric(4),
	nHorasExtras	integer,
	provincia	char(15)
);


insert into empleados values 	('Pepe', 100, 0,  'BURGOS'),
				('Juan', 200, 10, 'BURGOS'),
				('Ana',  200, 20, 'LEON');

select * from empleados;

/*----------------------------------------------------------------------------------*/
/* Se usa asociado a un atributo, a un cálculo hecho en ese atributo o a más de uno*/

-- Calculamos el valor máximo de una columna numérica				
SELECT MAX(salario) FROM empleados;

-- Uso de una constante y un atributo para en este caso mostrar el 80% del salario
SELECT MAX(0.8*salario) FROM empleados;

-- Igual que el anterior pero pierde los atributos de la columna
SELECT 0.8*MAX(salario) FROM empleados;

-- Agregamos al salario un beneficio por horas extras
SELECT AVG(salario+60*nHorasExtras)
FROM empleados;

--No funciona, ¿porqué?
SELECT AVG(salario+60*nHorasExtras), nombre
FROM empleados;

-- USo de una constante
SELECT 'El promedio es: ', AVG(salario+60*nHorasExtras)
FROM empleados
WHERE provincia='BURGOS';


-- no puede haber F. de Agregación en la clausula where
SELECT AVG(salario+60*nHorasExtras)
FROM empleados
WHERE MIN(salario)<100;

-- Tampoco permite agregar operaciones dentro de una función de Agregación.
SELECT 'El promedio es: ', AVG(MAX(salario+60*nHorasExtras))
FROM empleados
WHERE provincia='BURGOS';

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* La función COUNT(<expresión>) y COUNT(*) */
/*----------------------------------------------------------------------------------*/

-- cuántas filas tiene la tabla de empleados.
select * from empleados;

SELECT COUNT(*)
FROM empleados;

-- cuántas filas de la tabla de empleados tienen un valor de salario mayor que 100


/*----------------------------------------------------------------------------------*/
/*
COUNT y los NULOS
*/

/* Creamos BBDD para trabajar */
drop table if exists alumnos;
create table alumnos(
	nombre	char(20),
	altura	numeric(3,2),
	nota	numeric(4,2)
);

insert into alumnos values 	('Pepe', 1.70, 2.3),
				('Ana',  1.72, 5.4),
				('Pablo',1.70, null),
				('Pedro',null, 8);

select * from alumnos;
/*----------------------------------------------------------------------------------*/
--count y los nulls
select * from alumnos;

-- todas las filas
SELECT COUNT(*)
FROM alumnos WHERE nombre >= 'Pablo';

-- todos los valores del atributo nota

--count que no cumple ninguna fila o tabla vacia

-- count no devuelve los nulls

--distinct/all

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Las funciones MAX y MIN */
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */

drop table if exists alumnos cascade;
create table alumnos(
	nombre	char(20),	
	nota	numeric(4,2),
	fechaNac	date
);


insert into alumnos (nombre, fechaNac, nota) values ('Pedro', date '01-10-1983', 2.3),
						    ('Ana',   date '15-12-1980', 10),
						    ('Pablo', date '05-12-1984', null),
						    ('Pepe',  null,		 8),
						    ( null,   null, 		 1),
						    ('Zacarias', null, 		 1);
select * from alumnos;
/*----------------------------------------------------------------------------------*/

-- seleccionamos aquellos mayores/iguales que nombre 'Pablo'


-- Sólo pedimos los valores máximos y mínimos, que ojo son combinaciones que no siempre existen


--MAX/MIN cuando where no se verifica por ninguna fila o tabla vacia
select * from alumnos;

SELECT MAX( nombre), MIN( FechaNac), MAX(Nota)
FROM alumnos WHERE nombre < 'Ana';

--MAX/MIN cuando where se verifica solo en filas en las q la expresion evaluada es siempre nulo
select * from alumnos;

SELECT MAX( nombre), MIN(FechaNac), MAX(Nota)
FROM alumnos WHERE nombre >= 'Pepe';
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Las funciones SUM y AVG */
/*----------------------------------------------------------------------------------*/

select * from alumnos;

SELECT SUM(nota) FROM alumnos;

SELECT SUM(DISTINCT nota) FROM alumnos;

SELECT SUM( nota), SUM( ALL nota), SUM(DISTINCT Nota)
FROM alumnos;

select * from alumnos;

SELECT AVG(nota) FROM alumnos;

SELECT AVG(DISTINCT nota) FROM alumnos;

SELECT AVG( nota), AVG( ALL nota), AVG(DISTINCT Nota)
FROM alumnos;
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* La clausulas GROUP BY y HAVING */ 
/*----------------------------------------------------------------------------------*/
/* GROUP BY */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
drop table if exists oficinas cascade;
drop table if exists categorias cascade;
drop table if exists empleados cascade;

create table oficinas(
	n_oficina 	char(5) primary key,
	poblacion	char(40),
	region		char(20),
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


insert into oficinas values ( 'OFI_1', 'Burgos', null, null, null),
			    ( 'OFI_2', 'Leon', null, null, null),
			    ( 'OFI_3', 'Burgos', null, null, null);

insert into categorias values ('GERENTE', 10000), ('SECRETARIO', 1000), ('VENDEDOR', 3000);

insert into empleados values 	( 1, 'Pepe', 'OFI_1', 'VENDEDOR', 10),
				( 2, 'Juan', 'OFI_1', 'VENDEDOR', 20),
				( 3, 'Jorge','OFI_1', 'GERENTE', 30),
				( 4, 'Luis', 'OFI_2', null, 15),
				( 5, 'Ana', null, null, 5),
				( 6, 'Antonio', 'OFI_3', null, null);			   

select * from oficinas;
select * from categorias;
select * from empleados;
/*----------------------------------------------------------------------------------*/

-- null se reconocen como repetidos
select * from empleados;

SELECT cargo FROM empleados
GROUP BY cargo;

-- de igual manera
SELECT DISTINCT cargo FROM empleados;

-- obtener una fila por cada grupo			   
SELECT oficina FROM empleados
GROUP BY oficina;

-- de igual manera
SELECT DISTINCT oficina FROM empleados;

-- para calcular el promedio del campo comisión en cada oficina
SELECT AVG(comision) FROM empleados

SELECT oficina, AVG(comision) FROM empleados
GROUP BY oficina;

-- Agrupamientos por más de un criterio
-- para calcular el promedio del campo comisión en cada oficina y para cada cargo

-- Los atributos que se seleccionan (SELECT) deben estar en el GROUP BY  
-- Referencia a campo no agrupado

-- Hacemos el producto cartesiano y filtramos por las oficinas que son iguales (join)

-- Da error aun cuando casualmente todos los miembros del grupo coincidan en el valor no agrupado(poblacion)
SELECT oficina, poblacion, AVG(comision)
FROM empleados, oficinas
WHERE oficina = n_oficina
GROUP BY oficina;

-- Ahora SÍ funciona porque el GROUP BY contiene ambos atributos
SELECT oficina, poblacion, AVG(comision)
FROM empleados, oficinas
WHERE oficina = n_oficina
GROUP BY oficina, poblacion;

-- Obtener el promedio de la comisión por población

-- si queremos agregar la oficina deberemos agregarla tanto en el SELECT como en el GROUP BY

/*----------------------------------------------------------------------------------*/
/* Comparando con cuando no había GROUP BY*/

SELECT empleados.cargo, sal*AVG(comision)
FROM empleados, categorias
WHERE empleados.cargo = categorias.cargo
GROUP BY empleados.cargo;
--GROUP BY empleados.cargo, categorias.sal;


-- Si existen NULLs se mostrarán como NULL en el group by y en los cálculos que se realicen.
select * from empleados;

SELECT oficina, AVG(comision) FROM empleados
GROUP BY oficina;

-- Si ninguna fila de un grupo cumple el WHERE ese grupo no sale.
SELECT oficina, AVG(comision) FROM empleados
WHERE comision IS NOT NULL
GROUP BY oficina;


--En el siguiente ejemplos fijarnos en el grupo de OFI_3
select * from empleados;

SELECT oficina, count(comision), count(*), sum(comision), avg(comision), max(comision), min(comision)
FROM empleados
GROUP BY oficina;

--Ordenaciones por resultado de funcion sumaria
select * from empleados;

SELECT oficina, count(*)
FROM empleados
GROUP BY oficina
ORDER BY count(*) DESC;

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* La clausula HAVING */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */

drop table if exists oficinas,vendedores cascade;

create table oficinas(
	n_oficina 	char(5) primary key,
	poblacion	char(40)
);

create table vendedores(
	cod 		integer primary key,
	nombre		char(40),
	oficina 	char(5) references oficinas,
	ventas		numeric(6,2)
);


insert into oficinas values ( 'OFI_1', 'Burgos'),
			    ( 'OFI_2', 'Leon'),
			    ( 'OFI_3', 'Burgos');

insert into vendedores values 	( 1, 'Pepe',   'OFI_1', 100),
				( 2, 'Juan',   'OFI_1', 200),
				( 3, 'Jorge',  'OFI_1', 300),
				( 4, 'Luis',   'OFI_2',1500),
				( 5, 'Ana',     null,   500),
				( 6, 'Antonio', 'OFI_3', null);			   

select * from oficinas;
select * from vendedores;
/*----------------------------------------------------------------------------------*/

-- Calculamos el promedio de las comisiones en las oficinas de Burgos en las que las sumas de las ventas sea mayor que 100:
--Paso 1:
--SELECT n_oficina, ventas
SELECT *
FROM vendedores, oficinas
WHERE oficina = n_oficina
AND poblacion = 'Burgos';

--Paso 2:
SELECT n_oficina, AVG(ventas), SUM(ventas)
FROM vendedores, oficinas
WHERE oficina = n_oficina
AND poblacion = 'Burgos'
GROUP BY n_oficina;

--Paso 3:
SELECT n_oficina, AVG(ventas)
FROM vendedores, oficinas
WHERE oficina = n_oficina
AND poblacion = 'Burgos'
GROUP BY n_oficina
HAVING SUM(ventas) > 100;
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Intercambiar HAVING y WHERE */ 
/*----------------------------------------------------------------------------------*/
--A veces la condicion HAVING puede ir en el WHERE, suele ir mas deprisa xq elimina filas antes


-- comparar velocidades de estos ejemplos y discutir
SELECT n_oficina, AVG(ventas), poblacion
FROM vendedores, oficinas
WHERE oficina = n_oficina
GROUP BY n_oficina, poblacion
HAVING SUM(ventas) > 100 AND poblacion = 'Burgos';

SELECT n_oficina, AVG(ventas), poblacion
FROM vendedores, oficinas
WHERE oficina = n_oficina
AND poblacion = 'Burgos'
GROUP BY n_oficina, poblacion
HAVING SUM(ventas) > 100;
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* HAVING sin GROUP BY */ 
/*----------------------------------------------------------------------------------*/

-- una sola fila
select * from vendedores;

SELECT SUM(ventas) FROM vendedores
HAVING AVG(Ventas)>100;

-- ninguna fila
SELECT SUM(ventas) FROM vendedores
HAVING AVG(Ventas)>1000;
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* Consultas con join externo y agrupamiento */ 
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */ 

drop table if exists oficinas cascade;
drop table if exists categorias cascade;
drop table if exists empleados cascade;

create table oficinas(
	n_oficina 	char(5) primary key,
	poblacion	char(40),
	region		char(20),
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


insert into oficinas values ( 'OFI_1', 'Burgos', null, null, null),
			    ( 'OFI_2', 'Leon', null, null, null),
			    ( 'OFI_3', 'Burgos', null, null, null);

insert into categorias values ('GERENTE', 10000), ('SECRETARIO', 1000), ('VENDEDOR', 3000);

insert into empleados values 	( 1, 'Pepe', 'OFI_1', 'VENDEDOR', 10),
				( 2, 'Juan', 'OFI_1', 'VENDEDOR', 20),
				( 3, 'Jorge','OFI_1', 'GERENTE', 30),
				( 4, 'Luis', 'OFI_2', null, 15);


select * from oficinas;
select * from categorias;
select * from empleados;

/*----------------------------------------------------------------------------------*/
/* Consulta 1: Todas las oficinas con el numero de empleados de cada una.
*/ 

--Mal: la oficina 3 no tiene 1 empleado
select * from oficinas;
select * from empleados;

select n_oficina, count(*)
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;

--Mal también, ¿por qué?
select n_oficina, count(n_oficina)
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;

-- BIEN #1
select n_oficina, count(oficina)
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;

-- BIEN #2
select n_oficina, count(cod)
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;

/*----------------------------------------------------------------------------------*/
/* Consulta 2: Todos los cargos junto con el número de empleados que los ocupan */
select * from empleados;
select * from categorias;


/*----------------------------------------------------------------------------------*/
/* Consulta 3: Todas las oficinas con la comision máxima de empleado de cada una 
*/


/*----------------------------------------------------------------------------------*/
/* Consulta 4: Todos los cargos junto con la comision promedio 
*/

/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/