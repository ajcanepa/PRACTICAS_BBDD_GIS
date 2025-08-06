/*----------------------------------------------------------------------------------*/
/* 8. Algunos Tests Lógicos */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* 8.1 BETWEEN */ 
/*----------------------------------------------------------------------------------*/

/*
Sirve para determinar si los valores están dentro de un determinado rango (cerrado) de valores. Se podría representar usando:  "A BETWEEN A AND B --> x >= A AND X <= B ".

Sirve también para mostrar aquellos valores ausentes en un rango de valores (rango complementario), expresado por la negación NOT X BETWEEN A AND B --> x < A OR X > B ".

Se aplica a cualquier conjunto de datos ordenados (números, fechas, characteres)


Nota: Los ejemplos de esta sección están en 3.1. BETWEEN.sql
*/


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
-- SELECT ape1 FROM alumnos -- respuesta correcta
SELECT * FROM alumnos
WHERE fecha_nacimiento BETWEEN CURRENT_DATE-365*19 AND CURRENT_DATE-365*18;


-- Apellidos que están alfabéticamente entre García y López
SELECT nombre, ape1, ape2 FROM alumnos
WHERE ape1 BETWEEN 'Garcia' AND 'Lopez';

-- Si se niega salen todos menos los comprendidos en el BETWEEN 
SELECT nombre, ape1, ape2 FROM alumnos
WHERE NOT ape1 BETWEEN 'Garcia' AND 'Lopez';

-- Además se les puede unir otro predicado lógico.
--SELECT nombre, ape1, ape2 FROM alumnos -- Respuesta correcta
SELECT * FROM alumnos
WHERE NOT ape1 BETWEEN 'Garcia' AND 'Lopez'
OR altura > 1.70;
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Usando BETWEEN y CHECK*/
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
/* 3.2 LIKE ó Búsqueda con Comodines */ 
/*----------------------------------------------------------------------------------*/

/*
Se utiliza para hacer búsquedas aproximadas en SQL (a diferencia de IN que lo veremos a continuación).

Se utiliza solamente con cadenas de caracteres, en los que busca si hay patrones que coinciden usando 2 predicados 
el porcentage (%) y el guión bajo (_), donde:

%: cero o más caracteres cualesquiera
_: un sólo caracter cualesquiera

Actualmente se usa SIMILAR con Expresiones regulares para un fin similar, pero con búsquedas más complejas.


Nota: Los ejemplos de esta sección están en 3.2. Búsqueda con Comodines.sql
*/


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

/*Cuidado!! con CHAR tiene en cuenta espacios finales, se arregla con TRIM q quita los espacios finales*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */


--Cuidado!! con CHAR tiene en cuenta espacios finales, se arregla con TRIM q quita los espacios finales*/	
drop table if exists alumnos;
create table alumnos(
	nombre char(20)  
);

insert into alumnos values ('ANA'),(null),('PEDRO'),('ALBERTO'),('ALBERTA'),('MARIA'), ('PEPE'), ('PABLO');

select * from alumnos;

-- No selecciona nada (recordar diferencia entre CHAR y VARCHAR), porque como los espacios "sobrantes" del caracter VARCHAR los rellena con espacios en blanco, en realidad terminan en espacio en blanco y no en la letra "O" (o cualqueira otra)
SELECT nombre FROM alumnos
WHERE nombre LIKE 'P%O';  

-- Para quitar lso espacios en blanco después de los caracteres se debe usar trim().
SELECT nombre FROM alumnos
WHERE trim(nombre) LIKE 'P%O';
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* USANDO ESCAPE para obviar los metacaracteres % y _ */

/*
Cuando en los caracteres existen los valores (metacaracteres de LIKE) % y _, deberemos escapar de ellos para que entienda que estamos buscando eso como resultado y no como metacaracter.

Para hacer esto se utiliza la función ESCAPE que permite seleccionar cualquier caracter (raro ojalá para que no esté en el string), para que el primer caracter que viene a la derecha de este caracter raro, lo va a tomar como el caracter a buscar. 
*/

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
SELECT * FROM usuarios
WHERE password LIKE '%2$%%' ESCAPE '$';

