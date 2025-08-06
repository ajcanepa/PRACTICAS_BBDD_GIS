# TEMA 3 ------------------------------------------------------------------

# * Carga de Paquetes -----------------------------------------------------
# Revisar los paquetes que carga y los mensajes de conflictos (poco más en Fuentes de datos)
library(tidyverse)


# ** 3.0.1 Creamos las tablas ---------------------------------------------
# Conjunto de Datos
rm(empleados)

empleados <- tibble(
  dni = numeric(),
  nombre = character(),
  salario = numeric(),
  ventas = numeric(),
  ciudad = character(),
  categoria = character()
)


empleados <- 
  empleados %>% 
  add_row(dni = c(1,2,3,4,5), 
          nombre = c('Pepe', 'Juan', 'Ana', 'Maria', 'Luis'), 
          salario = c(1000, 1500, 750, 1500, 1000), 
          ventas = c(2000, 2000, 2000, 2000, 0), 
          ciudad = c('Burgos', 'Burgos', 'Soria', 'Madrid', 'Burgos'),
          categoria = c('Vendedor', 'Jefe', 'Jefe', 'Vendedor', 'Vendedor')
  )

empleados

# * 3.1 Selección  ----------------------------------------------------------
# filter
# selecciona un subconjunto de filas de la relación original. Se debe utilizar distinct para evitar duplicados

# atributo comparador constante: Salarios mayores que 1000

empleados %>% 
  filter(salario > 1000) %>% 
  select(salario)

empleados %>% 
  filter(salario > 1000) %>% 
  select(salario) %>% 
  distinct()

# En el caso de que se consulte más de un atributo, distinct_all operará sobre la  combinación de esos atributos
empleados %>% 
  filter(salario > 1000) %>% 
  select(dni, salario) %>% 
  distinct_all()

# forma correcta para igualar AR, si no hay PK!
empleados %>% 
  filter(salario > 1000) %>% 
  distinct()

# atributo comparador atributo: salario < ventas
empleados %>% 
  filter(salario < ventas) %>% 
  select(categoria) %>% 
  distinct()

# predicado logico de negación: salario no es = 1000
empleados %>% 
  filter(salario != 1000) %>% 
  distinct()

# predicado lógico, conector lógico, predicado lógico: salario > 1000 > ventas
empleados %>% 
  filter(salario >= 1000 & salario > ventas) %>% 
  distinct()


# * 3.2 Proyección --------------------------------------------------------
# Se utiliza el comando select(). Select(), selecciona un subconjunto de atributos de la relación original.
# Se debe utilizar distinct para evitar duplicados

# Con duplicados
empleados %>% 
  select(categoria, salario)

# Sin duplicados
empleados %>% 
  select(categoria, salario) %>% 
  distinct()

# Proyección incluyendo los atributos dentro de select lista 1 subconjunto lista 2
empleados %>% 
  select(categoria, salario, ciudad) %>% 
  filter(ciudad == 'Burgos')

# Proyeccion sin atributos dentro de select lista1 NO es subconjunto lista 2
# Fallará en otros lenguajes como en R!
empleados %>% 
  select(categoria, salario) %>% 
  filter(ciudad == 'Burgos')

# En R, normalmente se hace el filter antes que el select. En cualquier caso deberemos saber que no podemos operar sobre un atributo que no esté ya disponible.

# Solución anterior
empleados %>% 
  filter(ciudad == 'Burgos') %>% 
  select(categoria, salario)

# Tambien sirve permutar orden de atributos

# Tabla original
empleados

# Nueva tabla
empleados %>% 
  select(ciudad, dni, nombre, categoria, salario, ventas)

# * 3.3 Operaciones de Conjuntos ------------------------------------------
# Operaciones de Conjuntos U (unión) ∩ (intersección) - (diferencia)
# en SQL --> Union = union // Intersección = intersect // diferencia = except
# Las operaciones de conjuntos eliminan las filas repetidas
# Estas relaciones han de verificar la llamada "Compatibilidad de Unión". 


# ** 3.3.1 Creamos las tablas ---------------------------------------------
rm(empleados, ciudades)

# Tabla ciudades
ciudades <- tibble(
  ciudad = character(),
  habitantes = numeric()
)

ciudades <-
  ciudades %>% 
  add_row(ciudad = c('Burgos', 'Soria', 'Madrid'),
          habitantes = c(200000, 25000, 4000000)
  )

ciudades


# Tabla empleados
empleados <- tibble(
  dni = numeric(),
  nombre = character(),
  salario = numeric(),
  ventas = numeric(),
  ciudad = character(),
  categoria = character()
)


empleados <- 
  empleados %>% 
  add_row(dni = c(1,2,3,4,5), 
          nombre = c('Pepe', 'Juan', 'Ana', 'Maria', 'Luis'), 
          salario = c(1000, 1500, 750, 1500, 1000), 
          ventas = c(2000, 2000, 2000, 2000, 0), 
          ciudad = c('Burgos', 'Burgos', 'Soria', 'Madrid', 'Burgos'),
          categoria = c('Vendedor', 'Jefe', 'Jefe', 'Vendedor', 'Vendedor')
  )

