# Los nulos y las operaciones de dplyr (R) --------------------------------
# * Manipulación de valores nulos -------------------------------------------
rm(miTabla)

miTabla <- tibble(
  campo1 = character(),
  campo2 = character(),
  campo3 = character()
)

miTabla

# Agregamos valores nulos (NA) por omisión
miTabla <-
  miTabla %>% 
  add_row(.data = ., campo1 = 'Valor Campo 1' , campo3 = 'Valor Campo 3')

miTabla


# Agregamos valores nulos (NA) manualmente
miTabla <-
  miTabla %>% 
  add_row(.data = ., campo1 = 'Valor Campo 1' , campo3 = NA) # NA no es un character

miTabla

# No hay equivalencia (sencilla) de los valores 'default' de SQL
miTabla <-
  miTabla %>% 
  add_row(.data = ., campo1 = 'Valor Campo 1' , campo2 = 'Valor Campo 2') 

miTabla


# * Actualizando la tabla con NA ------------------------------------------
# Las funciones filter() más mutate(), no son lo mismo que replace()
miTabla %>% 
  filter(campo2 == 'Valor Campo 2') %>% 
  mutate(campo1 = NA)

# usando mutate() más replace()
miTabla %>% 
  mutate(campo1 = replace(x = campo1, list = campo2 == 'Valor Campo 2', values = NA))

# * Añadiendo una columna a una tabla (más exótico)  ----------------------
# No podemos definir el dominio con mutate()
miTabla %>% 
  mutate(Campo4 = character())

# Debemos indica el valor que se va a repetir (regla de reciclado)
miTabla %>% 
  mutate(Campo4 = NA)

# La regla de eciclado es independiente del dominio
miTabla %>% 
  mutate(Campo4 = 5)


# * Diferencias entre agregar un 'Blanco' de un NA ------------------------
# Ejemplo solo demostrativo de las diferencias con SQL y de la regla de Coercion
miTabla %>% 
  add_row(.data = ., campo1 = '' , campo2 = '', campo3 = NA) 


# * Cálculos usando NA ----------------------------------------------------
rm(Facturas)

Facturas <- tibble(
  numFactura = integer(),
  razonSocial = character(),
  total = numeric()
)

Facturas

Facturas <-
  Facturas %>% 
  add_row(.data = ., numFactura = c(1,2) , razonSocial = c(NA, 'Pepe'), total = c(NA, 10))

Facturas

# En dplyr, el orden de las mutaciones afectan los valores (cuando se reemplazan las variables) 
Facturas %>% 
  mutate(total1 = total*1.15,
         `Atención` = paste('A la atención de', razonSocial, sep = " "),
         coseno = cos(total),
         nickname = stringr::str_extract(razonSocial, "[a-z]+")
  ) %>% 
  select(numFactura, total1, `Atención`, coseno, nickname)

# La lógica trivaluada ----------------------------------------------------

# *  WHERE y NA  --------------------------------------------------------
rm(empleados)

empleados <- tibble(
  id = integer(),
  nombre = character(),
  salario = numeric()
)

empleados

empleados <-
  empleados %>% 
  add_row(.data = ., id = c(1,2, 3) , nombre = c('Pepe', 'Juan', 'Ana'), salario = c(50, NA, 200))

empleados

# Testamos por mayores que un valor fijo
#No debe salir Pepe ( es menor) y el desconocido debería quitarlo también.
#Pepe>100=FALSE // Ana>100 = TRUE // Juan (null)>100 = NULL

# Todos los atributos
empleados %>% 
  #select(nombre) %>%
  filter(salario > 100)

# Si solo queremos el nombre (¡¡cuidado con el orden!!)
empleados %>% 
  select(nombre) %>% # Las tuberías de R realmente van modificando el conjunto de datos
  filter(salario > 100)

# Si queremos sacar seleccionar a aquellos NULL usamos erróneamente...
# No devuelve nada porque si (efectivamente) es NULL lo oculta!
empleados %>% 
  filter(salario == NA) %>%
  select(nombre) 

# Si queremos sacar seleccionar a aquellos NULL usamos correctamente...
# Devuelve verdadero si hay algún NULL y lo muestra!
empleados %>% 
  filter(is.na(salario)) %>%
  select(nombre) 

# Tampoco muestra filas para la negación de NA
empleados %>% 
  filter(salario != NA) %>%
  select(nombre) 

# Forma correcta de preguntar por los NO NA
empleados %>% 
  filter(!is.na(salario)) %>%
  select(nombre) 

# * WHERE, AND, OR y NA ---------------------------------------------------
rm(alumnos)

alumnos <- tibble(
  nombre = character(),
  altura = numeric(),
  peso = numeric()  
)

alumnos

alumnos <- 
  alumnos %>% 
  add_row(.data = ., nombre = c('Pepe', 'Juan', 'Ana', 'Luis', 'Maria') , altura = c(NA, 1.8, NA, 1.5, NA), peso = c(70, NA, NA, NA, 60))

