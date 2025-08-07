# UTILIZACIÓN DE SELECT ---------------------------------------------------
# Select se utiliza de una manera similar (aunque no igual) en SQL y en R
rm(alumnos)

alumnos <- tibble(nombre = character(),
                  altura	= numeric(),
                  peso	= numeric()
)

alumnos <-
  alumnos %>% 
  add_row(.data = ., 
          nombre = c('Pepe', 'Ana', 'Juan', 'Luis'), 
          altura = c(1.7, 1.72, 1.7, 1.7),
          peso = c(67, 67, 83, 83))

alumnos

?select

# uso directo
select(.data = alumnos, nombre, altura)

# uso en tuberías
alumnos %>% 
  select(nombre, altura)

# ¿repetidos?
alumnos %>% 
  select(.data = ., altura)

# filtrar repetidos con distinct
alumnos %>% 
  select(.data = ., altura) %>% 
  distinct()


# USO DE EXPRESIONES -- Funciones matemáticas -----------------------------
alumnos %>% 
  select(.data = ., nombre, peso, altura)

# Calculo con aritmeticas
alumnos %>% 
  mutate(imc = peso/(altura*altura),
         alt_pies = altura/0.3048,
         peso_libr = peso/0.4536) %>% 
  select(.data = ., nombre, imc, alt_pies, peso_libr)

# Redondeo
alumnos %>% 
  mutate(imc = round(peso/(altura*altura),1),
         alt_pies = round((altura/0.3048),1),
         peso_libr = round((peso/0.4536),1)) %>% 
  select(.data = ., nombre, imc, alt_pies, peso_libr)


# USO DE EXPRESIONES -- "CONCATENACIÓN" -----------------------------------
alumnos %>% 
  select(.data = ., nombre, peso, altura, 'Hola') # da Error!

alumnos %>% 
  mutate(saludo = 'Hola')

# Si aplicamos select
alumnos %>% 
  mutate(saludo = 'Hola') %>% 
  select(.data = ., saludo, nombre, peso, altura)

alumnos %>% 
  mutate(saludo = paste0('Hola', nombre, sep = ""))

# Si aplicamos select
alumnos %>% 
  mutate(saludo = paste0('Hola', nombre, sep = "")) %>% 
  select(.data = ., saludo, peso, altura)

alumnos %>% 
  mutate(IMC = round(peso/(altura*altura),1),
         pies = round((altura/0.3048),1),
         libras = round((peso/0.4536),1)) %>% 
  select(.data = ., nombre, IMC, pies, libras)


# TRABAJAMOS CON OPERACIONES DE TIEMPO ------------------------------------
alumnos %>% 
  mutate(hoy = lubridate::today(),
         ahora = lubridate::now()) 

alumnos %>% 
  mutate(hoy = lubridate::today(),
         proxima_semana = lubridate::today() + 7,
         semana_pasada = lubridate::today() - 7) 

# Rango de días... resta entre fechas
alumnos %>% 
  mutate(hoy = lubridate::today(),
         proxima_semana = lubridate::today() + 7,
         semana_pasada = lubridate::today() - 7,
         dias = lubridate::today() - dmy("5-10-2020")) 

# UTILIZACIÓN DE FILTER -------------------------------------------------
?dplyr::filter

rm(alumnos)

alumnos <- tibble(nombre = character(),
                  altura	= numeric(),
                  peso	= numeric()
)

alumnos <-
  alumnos %>% 
  add_row(.data = ., 
          nombre = c('Pepe', 'Ana', 'Juan', 'Luis'), 
          altura = c(1.7, 1.72, 1.7, 1.7),
          peso = c(67, 67, 83, 83))

alumnos

# uso directo
filter(.data = alumnos, peso == 67)

# uso en tuberías
alumnos %>% 
  filter(.data = ., peso == 67)


# Expresiones -------------------------------------------------------------
alumnos %>% 
  mutate(altura_cm = (altura - 1)*100) %>% 
  filter(altura_cm > peso) %>% 
  select(nombre, altura_cm, peso)
#select(!altura) # Gran flexibilidad de select


# CONECTORES LÓGICOS ------------------------------------------------------
# NOT, AND, OR
alumnos %>% 
  filter(.data = ., peso == 67 & altura == 1.7)


# Orden de los conectores lógicos
alumnos %>% 
  filter(.data = ., (peso == 67 & altura == 1.7) | peso > 80)

alumnos %>% 
  filter(.data = ., peso == 67 & (altura == 1.7 | peso > 80))

# alumnos %>% 
#   filter(.data = ., peso == 67 & (altura == 1.7 | peso < 80))


# COMPARADOR COMPLEMENTARIO -----------------------------------------------
alumnos %>% 
  filter(.data = ., (peso == 67 & altura == 1.7) | peso > 80 & nombre != 'Juan')

