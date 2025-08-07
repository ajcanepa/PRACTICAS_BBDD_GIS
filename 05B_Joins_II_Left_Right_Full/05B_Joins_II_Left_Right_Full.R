# PRÁCTICA 5B: Joins II – LEFT, RIGHT y FULL OUTER JOIN
# Objetivo: Comprender las diferencias entre LEFT, RIGHT y FULL OUTER JOIN.
# Contexto: Relación entre citas médicas y resultados de laboratorio.

library(dplyr)

# EJEMPLO 1 (Fácil): LEFT JOIN para ver todas las citas, con o sin resultados
# CREATE TABLE citas
citas <- data.frame(
  id = c(1L, 2L, 3L),
  paciente = c('Luis', 'Ana', 'Marta'),
  fecha = as.Date(c('2025-01-10', '2025-01-11', '2025-01-12'))
)

# CREATE TABLE resultados
resultados <- data.frame(
  cita_id = c(1L, 2L),
  resultado = c('Normal', 'Alterado')
)

# SELECT citas.paciente, resultados.resultado FROM citas LEFT JOIN resultados
citas %>%
  left_join(resultados, by = c("id" = "cita_id")) %>%
  select(paciente, resultado)

# EJEMPLO 2 (Fácil): RIGHT JOIN para ver todos los resultados aunque no haya cita
# SELECT citas.paciente, resultados.resultado FROM citas RIGHT JOIN resultados
citas %>%
  right_join(resultados, by = c("id" = "cita_id")) %>%
  select(paciente, resultado)

# EJEMPLO 3 (Intermedio): FULL OUTER JOIN para ver citas y resultados completos
# SELECT citas.paciente, resultados.resultado FROM citas FULL OUTER JOIN resultados
citas %>%
  full_join(resultados, by = c("id" = "cita_id")) %>%
  select(paciente, resultado)

# EJEMPLO 4 (Avanzado): Diferenciar casos con y sin resultado usando CASE
# SELECT citas.paciente, CASE WHEN resultados.resultado IS NULL THEN 'Pendiente' ELSE resultados.resultado END AS estado
citas %>%
  left_join(resultados, by = c("id" = "cita_id")) %>%
  mutate(estado = case_when(
    is.na(resultado) ~ 'Pendiente',
    TRUE ~ resultado
  )) %>%
  select(paciente, estado)

# EVALUACIÓN (con soluciones)
# 1. Mostrar todas las citas con o sin resultado
# SELECT citas.*, resultados.resultado FROM citas LEFT JOIN resultados
citas %>%
  left_join(resultados, by = c("id" = "cita_id"))

# 2. Mostrar resultados que no tienen cita asociada
# SELECT resultados.* FROM resultados LEFT JOIN citas WHERE citas.id IS NULL
resultados %>%
  left_join(citas, by = c("cita_id" = "id")) %>%
  filter(is.na(id)) %>%
  select(cita_id, resultado)

# 3. Mostrar todos los registros posibles con FULL OUTER JOIN
# SELECT * FROM citas FULL OUTER JOIN resultados
citas %>%
  full_join(resultados, by = c("id" = "cita_id"))

# 4. Indicar si el resultado está pendiente o fue entregado
# SELECT citas.paciente, COALESCE(resultados.resultado, 'Pendiente') AS estado
citas %>%
  left_join(resultados, by = c("id" = "cita_id")) %>%
  mutate(estado = coalesce(resultado, 'Pendiente')) %>%
  select(paciente, estado)