ciudades
empleados


# ** 3.3.2 Unión ----------------------------------------------------------
# Se comporta como AR y quita filas repetidas (DISTINCT no es necesario)
# select requiere = numero de columnas
# solo variables con = dominio

# Ciudades que tienen vendedores o tienen menos de 100.000 habitantes

# Error por incompatibilidad de Unión
empleados %>% 
  filter(categoria == 'Vendedor') %>% 
  select(ciudad) %>% 
  union(.,
        ciudades %>% 
          filter(habitantes < 100000) %>% 
          select(ciudad, habitantes)
  )

# Ahora bien
empleados %>% 
  filter(categoria == 'Vendedor') %>% 
  select(ciudad) %>% 
  union(.,
        ciudades %>% 
          filter(habitantes < 100000) %>% 
          select(ciudad)
  )


# sin que se quiten los repetidos, ya que union quita repetidos (¡y costoso para el sistema!)
# si la proyección es a PK el uso de ALL da igual, de lo contrario es más rápido
empleados %>% 
  filter(categoria == 'Vendedor') %>% 
  select(ciudad) %>% 
  union_all(.,
            ciudades %>% 
              filter(habitantes < 100000) %>% 
              select(ciudad)
  )


# ** 3.3.3 Intersección ---------------------------------------------------
# Comando intersect()
# Todas las tuplas que están en A y en B simultáneamente

# Ciudades que tienen tanto jefes como vendedores
ciudades
empleados

empleados %>% 
  filter(categoria == 'Jefe') %>% 
  select(ciudad) %>% 
  intersect(., 
            empleados %>% 
              filter(categoria == 'Vendedor') %>% 
              select(ciudad)
  )


# ** 3.3.4 Resta ----------------------------------------------------------
# Comando setdiff()

# Ciudades que no tienen Jefe
empleados

empleados %>% 
  select(ciudad) %>% 
  setdiff(., 
          empleados %>% 
            filter(categoria == 'Jefe') %>% 
            select(ciudad)
  )


# * 3.4 El modificador ALL en las operaciones de Conjunto ---------------
# Hay que tener en cuenta que intersect(), union(), setdiff() y symdiff() eliminan los duplicados


# ** 3.4.0 Creamos las tablas -----------------------------------
rm(alumnos, profesores)

# Tabla alumnos
alumnos <- tibble(
  dni = integer(),
  Nombre = character(),
  Ape1 = character(),
  Ape2 = character(),
  matricula = numeric()
)

alumnos <-
  alumnos %>% 
  add_row(dni = c(1,2,3),
          Nombre = c('Pepe', 'Juan', 'Pepe'),
          Ape1 = c('Alvarez', 'Alvarez', 'Alvarez'),
          Ape2 = c('Alvarez', 'Alvarez', 'Garcia'),
          matricula = c(1,2,3)
  )

# Tabla profesores
profesores <- tibble(
  dni = integer(),
  Nombre = character(),
  Ape1 = character(),
  Ape2 = character(),
  nro = numeric()
)

profesores <-
  profesores %>% 
  add_row(dni = c(1,2,3, 4),
          Nombre = c('Pepe', 'Juan', 'Pepe', 'Juan'),
          Ape1 = c('Alvarez', 'Alvarez', 'Alvarez', 'Alvarez'),
          Ape2 = c('Alvarez', 'Lopez', 'Garcia', 'Lopez'),
          nro = c(4,5,6, 7)
  )

alumnos 
profesores


# ** 3.4.1 UNION_ALL ------------------------------------------------------------
# Evitamos los repetidos con union()
profesores %>% 
  select(dni, Nombre, Ape1, Ape2) %>% 
  union(.,
        alumnos %>% 
          select(dni, Nombre, Ape1, Ape2))

# incluyendo repetidos en la combinación
profesores %>% 
  select(dni, Nombre, Ape1, Ape2) %>% 
  union_all(.,
            alumnos %>% 
              select(dni, Nombre, Ape1, Ape2))


# Ejemplo 2 sin repetidos
profesores %>% 
  select(Ape1, Ape2) %>% 
  union(.,
        alumnos %>% 
          select(Ape1, Ape2))

# Ejemplo 2 con repetidos
profesores %>% 
  select(Ape1, Ape2) %>% 
  union_all(.,
            alumnos %>% 
              select(Ape1, Ape2))


# En R/dplyr no existe setdiff_all() para mostrar los repetidos en la diferencia
# Nombre y apellidos de profesores que no son alumnos 
profesores %>% 
  select(Nombre, Ape1, Ape2) %>% 
  setdiff(.,
          alumnos %>% 
            select(Nombre, Ape1, Ape2)
  )

# Nombre y apellidos de alumnos q no son profesores
alumnos %>% 
  select(Nombre, Ape1, Ape2) %>% 
  setdiff(.,
          profesores %>% 
            select(Nombre, Ape1, Ape2)
  )


# ** 3.4.2 Arrange en las operaciones de Conjunto ------------------------
# En las operaciones de conjunto el arrange siempre irá al último, aunque a diferencia de SQL no falla si lo ponemos antes.

