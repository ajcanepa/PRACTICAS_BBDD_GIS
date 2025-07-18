# PRÁCTICA 8: Subconsultas
# Objetivo: Simular subconsultas con filtros encadenados en R
# Contexto: Consultas anidadas sobre indicadores clínicos

library(tidyverse)

pacientes <- tibble(
  id = 1:5,
  nombre = c("Luis", "Ana", "Juan", "Marta", "Carlos"),
  edad = c(34, 45, 50, 29, 65),
  presion = c(120, 130, 128, 140, 125)
)

# Ejemplo: promedio de presión de los pacientes mayores de 40
pacientes %>%
  filter(edad > 40) %>%
  summarise(prom_presion = mean(presion))

# Subconsulta simulada: pacientes con presión superior a la media general
media_presion <- mean(pacientes$presion)
pacientes %>% filter(presion > media_presion)
