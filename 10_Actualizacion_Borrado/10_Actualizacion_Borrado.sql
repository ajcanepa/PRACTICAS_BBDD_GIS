-- PRÁCTICA 10: Operaciones de actualización y borrado
-- Objetivo: Modificar y eliminar datos usando UPDATE y DELETE.
-- Contexto: Gestión de historiales médicos.

-- EJEMPLO 1 (Fácil): Actualizar la edad de un paciente
CREATE TABLE pacientes (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER
);

INSERT INTO pacientes VALUES (1, 'Luis', 45), (2, 'Ana', 50), (3, 'Carlos', 60);

UPDATE pacientes SET edad = 46 WHERE nombre = 'Luis';

-- EJEMPLO 2 (Fácil): Eliminar un paciente por nombre
DELETE FROM pacientes WHERE nombre = 'Carlos';

-- EJEMPLO 3 (Intermedio): Aumentar edad a todos los mayores de 50 años
UPDATE pacientes SET edad = edad + 1 WHERE edad > 50;

-- EJEMPLO 4 (Avanzado): Eliminar todos los pacientes con edad nula o menor a 0
INSERT INTO pacientes VALUES (4, 'Marta', NULL), (5, 'Pedro', -1);
DELETE FROM pacientes WHERE edad IS NULL OR edad < 0;

-- EVALUACIÓN (con soluciones)
-- 1. Actualizar la edad de Ana a 55 años
UPDATE pacientes SET edad = 55 WHERE nombre = 'Ana';

-- 2. Eliminar paciente llamado Pedro (si existe)
DELETE FROM pacientes WHERE nombre = 'Pedro';

-- 3. Incrementar en 5 años la edad de todos los pacientes menores de 50
UPDATE pacientes SET edad = edad + 5 WHERE edad < 50;

-- 4. Eliminar todos los registros con nombre NULL
DELETE FROM pacientes WHERE nombre IS NULL;