# Error en SQL, en R/dplyr sí se puede ejecutar
profesores %>% 
  select(dni, Nombre, Ape1, Ape2) %>% 
  filter(Ape2 == 'Alvarez') %>% 
  arrange(dni) %>% 
  union(.,
        alumnos %>% 
          select(dni, Nombre, Ape1, Ape2)
  )


# ejemplo correcto en ambos lenguajes
profesores %>% 
  select(dni, Nombre, Ape1, Ape2) %>% 
  filter(Ape2 == 'Alvarez') %>% 
  union(.,
        alumnos %>% 
          select(dni, Nombre, Ape1, Ape2)
  ) %>%   
  arrange(dni)

# orden descendiente
profesores %>% 
  select(dni, Nombre, Ape1, Ape2) %>% 
  filter(Ape2 == 'Alvarez') %>% 
  union(.,
        alumnos %>% 
          select(dni, Nombre, Ape1, Ape2)
  ) %>%   
  arrange(desc(dni))

# * 3.5 Renombrar los Atributos de las Relaciones -------------------------


# ** 3.5.0 Creamos las tablas ---------------------------------------------
rm(empleados, ciudades)

# Tabla ciudades
ciudades <- tibble(
  ciudad = character(),
  habitantes = numeric()
)

ciudades <-
  ciudades %>% 
  add_row(ciudad = c('Burgos', 'Soria', 'Madrid'),
          habitantes = c(200000, 25000, 4000000)
  )

ciudades


# Tabla empleados
empleados <- tibble(
  dni = numeric(),
  nombre = character(),
  salario = numeric(),
  ventas = numeric(),
  ciudad = character(),
  categoria = character()
)


empleados <- 
  empleados %>% 
  add_row(dni = c(1,2,3,4,5), 
          nombre = c('Pepe', 'Juan', 'Ana', 'Maria', 'Luis'), 
          salario = c(1000, 1500, 750, 1500, 1000), 
          ventas = c(2000, 2000, 2000, 2000, 0), 
          ciudad = c('Burgos', 'Burgos', 'Soria', 'Madrid', 'Burgos'),
          categoria = c('Vendedor', 'Jefe', 'Jefe', 'Vendedor', 'Vendedor')
  )

ciudades
empleados


# ** 3.5.1 Renombrado sencillo --------------------------------------------
# renombrado requiere la definción donde --> nombre.nuevo = nombre.antiguo.
empleados %>% 
  filter(ciudad == 'Burgos') %>% 
  select(rango = categoria, euros = salario) %>% 
  distinct()

# ** 3.5.2 Renombrado en operaciones de conjunto --------------------------
# Creamos las tablas
rm(alumnos, profesores)

# Tabla alumnos
alumnos <- tibble(
  dni = integer(),
  Nombre = character(),
  Ape1 = character(),
  Ape2 = character(),
  matricula = numeric()
)

alumnos <-
  alumnos %>% 
  add_row(dni = c(1,2,3),
          Nombre = c('Pepe', 'Juan', 'Pepe'),
          Ape1 = c('Alvarez', 'Alvarez', 'Alvarez'),
          Ape2 = c('Alvarez', 'Alvarez', 'Garcia'),
          matricula = c(1,2,3)
  )

# Tabla profesores
profesores <- tibble(
  dni = integer(),
  Nombre = character(),
  apellido1 = character(),
  apellido2 = character(),
  nro = numeric()
)

profesores <-
  profesores %>% 
  add_row(dni = c(1,2,3, 4),
          Nombre = c('Pepe', 'Juan', 'Pepe', 'Juan'),
          apellido1 = c('Alvarez', 'Alvarez', 'Alvarez', 'Alvarez'),
          apellido2 = c('Alvarez', 'Lopez', 'Garcia', 'Lopez'),
          nro = c(4,5,6, 7)
  )

alumnos 
profesores


# Esto no funciona porque las columnas profesores$nro y alumnos$matricula comparten dominio pero se llaman diferente
profesores %>% 
  filter(apellido2 == 'Alvarez') %>% 
  select(nro, Nombre, apellido1, apellido2) %>% 
  union(.,
        alumnos %>% 
          select(matricula, Nombre, Ape1, Ape2)) %>% 
  arrange(nro, apellido1, apellido2)

# Es mas correcto renombrar los campos, el algebra lo exige
profesores %>% 
  filter(apellido2 == 'Alvarez') %>% 
  select(id = nro, Nombre, Ape1 = apellido1, Ape2 = apellido2) %>% 
  union(.,
        alumnos %>% 
          select(id = matricula, Nombre, Ape1, Ape2)) %>% 
  #arrange(nro, Ape1, Ape2) # Falla porque `nro` ya no existe
  arrange(id, Ape1, Ape2)


# * 3.6 Producto Cartesiano -----------------------------------------------
# Produce una nueva relación con:
# 1) Todos los atributos de A X B (si hay campos comunes se repiten)
# 2) Todas las combinaciones posibles entre las filas de las tablas A X B --> ¡tengan o no tengan sentido!

# ** 3.6.0 creamos las tablas ---------------------------------------------
rm(oficina, empleado, categoria)

