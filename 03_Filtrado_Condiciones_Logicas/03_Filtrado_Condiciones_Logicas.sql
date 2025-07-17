-- PRÁCTICA 3: Filtrado y condiciones lógicas
-- Objetivo: Aplicar filtros a consultas SQL mediante condiciones lógicas usando WHERE, AND, OR, y manejo de NULLs.

-- EJEMPLO 1 (Fácil): Pacientes mayores de 50 años
CREATE TABLE pacientes (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    edad INTEGER,
    fumador BOOLEAN,
    presion_arterial INTEGER
);
INSERT INTO pacientes VALUES 
(1, 'Luis', 45, TRUE, 135),
(2, 'Marta', 60, FALSE, 120),
(3, 'Raul', 50, TRUE, NULL),
(4, 'Laura', 30, FALSE, 110),
(5, 'Elena', NULL, FALSE, 115);

SELECT * FROM pacientes WHERE edad > 50;

-- EJEMPLO 2 (Fácil): Pacientes que no son fumadores
SELECT * FROM pacientes WHERE fumador = FALSE;

-- EJEMPLO 3 (Intermedio): Pacientes fumadores con presión alta (>=130)
SELECT * FROM pacientes WHERE fumador = TRUE AND presion_arterial >= 130;

-- EJEMPLO 4 (Avanzado): Pacientes con presión arterial NULL o edad desconocida
SELECT * FROM pacientes WHERE presion_arterial IS NULL OR edad IS NULL;

-- EVALUACIÓN
-- 1. Seleccionar pacientes con edad menor de 40 años
-- 2. Filtrar los pacientes que sean fumadores y mayores de 50 años
-- 3. Obtener los pacientes cuya presión arterial esté entre 110 y 130
-- 4. Filtrar los pacientes donde la edad o presión arterial sean NULL

-- EVALUACIÓN (con soluciones)
-- 1. Seleccionar pacientes con edad menor de 40 años
SELECT * FROM pacientes WHERE edad < 40;

-- 2. Filtrar los pacientes que sean fumadores y mayores de 50 años
SELECT * FROM pacientes WHERE fumador = TRUE AND edad > 50;

-- 3. Obtener los pacientes cuya presión arterial esté entre 110 y 130
SELECT * FROM pacientes WHERE presion_arterial BETWEEN 110 AND 130;

-- 4. Filtrar los pacientes donde la edad o presión arterial sean NULL
SELECT * FROM pacientes WHERE edad IS NULL OR presion_arterial IS NULL;
