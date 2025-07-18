-- PRÁCTICA 6: Joins I – INNER y OUTER JOIN
-- Objetivo: Introducir las uniones INNER y OUTER JOIN.
-- Contexto: Relación entre pacientes y sus médicos asignados.

-- EJEMPLO 1 (Fácil): INNER JOIN entre pacientes y médicos
CREATE TABLE pacientes (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    medico_id INTEGER
);

CREATE TABLE medicos (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(50)
);

INSERT INTO pacientes VALUES (1, 'Luis', 1), (2, 'Elena', 2), (3, 'Carlos', NULL);
INSERT INTO medicos VALUES (1, 'Dr. Juan'), (2, 'Dra. Marta');

SELECT pacientes.nombre AS paciente, medicos.nombre AS medico
FROM pacientes
INNER JOIN medicos ON pacientes.medico_id = medicos.id;

-- EJEMPLO 2 (Fácil): Mostrar todos los pacientes, incluyendo los sin médico (LEFT JOIN)
SELECT pacientes.nombre AS paciente, medicos.nombre AS medico
FROM pacientes
LEFT JOIN medicos ON pacientes.medico_id = medicos.id;

-- EJEMPLO 3 (Intermedio): Médicos que no tienen pacientes (RIGHT JOIN)
SELECT pacientes.nombre AS paciente, medicos.nombre AS medico
FROM pacientes
RIGHT JOIN medicos ON pacientes.medico_id = medicos.id;

-- EJEMPLO 4 (Avanzado): Uso de COALESCE para mostrar texto cuando hay valores NULL
SELECT pacientes.nombre AS paciente, 
       COALESCE(medicos.nombre, 'Sin asignar') AS medico
FROM pacientes
LEFT JOIN medicos ON pacientes.medico_id = medicos.id;

-- EVALUACIÓN (con soluciones)
-- 1. Obtener todos los pacientes con su médico asignado (INNER JOIN)
SELECT pacientes.nombre, medicos.nombre
FROM pacientes
INNER JOIN medicos ON pacientes.medico_id = medicos.id;

-- 2. Mostrar todos los médicos aunque no tengan pacientes
SELECT pacientes.nombre, medicos.nombre
FROM pacientes
RIGHT JOIN medicos ON pacientes.medico_id = medicos.id;

-- 3. Mostrar pacientes sin médico asignado
SELECT nombre FROM pacientes WHERE medico_id IS NULL;

-- 4. Usar LEFT JOIN y COALESCE para mostrar 'No asignado' donde no haya médico
SELECT pacientes.nombre, COALESCE(medicos.nombre, 'No asignado')
FROM pacientes
LEFT JOIN medicos ON pacientes.medico_id = medicos.id;
