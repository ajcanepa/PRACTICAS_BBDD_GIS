# PRÁCTICA 5: Agrupaciones y filtros sobre grupos
# Objetivo: Agrupar datos con group_by() y filtrar grupos con filter() y summarise().
# Contexto: Análisis de consultas médicas por especialidad.

library(tidyverse)

# Datos
consultas <- tibble(
  id = 1:5,
  especialidad = c("Pediatría", "Pediatría", "Cardiología", "Cardiología", "Cardiología"),
  medico = c("Dra. Ana", "Dra. Ana", "Dr. Juan", "Dr. Juan", "Dr. Juan"),
  paciente = c("Luis", "Elena", "Carlos", "Pepe", "Marta")
)

# EJEMPLO 1
consultas %>%
  group_by(especialidad) %>%
  summarise(total_consultas = n())

# EJEMPLO 2
consultas %>%
  group_by(especialidad) %>%
  summarise(medicos_unicos = n_distinct(medico))

# EJEMPLO 3
consultas %>%
  group_by(especialidad) %>%
  summarise(total = n()) %>%
  filter(total > 2)

# EJEMPLO 4
consultas %>%
  group_by(especialidad, medico) %>%
  summarise(total = n()) %>%
  filter(total > 1)

# EVALUACIÓN
consultas %>% group_by(medico) %>% summarise(pacientes_unicos = n_distinct(paciente))

consultas %>% group_by(especialidad) %>% summarise(n = n_distinct(medico)) %>% filter(n >= 2)

consultas %>% group_by(medico) %>% summarise(n = n())

consultas %>% group_by(especialidad, medico) %>% summarise(n = n()) %>% filter(n > 2)