alumnos


# ** WHERE, OR y NA -----------------------------------------------------
# seleccionamos aquellos que peso sea mayor que 67 ó que la altura mayor que 1.7 
alumnos %>%
  filter(peso > 67 | altura > 1.7)

# Si sólo pedimos los nombres
alumnos %>%
  filter(peso > 67 | altura > 1.7) %>% 
  select(nombre)

# Deberían salir todos, pero no es así. Sólo sale Pepe y Ana, poque tienen algun valor
alumnos %>%
  filter(peso > 67 | peso <= 67)

# Si queremos que aparezcan los NA deberemos llamarlos usando is.na(variable).
alumnos %>%
  filter(peso > 67 | peso <= 67 | is.na(peso))


# ** WHERE, AND y NA -------------------------------------------------------
alumnos

# No devuelve nada porque en combinación con el AND hay solo NA y FALSE y no se muestran
alumnos %>%
  filter(peso > 67 & altura > 1.7)


# NA con Check y Unique ---------------------------------------------------
# No existe equivalencia sencilla y directa con dplyr

# Los NA y el join externo  -----------------------------------------------


# * Outer join sobre varias tablas ----------------------------------------
rm(alquila, inmuebles, inquilinos)

# Tabla Inquilinos
inquilinos <- tibble(
  dni = numeric(),
  nombre = character(),
  tfno = numeric()
)

inquilinos

inquilinos <-
  inquilinos %>% 
  add_row(.data = ., dni = c(1, 2, 3), nombre = c('Pepe', 'Maria', 'Enrique') , tfno = c(123456789, 123456789, 333333333))

# Tabla inmuebles
inmuebles <- tibble(
  planta = numeric(), # PK
  letra = character(),
  alquiler = numeric() # PK
)

inmuebles

inmuebles <-
  inmuebles %>% 
  add_row(.data = ., planta = c(1, 1, 2, 2), letra = c('A', 'B', 'A', 'B') , alquiler = c(400, 500, 300, 400))

# Tabla alquila
alquila <- tibble(
  dni = numeric(),
  planta = numeric(),
  letra = character()
)

alquila

alquila <- 
  alquila %>% 
  add_row(.data = ., dni = c(1,2,1), planta = c(1,1,2), letra = c('B', 'B', 'A'))

# Todas las tablas

# Maria y Pepe viven en el 1-B
# Pepe tiene el 2A como despacho
alquila

# Enrique no vive en ninguna casa (no está dado de alta a lo menos)
inquilinos

# 1º A y 2º B están vacías, no hay nadie 
?left_join

# Si usamos el NATUAL JOIN no indicamos las columnas de unión
# Salen todos los inmuebles incluso los 2 que están vacíos
# planta y letra salen una sola vez porque el JOIN NATURAL los usa a ellos.

inner_join(x = inmuebles, y = alquila) # Solo entrega correspondencias válidas (!is.na())

left_join(x = inmuebles, y = alquila)

# Hacemos ahora el segundo JOIN con Inquilinos (SIN ESPECIFICAR EXTERNO)
# Pasa que se pierden las dos filas con los inmuebles vacíos por los NULLs! ya que null y null jamás es verdadero (no hay match)
left_join(x = inmuebles, y = alquila) %>% 
  inner_join(x = ., y = inquilinos)

# Solución usando un segundo JOIN EXTERNO
left_join(x = inmuebles, y = alquila) %>% 
  left_join(x = ., y = inquilinos)

# Arreglo 2 (menos frecuente y menos recomendado): 
# Cambiar el orden en el que se ejecutan los joins mediante los parentesis.

# primero hacemos join entre alquila e inquilinos ( A través del DNI)
inner_join(x = alquila, y = inquilinos)

# join con inmuebles, tomando la anterior como la tabla base
# paréntesis indican qué join se hace primero
inmuebles %>% 
  left_join(x = ., 
            y = inner_join(x = alquila, y = inquilinos)
  )

# hacemos la proyección y estamos listo!
inmuebles %>% 
  left_join(x = ., 
            y = inner_join(x = alquila, y = inquilinos)
  ) %>% 
  select(planta, letra, alquiler, dni, nombre, tfno)

# si NO uso los paréntesis y los pongo primero en orden, el JOIN ahora es Derecho
# cambiando la posición de las tablas en el from
inner_join(x = alquila, y = inquilinos) %>% 
  right_join(x = ., y = inmuebles) %>% 
  select(planta, letra, alquiler, dni, nombre, tfno)


# * Outer join más WHERE  y NA --------------------------------------------------------
rm(equipos, jugadoresinternacionales)

# Tabla 1
equipos <- tibble(
  nombre = character(),
  ciudad = character()
)