# Tabla Oficinas
oficinas <- tibble(
  n_oficina = numeric(),
  poblacion = character(),
  region = character(),
  ventas = numeric(),
  objetivo = numeric()
)

oficinas <- 
  oficinas %>% 
  add_row(n_oficina = c(1, 2), 
          poblacion = c('Madrid', 'Bilbao'), 
          region = c('CENTRO', 'NORTE'), 
          ventas = c(1000000, 900000), 
          objetivo = c(1200000, 1000000))

# Tabla categorias
categorias <- tibble(
  cargo = character(),
  sal = numeric()
)

categorias <- 
  categorias %>% 
  add_row(cargo = c('VENDEDOR', 'ADMINISTRATIVO', 'JEFE'), 
          sal = c(2000, 1000, 4000))

# Tabla empleados
empleados <- tibble(
  cod = numeric(),
  nombre = character(),
  oficina = numeric(),
  cargo = character(),
  comision = numeric()
)

empleados <- 
  empleados %>% 
  add_row(cod = c(1,2,3,4,5), 
          nombre = c('Pepe', 'Maria', 'Juan', 'Carlos', 'Luis'), 
          oficina = c(1, 1, 1, 2, 2), 
          cargo = c('VENDEDOR', 'VENDEDOR', 'JEFE', 'JEFE', 'ADMINISTRATIVO'), 
          comision = c(10,15,25,20,NA)
  )

# Revisamos
oficinas
categorias
empleados

# ** 3.6.1 Producto cartesiano (PC) de Oficinas X Empleado ----------------
# La función para el PC en dplyr (tidyr) es crossing.
# Revisar número de columnas (suma de atributos = suma de grados)
# Revisar número de filas (multiplicación de cardinalidades --> 2 oficinas X 5 empleados = 10 filas)

oficinas %>% 
  crossing(., empleados)

# Agregando todas las combinaciones posibles
# Revisar atributo "Cargo" --> Da error porque no pueden haber dos columnas con igual nombre
oficinas %>% 
  crossing(., empleados, categorias)

# usando el argumento .name_repair igualamos a SQL
oficinas %>% 
  crossing(., empleados, categorias, .name_repair = "minimal")


# Qué pasa si sólo queremos un campo y es uno duplicado --error!
oficinas %>% 
  crossing(., empleados, categorias, .name_repair = "minimal") %>% 
  select(empleados$cargo)


# ** ALIAS DE TABLA -------------------------------------------------------
# no existe un equivalente sencillo en `dpyr`.


# * 3.7 Theta Join --------------------------------------------------------
# Permite fusionar dos tablas en función de la condición representada por theta (>, <, =, !=, etc).


# ** 3.7.0 Creamos las tablas ---------------------------------------------
rm(oficina, empleado, categoria)

# Tabla Oficinas
oficinas <- tibble(
  n_oficina = numeric(),
  poblacion = character(),
  region = character(),
  ventas = numeric(),
  objetivo = numeric()
)

oficinas <- 
  oficinas %>% 
  add_row(n_oficina = c(1, 2), 
          poblacion = c('Madrid', 'Bilbao'), 
          region = c('CENTRO', 'NORTE'), 
          ventas = c(1000000, 900000), 
          objetivo = c(1200000, 1000000))

# Tabla categorias
categorias <- tibble(
  cargo = character(),
  sal = numeric()
)

categorias <- 
  categorias %>% 
  add_row(cargo = c('VENDEDOR', 'ADMINISTRATIVO', 'JEFE'), 
          sal = c(2000, 1000, 4000))

# Tabla empleados
empleados <- tibble(
  cod = numeric(),
  nombre = character(),
  oficina = numeric(),
  cargo = character(),
  comision = numeric()
)

empleados <- 
  empleados %>% 
  add_row(cod = c(1,2,3,4,5), 
          nombre = c('Pepe', 'Maria', 'Juan', 'Carlos', 'Luis'), 
          oficina = c(1, 1, 1, 2, 2), 
          cargo = c('VENDEDOR', 'VENDEDOR', 'JEFE', 'JEFE', 'ADMINISTRATIVO'), 
          comision = c(10,15,25,20,0)
  )

# Revisamos
oficinas
categorias
empleados


# ** 3.7.1 Join derivado --------------------------------------------------
# Producto cartesiano. Aparecen todas las combinaciones
# Revisar a Pepe alineado con diferentes oficinas
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal")

# Para hacerlo más claro, revisar a Carlos en ambas oficinas (Bilbao y Madrid)
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal") %>% 
  select(nombre, poblacion) %>% 
  distinct()

# Para pedir que salgan aquellas asociaciones con oficinas de manera correcta, pido una igualdad entre oficinas
# Realizando el Equi-Join (theta join de igualdades)
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal") %>% 
  filter(n_oficina == oficina) %>%
  select(nombre, poblacion) %>% 
  distinct() 

# Usando un Theta (no equi) join 
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal") %>% 
  filter(((comision*ventas)/100) > (objetivo)/8) %>%
  select(nombre) %>% 
  distinct() 

# Cuidado que este theta join no evita las filas espúrias
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal") %>% 
  filter(((comision*ventas)/100) > (objetivo)/8) %>%
  #  select(nombre) %>% 
  distinct() 

