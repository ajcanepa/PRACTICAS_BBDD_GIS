-- PRÁCTICA 5: Agrupaciones y filtros sobre grupos
-- Objetivo: Aprender a agrupar datos con GROUP BY y a filtrar grupos con HAVING.
-- Contexto: Análisis de consultas médicas por especialidad.

-- EJEMPLO 1 (Fácil): Total de consultas por especialidad
CREATE TABLE consultas (
    id SERIAL PRIMARY KEY,
    especialidad VARCHAR(30),
    medico VARCHAR(50),
    paciente VARCHAR(50)
);

INSERT INTO consultas (especialidad, medico, paciente) VALUES
('Pediatría', 'Dra. Ana', 'Luis'),
('Pediatría', 'Dra. Ana', 'Elena'),
('Cardiología', 'Dr. Juan', 'Carlos'),
('Cardiología', 'Dr. Juan', 'Pepe'),
('Cardiología', 'Dr. Juan', 'Marta');

SELECT especialidad, COUNT(*) AS total_consultas
FROM consultas
GROUP BY especialidad;

-- EJEMPLO 2 (Fácil): Número de médicos por especialidad
SELECT especialidad, COUNT(DISTINCT medico) AS medicos_unicos
FROM consultas
GROUP BY especialidad;

-- EJEMPLO 3 (Intermedio): Especialidades con más de 2 consultas
SELECT especialidad, COUNT(*) AS total
FROM consultas
GROUP BY especialidad
HAVING COUNT(*) > 2;

-- EJEMPLO 4 (Avanzado): Médicos con más de una consulta por especialidad
SELECT especialidad, medico, COUNT(*) AS total
FROM consultas
GROUP BY especialidad, medico
HAVING COUNT(*) > 1;

-- EVALUACIÓN (con soluciones)
-- 1. Contar el número de pacientes atendidos por cada médico
SELECT medico, COUNT(DISTINCT paciente) FROM consultas GROUP BY medico;

-- 2. Listar especialidades con al menos 2 médicos distintos
SELECT especialidad FROM consultas GROUP BY especialidad HAVING COUNT(DISTINCT medico) >= 2;

-- 3. Agrupar por médico y mostrar total de consultas
SELECT medico, COUNT(*) FROM consultas GROUP BY medico;

-- 4. Obtener médico y especialidad con más de 2 consultas
SELECT especialidad, medico, COUNT(*) 
FROM consultas 
GROUP BY especialidad, medico 
HAVING COUNT(*) > 2;
