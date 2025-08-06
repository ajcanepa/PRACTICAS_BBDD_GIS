-- PRÁCTICA 7: Joins II – LEFT, RIGHT y FULL OUTER JOIN
-- Objetivo: Comprender las diferencias entre LEFT, RIGHT y FULL OUTER JOIN.
-- Contexto: Relación entre citas médicas y resultados de laboratorio.

-- EJEMPLO 1 (Fácil): LEFT JOIN para ver todas las citas, con o sin resultados
CREATE TABLE citas (
    id INTEGER PRIMARY KEY,
    paciente VARCHAR(50),
    fecha DATE
);

CREATE TABLE resultados (
    cita_id INTEGER,
    resultado TEXT
);

INSERT INTO citas VALUES (1, 'Luis', '2025-01-10'), (2, 'Ana', '2025-01-11'), (3, 'Marta', '2025-01-12');
INSERT INTO resultados VALUES (1, 'Normal'), (2, 'Alterado');

SELECT citas.paciente, resultados.resultado
FROM citas
LEFT JOIN resultados ON citas.id = resultados.cita_id;

-- EJEMPLO 2 (Fácil): RIGHT JOIN para ver todos los resultados aunque no haya cita
SELECT citas.paciente, resultados.resultado
FROM citas
RIGHT JOIN resultados ON citas.id = resultados.cita_id;

-- EJEMPLO 3 (Intermedio): FULL OUTER JOIN para ver citas y resultados completos
SELECT citas.paciente, resultados.resultado
FROM citas
FULL OUTER JOIN resultados ON citas.id = resultados.cita_id;

-- EJEMPLO 4 (Avanzado): Diferenciar casos con y sin resultado usando CASE
SELECT citas.paciente,
       CASE
         WHEN resultados.resultado IS NULL THEN 'Pendiente'
         ELSE resultados.resultado
       END AS estado
FROM citas
LEFT JOIN resultados ON citas.id = resultados.cita_id;

-- EVALUACIÓN (con soluciones)
-- 1. Mostrar todas las citas con o sin resultado
SELECT citas.*, resultados.resultado FROM citas LEFT JOIN resultados ON citas.id = resultados.cita_id;

-- 2. Mostrar resultados que no tienen cita asociada
SELECT resultados.* FROM resultados LEFT JOIN citas ON resultados.cita_id = citas.id WHERE citas.id IS NULL;

-- 3. Mostrar todos los registros posibles con FULL OUTER JOIN
SELECT * FROM citas FULL OUTER JOIN resultados ON citas.id = resultados.cita_id;

-- 4. Indicar si el resultado está pendiente o fue entregado
SELECT citas.paciente, COALESCE(resultados.resultado, 'Pendiente') AS estado
FROM citas
LEFT JOIN resultados ON citas.id = resultados.cita_id;
