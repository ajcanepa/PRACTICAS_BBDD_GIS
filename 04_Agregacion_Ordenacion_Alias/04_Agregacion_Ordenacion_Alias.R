# PRÁCTICA 4: Agregación, ordenación y alias
# Objetivo: Utilizar funciones de agregación (n(), sum(), mean(), max(), min()), ordenar resultados con arrange() y aplicar alias con mutate().
# Contexto: Registro de pacientes con mediciones clínicas.

library(tidyverse)

# EJEMPLO 1 (Fácil): Calcular el número total de pacientes registrados
registros <- tibble(
  id = 1:4,
  nombre = c("Luis", "Marta", "Laura", "Iker"),
  edad = c(45, 60, 30, 40),
  presion_arterial = c(135, 120, 110, 130)
)

registros %>% summarise(total_pacientes = n())

# EJEMPLO 2 (Fácil): Calcular la media de edad de los pacientes
registros %>% summarise(edad_media = mean(edad))

# EJEMPLO 3 (Intermedio): Obtener el paciente con mayor presión arterial
registros %>%
  arrange(desc(presion_arterial)) %>%
  slice(1)

# EJEMPLO 4 (Avanzado): Obtener la edad media y presión media, agrupadas por tramos etarios
registros %>%
  mutate(grupo_edad = case_when(
    edad < 40 ~ "Menores de 40",
    edad >= 40 & edad <= 59 ~ "40-59",
    TRUE ~ "60 o más"
  )) %>%
  group_by(grupo_edad) %>%
  summarise(
    n = n(),
    media_presion = mean(presion_arterial, na.rm = TRUE)
  ) %>%
  arrange(grupo_edad)

# EVALUACIÓN (con soluciones)
registros %>% filter(edad > 50) %>% summarise(n = n())

registros %>% arrange(presion_arterial)

registros %>% filter(edad < 45) %>% summarise(prom_presion = mean(presion_arterial))

registros %>% arrange(presion_arterial) %>% slice(1) %>% select(nombre, edad)