# Condicion de Theta después de producto cartesiano con Otros campos
# Quienes cumplen una condicion pero que pueda suceder en cualquier oficina
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal") %>% 
  filter(((comision*ventas)/100) > (objetivo)/8) %>%
  select(nombre, oficina, n_oficina) %>% 
  distinct() 

# Igual que anterior, pero asegurando que salga la oficina correspondiente y no en cualquiera
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal") %>% 
  filter(n_oficina == oficina & ((comision*ventas)/100) > (objetivo)/8) %>%
  select(nombre, oficina, n_oficina) %>% 
  distinct() 

# Mostrando todos los campos
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal") %>% 
  filter(n_oficina == oficina & ((comision*ventas)/100) > (objetivo)/8) %>%
  #select(nombre, oficina, n_oficina) %>% 
  distinct() 

## HASTA AQUI MARTES 29 y JUEVES 31 OCTUBRE ##
# ** 3.7.2 Join Natural ---------------------------------------------------
# Actualizamos la tabla oficinas
# Tabla Oficinas
oficinas <- tibble(
  n_oficina = numeric(),
  poblacion = character(),
  region = character(),
  ventas = numeric(),
  objetivo = numeric()
)

oficinas <- 
  oficinas %>% 
  add_row(n_oficina = c(1, 2), 
          poblacion = c('Madrid', 'Bilbao'), 
          region = c('CENTRO', 'NORTE'), 
          ventas = c(1000000, 400000), 
          objetivo = c(1200000, 1000000))

# Revisamos
oficinas
categorias
empleados


# *** 3.7.2.1 Producto Cartesiano -----------------------------------------
# Producto Cartesiano de Empleado X oficina (1º empleado) = 10 filas!
empleados %>% 
  crossing(., oficinas, .name_repair = "minimal") 

# Join usando atributos de diferente nombre
# Cada empleado debe salir con su oficina, por lo que agregamos la condicion de theta join
# Cada empleado sale solo con su padre por lo que Nº Filas = Nº Empleados --> 5 filas!
empleados %>% 
  crossing(., oficinas, .name_repair = "minimal") %>% 
  filter(oficina == n_oficina)


# *** 3.7.2.2 Atributos de igual nombre -----------------------------------
# Join usando atributos de == nombre
# Todos los nombres
empleados %>% 
  crossing(., categorias, .name_repair = "minimal") 

# Tratando de hacer el PC y luego el filtrado
empleados %>% 
  crossing(., categorias, .name_repair = "minimal") %>% 
  filter(oficina == oficina)

# Indexación de tabla como en SQL es imposible
empleados %>% 
  crossing(., categorias, .name_repair = "minimal") %>% 
  filter(empleados$oficina == categorias$oficina)

# uso correcto del argumento .name_repair
empleados %>% 
  crossing(., categorias, .name_repair = "universal") 

# Filtrado correcto
empleados %>% 
  crossing(., categorias, .name_repair = "universal") %>% 
  filter(`cargo...4` == `cargo...6`)


# *** 3.7.2.3 Union de 3 tablas -------------------------------------------
# para juntar más de una relación se necesitan más de un enganche (3 vagones y 2 enganches)
# deben salir solo 5 filas ya que hay 5 empleados

# Probando todo
categorias %>% 
  crossing(., empleados, oficinas, .name_repair = "minimal")

# Nombres modificados para poder hacer el filter
categorias %>% 
  crossing(., empleados, oficinas, .name_repair = "universal")

# Uniendo las tablas y filtrando para que solo queden las filas que corresponden
categorias %>% 
  crossing(., empleados, oficinas, .name_repair = "universal") %>% 
  filter(oficina == n_oficina & `cargo...1` == `cargo...6`) %>% 
  arrange(cod)

# ACTUALIZAMOS TABLAS
# Tabla Oficinas
oficinas <- tibble(
  n_oficina = numeric(),
  poblacion = character(),
  region = character(),
  ventas = numeric(),
  objetivo = numeric()
)

oficinas <- 
  oficinas %>% 
  add_row(n_oficina = c(1, 1, 2), 
          poblacion = c('Madrid', 'Bilbao', 'Burgos'), 
          region = c('CENTRO', 'NORTE', 'CENTRO'), 
          ventas = c(1000000, 400000, 400000), 
          objetivo = c(1200000, 1000000, 800000))


# Tabla empleados
empleados <- tibble(
  cod = numeric(),
  nombre = character(),
  oficina = numeric(),
  region  = character(),
  cargo = character(),
  comision = numeric()
)

empleados <- 
  empleados %>% 
  add_row(cod = c(1,2,3,4,5), 
          nombre = c('Pepe', 'Maria', 'Juan', 'Carlos', 'Luis'), 
          oficina = c(1, 1, 1, 1, 2), 
          region = c('CENTRO', 'CENTRO', 'CENTRO', 'NORTE', 'CENTRO'),
          cargo = c('VENDEDOR', 'VENDEDOR', 'JEFE', 'JEFE', 'ADMINISTRATIVO'), 
          comision = c(10,15,25,20,0)
  )

