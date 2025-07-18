# PRÁCTICA 2: Modificación y eliminación de estructuras
# Objetivo: Aprender a borrar y recrear tablas, así como a detectar y corregir errores comunes en R.

library(tidyverse)

# Crear tabla y eliminarla
alumnos <- tibble(
  cod = c(1, 2, 3),
  nombre = c("Pepe", "Ana", "Juan")
)
alumnos

rm(alumnos)

# Recrear la tabla
alumnos <- tibble(
  cod = c(1, 2, 3),
  nombre = c("Pepe", "Ana", "Juan")
)
alumnos

# Simulación de error comentada
# alumnos <- alumnos %>% add_row(cod = "x", nombre = 100)

# EVALUACIÓN (con soluciones)
region_sanitaria <- tibble(id = integer(), nombre = character())
rm(region_sanitaria)

equipos_medicos <- tibble(
  id = c(1, 2),
  descripcion = c("Electrocardiógrafo", "Monitor multiparamétrico")
)
equipos_medicos

dispositivos <- tibble(
  id = c(1),
  nombre = c("ECG portátil")
)
# dispositivos <- dispositivos %>% add_row(id = 1, nombre = "ECG fijo") # Error por clave duplicada
rm(equipos_medicos, dispositivos)
