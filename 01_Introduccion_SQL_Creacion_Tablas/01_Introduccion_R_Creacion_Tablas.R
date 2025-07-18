# PRÁCTICA 1: Introducción a R y creación de tablas con dplyr
# Objetivo: Familiarizarse con la sintaxis básica de R y dplyr para la creación de tablas, inserción de datos y consultas simples.
# Contexto: Gestión de alumnos de una asignatura de Salud Pública.

library(tidyverse)

# EJEMPLO 1 (Fácil): Crear una tabla simple de alumnos
alumnos <- tibble(
  cod = c(1, 2, 3),
  nombre = c("Pepe", "Ana", "Juan")
)
alumnos

# EJEMPLO 2 (Fácil): Crear tabla con otra estructura
materias <- tibble(
  id = c(1, 2),
  nombre_materia = c("Epidemiología", "Estadística")
)
materias

# EJEMPLO 3 (Intermedio): Crear tabla con tipos variados y valores por defecto simulados
profesionales_salud <- tibble(
  dni = c("12345678A", "87654321B"),
  nombre = c("Dra. Marta", "Dr. Luis"),
  especialidad = c("General", "General") # DEFAULT simulado
)
profesionales_salud

# EJEMPLO 4 (Avanzado): Crear tabla con restricciones simuladas
hospitales <- tibble(
  id = c(1, 2),
  nombre = c("Hospital Central", "Clínica del Norte"),
  capacidad = c(250, 120)
)
stopifnot(all(hospitales$capacidad > 0))
hospitales

# EVALUACIÓN (con soluciones)
centros_salud <- tibble(
  id = c(1, 2, 3),
  nombre = c("Centro de Salud Norte", "Hospital General", "Clínica Familiar"),
  tipo = c("Ambulatorio", "Hospitalario", "Privado")
)
centros_salud

medicos <- tibble(
  id = 1,
  nombre = "Dra. Susana",
  especialidad = "Pediatría"
)
medicos