# Revisamos
oficinas
categorias
empleados

# Join similar al anterior (== nombre) por lo que necesitamos reparacion de nombres, pero como además
# una de las conexiones es una PK compuesta, necesitamos 2 filtros
categorias %>% 
  crossing(., empleados, oficinas, .name_repair = "universal") %>% 
  filter((oficina == n_oficina & `region...6` == `region...11`) & `cargo...1` == `cargo...7`)

# Aquellos salarios mayores que 2000 ó ventas mayores que 50000
# Uso correcto de paréntesis
categorias %>% 
  crossing(., empleados, oficinas, .name_repair = "universal") %>% 
  filter((oficina == n_oficina & `region...6` == `region...11`) & `cargo...1` == `cargo...7` & (sal > 2000 | ventas > 500000))

# ** 3.7.3 Join Externo ---------------------------------------------------
# Cuando se unen relaciones a través de un join y que no existe combinación de tuplas, en un
# join interno no se mostrarán las celdas "vacías". En un Join externo forzaremos a que sí se muestren.

# ACTUALIZAMOS TABLAS
# Tabla Oficinas
oficinas <- tibble(
  n_oficina = numeric(),
  poblacion = character(),
  region = character(),
  ventas = numeric(),
  objetivo = numeric()
)

oficinas <- 
  oficinas %>% 
  add_row(n_oficina = c(1, 2, 3), 
          poblacion = c('Madrid', 'Bilbao', 'Burgos'), 
          region = c('CENTRO', 'NORTE', 'CENTRO'), 
          ventas = c(1000000, 900000, 500000), 
          objetivo = c(1200000, 1000000, 800000))

# Tabla categorias
categorias <- tibble(
  cargo = character(),
  sal = numeric()
)

categorias <- 
  categorias %>% 
  add_row(cargo = c('VENDEDOR', 'ADMINISTRATIVO', 'JEFE', 'RECADERO'), 
          sal = c(2000, 1000, 4000, 1000))

# Tabla empleados
empleados <- tibble(
  cod = numeric(),
  nombre = character(),
  oficina = numeric(),
  cargo = character(),
  comision = numeric()
)

empleados <- 
  empleados %>% 
  add_row(cod = c(1,2,3,4,5, 6, 7, 8), 
          nombre = c('Pepe', 'Maria', 'Juan', 'Carlos', 'Luis', 'Alberto', 'Pedro', 'Rodrigo'), 
          oficina = c(1, 1, 1, 2, 2, NA, NA, 1), 
          cargo = c('VENDEDOR', 'VENDEDOR', 'JEFE', 'JEFE', 'ADMINISTRATIVO', 'VENDEDOR', 'VENDEDOR', NA), 
          comision = c(10,15,25,20,0, 10, 15, 15)
  )



# Revisamos
oficinas
categorias
empleados

# JOIN INTERNO TRADICIONAL
# no se muestra ni Alberto, ni Pedro ni Rodrigo (tienen null en algún campo)
categorias %>% 
  crossing(., empleados, oficinas, .name_repair = "universal") %>%
  #filter(oficina == n_oficina )
  filter(oficina == n_oficina & `cargo...1` == `cargo...6`) %>% 
  arrange(cod)


# * 3.8 JOINS Cualificados ------------------------------------------------

# ** 3.8.1 CROSS JOIN -----------------------------------------------------
# representa el producto cartesiano
oficinas %>% 
  cross_join(., empleados)

# Se puede usar la misma formula anterior
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal")

# ** 3.8.2 INNER JOIN -----------------------------------------------------
# Vuelve a existir la equivalencia con R!

# se puede hacer de la manera tradicional
oficinas %>% 
  crossing(., empleados, .name_repair = "minimal") %>% 
  filter(n_oficina == oficina) %>% 
  arrange(cod) # opcional, solo por equivalencia con SQL

# Función inner_join()
oficinas
empleados

# Revisar warnings()
oficinas %>%
  inner_join(., empleados,  by = c("n_oficina" = "oficina")) 

# para evitar warnings y disposición como en SQL
oficinas %>%
  inner_join(., empleados,  by = c("n_oficina" = "oficina"), multiple = "all") %>% 
  arrange(cod)

# Para condicionantes multiples, mejor abrir un filter()
oficinas %>%
  inner_join(., empleados,  by = c("n_oficina" = "oficina"), multiple = "all") %>% 
  filter(((comision*ventas)/100) > (objetivo)/8) %>% 
  arrange(cod) 

# ** 3.8.3 OUTER JOIN -----------------------------------------------------
# Puede ser left/right/full _join()

# Permite seleccionar qué tabla aporta el outer (left, right o ambas (full))


# *** 3.8.3.1 LEFT JOIN ---------------------------------------------------
# en este caso para que salgan todas las oficinas (incluso las que no tienen empleado --> n_oficina = 3)
oficinas %>%
  left_join(., empleados,  by = c("n_oficina" = "oficina"), multiple = "all") %>% 
  arrange(cod)


