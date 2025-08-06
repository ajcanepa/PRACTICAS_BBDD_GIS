# PRÁCTICA 7: JOINS II – LEFT, RIGHT, FULL
# Objetivo: Comprender LEFT JOIN, RIGHT JOIN y FULL JOIN usando dplyr
# Contexto: Relación entre pacientes y visitas clínicas

library(tidyverse)

pacientes <- tibble(
  id = c(1, 2, 3, 4),
  nombre = c("Luis", "Marta", "Carlos", "Ana")
)

visitas <- tibble(
  paciente_id = c(1, 2, 5),
  fecha = c("2024-01-01", "2024-01-03", "2024-01-05")
)

# LEFT JOIN
left_join(pacientes, visitas, by = c("id" = "paciente_id"))

# RIGHT JOIN (simulado)
right_join(pacientes, visitas, by = c("id" = "paciente_id"))

# FULL JOIN
full_join(pacientes, visitas, by = c("id" = "paciente_id"))
