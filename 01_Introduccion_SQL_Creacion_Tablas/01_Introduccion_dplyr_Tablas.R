# TEMA 2 ------------------------------------------------------------------
# * Carga de Paquetes -------------------------------------------------------
# Revisar los paquetes que carga y los mensajes de conflictos (poco más en Fuentes de datos)
library(tidyverse)

# IMPORTANTE PARA EL EXAMEN

# Crear tablas -------------------------------------------------------
# Limpiamos los objetos
rm(examen)

# Creamos la tabla vacía con tibble
examen <- tibble(nombre = character(),
                 nota = numeric())

examen

examen <-
  examen %>% 
  add_row(.data = ., nombre = 'Pepe', nota = 5.75) %>% 
  add_row(.data = ., nombre = 'Ana', nota = 8) %>% 
  add_row(.data = ., nombre = 'Juan', nota = 4.5)

examen

# ó bien...

examen <- tibble(nombre = c('Pepe', 'Ana', 'Juan'),
                 nota = c(5.75, 8.00, 4.50)
)

examen


# Comentando el código ----------------------------------------------------
# esto es un comentario
# Para comentar múltiples líneas: seleccionar --> Shift + Ctrl + C

rm(examen)

examen <- tibble(nombre = character(),
                 nota = numeric())

examen

examen <-
  examen %>% 
  add_row(.data = ., nombre = 'Pepe', nota = 5.75) %>% 
  #add_row(.data = ., nombre = 'Ana', nota = 8) %>% 
  add_row(.data = ., nombre = 'Juan', nota = 4.5)

examen


# Mayúsculas y Minúsculas -------------------------------------------------
# R es "case sensitive", por lo que las mayúsculas y minúsculas sí importan.

examen

Examen


# Agregando filas de manera condensada ------------------------------------
rm(examen)

examen <- tibble(nombre = character(),
                 nota = numeric())

examen

examen <-
  examen %>% 
  add_row(.data = ., 
          nombre = c('Pepe', 'Ana', 'Juan'), 
          nota = c(5.75, 8, 4.5)
  ) 

examen

# INSERT LINEA INDIVIDUAL y hablar del orden ------------------------------
# SQL --> Rapidez de ejecución y R --> Orden al ser ingresadas
rm(examen)

examen <- tibble(nombre = character(),
                 nota = numeric())

examen

examen <-
  examen %>% 
  add_row(.data = ., nombre = 'Pepe', nota = 5.75) %>% 
  add_row(.data = ., nombre = 'Ana', nota = 8) 

examen

examen <-
  examen %>% 
  add_row(.data = ., nombre = 'Juan', nota = 4.5)

examen


# TIPOS DE DATOS ----------------------------------------------------------
# ENTEROS
rm(examen)

examen <- tibble(nombre = character(),
                 #nota = integer(), # Si pasamos un doble a un integer --> double (Reglas de coercion)
                 nota = double())

examen

examen <-
  examen %>% 
  add_row(.data = ., nombre = 'Pepe', nota = 5.75) %>% 
  add_row(.data = ., nombre = 'Ana', nota = 8) %>% 
  add_row(.data = ., nombre = 'Juan', nota = 4.5)

examen


# Valores Ausentes --NA-- -------------------------------------------------
rm(examen)

examen <- tibble(nombre = character(),
                 nota = double(),
                 ciudad = character()) #agregamos ciudad

examen

examen <-
  examen %>% 
  add_row(.data = ., nombre = 'Pepe', nota = 5.75) %>% 
  add_row(.data = ., nombre = 'Ana', nota = 8) %>% 
  add_row(.data = ., nombre = 'Juan', nota = 4.5)

examen


# Valores Ausentes Multifila --NA-- ---------------------------------------
# SQL da Error mientras que en R sí se puede.
rm(examen)

examen <- tibble(nombre = character(),
                 nota = double(),
                 ciudad = character()) #agregamos ciudad

examen

examen <-
  examen %>% 
  add_row(.data = ., nombre = 'Pepe', nota = 5.75) %>% 
  add_row(.data = ., nombre = 'Ana', nota = 8, ciudad = "León") %>% 
  add_row(.data = ., nombre = 'Juan', nota = 4.5)

examen

# Valores Ausentes Manualmente --------------------------------------------
rm(examen)

examen <- tibble(nombre = character(),
                 nota = double(),
                 ciudad = character()) #agregamos ciudad

examen

examen <-
  examen %>% 
  #add_row(.data = ., nombre = 'Pepe', nota = 5.75, ciudad = "NA") %>% # Ojo NA no es un caracter
  add_row(.data = ., nombre = 'Pepe', nota = 5.75, ciudad = NA) %>% 
  add_row(.data = ., nombre = 'Ana', nota = 8, ciudad = "León") %>% 
  add_row(.data = ., nombre = 'Juan', nota = 4.5, ciudad = "Burgos")

examen


# NUMERIC con decimales -- Redondeo ---------------------------------------
# R no es tan flexible a la hora de restringir el dominio de los campos

rm(alumnos)

alumnos <- tibble(cod = numeric(),
                  nombre = character(),
                  ciudad = character(), # No hay una opcion fácil de agregar valores por defecto
                  telefono = double(),
                  nota = double()
)

alumnos

alumnos <-
  alumnos %>% 
  add_row(.data = ., cod = 1, nombre = 'Pepe') %>% 
  add_row(.data = ., cod = 2, nombre = 'Ana') %>% 
  add_row(.data = ., cod = 3, nombre = 'Juan')

alumnos

alumnos <-
  alumnos %>% 
  add_row(.data = ., cod = 4, nombre = 'Maria', ciudad = 'León')

alumnos

alumnos <-
  alumnos %>% 
  add_row(.data = ., cod = 5, nombre = NA, ciudad = 'Burgos')

alumnos <-
  alumnos %>% 
  add_row(.data = ., cod = 6, nombre = NA, ciudad = 'Burgos')

alumnos

alumnos <-
  alumnos %>% 
  add_row(.data = ., cod = 7, nombre = 'Antonio', ciudad = 'Soria', telefono = 334, nota = 10)

alumnos

alumnos <-
  alumnos %>% 
  add_row(.data = ., cod = 8, nombre = 'Antonio', ciudad = 'Soria', telefono = 334, nota = 9.56888)

alumnos

# DATE time/Data  ---------------------------------------------------------
#library(lubridate)
rm(ejemplo_tiempos)

ejemplo_tiempos <- tibble(fecha = lubridate::ymd(),
                          fecha_hora = lubridate::ymd_hms()
)

ejemplo_tiempos

ejemplo_tiempos <-
  ejemplo_tiempos %>% 
  add_row(.data = ., fecha = dmy("04-06-2018")) %>%
  add_row(.data = ., fecha = dmy('04-06-2018'), fecha_hora = dmy_hms("04-06-2018 09:00:00", tz = "Pacific/Auckland"))

ejemplo_tiempos