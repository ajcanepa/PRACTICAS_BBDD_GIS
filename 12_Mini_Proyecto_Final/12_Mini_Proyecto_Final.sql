-- PRÁCTICA 12: Mini-proyecto final aplicado
-- Objetivo: Integrar conceptos vistos a lo largo del curso en una consulta biomédica completa.
-- Contexto: Análisis de datos de atención primaria.

-- EJEMPLO 1 (Fácil): Crear tablas base
CREATE TABLE pacientes (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER
);

CREATE TABLE consultas (
    id INTEGER,
    paciente_id INTEGER,
    motivo TEXT,
    fecha DATE
);

INSERT INTO pacientes VALUES (1, 'Luis', 45), (2, 'Ana', 60), (3, 'Laura', 30);
INSERT INTO consultas VALUES 
(1, 1, 'Chequeo', '2024-10-01'), 
(2, 2, 'Dolor', '2024-10-03'),
(3, 1, 'Seguimiento', '2024-11-01');

-- EJEMPLO 2 (Fácil): Ver pacientes con más de una consulta
SELECT paciente_id, COUNT(*) 
FROM consultas 
GROUP BY paciente_id 
HAVING COUNT(*) > 1;

-- EJEMPLO 3 (Intermedio): Consultas por mes
SELECT EXTRACT(MONTH FROM fecha) AS mes, COUNT(*) 
FROM consultas 
GROUP BY mes;

-- EJEMPLO 4 (Avanzado): JOIN y CASE para clasificar pacientes por edad y actividad
SELECT p.nombre,
       CASE 
         WHEN edad < 40 THEN 'Joven'
         WHEN edad < 60 THEN 'Adulto'
         ELSE 'Mayor'
       END AS grupo_edad,
       COUNT(c.id) AS num_consultas
FROM pacientes p
LEFT JOIN consultas c ON p.id = c.paciente_id
GROUP BY p.nombre, grupo_edad;

-- EVALUACIÓN (con soluciones)
-- 1. Crear tabla enfermedades y relacionarla con pacientes
CREATE TABLE enfermedades (
    id INTEGER,
    paciente_id INTEGER,
    diagnostico TEXT
);

-- 2. Insertar enfermedades para 2 pacientes
INSERT INTO enfermedades VALUES (1, 1, 'HTA'), (2, 2, 'Diabetes');

-- 3. JOIN para mostrar nombre y diagnóstico
SELECT p.nombre, e.diagnostico
FROM pacientes p
JOIN enfermedades e ON p.id = e.paciente_id;

-- 4. Vista resumen general
CREATE VIEW resumen_general AS
SELECT p.nombre, COUNT(c.id) AS total_consultas
FROM pacientes p
LEFT JOIN consultas c ON p.id = c.paciente_id
GROUP BY p.nombre;
