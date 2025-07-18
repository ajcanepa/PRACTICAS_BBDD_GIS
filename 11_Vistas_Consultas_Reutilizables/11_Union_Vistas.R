# PRÁCTICA 11: UNION y Vistas
# Objetivo: Unir datasets y simular vistas
# Contexto: Combinar registros de pacientes de diferentes clínicas

library(tidyverse)

pacientes_A <- tibble(
  id = c(1, 2),
  nombre = c("Luis", "Ana"),
  origen = "Clínica A"
)

pacientes_B <- tibble(
  id = c(3, 4),
  nombre = c("Juan", "Marta"),
  origen = "Clínica B"
)

# UNION (sin duplicados)
pacientes_union <- bind_rows(pacientes_A, pacientes_B)
pacientes_union

# Vista: tabla derivada
vista_mayores <- pacientes_union %>% filter(nombre != "Ana")
vista_mayores
