# TEMA 5 ------------------------------------------------------------------
# Carga Paquetes ----------------------------------------------------------
library(dplyr)
library(lubridate)

# Construcciones de bifurcación CASE --------------------------------------
rm(alumnos)

alumnos <- tibble(
  nombre = character(),
  nota = numeric(),
  fechaMatricula = lubridate::ymd_hms()
)

alumnos

alumnos <-
  alumnos %>% 
  add_row(.data = ., nombre = 'Pepe', nota = 4, fechaMatricula = (lubridate::now() - 1)) %>% 
  add_row(.data = ., nombre = 'Juan', nota = 5, fechaMatricula = (lubridate::now() - 1)) %>% 
  add_row(.data = ., nombre = 'Luis', nota = 6, fechaMatricula = (lubridate::now() - 1)) %>% 
  add_row(.data = ., nombre = 'Ana', nota = 7, fechaMatricula = (lubridate::now() - 2)) %>% 
  add_row(.data = ., nombre = 'Maria', nota = 8, fechaMatricula = (lubridate::now() - 2)) %>% 
  add_row(.data = ., nombre = 'Olga', nota = 10, fechaMatricula = (lubridate::now() - 2)) %>% 
  add_row(.data = ., nombre = 'Laura', nota = 11, fechaMatricula = (lubridate::now() - 3)) %>% 
  add_row(.data = ., nombre = 'Iker', nota = NA, fechaMatricula = (lubridate::now() - 3))

alumnos

# * Recodificamos una variable usando (case_when) -----------------

# Usamos el valor .default para decir "todo lo demás", pero en todo lo demás está el 11 de Laura y el "NA" de Iker.
alumnos %>% 
  mutate(
    case_when(nota < 5 ~ 'Supenso',
              nota < 7 ~ 'Aprobado',
              nota < 9 ~ 'Notable',
              .default = 'Sobresaliente')
  )


#Creamos una clase más, pero veremos que R tiene una solución para tratar específicamente los NA
alumnos %>% 
  mutate(
    case_when(nota < 5 ~ 'Supenso',
              nota < 7 ~ 'Aprobado',
              nota < 9 ~ 'Notable',
              nota <= 10 ~ 'Sobresaliente',
              .default = 'No evaluado')
  )

# usamos la condicional is.na() para evaluar si es que hay NA en el atributo Nota y trasnformarlo en lo que queramos. 
alumnos %>% 
  mutate(
    case_when(nota < 5 ~ 'Supenso',
              nota < 7 ~ 'Aprobado',
              nota < 9 ~ 'Notable',
              nota <= 10 ~ 'Sobresaliente',
              is.na(nota) ~ 'Sin evaluación',
              .default = 'Evaluación incorrecta')
  )

# Para evitar el atributo con nombre de case_when, podremos darle un nombre manualmente
alumnos %>% 
  mutate(
    nota_escala = case_when(nota < 5 ~ 'Supenso',
                            nota < 7 ~ 'Aprobado',
                            nota < 9 ~ 'Notable',
                            nota <= 10 ~ 'Sobresaliente',
                            is.na(nota) ~ 'Sin evaluación',
                            .default = 'Evaluación incorrecta')
  )



# * Ejemplo Natación ------------------------------------------------------
# Como recordaréis en R no tenemos (de manera sencilla) la restricción de dominio tipo Check

rm(socios)

socios <- tibble(
  dni = numeric(),
  nombre = character(),
  tipo = character()
)

socios

socios <-
  socios %>% 
  add_row(.data = ., dni = c(1,2,3,4), nombre = c('Pepe', 'Ana', 'Luis', 'Maria'), tipo = c('N','T','J','V'))

socios

# Podemos usar un case_when incluso cuando son todo igualdades
socios %>% 
  mutate(
    tipo_largo = case_when(
      tipo == 'N' ~ 'Niño',
      tipo == 'T' ~ 'Trabajador',
      tipo == 'J' ~ 'Jubilado',
      tipo == 'V' ~ 'VIP'
    )
  )

# Al igual que en SQL tenemos una opción abreviada para cuando solamente se trata de igualdades, en R (dplyr) tenemos case_match. En este caso debemos indicar la columna/atributo dónde buscar las equivalencias

socios %>% 
  mutate(
    tipo_largo = case_match(.$tipo, 
                            'N' ~ 'Niño',
                            'T' ~ 'Trabajador',
                            'J' ~ 'Jubilado',
                            'V' ~ 'VIP'
    )
  )


# * case_when Anidado -----------------------------------------------------
rm(empleados)

empleados <- tibble(
  dni = numeric(),
  nombre = character(),
  sueldo = numeric(),
  horasSemana = numeric()
)

empleados

empleados <-
  empleados %>% 
  add_row(.data = ., dni = c(1,2,3), nombre = c('Pepe', 'maria', 'Jorge'), sueldo = c(500, 1200, 1200), horasSemana = c(40, 20, 40))

empleados

# como son pocos los reemplazos hemos usado mucho el .default 
empleados %>% 
  mutate(
    estado = case_when(
      sueldo > 1000 ~ case_when(
        horasSemana < 35 ~ 'Vive como quiere',
        .default = 'Trabaja mucho pero cobra bien'
      ),
      .default = 'Le están explotando'
    )
  )



# ** Ejercicio página 6 (resuelto) ----------------------------------------
ejercicio <- tibble(
  a = numeric()
)

ejercicio

ejercicio <- 
  ejercicio %>% 
  add_row(a = c(0, 2000))

ejercicio

ejercicio %>% 
  mutate( a = case_when(
    a < 1000 ~ a + 1000,
    .default = a - 1000
  ))


