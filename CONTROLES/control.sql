-- CONTROL DE EVALUACIÓN: SQL PARA INGENIERÍA DE LA SALUD
-- Nivel: Medio-Alto
-- Total de preguntas: 60
-- Todas las preguntas incluyen la creación de tablas, inserción de datos biomédicos y una consulta con su solución explicada.
-- Las preguntas se centran en los temas tratados en las 12 prácticas del curso.
-- Atención especial a: JOINS, subconsultas, CASE, agregación, filtros avanzados, vistas, actualizaciones y condiciones compuestas.

-- PREGUNTA 1
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 2
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 3
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 4
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 5
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 6
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 7
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 8
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 9
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 10
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 11
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 12
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 13
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 14
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 15
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 16
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 17
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 18
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 19
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 20
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 21
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 22
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 23
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 24
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 25
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 26
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 27
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 28
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 29
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 30
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 31
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 32
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 33
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 34
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 35
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 36
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 37
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 38
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 39
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 40
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 41
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 42
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 43
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 44
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 45
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 46
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 47
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 48
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 49
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 50
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 51
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 52
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 53
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 54
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 55
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 56
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 57
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 58
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 59
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


-- PREGUNTA 60
-- Tabla de pacientes con signos clínicos
DROP TABLE IF EXISTS pacientes_signos;
CREATE TABLE pacientes_signos (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER,
    presion_sistolica INTEGER,
    presion_diastolica INTEGER,
    fumador BOOLEAN,
    colesterol INTEGER
);

INSERT INTO pacientes_signos VALUES
(1, 'Luis', 45, 130, 85, TRUE, 210),
(2, 'Ana', 60, NULL, 90, FALSE, NULL),
(3, 'Pedro', 35, 120, 80, FALSE, 180),
(4, 'Laura', 50, 135, 88, TRUE, 220),
(5, 'Marta', NULL, 140, 95, TRUE, 230),
(6, 'Iker', 40, 125, 82, NULL, 200),
(7, 'Sonia', 55, 145, NULL, TRUE, 240),
(8, 'David', 65, 150, 100, TRUE, NULL),
(9, 'Lucía', 30, 110, 70, FALSE, 160),
(10, 'Carlos', 70, NULL, NULL, TRUE, 250);

-- Enunciado:
-- Obtener los nombres de los pacientes clasificados como "Riesgo Alto" si:
-- - Su presión sistólica es mayor a 140 O
-- - Su colesterol es mayor a 220
-- Y además, son fumadores conocidos (TRUE).
-- Mostrar también la clasificación de riesgo usando CASE.

-- RESPUESTA:
SELECT nombre,
       CASE
         WHEN presion_sistolica > 140 OR colesterol > 220 THEN 'Riesgo Alto'
         ELSE 'Riesgo Moderado'
       END AS clasificacion
FROM pacientes_signos
WHERE (presion_sistolica > 140 OR colesterol > 220)
  AND fumador = TRUE;

-- Explicación:
-- - La condición del CASE permite clasificar por nivel de riesgo.
-- - El filtro en el WHERE asegura que solo se consideren fumadores conocidos (TRUE).
-- - Se incluyen valores NULL en varias columnas para obligar a considerar filtros correctos.


