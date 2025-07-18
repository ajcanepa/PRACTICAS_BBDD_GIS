# PRÁCTICA 1: Introducción a R y creación de tablas con dplyr
# Objetivo: Crear tibbles, añadir registros y visualizar datos simples
library(tidyverse)

# Limpiamos el entorno
rm(list = ls())

# Creamos una tabla vacía
alumnos <- tibble(cod = numeric(), nombre = character())
alumnos

# Ejemplo 1: Añadir registros individualmente
alumnos <- alumnos %>%
  add_row(cod = 1, nombre = 'Pepe') %>%
  add_row(cod = 2, nombre = 'Ana') %>%
  add_row(cod = 3, nombre = 'Juan')
alumnos

# Ejemplo 2: Crear tabla directamente con datos
alumnos <- tibble(
  cod = c(1, 2, 3),
  nombre = c('Pepe', 'Ana', 'Juan')
)
alumnos

# Ejemplo 3: Mostrar la tabla completa (equivalente a SELECT *)
print(alumnos)

# Ejemplo 4: Reiniciar tabla y añadir con múltiples columnas
rm(alumnos)
alumnos <- tibble(cod = numeric(), nombre = character(), ciudad = character())
alumnos <- alumnos %>%
  add_row(cod = 1, nombre = 'Pepe', ciudad = NA) %>%
  add_row(cod = 2, nombre = 'Ana', ciudad = 'León') %>%
  add_row(cod = 3, nombre = 'Juan', ciudad = 'Burgos')
alumnos
