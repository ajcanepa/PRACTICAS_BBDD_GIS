-- PRÁCTICA 1: Introducción a SQL y creación de tablas
-- Objetivo: Familiarizarse con la sintaxis básica de SQL para la creación de tablas, inserción de datos y consultas simples.
-- Contexto: Gestión de alumnos de una asignatura de Salud Pública.

-- EJEMPLO 1 (Fácil): Crear una tabla simple de alumnos
CREATE TABLE alumnos (
    cod INTEGER,
    nombre VARCHAR(20)
);

INSERT INTO alumnos VALUES 
(1, 'Pepe'), 
(2, 'Ana'), 
(3, 'Juan');

SELECT * FROM alumnos;

-- EJEMPLO 2 (Fácil): Crear tabla con otra estructura
CREATE TABLE materias (
    id INTEGER,
    nombre_materia VARCHAR(50)
);

INSERT INTO materias VALUES 
(1, 'Epidemiología'), 
(2, 'Estadística');

SELECT * FROM materias;

-- EJEMPLO 3 (Intermedio): Crear tabla con tipos variados y valores por defecto
CREATE TABLE profesionales_salud (
    dni VARCHAR(10),
    nombre VARCHAR(50),
    especialidad VARCHAR(50) DEFAULT 'General'
);

INSERT INTO profesionales_salud (dni, nombre) VALUES 
('12345678A', 'Dra. Marta'), 
('87654321B', 'Dr. Luis');

SELECT * FROM profesionales_salud;

-- EJEMPLO 4 (Avanzado): Crear tabla con restricciones
CREATE TABLE hospitales (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    capacidad INTEGER CHECK (capacidad > 0)
);

INSERT INTO hospitales (nombre, capacidad) VALUES 
('Hospital Central', 250),
('Clínica del Norte', 120);

SELECT * FROM hospitales;

-- EVALUACIÓN
-- 1. Crear una tabla "centros_salud" con columnas id (int), nombre (varchar), tipo (varchar)
-- 2. Insertar 3 registros ficticios en la tabla "centros_salud"
-- 3. Crear tabla "medicos" con clave primaria en columna "id"
-- 4. Insertar un médico con nombre y especialidad, y consultar toda la tabla

-- EVALUACIÓN (con soluciones)
-- 1. Crear una tabla "centros_salud" con columnas id (int), nombre (varchar), tipo (varchar)
CREATE TABLE centros_salud (
    id INTEGER,
    nombre VARCHAR(50),
    tipo VARCHAR(30)
);

-- 2. Insertar 3 registros ficticios en la tabla "centros_salud"
INSERT INTO centros_salud VALUES
(1, 'Centro de Salud Norte', 'Ambulatorio'),
(2, 'Hospital General', 'Hospitalario'),
(3, 'Clínica Familiar', 'Privado');

-- 3. Crear tabla "medicos" con clave primaria en columna "id"
CREATE TABLE medicos (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(50)
);

-- 4. Insertar un médico con nombre y especialidad, y consultar toda la tabla
INSERT INTO medicos VALUES (1, 'Dra. Susana', 'Pediatría');
SELECT * FROM medicos;