-- passwords que acaben en 2 porcentages %
SELECT * FROM usuarios
WHERE password LIKE '%$%$%' ESCAPE '$';

-- utilizando el acento circunflejo para aquellos passwords con un % seguido de un $
SELECT * FROM usuarios
WHERE password LIKE '%^%$%' ESCAPE '^'; -- acento circunflejo
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* 3.2.2 SIMILAR TO */ 
/*----------------------------------------------------------------------------------*/

/*
Mayor precisión que LIKE, ya que posee además de "%" y "_" otros metacaracteres, que se usan con expresiones regulares.

El punto (.) que es ampliamente usado por otros Lenguajes para indicar un caracter cualquiera, acá no se usa ya que para eso está el "_". 

Nota: Los ejemplos de esta sección están Guía docente página 28 y 29.
EXPLICAR TABLA DE LA PÁGINA 29

Los ejemplos de esta sección están en 3.2. Búsqueda con comodines.sql
*/


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

/*
Patrón Incorrecto, mejor NO mostrar!

drop table if exists ordenadores;

create table ordenadores(
	ip char(15) check( ip similar to '[0-2][0-9]{2}.[0-2][0-9]{2}.[0-2][0-9]{2}.[0-2][0-9]{2}'),
	nombre char(40));

insert into ordenadores values
	('125.125.125.125', 'ordenador de Pepe'),
	('125.295.125.125', 'ordenador de Maria');
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
/* 3.3 Test de Pertenencia */ 
/*----------------------------------------------------------------------------------*/

/*
Permite hacer búsquedas exactas.

La sintaxis requiere que se escriba la función IN después de un atributo y luego de IN una lista de carcateres (o vector numérico o incluso subconsulta) dónde buscar esa coincidencia.

Nota: El material de esta sección está en 3.3. Test de Pertenencia.sql
*/


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
/* 3.3.1 CHECK con IN y su decodificación */ 
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
/* 4. Las Funciones de Agregación */ 
/*----------------------------------------------------------------------------------*/

/*
Se utilizan para generar medidas resúmenes de filas (reducen la primera dimensión). Estas medidas resúmenes pueden ser mínimo (MIN), máximo (MAX), promedio (AVG) y numero de elementos (COUNT).

Se pueden utilizar sintácticamente a continuación del select.

El resultado es un único valor (en ausencia de group by)

Nota: Las consultas de esta sección están en 4. Las Funciones de Agregación.sql
*/

/*----------------------------------------------------------------------------------*/
/* 4.1 Funciones de Agregación sin Group By */ 
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

--No funciona porque al condensar el resultado en una fila, ¿qué nombre elije y con que criterio?

SELECT AVG(salario+60*nHorasExtras), nombre
FROM empleados;


--si que puede ir una cte en la select u otra F. de Agregación, pero no una referencia directa a un campo
--en el where no hay esa restriccion

SELECT 'El promedio es: ', AVG(salario+60*nHorasExtras)
FROM empleados
WHERE provincia='BURGOS';

/*no puede haber F. de Agregación en la clausula where */

SELECT AVG(salario+60*nHorasExtras)
FROM empleados
WHERE MIN(salario)<100;

-- Tampoco permite agregar operaciones dentro de una función de Agregación.

SELECT 'El promedio es: ', AVG(MAX(salario+60*nHorasExtras))
FROM empleados
WHERE provincia='BURGOS';

/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* 4.2 La función COUNT(<expresión>) y COUNT(*) */
/*----------------------------------------------------------------------------------*/
/*
COUNT permite tanto el uso de un atributo como un * para indicar el número de elemntos (filas)
*/

