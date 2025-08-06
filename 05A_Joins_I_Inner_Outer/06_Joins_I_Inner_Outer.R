# PRÁCTICA 6: Joins I – INNER y OUTER JOIN
# Objetivo: Usar inner_join() y left_join() para combinar tablas.
# Contexto: Relación entre pacientes y sus médicos asignados.

library(tidyverse)

pacientes <- tibble(
  id = c(1, 2, 3),
  nombre = c("Luis", "Elena", "Carlos"),
  medico_id = c(1, 2, NA)
)

medicos <- tibble(
  id = c(1, 2),
  nombre = c("Dr. Juan", "Dra. Marta")
)

# INNER JOIN
pacientes %>%
  inner_join(medicos, by = c("medico_id" = "id")) %>%
  select(paciente = nombre.x, medico = nombre.y)

# LEFT JOIN
pacientes %>%
  left_join(medicos, by = c("medico_id" = "id")) %>%
  select(paciente = nombre.x, medico = nombre.y)

# RIGHT JOIN (simulado con full_join + filtro)
medicos %>%
  full_join(pacientes, by = c("id" = "medico_id")) %>%
  filter(is.na(nombre.y) | !is.na(nombre.x)) %>%
  select(paciente = nombre.y, medico = nombre.x)

# COALESCE
pacientes %>%
  left_join(medicos, by = c("medico_id" = "id")) %>%
  mutate(medico = coalesce(nombre.y, "Sin asignar")) %>%
  select(paciente = nombre.x, medico)
