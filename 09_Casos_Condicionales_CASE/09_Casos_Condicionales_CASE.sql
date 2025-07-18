-- PRÁCTICA 9: Condicionales con CASE
-- Objetivo: Re-codificar variables y construir condiciones complejas usando CASE.
-- Contexto: Clasificación de pacientes por nivel de riesgo.

-- EJEMPLO 1 (Fácil): Clasificar pacientes por edad
CREATE TABLE pacientes (
    id INTEGER,
    nombre TEXT,
    edad INTEGER
);

INSERT INTO pacientes VALUES (1, 'Luis', 45), (2, 'Marta', 60), (3, 'Laura', 30);

SELECT nombre, 
       CASE 
         WHEN edad < 40 THEN 'Joven'
         WHEN edad BETWEEN 40 AND 59 THEN 'Adulto'
         ELSE 'Mayor'
       END AS grupo_edad
FROM pacientes;

-- EJEMPLO 2 (Fácil): Clasificación con ELSE
SELECT nombre, 
       CASE 
         WHEN edad >= 60 THEN 'Riesgo alto'
         ELSE 'Riesgo bajo'
       END AS riesgo
FROM pacientes;

-- EJEMPLO 3 (Intermedio): Combinación de condiciones múltiples
SELECT nombre, edad,
       CASE 
         WHEN edad < 40 THEN 'Joven'
         WHEN edad >= 40 AND edad < 60 THEN 'Adulto'
         ELSE 'Senior'
       END AS clasificacion
FROM pacientes;

-- EJEMPLO 4 (Avanzado): Clasificación condicional con datos externos
CREATE TABLE presiones (
    paciente_id INTEGER,
    sistolica INTEGER
);

INSERT INTO presiones VALUES (1, 130), (2, 145), (3, 110);

SELECT nombre,
       CASE 
         WHEN sistolica < 120 THEN 'Normal'
         WHEN sistolica BETWEEN 120 AND 139 THEN 'Prehipertensión'
         ELSE 'Hipertensión'
       END AS nivel
FROM pacientes
JOIN presiones ON pacientes.id = presiones.paciente_id;

-- EVALUACIÓN (con soluciones)
-- 1. Clasificar pacientes como 'Mayor de edad' o 'Menor de edad'
SELECT nombre, CASE WHEN edad >= 18 THEN 'Mayor' ELSE 'Menor' END AS categoria FROM pacientes;

-- 2. Clasificar sistólica en niveles
SELECT paciente_id,
       CASE 
         WHEN sistolica < 120 THEN 'Normal'
         WHEN sistolica < 140 THEN 'Elevada'
         ELSE 'Alta'
       END AS presion_cat
FROM presiones;

-- 3. Combinar edad y presión en clasificación
SELECT p.nombre,
       CASE 
         WHEN edad > 50 AND sistolica > 140 THEN 'Riesgo elevado'
         ELSE 'Riesgo moderado'
       END AS evaluacion
FROM pacientes p
JOIN presiones pr ON p.id = pr.paciente_id;

-- 4. Clasificación múltiple en SELECT
SELECT nombre, edad,
       CASE 
         WHEN edad < 30 THEN 'Joven'
         WHEN edad < 60 THEN 'Adulto'
         ELSE 'Mayor'
       END AS grupo
FROM pacientes;
