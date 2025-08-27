/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* GUIA CODIGOS TEMA 5 */
/*----------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------*/
/* Construcciones de bifurcación CASE */ 
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */

drop table if exists alumnos;

create table alumnos	(
	nombre char(10) primary key,
	nota   numeric(3,1),
	fechaMatricula date
);

insert into alumnos values
('Pepe', 4, CURRENT_DATE-1), ('Juan', 5, CURRENT_DATE-1), ('Luis', 6, CURRENT_DATE-1),
('Ana', 7, CURRENT_DATE-2),  ('Maria', 8, CURRENT_DATE-2), ('Olga', 10, CURRENT_DATE-2),
('Laura', 11, CURRENT_DATE-3), ('Iker', null, CURRENT_DATE-3);

select * from alumnos;
/*----------------------------------------------------------------------------------*/


-- Recodificamos una variable usando (case when y luego else).
SELECT Nombre, nota
	CASE
		WHEN nota < 5 THEN 'Suspenso'
		WHEN nota < 7 THEN 'Aprobado'
		WHEN nota < 9 THEN 'Notable'
		ELSE 'Sobresaliente'
	END, fechaMatricula
FROM Alumnos;

/*----------------------------------------------------------------------------------*/

-- Una manera de solucionar esto es quitando el ELSE (así no se completan los campos con valores por defecto) y Creamos la categoría para Sobresaliente.

SELECT nombre,
	CASE
		WHEN nota < 5 THEN 'Suspenso'
		WHEN nota < 7 THEN 'Aprobado'
		WHEN nota < 9 THEN 'Notable'
		WHEN nota <=10 THEN 'Sobresaliente'
	END, fechaMatricula
FROM Alumnos;

-- Eliminar el ELSE en realidad significa esto:
SELECT nombre,
	CASE
		WHEN nota < 5 THEN 'Suspenso'
		WHEN nota < 7 THEN 'Aprobado'
		WHEN nota < 9 THEN 'Notable'
		WHEN nota <=10 THEN 'Sobresaliente'
		ELSE NULL
	END, fechaMatricula
FROM Alumnos;


-- o haciéndolo mas elegante
SELECT nombre,
	CASE
		WHEN nota < 5 THEN 'Suspenso'
		WHEN nota < 7 THEN 'Aprobado'
		WHEN nota < 9 THEN 'Notable'
		WHEN nota <=10 THEN 'Sobresaliente'
		ELSE 'No evaluado'
	END, fechaMatricula
FROM Alumnos;

/*----------------------------------------------------------------------------------*/
/* EJEMPLO CLUB DE NATACION */
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
/*----------------------------------------------------------------------------------*/

-- Decodificamos con un CASE en el que usamos sólo igualdades.
select nombre, case
		when tipo='N' THEN 'Niño'
		WHEN tipo='T' THEN 'Trabajador'
		WHEN tipo='J' THEN 'Jubilado'
		WHEN tipo='V' THEN 'VIP'
		ELSE 'Valor incorrecto o nulo'
	       end 
from socios;

-- En el caso de que se trabaje SOLAMENTE con igualdades, hay una forma abreviada del CASE.
-- Se especifica el atributo que quiero modificar y se le entregan los valores.
select nombre, case tipo
		when 'N' THEN 'Niño'
		WHEN 'T' THEN 'Trabajador'
		WHEN 'J' THEN 'Jubilado'
		WHEN 'V' THEN 'VIP'
		ELSE 'Valor incorrecto o nulo' -- redundante por el check.
	       end as humano -- cambia el nombre de la columna
from socios;
/*----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/* CASE ANIDADO */
/*----------------------------------------------------------------------------------*/
/* Creamos BBDD para trabajar */
	
drop table if exists empleados cascade;
create table empleados(
	dni numeric(8) primary key,
	nombre char(15),
	sueldo numeric(7,2),
	horasSemana numeric(2));

insert into empleados values
	(1, 'Pepe', 500, 40),
	(2, 'Maria', 1200, 20),
	(3, 'Jorge', 1200, 40);


select * from empleados;
/*----------------------------------------------------------------------------------*/
/*
1) Crearemos una columna nueva "categoria" en la que todos serán empleados y por eso usamos 'El Empleado' as Categoria.

2) Creamos el primer CASE para separar si cobra más de 1000 o si le están explotando y

3) Usamos un segundo CASE para separar el número de horas de esos 1000 euros.
*/


SELECT 'El empleado' as Categoria, nombre,
 CASE
  WHEN sueldo > 1000 THEN
    CASE
      WHEN horasSemana < 35 THEN 'Vive como quiere'
      ELSE 'Trabaja mucho pero cobra bien'
    END
  ELSE
  'Le están explotando'
END
FROM Empleados;



---Ejercicio resuelto (página 6)
drop table if exists t cascade;

create table t(	a numeric(4));

insert into t values (0), (2000);

select * from t;

UPDATE T SET a = CASE
			WHEN a < 1000 THEN a+1000
			ELSE a-1000
		 END;

select * from t;
