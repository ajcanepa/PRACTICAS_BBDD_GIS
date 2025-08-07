# PRÁCTICA 10: Operaciones completas de manipulación de datos en R
# Objetivo: Dominar add_row, mutate, filter, select y modificaciones de estructura

library(dplyr)
library(tibble)
library(lubridate)

# =====================================================
# PARTE I: CREACIÓN Y INSERCIÓN DE DATOS (equivalente a INSERT)
# =====================================================

# EJEMPLO 1 (Básico): Crear data frame y agregar datos individuales
# CREATE TABLE pacientes + INSERT individual
pacientes <- tibble(
  id = integer(),
  nombre = character(),
  edad = integer(),
  email = character(),
  fecha_registro = as.Date(character())
)

# Inserción individual (equivalente a INSERT)
pacientes <- pacientes %>%
  add_row(id = 1, nombre = 'Luis', edad = 45, email = 'luis@email.com', fecha_registro = Sys.Date())

# Inserción múltiple (equivalente a INSERT múltiple)
nuevos_pacientes <- tibble(
  id = c(2, 3, 4),
  nombre = c('Ana', 'Carlos', 'Marta'),
  edad = c(50, 60, 35),
  email = c('ana@email.com', 'carlos@email.com', 'marta@email.com'),
  fecha_registro = Sys.Date()
)

pacientes <- pacientes %>%
  bind_rows(nuevos_pacientes)

# EJEMPLO 2 (Intermedio): Insertar con valores NULL y DEFAULT
# INSERT con NULL y DEFAULT
pacientes <- pacientes %>%
  add_row(id = 5, nombre = 'Pedro', edad = NA_integer_, email = NA_character_, fecha_registro = Sys.Date()) %>%
  add_row(id = 6, nombre = 'Sofia', edad = 28, email = NA_character_, fecha_registro = Sys.Date())

# =====================================================
# PARTE II: MODIFICACIÓN DE ESTRUCTURA (equivalente a ALTER TABLE)
# =====================================================

# EJEMPLO 3 (Intermedio): Agregar columnas nuevas
# ALTER TABLE ADD COLUMN
pacientes <- pacientes %>%
  mutate(
    telefono = NA_character_,
    activo = TRUE  # DEFAULT TRUE
  )

# EJEMPLO 4 (Intermedio): Modificar tipo de columna
# ALTER TABLE MODIFY COLUMN (conversión de tipos)
pacientes <- pacientes %>%
  mutate(email = as.character(email))  # Asegurar que email es character

# EJEMPLO 5 (Avanzado): Agregar restricciones (validación manual en R)
# ALTER TABLE ADD CONSTRAINT CHECK
validar_edad <- function(df) {
  if(any(!is.na(df$edad) & (df$edad < 0 | df$edad > 120))) {
    stop("Error: Edad debe estar entre 0 y 120 años")
  }
  return(df)
}

pacientes <- validar_edad(pacientes)

# =====================================================
# PARTE III: ACTUALIZACIÓN DE DATOS (equivalente a UPDATE)
# =====================================================

# EJEMPLO 6 (Fácil): Actualizar un campo específico
# UPDATE SET WHERE
pacientes <- pacientes %>%
  mutate(edad = ifelse(nombre == 'Luis', 46, edad))

# EJEMPLO 7 (Intermedio): Actualizar múltiples campos
# UPDATE múltiples campos WHERE
pacientes <- pacientes %>%
  mutate(
    telefono = ifelse(id == 1, '123-456-7890', telefono),
    email = ifelse(id == 1, 'luis.nuevo@email.com', email)
  )

# EJEMPLO 8 (Intermedio): Actualización condicional con operaciones aritméticas
# UPDATE con operaciones aritméticas
pacientes <- pacientes %>%
  mutate(edad = ifelse(!is.na(edad) & edad > 50, edad + 1, edad))

# EJEMPLO 9 (Avanzado): Actualización usando CASE
# UPDATE con CASE
pacientes <- pacientes %>%
  mutate(activo = case_when(
    is.na(edad) | edad < 18 ~ FALSE,
    edad >= 65 ~ FALSE,
    TRUE ~ TRUE
  ))

# EJEMPLO 10 (Avanzado): Actualización masiva con join
# UPDATE con subconsulta - crear tabla auxiliar primero
ajustes_edad <- tibble(
  paciente_id = c(1, 2, 3),
  ajuste = c(2, -1, 3)
)

# UPDATE usando left_join
pacientes <- pacientes %>%
  left_join(ajustes_edad, by = c("id" = "paciente_id")) %>%
  mutate(edad = ifelse(!is.na(ajuste), edad + ajuste, edad)) %>%
  select(-ajuste)

# =====================================================
# PARTE IV: ELIMINACIÓN DE DATOS (equivalente a DELETE)
# =====================================================

# EJEMPLO 11 (Fácil): Eliminar un registro específico
# DELETE WHERE
pacientes <- pacientes %>%
  filter(nombre != 'Carlos')

# EJEMPLO 12 (Intermedio): Eliminar con múltiples condiciones
# DELETE con OR
pacientes <- pacientes %>%
  filter(!(is.na(edad) | (!is.na(edad) & edad < 0)))

# EJEMPLO 13 (Intermedio): Eliminar usando anti_join (equivalente a subconsulta)
# DELETE usando subconsulta
ajustes_negativos <- ajustes_edad %>% filter(ajuste < 0)
pacientes <- pacientes %>%
  anti_join(ajustes_negativos, by = c("id" = "paciente_id"))

# EJEMPLO 14 (Avanzado): Eliminar duplicados (manteniendo el más reciente)
# Primero insertamos duplicados para demostrar
pacientes <- pacientes %>%
  add_row(id = 7, nombre = 'Ana', edad = 51, email = 'ana.duplicada@email.com', 
          fecha_registro = Sys.Date(), telefono = NA_character_, activo = TRUE)