# *** 3.8.3.2 RIGHT JOIN --------------------------------------------------
#  De igual manera se pueden pedir las oficinas incluso que no tengan empleados (Right Join)
# Efecto de la proyección parcial v/s la total en el orden de los atributos
empleados %>%
  right_join(., oficinas,  by = c("oficina" = "n_oficina"), multiple = "all") %>% 
  arrange(cod)

# todas las oficinas con empleados que cumplan con esos objetivos (condición theta join cualquiera)
# las oficinas que no tienen empleados que cumplan esa condición aparecen pero con valores null.
# No funciona como en SQL
oficinas %>%
  left_join(., empleados,  by = c("n_oficina" = "oficina"), multiple = "all") %>% 
  filter(((comision*ventas)/100) > ((objetivo)/8)) %>% 
  arrange(cod) 

# *** 3.8.3.3 FULL JOIN ---------------------------------------------------
# Full join muestra los NA en las filas que no tienen coincidencia en ambas tablas

# todas las oficinas aunque no tengan empleados y todos los empleados aunque no tengan oficina
oficinas %>%
  full_join(., empleados,  by = c("n_oficina" = "oficina"), multiple = "all")


# ** 3.8.4 JOIN usando lista de campos ------------------------------------
# Como en R/dplyr el argumento para seleccionar la/las columnas a unir es un vector `c()` no hay necesidad de cambiar de función como ocurre en SQL.

# En R/dplyr NO requiere que los campos se llamen iguales, incluso puede haber una combinación de ellos.

# Join Interno usando el campo común que es Cargo. A diferencia de SQL, el atributo `cargo` no sale repetido.
categorias %>%
  inner_join(., empleados,  by = c("cargo"), multiple = "all") %>% 
  arrange(cod)

#  Al usar un LEFT JOIN, aplicamos un OUTER JOIN, aparecen valores sin conexión (cargo = RECADERO)
# todos los cargos aunque no tenga empleados
categorias %>%
  left_join(., empleados,  by = c("cargo"), multiple = "all") %>% 
  arrange(cod)

# todos los cargos sin empleados, pero también salen empleados sin cargos
categorias %>%
  full_join(., empleados,  by = c("cargo"), multiple = "all") %>% 
  arrange(cod)

# ** 3.8.5 NATURAL JOIN ---------------------------------------------------
# En R/dplyr el natural join se da automáticamente desactivando el argumento by --> `by = NULL`
# En R/dplyr las columnas de unión siempre se elimina su duplicidad

# INNER JOIN con by
categorias %>%
  inner_join(., empleados,  by = c("cargo"), multiple = "all") %>% 
  arrange(cod)

# INNER JOIN NATURAL el sólo sabe que Cargo se repite (= resultado)
categorias %>%
  inner_join(., empleados,  by = NULL, multiple = "all") %>% 
  arrange(cod)

# También para Joint externos (todas las categorías aunque no tengan empleados)
categorias %>%
  left_join(., empleados,  by = NULL, multiple = "all") %>% 
  arrange(cod)

# Join natural Externo donde aparece cargos sin empleados y empleados sin cargo
categorias %>%
  full_join(., empleados,  by = NULL, multiple = "all") %>% 
  arrange(cod)


# * 3.9 Ejercicios de JOINS ----------------------------------------------
# Sólo hacerlos en SQL

library(dplyr)

# --------------------------------------------------------------------------
# 1.1 Utilizando ON y proyectando (a1, a2, a3, a4, b3, b4)
# --------------------------------------------------------------------------

# Atención que los campos repetidos a1 y a2 se solicitan sólo una vez.
# el ON (ejercicio 1.1) no quita atributos duplicados (es un theta Join) 
# a diferencia de usar el USING o el NATURAL dentro del Join

# Usamos el ON y seleccionamos todos los campos
result1_1 <- a %>%
  inner_join(b, by = c("a1" = "b.a1", "a2" = "b.a2"))

# Proyectamos solo los campos deseados
result1_1_proj <- a %>%
  inner_join(b, by = c("a1" = "b.a1", "a2" = "b.a2")) %>%
  select(a1, a2, a3, a4, b3, b4)

# --------------------------------------------------------------------------
# 1.2 Utilizando USING y proyectando (a1, a2, a3, a4, b3, b4)
# --------------------------------------------------------------------------

# En este caso, al usar USING los campos comunes se proyectan solo individualmente
result1_2 <- a %>%
  inner_join(b, by = c("a1", "a2"))

# --------------------------------------------------------------------------
# 1.3 Utilizando NATURAL y proyectando (a1, a2, a3, a4, b3, b4)
# --------------------------------------------------------------------------

# En este caso, al usar NATURAL los campos comunes se proyectan solo individualmente
result1_3 <- a %>%
  inner_join(b)

# --------------------------------------------------------------------------
# 2.1 Respuesta a la pregunta sin más
# --------------------------------------------------------------------------

# se hace el JOIN usando IdProfesor que aparece en ambas, 
# pero es PK en Profesores (identifica a c/profesor) 
# y sin embargo es FK en asignaturas, 
# ya que indica qué profe entrega cada asignatura pero puede repetirse 
# ya que hay un profe que da más de una asignatura
result2_1 <- profesores %>%
  inner_join(asignaturas, by = "IdProfesor")

