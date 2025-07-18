# PRÁCTICA 9: Condicionales con CASE
# Objetivo: Re-codificar variables y construir condiciones complejas usando dplyr::case_when
# Contexto: Clasificación de pacientes por nivel de riesgo.

library(tidyverse)

# EJEMPLO 1 (Fácil): Clasificar pacientes por edad
pacientes <- tibble(
  id = c(1, 2, 3),
  nombre = c("Luis", "Marta", "Laura"),
  edad = c(45, 60, 30)
)

pacientes %>%
  mutate(grupo_edad = case_when(
    edad < 40 ~ "Joven",
    edad >= 40 & edad <= 59 ~ "Adulto",
    TRUE ~ "Mayor"
  )) %>%
  select(nombre, grupo_edad)

# EJEMPLO 2 (Fácil): Clasificación con ELSE
pacientes %>%
  mutate(riesgo = case_when(
    edad >= 60 ~ "Riesgo alto",
    TRUE ~ "Riesgo bajo"
  )) %>%
  select(nombre, riesgo)

# EJEMPLO 3 (Intermedio): Combinación de condiciones múltiples
pacientes %>%
  mutate(clasificacion = case_when(
    edad < 40 ~ "Joven",
    edad >= 40 & edad < 60 ~ "Adulto",
    TRUE ~ "Senior"
  )) %>%
  select(nombre, edad, clasificacion)

# EJEMPLO 4 (Avanzado): Clasificación condicional con datos externos
presiones <- tibble(
  paciente_id = c(1, 2, 3),
  sistolica = c(130, 145, 110)
)

pacientes %>%
  inner_join(presiones, by = c("id" = "paciente_id")) %>%
  mutate(nivel = case_when(
    sistolica < 120 ~ "Normal",
    sistolica >= 120 & sistolica <= 139 ~ "Prehipertensión",
    TRUE ~ "Hipertensión"
  )) %>%
  select(nombre, nivel)

# EVALUACIÓN (con soluciones)

# 1. Clasificar pacientes como 'Mayor de edad' o 'Menor de edad'
pacientes %>%
  mutate(categoria = if_else(edad >= 18, "Mayor", "Menor")) %>%
  select(nombre, categoria)

# 2. Clasificar sistólica en niveles
presiones %>%
  mutate(presion_cat = case_when(
    sistolica < 120 ~ "Normal",
    sistolica < 140 ~ "Elevada",
    TRUE ~ "Alta"
  )) %>%
  select(paciente_id, presion_cat)

# 3. Combinar edad y presión en clasificación
pacientes %>%
  inner_join(presiones, by = c("id" = "paciente_id")) %>%
  mutate(evaluacion = case_when(
    edad > 50 & sistolica > 140 ~ "Riesgo elevado",
    TRUE ~ "Riesgo moderado"
  )) %>%
  select(nombre, evaluacion)

# 4. Clasificación múltiple en SELECT
pacientes %>%
  mutate(grupo = case_when(
    edad < 30 ~ "Joven",
    edad < 60 ~ "Adulto",
    TRUE ~ "Mayor"
  )) %>%
  select(nombre, edad, grupo)
