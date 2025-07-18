-- PRÁCTICA 11: Vistas y consultas reutilizables
-- Objetivo: Crear y consultar vistas para simplificar consultas complejas.
-- Contexto: Resumen de atención médica.

-- EJEMPLO 1 (Fácil): Crear vista con pacientes mayores de 50
CREATE TABLE pacientes (
    id INTEGER,
    nombre TEXT,
    edad INTEGER
);

INSERT INTO pacientes VALUES (1, 'Luis', 45), (2, 'Marta', 60), (3, 'Laura', 30);

CREATE VIEW mayores_50 AS
SELECT * FROM pacientes WHERE edad > 50;

SELECT * FROM mayores_50;

-- EJEMPLO 2 (Fácil): Vista con campos renombrados
CREATE VIEW pacientes_renombrado AS
SELECT nombre AS paciente, edad AS años FROM pacientes;

-- EJEMPLO 3 (Intermedio): Vista que incluye función agregada
CREATE TABLE consultas (
    id INTEGER,
    paciente_id INTEGER,
    motivo TEXT
);

INSERT INTO consultas VALUES (1, 1, 'Chequeo'), (2, 2, 'Dolor'), (3, 2, 'Seguimiento');

CREATE VIEW consultas_por_paciente AS
SELECT paciente_id, COUNT(*) AS total_consultas
FROM consultas
GROUP BY paciente_id;

-- EJEMPLO 4 (Avanzado): Vista con JOIN entre tablas
CREATE VIEW resumen_atencion AS
SELECT p.nombre, c.motivo
FROM pacientes p
JOIN consultas c ON p.id = c.paciente_id;

-- EVALUACIÓN (con soluciones)
-- 1. Crear vista con pacientes menores de 40
CREATE VIEW menores_40 AS SELECT * FROM pacientes WHERE edad < 40;

-- 2. Crear vista de número de consultas por paciente
CREATE VIEW total_consultas AS 
SELECT paciente_id, COUNT(*) FROM consultas GROUP BY paciente_id;

-- 3. Crear vista con nombre y número total de consultas
CREATE VIEW nombre_consultas AS
SELECT p.nombre, COUNT(c.id)
FROM pacientes p
JOIN consultas c ON p.id = c.paciente_id
GROUP BY p.nombre;

-- 4. Consultar la vista mayores_50
SELECT * FROM mayores_50;
