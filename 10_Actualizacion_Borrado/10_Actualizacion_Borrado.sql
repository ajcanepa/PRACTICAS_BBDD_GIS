-- PRÁCTICA 10: Operaciones completas de DDL y DML
-- Objetivo: Dominar INSERT, UPDATE, DELETE y modificaciones de estructura (ALTER TABLE, DROP)

-- =====================================================
-- PARTE I: CREACIÓN Y INSERCIÓN DE DATOS (INSERT)
-- =====================================================

-- EJEMPLO 1 (Básico): Crear tabla y insertar datos individuales
CREATE TABLE pacientes (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    edad INTEGER,
    email TEXT,
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- Inserción individual
INSERT INTO pacientes (id, nombre, edad, email) VALUES (1, 'Luis', 45, 'luis@email.com');

-- Inserción múltiple
INSERT INTO pacientes (id, nombre, edad, email) VALUES 
    (2, 'Ana', 50, 'ana@email.com'),
    (3, 'Carlos', 60, 'carlos@email.com'),
    (4, 'Marta', 35, 'marta@email.com');

-- EJEMPLO 2 (Intermedio): Insertar con valores NULL y DEFAULT
INSERT INTO pacientes (id, nombre, edad) VALUES (5, 'Pedro', NULL);
INSERT INTO pacientes (id, nombre, edad, email) VALUES (6, 'Sofia', 28, NULL);

-- =====================================================
-- PARTE II: MODIFICACIÓN DE ESTRUCTURA (ALTER TABLE)
-- =====================================================

-- EJEMPLO 3 (Intermedio): Agregar columnas nuevas
ALTER TABLE pacientes ADD COLUMN telefono TEXT;
ALTER TABLE pacientes ADD COLUMN activo BOOLEAN DEFAULT TRUE;

-- EJEMPLO 4 (Intermedio): Modificar tipo de columna (sintaxis puede variar por SGBD)
ALTER TABLE pacientes ALTER COLUMN email TYPE VARCHAR(100); -- PostgreSQL

-- EJEMPLO 5 (Avanzado): Agregar restricciones
ALTER TABLE pacientes ADD CONSTRAINT chk_edad CHECK (edad >= 0 AND edad <= 120);

-- =====================================================
-- PARTE III: ACTUALIZACIÓN DE DATOS (UPDATE)
-- =====================================================

-- EJEMPLO 6 (Fácil): Actualizar un campo específico
UPDATE pacientes SET edad = 46 WHERE nombre = 'Luis';

-- EJEMPLO 7 (Intermedio): Actualizar múltiples campos
UPDATE pacientes 
SET telefono = '123-456-7890', 
    email = 'luis.nuevo@email.com' 
WHERE id = 1;

-- EJEMPLO 8 (Intermedio): Actualización condicional con operaciones aritméticas
UPDATE pacientes SET edad = edad + 1 WHERE edad > 50 AND edad IS NOT NULL;

-- EJEMPLO 9 (Avanzado): Actualización usando CASE
UPDATE pacientes 
SET activo = CASE 
    WHEN edad IS NULL OR edad < 18 THEN FALSE
    WHEN edad >= 65 THEN FALSE
    ELSE TRUE
END;

-- EJEMPLO 10 (Avanzado): Actualización masiva con subconsulta
-- Primero creamos una tabla auxiliar
CREATE TABLE ajustes_edad (
    paciente_id INTEGER,
    ajuste INTEGER
);
INSERT INTO ajustes_edad VALUES (1, 2), (2, -1), (3, 3);

-- Actualización usando subconsulta
UPDATE pacientes 
SET edad = edad + (SELECT ajuste FROM ajustes_edad WHERE ajustes_edad.paciente_id = pacientes.id)
WHERE id IN (SELECT paciente_id FROM ajustes_edad);

-- =====================================================
-- PARTE IV: ELIMINACIÓN DE DATOS (DELETE)
-- =====================================================

-- EJEMPLO 11 (Fácil): Eliminar un registro específico
DELETE FROM pacientes WHERE nombre = 'Carlos';

-- EJEMPLO 12 (Intermedio): Eliminar con múltiples condiciones
DELETE FROM pacientes WHERE edad IS NULL OR edad < 0;

-- EJEMPLO 13 (Intermedio): Eliminar usando subconsulta
DELETE FROM pacientes 
WHERE id IN (SELECT paciente_id FROM ajustes_edad WHERE ajuste < 0);

-- EJEMPLO 14 (Avanzado): Eliminar duplicados (manteniendo el más reciente)
-- Primero insertamos duplicados para demostrar
INSERT INTO pacientes (id, nombre, edad, email) VALUES (7, 'Ana', 51, 'ana.duplicada@email.com');

-- Eliminar duplicados por nombre, manteniendo el ID mayor
DELETE FROM pacientes p1 
WHERE EXISTS (
    SELECT 1 FROM pacientes p2 
    WHERE p2.nombre = p1.nombre 
    AND p2.id > p1.id
);

-- =====================================================
-- PARTE V: ELIMINACIÓN DE ESTRUCTURA (DROP)
-- =====================================================

-- EJEMPLO 15 (Intermedio): Eliminar columnas
ALTER TABLE pacientes DROP COLUMN telefono;

-- EJEMPLO 16 (Avanzado): Eliminar restricciones
ALTER TABLE pacientes DROP CONSTRAINT chk_edad;

-- EJEMPLO 17 (Básico): Eliminar tabla auxiliar
DROP TABLE ajustes_edad;

-- =====================================================
-- PARTE VI: OPERACIONES COMBINADAS AVANZADAS
-- =====================================================

-- EJEMPLO 18 (Avanzado): UPSERT usando INSERT con ON CONFLICT (PostgreSQL)
-- INSERT INTO pacientes (id, nombre, edad, email) VALUES (2, 'Ana', 52, 'ana.actualizada@email.com')
-- ON CONFLICT (id) DO UPDATE SET edad = EXCLUDED.edad, email = EXCLUDED.email;

-- EJEMPLO 19 (Avanzado): UPDATE con JOIN (crear tabla relacionada primero)
CREATE TABLE historiales (
    id INTEGER PRIMARY KEY,
    paciente_id INTEGER,
    diagnostico TEXT,
    fecha_consulta DATE
);

INSERT INTO historiales VALUES 
    (1, 1, 'Hipertensión', '2025-01-15'),
    (2, 2, 'Diabetes', '2025-01-16'),
    (3, 4, 'Obesidad', '2025-01-17');

-- Marcar como inactivos los pacientes con diagnósticos graves
UPDATE pacientes 
SET activo = FALSE 
WHERE id IN (
    SELECT paciente_id FROM historiales 
    WHERE diagnostico IN ('Hipertensión', 'Diabetes')
);

-- =====================================================
-- EVALUACIÓN PRÁCTICA (con soluciones)
-- =====================================================

-- 1. (Básico) Insertar un nuevo paciente con todos los campos
INSERT INTO pacientes (id, nombre, edad, email, activo) 
VALUES (8, 'Roberto', 42, 'roberto@email.com', TRUE);

-- 2. (Intermedio) Agregar una columna 'genero' con valor por defecto
ALTER TABLE pacientes ADD COLUMN genero CHAR(1) DEFAULT 'M';

-- 3. (Intermedio) Actualizar el email de todos los pacientes mayores de 45 años
UPDATE pacientes 
SET email = CONCAT(LOWER(nombre), '.senior@clinica.com') 
WHERE edad > 45 AND edad IS NOT NULL;

-- 4. (Avanzado) Actualizar la edad sumando 1 solo a pacientes activos con email válido
UPDATE pacientes 
SET edad = edad + 1 
WHERE activo = TRUE 
AND email IS NOT NULL 
AND email LIKE '%@%'
AND edad IS NOT NULL;

-- 5. (Básico) Eliminar pacientes inactivos sin historial médico
DELETE FROM pacientes 
WHERE activo = FALSE 
AND id NOT IN (SELECT DISTINCT paciente_id FROM historiales WHERE paciente_id IS NOT NULL);

-- 6. (Intermedio) Eliminar columna genero recién creada
ALTER TABLE pacientes DROP COLUMN genero;

-- 7. (Avanzado) Crear una vista y luego eliminarla
CREATE VIEW pacientes_activos AS 
SELECT id, nombre, edad, email 
FROM pacientes 
WHERE activo = TRUE;

DROP VIEW pacientes_activos;

-- 8. (Experto) Transacción completa con rollback en caso de error
BEGIN TRANSACTION;
    -- Intentar actualizar edad
    UPDATE pacientes SET edad = edad + 5 WHERE nombre = 'Luis';
    -- Verificar que no hay edades inválidas
    SELECT COUNT(*) as edades_invalidas FROM pacientes WHERE edad > 120 OR edad < 0;
    -- Si hay problemas, hacer ROLLBACK; si no, COMMIT;
COMMIT;

-- =====================================================
-- LIMPIEZA FINAL (opcional)
-- =====================================================
-- Para limpiar todo después de la práctica:
-- DROP TABLE historiales;
-- DROP TABLE pacientes;