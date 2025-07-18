-- PRÁCTICA 8: Subconsultas
-- Objetivo: Utilizar subconsultas en SELECT, FROM y WHERE.
-- Contexto: Pacientes y estadísticas de hospitalización.

-- EJEMPLO 1 (Fácil): Subconsulta en SELECT para calcular edad promedio
CREATE TABLE pacientes (
    id INTEGER,
    nombre TEXT,
    edad INTEGER
);

INSERT INTO pacientes VALUES (1, 'Luis', 45), (2, 'Marta', 60), (3, 'Laura', 30);

SELECT nombre, edad, (SELECT AVG(edad) FROM pacientes) AS edad_media FROM pacientes;

-- EJEMPLO 2 (Fácil): Subconsulta en WHERE para filtrar por edad superior a la media
SELECT * FROM pacientes WHERE edad > (SELECT AVG(edad) FROM pacientes);

-- EJEMPLO 3 (Intermedio): Subconsulta en FROM
SELECT promedio_edad FROM (SELECT AVG(edad) AS promedio_edad FROM pacientes) AS datos;

-- EJEMPLO 4 (Avanzado): Subconsulta correlacionada
CREATE TABLE hospitalizaciones (
    id INTEGER,
    paciente_id INTEGER,
    dias INTEGER
);

INSERT INTO hospitalizaciones VALUES (1, 1, 3), (2, 2, 5), (3, 3, 2);

SELECT nombre, edad,
       (SELECT dias FROM hospitalizaciones WHERE paciente_id = pacientes.id LIMIT 1) AS dias_estancia
FROM pacientes;

-- EVALUACIÓN (con soluciones)
-- 1. Mostrar pacientes cuya edad sea mayor a la edad media
SELECT * FROM pacientes WHERE edad > (SELECT AVG(edad) FROM pacientes);

-- 2. Calcular el total de días de hospitalización por paciente
SELECT paciente_id, SUM(dias) FROM hospitalizaciones GROUP BY paciente_id;

-- 3. Mostrar nombre y días hospitalizado
SELECT nombre,
       (SELECT dias FROM hospitalizaciones WHERE paciente_id = pacientes.id LIMIT 1) AS dias
FROM pacientes;

-- 4. Obtener el promedio de días de estancia
SELECT AVG(dias) FROM hospitalizaciones;
