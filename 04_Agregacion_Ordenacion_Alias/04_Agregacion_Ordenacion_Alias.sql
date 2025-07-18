-- PRÁCTICA 4: Agregación, ordenación y alias
-- Objetivo: Utilizar funciones de agregación (COUNT, SUM, AVG, MAX, MIN), ordenar resultados con ORDER BY y aplicar alias con AS.
-- Contexto: Registro de pacientes con mediciones clínicas.

-- EJEMPLO 1 (Fácil): Calcular el número total de pacientes registrados
CREATE TABLE registros (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    edad INTEGER,
    presion_arterial INTEGER
);

INSERT INTO registros (nombre, edad, presion_arterial) VALUES
('Luis', 45, 135), ('Marta', 60, 120), ('Laura', 30, 110), ('Iker', 40, 130);

SELECT COUNT(*) AS total_pacientes FROM registros;

-- EJEMPLO 2 (Fácil): Calcular la media de edad de los pacientes
SELECT AVG(edad) AS edad_media FROM registros;

-- EJEMPLO 3 (Intermedio): Obtener el paciente con mayor presión arterial
SELECT nombre, presion_arterial FROM registros
ORDER BY presion_arterial DESC
LIMIT 1;

-- EJEMPLO 4 (Avanzado): Obtener la edad media y presión media, agrupadas por tramos etarios
SELECT 
  CASE 
    WHEN edad < 40 THEN 'Menores de 40'
    WHEN edad BETWEEN 40 AND 59 THEN '40-59'
    ELSE '60 o más'
  END AS grupo_edad,
  COUNT(*) AS n,
  AVG(presion_arterial) AS media_presion
FROM registros
GROUP BY grupo_edad
ORDER BY grupo_edad;

-- EVALUACIÓN (con soluciones)
-- 1. Contar cuántos pacientes tienen más de 50 años
SELECT COUNT(*) FROM registros WHERE edad > 50;

-- 2. Mostrar los pacientes ordenados por presión arterial de menor a mayor
SELECT * FROM registros ORDER BY presion_arterial ASC;

-- 3. Calcular la presión arterial promedio de pacientes menores de 45 años
SELECT AVG(presion_arterial) FROM registros WHERE edad < 45;

-- 4. Obtener el nombre y edad del paciente con menor presión arterial
SELECT nombre, edad FROM registros ORDER BY presion_arterial ASC LIMIT 1;