-- cuántas filas tiene la tabla de empleados.
select * from empleados;

SELECT COUNT(*)
FROM empleados;

-- cuántas filas de la tabla de empleados tienen un valor de salario mayor que 100
SELECT COUNT(*)
FROM empleados
WHERE salario>100;

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
-- SQL primero tomará a Pablo, Pedro y Pepe que son los que cumplen la condición WHERE.
-- Como Pablo tiene nota nula, el resultado será
select * from alumnos;

-- todas las filas
SELECT COUNT(*)
FROM alumnos WHERE nombre >= 'Pablo';

-- todos los valores del atributo nota
SELECT COUNT(nota)
FROM alumnos WHERE nombre >= 'Pablo';

SELECT COUNT(*), COUNT(nota)
FROM alumnos WHERE nombre >= 'Pablo';

--count que no cumple ninguna fila o tabla vacia
SELECT COUNT(*), COUNT(nota)
FROM alumnos
WHERE nombre = 'David';

-- count no devuelve los nulls
SELECT COUNT(*), COUNT(nota)
FROM alumnos
WHERE nombre = 'Pablo';

--distinct/all
select * from alumnos;

SELECT COUNT(*), COUNT(DISTINCT altura),
	COUNT(ALL altura), COUNT(altura)
FROM alumnos;
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* 4.3 Las funciones MAX y MIN */
/*----------------------------------------------------------------------------------*/
/*
Mirar página 36 para el detalle

Las funciones MAX y MIN calculan el máximo y mínimo de una expresión
No cuentan los nulos
Se pueden usar para valores numéricos, pero también para cadena de caracteres, fechas, etc.
*/

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
SELECT nombre, FechaNac, Nota
FROM alumnos WHERE nombre >= 'Pablo';

-- Sólo pedimos los valores máximos y mínimos, que ojo son combinaciones que no siempre existen
select * from alumnos;

SELECT MAX(nombre), MIN( FechaNac), MAX(Nota)
FROM alumnos WHERE nombre >= 'Pablo';


--MAX/MIN cuando where no se verifica por ninguna fila o tabla vacia
-- Diferente de count que regresa 0, acá regresa NULO y no lo muestra
select * from alumnos;

SELECT MAX( nombre), MIN( FechaNac), MAX(Nota)
FROM alumnos WHERE nombre < 'Ana';

--MAX/MIN cuando where se verifica solo en filas en las q la expresion evaluada es siempre nulo
select * from alumnos;

SELECT MAX( nombre), MIN(FechaNac), MAX(Nota)
FROM alumnos WHERE nombre >= 'Pepe';
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* 4.4 Las funciones SUM y AVG */
/*----------------------------------------------------------------------------------*/
/*
Mirar página 38 para el detalle

no admiten *

si admiten DISTINCT y ALL

desprecia/no computa los nulos

únicamente admite tipos numéricos
*/

-- Página 38: La nota de null vale 1 y está repetida respecto a la de Zacarías. Por eso al hacer SUM-DISTINCT sale uno menos. (Diferencia con R que cuando hay NA, sale NA y te advierte)
select * from alumnos;

SELECT SUM(nota) FROM alumnos;

SELECT SUM(DISTINCT nota) FROM alumnos;

SELECT SUM( nota), SUM( ALL nota), SUM(DISTINCT Nota)
FROM alumnos;

-- Página 38-39
select * from alumnos;

SELECT AVG(nota) FROM alumnos;

SELECT AVG(DISTINCT nota) FROM alumnos;

SELECT AVG( nota), AVG( ALL nota), AVG(DISTINCT Nota)
FROM alumnos;
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* 5. La clausulas GROUP BY y HAVING */ 
/*----------------------------------------------------------------------------------*/
/* 5.1 GROUP BY */ 
/*----------------------------------------------------------------------------------*/