# DELETE duplicados manteniendo el ID mayor
pacientes <- pacientes %>%
  group_by(nombre) %>%
  filter(id == max(id)) %>%
  ungroup()

# =====================================================
# PARTE V: ELIMINACIÓN DE ESTRUCTURA (equivalente a DROP)
# =====================================================

# EJEMPLO 15 (Intermedio): Eliminar columnas
# ALTER TABLE DROP COLUMN
pacientes <- pacientes %>%
  select(-telefono)

# EJEMPLO 16 (Avanzado): Eliminar restricciones (remover validación)
# ALTER TABLE DROP CONSTRAINT - simplemente no aplicar validación

# EJEMPLO 17 (Básico): Eliminar objeto (equivalente a DROP TABLE)
# DROP TABLE
rm(ajustes_edad)

# =====================================================
# PARTE VI: OPERACIONES COMBINADAS AVANZADAS
# =====================================================

# EJEMPLO 18 (Avanzado): UPSERT usando rows_upsert
# INSERT con ON CONFLICT DO UPDATE
pacientes <- pacientes %>%
  rows_upsert(
    tibble(id = 2, nombre = 'Ana', edad = 52, email = 'ana.actualizada@email.com',
           fecha_registro = Sys.Date(), activo = TRUE),
    by = "id"
  )

# EJEMPLO 19 (Avanzado): UPDATE con JOIN - crear tabla relacionada primero
# Crear tabla historiales
historiales <- tibble(
  id = c(1, 2, 3),
  paciente_id = c(1, 2, 4),
  diagnostico = c('Hipertensión', 'Diabetes', 'Obesidad'),
  fecha_consulta = as.Date(c('2025-01-15', '2025-01-16', '2025-01-17'))
)

# UPDATE con JOIN - marcar como inactivos los pacientes con diagnósticos graves
pacientes_graves <- historiales %>%
  filter(diagnostico %in% c('Hipertensión', 'Diabetes')) %>%
  distinct(paciente_id)

pacientes <- pacientes %>%
  mutate(activo = ifelse(id %in% pacientes_graves$paciente_id, FALSE, activo))

# =====================================================
# EVALUACIÓN PRÁCTICA (con soluciones)
# =====================================================

# 1. (Básico) Insertar un nuevo paciente con todos los campos
# INSERT completo
pacientes <- pacientes %>%
  add_row(id = 8, nombre = 'Roberto', edad = 42, email = 'roberto@email.com', 
          fecha_registro = Sys.Date(), activo = TRUE)

# 2. (Intermedio) Agregar una columna 'genero' con valor por defecto
# ALTER TABLE ADD COLUMN con DEFAULT
pacientes <- pacientes %>%
  mutate(genero = 'M')

# 3. (Intermedio) Actualizar el email de todos los pacientes mayores de 45 años
# UPDATE con CONCAT y WHERE
pacientes <- pacientes %>%
  mutate(email = ifelse(!is.na(edad) & edad > 45, 
                        paste0(tolower(nombre), '.senior@clinica.com'), 
                        email))

# 4. (Avanzado) Actualizar la edad sumando 1 solo a pacientes activos con email válido
# UPDATE con múltiples condiciones
pacientes <- pacientes %>%
  mutate(edad = ifelse(activo == TRUE & 
                         !is.na(email) & 
                         grepl('@', email) & 
                         !is.na(edad), 
                       edad + 1, edad))

# 5. (Básico) Eliminar pacientes inactivos sin historial médico
# DELETE con NOT IN
pacientes_con_historial <- historiales %>% 
  filter(!is.na(paciente_id)) %>% 
  distinct(paciente_id)

pacientes <- pacientes %>%
  filter(!(activo == FALSE & !(id %in% pacientes_con_historial$paciente_id)))

# 6. (Intermedio) Eliminar columna genero recién creada
# ALTER TABLE DROP COLUMN
pacientes <- pacientes %>%
  select(-genero)

# 7. (Avanzado) Crear una "vista" y luego eliminarla
# CREATE VIEW y DROP VIEW
pacientes_activos <- pacientes %>%
  filter(activo == TRUE) %>%
  select(id, nombre, edad, email)

# Ver la "vista"
print(pacientes_activos)

# "Eliminar vista"
rm(pacientes_activos)

# 8. (Experto) Operación completa con manejo de errores (equivalente a transacción)
# BEGIN TRANSACTION + COMMIT/ROLLBACK
tryCatch({
  # Guardar estado original
  pacientes_backup <- pacientes
  
  # Intentar actualizar edad
  pacientes <- pacientes %>%
    mutate(edad = ifelse(nombre == 'Luis', edad + 5, edad))
  
  # Verificar que no hay edades inválidas
  edades_invalidas <- pacientes %>%
    filter(!is.na(edad) & (edad > 120 | edad < 0)) %>%
    nrow()
  
  if(edades_invalidas > 0) {
    # ROLLBACK
    pacientes <- pacientes_backup
    message("ROLLBACK: Se detectaron edades inválidas")
  } else {
    # COMMIT
    message("COMMIT: Operación completada exitosamente")
  }
  
}, error = function(e) {
  # ROLLBACK en caso de error
  pacientes <- pacientes_backup
  message(paste("ROLLBACK: Error -", e$message))
})

# Limpiar backup
rm(pacientes_backup)

# =====================================================
# LIMPIEZA FINAL (opcional)
# =====================================================
# Para limpiar todo después de la práctica:
# rm(historiales)
# rm(pacientes)

# Mostrar resultado final
print("Estado final de la tabla pacientes:")
print(pacientes)