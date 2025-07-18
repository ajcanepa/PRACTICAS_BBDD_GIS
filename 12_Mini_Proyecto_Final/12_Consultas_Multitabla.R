# PRÁCTICA 12: Consultas multitabla
# Objetivo: Ejecutar consultas complejas combinando múltiples fuentes
# Contexto: Relacionar pacientes, citas y tratamientos

library(tidyverse)

pacientes <- tibble(
  id = c(1, 2),
  nombre = c("Luis", "Ana")
)

citas <- tibble(
  id = c(101, 102),
  paciente_id = c(1, 2),
  fecha = c("2024-06-01", "2024-06-02")
)

tratamientos <- tibble(
  cita_id = c(101, 102),
  tratamiento = c("Fisioterapia", "Revisión general")
)

# Multijoin
pacientes %>%
  left_join(citas, by = c("id" = "paciente_id")) %>%
  left_join(tratamientos, by = c("id.y" = "cita_id"))