/*
Se utiliza para generar grupos sobre los que se realizan cálculos.
Se usa detrás de WHERE (detrás de FROM si no hay WHERE) y antes de ORDER BY

Nota: El material correspondiente a esta sección está en 5.1. GROUP BY.sql
*/


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
SELECT oficina, cargo, AVG(comision) FROM empleados
GROUP BY oficina, cargo;

-- Los atributos que se seleccionan (SELECT) deben estar en el GROUP BY  
-- Referencia a campo no agrupado
SELECT oficina, cargo, AVG(comision), nombre FROM empleados
GROUP BY oficina, cargo;


-- Hacemos el producto cartesiano y filtramos por las oficinas que son iguales (join)
select * from empleados;
select * from oficinas;

SELECT oficina, poblacion, comision
FROM empleados, oficinas
WHERE oficina = n_oficina;

-- Los atributos que se seleccionan (SELECT) deben estar en el GROUP BY 

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
SELECT poblacion, AVG(comision)
FROM empleados, oficinas
WHERE oficina = n_oficina
GROUP BY poblacion;

-- si queremos agregar la oficina deberemos agregarla tanto en el SELECT como en el GROUP BY
SELECT poblacion, oficina, AVG(comision)
FROM empleados, oficinas
WHERE oficina = n_oficina
GROUP BY poblacion, oficina;
/*----------------------------------------------------------------------------------*/
/* Comparando con cuando no había GROUP BY*/

--Puedo poner campos (cargo) y expresiones con referencias a campos (sal) si estos estan en el GROUP BY y
-- pertenecen a la misma tabla!

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
-- OFI_3 no sale porque es NULL
SELECT oficina, AVG(comision) FROM empleados
WHERE comision IS NOT NULL
GROUP BY oficina;


--Si en todas las filas del grupo en las que se cumple el WHERE la expresión del parámetro vale nulo:
--COUNT (<expresión> ) devuelve cero, los demás (excepto COUNT(*)) devuelven nulo.
--COUNT(*) al no tener parámetros no se ve afectado por esta regla (devuelve el número de elementos que tenga el grupo).
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
/* 5.2 La clausula HAVING */ 
/*----------------------------------------------------------------------------------*/

/*
Una solución al no poder poner funciones de agregación en el WHERE.

Permite filtrar grupos por condiciones que incluyan una función de agregación.

Se usa normalmente después del GROUP BY (No mandatorio) y antes del ORDER BY.

La sintaxis de HAVING pueden tener argumentos con predicado lógico; siempre incluidos en el GROUP BY

Nota: El material correspondiente a esta sección está en 5.2. La clausula HAVING.sql
*/


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
			   
SELECT n_oficina, AVG(ventas)
FROM vendedores, oficinas
WHERE oficina = n_oficina
AND poblacion = 'Burgos'
GROUP BY n_oficina
HAVING SUM(ventas) > 100;


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
/* 5.2.1  Intercambiar HAVING y WHERE */ 

--A veces la condicion HAVING puede ir en el WHERE, suele ir mas deprisa xq elimina filas antes

-- más lento
SELECT n_oficina, AVG(ventas), poblacion
FROM vendedores, oficinas
WHERE oficina = n_oficina
GROUP BY n_oficina, poblacion
HAVING SUM(ventas) > 100 AND poblacion = 'Burgos';

-- mas rápido porque elimina filas
SELECT n_oficina, AVG(ventas), poblacion
FROM vendedores, oficinas
WHERE oficina = n_oficina
AND poblacion = 'Burgos'
GROUP BY n_oficina, poblacion
HAVING SUM(ventas) > 100;
/*----------------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------------*/
/* 5.2.2  HAVING sin GROUP BY */ 

-- Se puede usar el HAVING sin el GROUP BY, pero hay que tener cuidado
-- El resultado o da una fila o no da ninguna

-- una sola fila
select * from vendedores;

SELECT SUM(ventas) FROM vendedores
HAVING AVG(Ventas)>100;

