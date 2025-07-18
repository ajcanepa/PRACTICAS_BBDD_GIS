# PRÁCTICA 10: Creación de tablas desde select
# Objetivo: Crear nuevos data frames a partir de filtros y transformaciones
# Contexto: Selección de pacientes de alto riesgo

library(tidyverse)

pacientes <- tibble(
  id = 1:5,
  nombre = c("Luis", "Ana", "Marta", "Pepe", "Laura"),
  edad = c(65, 30, 45, 70, 55),
  riesgo = c("alto", "bajo", "alto", "medio", "alto")
)

# Crear una tabla con pacientes de alto riesgo
alto_riesgo <- pacientes %>% filter(riesgo == "alto")
alto_riesgo