# --------------------------------------------------------------------------
# 2.2 NATURAL sale 0 filas
# --------------------------------------------------------------------------

# NATURAL busca todos los campos con el mismo nombre y 
# además de IdProfesor hay otro campo que se llama igual, que es Nombre. 
# Sin embargo en profesores el nombre indica el nombre del profe 
# y en asignatura indica el nombre de la asignatura, 
# por lo que nunca van a coincidir sus dominios.
result2_natural <- profesores %>%
  natural_join(asignaturas)

# --------------------------------------------------------------------------
# 3.1 Departamentos y proyectos
# --------------------------------------------------------------------------

# departamentos.presupuesto ha de ser mayor (>) que proyectos.presupuesto.
# necesitamos seleccionar a partir del producto cartesiano aquellas que cumplan un ON
result3_1 <- departamentos %>%
  inner_join(proyectos, by = character(0)) %>% # Producto cartesiano
  filter(presupuesto.x >= presupuesto.y) %>%
  select(nombre_dept = nombre.x, nombre_proy = nombre.y)

# --------------------------------------------------------------------------
# 3.2 Con todos los proyectos
# --------------------------------------------------------------------------

# departamentos.presupuesto ha de ser mayor (>) que proyectos.presupuesto.
# Para sacarlo necesitaremos hacer un join externo y ver el null del proy1 (son pobres!)
result3_2 <- departamentos %>%
  left_join(proyectos, by = character(0)) %>%
  filter(presupuesto.x >= presupuesto.y) %>%
  select(nombre_dept = nombre.x, nombre_proy = nombre.y)

# --------------------------------------------------------------------------
# 4.1 Listado de profesores con su(s) asignatura(s)
# --------------------------------------------------------------------------

# asignaturas y profesores no se pueden unir (aunque nombre sea común) y requiere imparte
# 1º) join de asignatura con imparte
result4_1 <- profesores %>%
  left_join(imparte, by = "dni") %>%
  left_join(asignaturas, by = "id") %>%
  select(profesor = nombre.x, asignatura = nombre.y)

# --------------------------------------------------------------------------
# 4.2 Listado de asignatura(s) con su(s) profesore(s)
# --------------------------------------------------------------------------

# igual que anterior porque es simétrica
result4_2 <- asignaturas %>%
  left_join(imparte, by = "id") %>%
  left_join(profesores, by = "dni") %>%
  select(asignatura = nombre.x, profesor = nombre.y)

# --------------------------------------------------------------------------
# 4.3 Listado de asignatura(s) con su(s) profesore(s) y quienes no imparten
# --------------------------------------------------------------------------

# primero asignaturas que no imparte nadie
result4_3 <- asignaturas %>%
  left_join(imparte, by = "id") %>%
  full_join(profesores, by = "dni") %>%
  select(asignatura = nombre.x, profesor = nombre.y)

# --------------------------------------------------------------------------
# 4.4 Profesores que no podrían cubrir alguna asignatura
# --------------------------------------------------------------------------

# mirar horas de contrato y horas de clases
# profesor 1 no sale porque tiene 100 horas y puede con todas 
result4_4 <- profesores %>%
  inner_join(asignaturas, by = character(0)) %>%
  filter(horasContrato < horasclase) %>%
  select(profesor = nombre.x, horas_contrato = horasContrato, 
         asignatura = nombre.y, horas_clase = horasclase)

result4_4_all <- profesores %>%
  left_join(asignaturas, by = character(0)) %>%
  filter(horasContrato < horasclase) %>%
  select(profesor = nombre.x, horas_contrato = horasContrato, 
         asignatura = nombre.y, horas_clase = horasclase)

# --------------------------------------------------------------------------
# 9. Relación de conocimiento entre chicos y chicas
# --------------------------------------------------------------------------

# Creamos las tablas
chicos <- data.frame(DNIchico = c(1, 2, 3), nombre = c("Pepe", "Juan", "Luis"))
chicas <- data.frame(DNIchica = c(4, 5), nombre = c("Ana", "Maria"))
conoce <- data.frame(DNIchico = c(1, 1, 2), DNIchica = c(4, 5, 4))

# Todas las combinaciones chico x chica
todas_combinaciones <- expand.grid(DNIchico = chicos$DNIchico, DNIchica = chicas$DNIchica)

# Restamos las parejas que ya se conocen
parejas_no_conocidas <- todas_combinaciones %>%
  anti_join(conoce, by = c("DNIchico", "DNIchica"))

# Chicos que no conocen a todas las chicas
chicos_que_no_conocen_a_todas <- unique(parejas_no_conocidas$DNIchico)

# Chicos que conocen a todas las chicas
chicos_que_conocen_a_todas <- chicos %>%
  filter(!DNIchico %in% chicos_que_no_conocen_a_todas) %>%
  select(DNIchico)

# Visualización de resultados
list(result1_1, result1_1_proj, result1_2, result1_3, result2_1, 
     result2_natural, result3_1, result3_2, result4_1, result4_2, 
     result4_3, result4_4, result4_4_all, parejas_no_conocidas, 
     chicos_que_no_conocen_a_todas, chicos_que_conocen_a_todas)