-- ninguna fila
SELECT SUM(ventas) FROM vendedores
HAVING AVG(Ventas)>1000;
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* 5.3 Consultas con join externo y agrupamiento */ 
/*----------------------------------------------------------------------------------*/

/*
Es muy frecuente que las consultas con agrupamiento estén asociadas a un join entre una tabla
(padre) a la que a cada fila le corresponden varias de la otra tabla (hija).

El agrupamiento se hace de manera que cada fila de la tabla padre genera un grupo con una función
sumaria aplicada sobre campos de la tabla hija.

Nota: El material correspondiente a esta sección está en 5.3. Consultas con join externo y
agrupamiento.sql
*/


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

Para saber el número de empleados de cada oficina necesitamos:
1) en la tabla de empleados agrupar por oficina,
2) en cada grupo aplicar un COUNT. 
Pero, como nos piden “todas” las oficinas, y alguna pude que no tenga empleados, 
deberemos de hacer un join externo
*/ 

--Mal: la oficina 3 no tiene 1 empleado
-- porque COUNT(*) cuenta las filas, y como los grupos de las oficinas sin empleados
-- ocupan una fila del join externo, nos sale un uno
select * from oficinas;
select * from empleados;

select n_oficina, count(*)
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;

--Mal tambien porque n_oficina es un campo de oficinas que además es la clave primaria 
-- de esta tabla, y nunca vale nulo
select n_oficina, count(n_oficina)
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;

-- BIEN: Si usamos un atributo de empleados
-- asi bien, queremos que cuente las veces q oficina no es nulo.
select n_oficina, count(oficina)
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;

--tb bien así, o con cualquier otro campo de empleados
select n_oficina, count(cod)
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;

/*----------------------------------------------------------------------------------*/
/* Consulta 2: Todos los cargos junto con el número de empleados que los ocupan */
-- Solo hay Vendedor y Gerente (Falta secretario)
select * from empleados;
select * from categorias;


--MAL:
--Ese "cargo" nunca vale nulo porque es de la tabla categorias. 
-- Por defecto si no digo nada es el del lado (LEFT) del join y queremos el de empleados (Right)
select cargo, count(cargo)
from categorias natural left join empleados
group by cargo;

-- si solicitamos todos los nombres en el join tenemos
select cargo, nombre, categorias.cargo, empleados.cargo
from categorias natural left join empleados;

-- BIEN: de esta manera sí se obtiene la pregunta correcta
select cargo, count(empleados.cargo)
from categorias natural left join empleados
group by cargo;

/*----------------------------------------------------------------------------------*/
/* Consulta 3: Todas las oficinas con la comision máxima de empleado de cada una 

Si una oficina no tiene empleados que salga "SIN EMPLEADOS" en lugar de la comisión máxima
*/

--Paso 1: Mostramos los valores aunque sea mostrando "NULLL" en vez de "SIN EMPLEADOS"
select * from oficinas;
select * from empleados;

select n_oficina, max(comision)
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;


--Paso 2:MAL porque no podemos pegar un caracter en un numérico.

select n_oficina, coalesce( max(comision), 'SIN EMPLEADOS')
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;


--necesitamos convertir la comisión a cadena para que sea del mismo tipo que "SIN EMPLEADOS"

select n_oficina, coalesce( cast (max(comision) as CHAR(15)), 'SIN EMPLEADOS')
from oficinas left join empleados on (n_oficina=oficina)
group by n_oficina;

/*----------------------------------------------------------------------------------*/
/* Consulta 4: Todos los cargos junto con la comision promedio 

Si una oficina no tiene empleados que salga "SIN EMPLEADOS" en lugar de la comisión promedio
*/

-- Ejercicio para el lab?
select * from categorias;
select * from empleados;

select cargo, coalesce( cast (AVG(comision) as CHAR(15)), 'SIN EMPLEADOS')
from categorias natural left join empleados
group by cargo;
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/