alumnos %>% 
  filter(.data = ., nombre >= 'Juan')

alumnos %>% 
  filter(.data = ., nombre >= 'Abuan')

# ORDER BY == ARRANGE -----------------------------------------------------
alumnos %>% 
  select(nombre, altura, peso) %>% 
  #arrange(altura)  
  arrange(desc(altura))

alumnos %>% 
  select(nombre, altura, peso) %>% 
  arrange(altura, peso)  

alumnos %>% 
  select(nombre, altura, peso) %>% 
  filter(nombre != 'Juan') %>% 
  arrange(altura, peso) 

alumnos %>% 
  select(nombre, altura, peso) %>% 
  filter(nombre != 'Juan') %>% 
  arrange(desc(altura), peso) 

# No hay equivalencia directa en las fórmulas, éstas primero se han de computar
alumnos %>% 
  select(nombre, altura, peso) %>% 
  filter(nombre != 'Juan') %>% 
  arrange(desc(peso/(altura*altura))) 

alumnos %>% 
  select(nombre, altura, peso) %>% 
  filter(nombre != 'Juan') %>% 
  mutate(imc = peso/(altura*altura)) %>% 
  arrange(desc(imc)) 

# Cuidado con el orden de los pasos en una tubería!
# alumnos %>% 
#   mutate(imc = peso/(altura*altura)) %>% 
#   select(nombre, altura, peso) %>% 
#   filter(nombre != 'Juan') %>% 
#   arrange(desc(imc)) 


# COMANDO DELETE =~ FILTER ------------------------------------------------
# Sin afectar al objeto
alumnos %>% 
  filter(peso > 70)

# afectando/actualizando el objeto
alumnos <-
  alumnos %>% 
  filter(peso > 70)

alumnos
#borrado total --> borrar el objeto
rm(alumnos)

alumnos

# Creamos el conjunto de datos nuevamente.
alumnos <- tibble(nombre = character(),
                  altura	= numeric(),
                  peso	= numeric()
)

alumnos <-
  alumnos %>% 
  add_row(.data = ., 
          nombre = c('Pepe', 'Ana', 'Juan', 'Luis'), 
          altura = c(1.7, 1.72, 1.7, 1.7),
          peso = c(67, 67, 83, 83))

alumnos

# borramos al (los) que tenga(n) el mayor IMC
alumnos %>% 
  select(nombre, altura, peso) %>% 
  #filter(nombre != 'Juan') %>% 
  mutate(imc = peso/(altura*altura)) %>% 
  #arrange(desc(imc)) %>% 
  filter(imc >= max(imc))


# Modificaciones de valores ~~ MUTATE/REPLACE -----------------------------
?replace

# Reemplazo de valores condicionales
alumnos %>% 
  mutate(altura = replace(x = altura, list = nombre == 'Pepe', values = 1.9),
         peso = replace(x = peso, list = nombre == 'Pepe', values = 90))

# Reemplazamos un valor con un cálculo basado en el registro actual
alumnos %>% 
  mutate(altura = replace(x = altura, list = nombre == 'Pepe', values = 1.9),
         peso = replace(x = peso, list = nombre == 'Pepe', values = alumnos$peso[alumnos$nombre == 'Pepe'] * 1.2 ))

# Reemplazamos el valor de todas las filas (Asuencia de where)
alumnos %>% 
  mutate(altura = replace(x = altura, values = 1.9),
         peso = replace(x = peso, values = alumnos$peso * 1.2 ))

# Transformar los valores a UPPERCASE
alumnos %>% 
  mutate(nombre = toupper(nombre))

#Transformación de varias columnas según dominio
alumnos %>% 
  mutate(Apellido = c('Bastidas', 'Jimenez', 'Astorga', 'Gatica'))

alumnos %>% 
  mutate(Apellido = c('Bastidas', 'Jimenez', 'Astorga', 'Gatica')) %>% 
  mutate(across(where(is.character), toupper)) 

# INSERT con sub-SELECT ---------------------------------------------------
alumnos <- tibble(nombre = character(),
                  altura	= numeric(),
                  peso	= numeric()
)

alumnos <-
  alumnos %>% 
  add_row(.data = ., 
          nombre = c('Pepe', 'Ana', 'Juan', 'Luis'), 
          altura = c(1.7, 1.72, 1.7, 1.7),
          peso = c(67, 67, 83, 83))

alumnos

altos <- tibble(nombre = character(),
                pies	= numeric()
)

altos

# Insertado manual
altos %>% 
  add_row(.data = ., 
          nombre = 'Juan', 
          pies = 5)

#Insertado usando una subconsulta
altos %>% 
  add_row(.data = ., 
          nombre = unlist(alumnos %>% filter(altura > 1.7) %>% select(nombre)), 
          pies = unlist(alumnos %>% filter(altura > 1.7) %>% select(altura)))