equipos <-
  equipos %>% 
  add_row(.data = ., nombre = c('Al-Nassr Football Club', 'PSG', 'Real Madrid', 'Vissel Kobe', 'Atlético de Madrid','CD Univeridad de Burgos'), ciudad = c('Riad', 'París', 'Madrid','Kobe', 'Madrid','Burgos'))

equipos

# Tabla 2
jugadoresinternacionales <- tibble(
  nombre = character(),
  nombre_equipo = character(),
  nacionalidad = character()
)

jugadoresinternacionales <-
  jugadoresinternacionales %>% 
  add_row(.data = ., nombre = c('Leo Messi','Cristiano Ronaldo', 'Sergio Ramos', 'Isco', 'Andrés Iniesta', 'Antoine Griezmann'), nombre_equipo = c('PSG', 'Al-Nassr Football Club', 'PSG', 'Real Madrid', 'Vissel Kobe', 'Atlético de Madrid'), nacionalidad = c('Argentino', 'Portuges', 'Español', 'Español', 'Español', 'Frances'))

jugadoresinternacionales

# Que se muestren todos los equipos, aunque no tengan jugadores internacionales (Join externo), y 
# Que en el resultado sólo salgan jugadores españoles.
# Mirar los warnings()

equipos %>% 
  left_join(x = ., y = jugadoresinternacionales, by = c("nombre" = "nombre_equipo"))


equipos %>% 
  left_join(x = ., y = jugadoresinternacionales, by = c("nombre" = "nombre_equipo"), multiple = "all")


# Filtramos para que solo salgan los españoles
equipos %>% 
  left_join(x = ., y = jugadoresinternacionales, by = c("nombre" = "nombre_equipo"), multiple = "all") %>% 
  filter(nacionalidad == "Español")

# La solución es hacer una subconsulta interna
equipos %>% 
  left_join(x = ., y = jugadoresinternacionales %>% 
              filter(nacionalidad == "Español"), by = c("nombre" = "nombre_equipo"), multiple = "all") 


# Tratamiento de NAs con COALESCE -----------------------------------------
# Permite reemplazar los NAs, por lo que se usa mucho en los Joins Externos
# La función va chequeando todos los valores que toman los argumentos de izquierda a derecha devolviendo el primero que no sea nulo. Si son todos nulos, devuelve nulo.
rm(empleados)

empleados <- tibble(
  dni = numeric(),
  nombre = character(),
  nacidoen = character(),
  viveen = character(),
  salario = numeric(),
  bonus = numeric()
)

empleados <- 
  empleados %>% 
  add_row(.data = ., dni = c(1,2,3,4), nombre = c('Pepe','Juan', 'Ana', 'Luis'), nacidoen = c('Burgos', 'Burgos', NA, NA), viveen = c('Madrid', 'Burgos', 'Soria', NA), salario = c(2000, NA, NA, 500), bonus = c(NA, NA, 1500, 1000))

empleados


# *  Necesitamos que cuando salario sea NA en realidad salga un cero -------
# Entregamos directamente el valor a ser reemplazado (respetando el dominio)
empleados %>% 
  select(nombre, salario) %>% 
  mutate(nombre = nombre, salario = coalesce(salario, 0L))

empleados %>% 
  select(nombre, salario) %>% 
  mutate(nombre = nombre, salario = coalesce(salario, '0L'))

# Podemos reemplazar por un valor existente en otra variable y si no lo tiene (NA), que coja el que le estamos dando.
empleados %>% 
  mutate(origen = coalesce(nacidoen, viveen, '¿?'))


# * Ordenaciones y NA -----------------------------------------------------
# Al igual que postgreSQL los NA los deja al final
empleados %>% 
  arrange(bonus)

# A diferencia de postgreSQL los NA siempre están al final
empleados %>% 
  arrange(desc(bonus))

# En dplyr NO Existe algo como NA First o NA Last, pero sí Coalesce!
# Lo mismo se puede conseguir con la función COALESCE al reemplazar los NA por un valor muuuuy pequeño y muuuy negativo
empleados %>% 
  arrange(coalesce(bonus, -100000))

# También podemos dejar los NAs al final reemplazándolos por un número muuuy positivo 
empleados %>% 
  arrange(coalesce(bonus, 100000))

# Usando el DESC también funciona con coalesce
empleados %>% 
  arrange(desc(coalesce(bonus, 100000)))


# * Combinando dominos ----------------------------------------------------
# Si intentamos pasar el caracter 'no tiene' dentro del coalesce no funciona, porque:
# Salario es de tipo numérico y 'no tiene' es de tipo caracter.
empleados %>% 
  select(nombre, salario) %>% 
  mutate(nombre = nombre, salario = coalesce(salario, 'no tiene'))

# Gracias a la familia de funciones as.XX obligaremos a la variable salario a comportarse como cáracter usando as.character()
# Luego de eso lo podremos pegar.
empleados %>% 
  select(nombre, salario) %>% 
  mutate(nombre = nombre, salario = coalesce(as.character(salario), 'no tiene'))
