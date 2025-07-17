-- PRÁCTICA 2: Modificación y eliminación de estructuras
-- Objetivo: Aprender a borrar y recrear tablas, así como a detectar y corregir errores comunes en SQL.

-- EJEMPLO 1 (Fácil): Eliminar y recrear tabla simple
DROP TABLE IF EXISTS alumnos;
CREATE TABLE alumnos (
    cod INTEGER,
    nombre VARCHAR(20)
);
INSERT INTO alumnos VALUES (1, 'Pepe'), (2, 'Ana');
SELECT * FROM alumnos;

-- EJEMPLO 2 (Fácil): Eliminar una tabla y verificar que no existe
DROP TABLE IF EXISTS materias;
CREATE TABLE materias (
    id INTEGER,
    nombre VARCHAR(50)
);
DROP TABLE materias;

-- EJEMPLO 3 (Intermedio): Uso de DROP con múltiples tablas
DROP TABLE IF EXISTS pacientes, medicos;
CREATE TABLE pacientes (id INTEGER, nombre TEXT);
CREATE TABLE medicos (id INTEGER, nombre TEXT);
DROP TABLE pacientes, medicos;

-- EJEMPLO 4 (Avanzado): Simulación de errores al insertar tipos no válidos o claves duplicadas
CREATE TABLE personas (
    dni VARCHAR(9) PRIMARY KEY,
    nombre TEXT
);
INSERT INTO personas VALUES ('12345678A', 'Carlos');
-- Este insert genera error por clave duplicada:
-- INSERT INTO personas VALUES ('12345678A', 'Marta');

-- EVALUACIÓN
-- 1. Crear y borrar una tabla llamada "region_sanitaria"
-- 2. Crear una tabla "equipos_medicos" e insertar dos filas
-- 3. Simular error al insertar duplicados con clave primaria
-- 4. Eliminar dos tablas al mismo tiempo usando DROP TABLE

-- EVALUACIÓN (con soluciones)
-- 1. Crear y borrar una tabla llamada "region_sanitaria"
CREATE TABLE region_sanitaria (
    id INTEGER,
    nombre TEXT
);
DROP TABLE region_sanitaria;

-- 2. Crear una tabla "equipos_medicos" e insertar dos filas
CREATE TABLE equipos_medicos (
    id INTEGER,
    descripcion TEXT
);
INSERT INTO equipos_medicos VALUES 
(1, 'Electrocardiógrafo'),
(2, 'Monitor multiparamétrico');

-- 3. Simular error al insertar duplicados con clave primaria
CREATE TABLE dispositivos (
    id INTEGER PRIMARY KEY,
    nombre TEXT
);
INSERT INTO dispositivos VALUES (1, 'ECG portátil');
-- La siguiente línea generará un error si se ejecuta:
-- INSERT INTO dispositivos VALUES (1, 'ECG fijo');

-- 4. Eliminar dos tablas al mismo tiempo usando DROP TABLE
DROP TABLE IF EXISTS equipos_medicos, dispositivos;
