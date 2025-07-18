# PRÁCTICA 3: Filtrado y condiciones lógicas
# Objetivo: Aplicar filtros a consultas mediante condiciones lógicas usando filter().
# Contexto: Datos de pacientes con variables clínicas.

library(tidyverse)

pacientes <- tibble(
  id = 1:5,
  nombre = c("Luis", "Marta", "Raul", "Laura", "Elena"),
  edad = c(45, 60, 50, 30, NA),
  fumador = c(TRUE, FALSE, TRUE, FALSE, FALSE),
  presion_arterial = c(135, 120, NA, 110, 115)
)
pacientes

# EJEMPLO 1: Pacientes mayores de 50 años
pacientes %>% filter(edad > 50)

# EJEMPLO 2: Fumadores con presión alta
pacientes %>% filter(fumador == TRUE & presion_arterial >= 130)

# EJEMPLO 3: Presión arterial ausente
pacientes %>% filter(is.na(presion_arterial))

# EJEMPLO 4: No fumadores o edad menor de 40
pacientes %>% filter(fumador == FALSE | edad < 40)

# EVALUACIÓN (con soluciones)
pacientes %>% filter(edad < 40)

pacientes %>% filter(fumador == TRUE & edad > 50)

pacientes %>% filter(presion_arterial >= 110 & presion_arterial <= 130)

pacientes %>% filter(is.na(edad) | is.na(presion_arterial))
