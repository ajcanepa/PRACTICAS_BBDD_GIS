# Test Lógicos ------------------------------------------------------------

# * Between ---------------------------------------------------------------
# Sirve para determinar si los valores están dentro de un determinado rango (cerrado) de valores
rm(alumnos)

alumnos <- tibble(
  nombre = character(),
  ape1 = character(),
  ape2 = character(),
  fecha_nacimiento = lubridate::ymd(),
  altura = numeric()
)

alumnos

alumnos <-
  alumnos %>% 
  add_row(.data = ., nombre = c('Pepe', 'Pepe', 'Pepe', 'Pepe', 'Pepe', 'Pepe'), ape1 = c('Álvarez', 'Fernández', 'García', 'González', 'López', 'Rodríguez'), ape2 = c('Fernández', 'Fernández', 'Fernández', 'Fernández', 'Fernández', 'Fernández') , fecha_nacimiento = c((lubridate::today() - 365*17), (lubridate::today() - 365*18), (lubridate::today() - 365*19), (lubridate::today() - 365*20), (lubridate::today() - 365*21), (lubridate::today() - 365*22)), altura = c(1.7,1.7,1.9,1.7,1.7,1.7)) 

alumnos

# Selecciono los apellidos de los alumnos que nacieron entre 19 y 18 años atrás

# Filtramos usanod >= y <=
alumnos %>% 
  filter(fecha_nacimiento >= (lubridate::today() - 365*19) & fecha_nacimiento <= (lubridate::today() - 365*18))

# Filtramos equivalente con Between
alumnos %>% 
  filter(between(fecha_nacimiento, (lubridate::today() - 365*19), (lubridate::today() - 365*18)))


#  GREP (Like equivalent) ó Búsqueda con Comodines -----------------------------
# No hay directa equivalencia y hay que trabajar con expresiones regulares
# https://evoldyn.gitlab.io/evomics-2018/ref-sheets/R_strings.pdf

rm(alumnos)

alumnos <- tibble(
  nombre = character()
)

alumnos <- 
  alumnos %>% 
  add_row(., nombre = c('ANA', NA, 'PEDRO', 'ALBERTO', 'ALBERTA', 'MARIA', 'PEPE', 'PABLO'))

alumnos

# Comienzan por P
alumnos %>% 
  grep(pattern = "^P", x = .$nombre, value = TRUE) 

# Terminan en O
alumnos %>% 
  grep(pattern = "*O", x = .$nombre, value = TRUE) 

# Contienen P u O
alumnos %>% 
  grep(pattern = "P|O", x = .$nombre, value = TRUE) 

# Comienzan por P ó Terminan en O
alumnos %>% 
  grep(pattern = "P*O", x = .$nombre, value = TRUE) 


# FUNCIONES DE AGREGACION -------------------------------------------------
rm(empleados)

empleados <- tibble(
  nombre = character(),
  salario = numeric(),
  nHorasExtras = numeric(),
  provincia = character()
)

empleados <-
  empleados %>% 
  add_row(nombre = c('Pepe', 'Juan', 'Ana'), salario = c(100, 200, 200), nHorasExtras = c(0, 10, 20), provincia = c('BURGOS', 'BURGOS', 'LEON'))

empleados

# Calculamos el valor máximo de una columna numérica
empleados %>% 
  summarise(salario = max(salario))

# Uso de una constante y un atributo para en este caso mostrar el 80% del salario
empleados %>% 
  summarise(salario = max(salario)*0.8)


# Agregamos al salario un beneficio por horas extras
empleados %>% 
  summarise(salario = mean(salario + 60*nHorasExtras))

# empleados %>% 
#   summarise(salario = mean(salario + (60*nHorasExtras)))

# No funciona porque al condensar el resultado en una fila, ¿qué nombre elije y con que criterio?
empleados %>% 
  summarise(salario = mean(salario + 60*nHorasExtras), nombre = nombre)

# si que puede ir una cte en la select u otra F. de Agregación, pero no una referencia directa a un campo
empleados %>% 
  summarise(texto = "El promedio TOTAL es:", salario = mean(salario + 60*nHorasExtras))

# usamos un filtro para que el cálculo se realice solo en algunas de las filas
empleados %>% 
  filter(provincia == 'BURGOS') %>% 
  summarise(texto = "El promedio en BURGOS es:", salario = mean(salario + 60*nHorasExtras))

# A diferencia de postgreSQL SÍ pueden haber funciones de agregación en el WHERE/FILTER --> analizar resultado cambiandolo por 1000
# Suele no usarse de esta manera
empleados %>% 
  filter(mean(salario) < 1000) %>% 
  summarise(salario = mean(salario + 60*nHorasExtras))

# * Conteo - n() ------------------------------------------------------
# cuántas filas tiene la tabla de empleados.
empleados %>% 
  summarise(Total = n())

# cuántas filas de la tabla de empleados tienen un valor de salario mayor que 100
empleados %>% 
  filter(salario > 100) %>% 
  summarise(Total = n())


# ** Conteo y los NAs - COUNT(), n() ------------------------------------------------
rm(alunos)

alumnos <- tibble(
  nombre = character(),
  altura = numeric(),
  nota = numeric()
)

alumnos <-
  alumnos %>% 
  add_row(nombre = c('Pepe', 'Ana', 'Pablo', 'Pedro'), altura = c(1.7, 1.72, 1.70, NA), nota = c(2.3, 5.4, NA, 8.0))

alumnos

# Tenemos 2 funciones que nos permiten contar el número de filas
# Número total de ocurrencias
alumnos %>% 
  summarise(Total = n())

alumnos %>% 
  count()

# Número de ocurrencias que cumplen un criterio
alumnos %>% 
  filter(nombre >= 'Pablo') %>% 
  count()

# Sin embargo count se comporta como una variable de agrupación y no es comparable con el COUNT de SQL
alumnos %>% 
  filter(nombre >= 'Pablo') %>% 
  count(nota)

# Si usamos n(), los NA los contará igualmente
alumnos %>% 
  filter(nombre >= 'Pablo') %>% 
  select(nota) %>% 
  summarise(Total = n())

# Usaremos n() y la negación de los NA en el atributo especificado
alumnos %>% 
  filter(nombre >= 'Pablo' & !is.na(nota)) %>% 
  summarise(Total = n())

# distinct/all
alumnos

# Para contar los diferentes deberemos usar n_distinct()
# Los NAs los cuenta como diferentes y por ende los cuenta
alumnos %>% 
  summarise(Altura = n(), Altura_2 = n_distinct(.$altura, na.rm = FALSE))

# Podemos usar el argumento "na.rm = TRUE", para evitar que cuente los NAs
alumnos %>% 
  summarise(Altura = n(), Altura_2 = n_distinct(.$altura, na.rm = TRUE))


# * Las funciones MAX y MIN ---------------------------------------------------------
rm(alumnos)

alumnos <- tibble(
  nombre = character(),
  nota = numeric(),
  fechaNac = lubridate::dmy()
)

alumnos <-
  alumnos %>% 
  add_row(nombre = c('Pedro', 'Ana', 'Pablo', 'Pepe', NA, 'Zacarías'), 
          nota = c(2.3, 10, NA, 8, 1, 1), 
          fechaNac = lubridate::dmy(c("01-10-1983", "15-12-1980", "05-12-1984", NA, NA, NA))
  )

alumnos

# seleccionamos aquellos mayores/iguales que nombre 'Pablo'
alumnos %>% 
  select(nombre, fechaNac, nota) %>% 
  filter(nombre >= 'Pablo')

# Funciones de agregación en el summarise, ¡cuando hay NA siempre es NA!
alumnos %>% 
  filter(nombre >= 'Pablo') %>% 
  summarise(max_name = max(nombre), min_fecha = min(fechaNac), max_nota = max(nota))

# Usamos el argumento na.rm = TRUE (por defecto es FALSE) para omitir los NAs
alumnos %>% 
  filter(nombre >= 'Pablo') %>% 
  summarise(max_name = max(nombre, na.rm = TRUE), min_fecha = min(fechaNac, na.rm = TRUE), max_nota = max(nota, na.rm = TRUE))

# MAX/MIN cuando filter(where) no se verifica por ninguna fila o tabla vacia
# Operaciones matemáticas en el vacío intentan realizarse, por lo que a diferencia de SQL el resultado es más variopinto
alumnos %>% 
  filter(nombre < 'Ana') %>% 
  summarise(max_name = max(nombre, na.rm = TRUE), min_fecha = min(fechaNac, na.rm = TRUE), max_nota = max(nota, na.rm = TRUE))

# MAX/MIN cuando where se verifica solo en filas en las q la expresion evaluada es siempre nulo
# Intenta calcular el mínimo de NA ya que no hay "non-missing arguments" para la función min()
alumnos %>% 
  filter(nombre >= 'Pepe') %>% 
  summarise(max_name = max(nombre, na.rm = TRUE), min_fecha = min(fechaNac, na.rm = TRUE), max_nota = max(nota, na.rm = TRUE))

# Si quitamos la restricción de que elimine los NA, se parece a SQL
alumnos %>% 
  filter(nombre >= 'Pepe') %>% 
  summarise(max_name = max(nombre, na.rm = FALSE), min_fecha = min(fechaNac, na.rm = FALSE), max_nota = max(nota, na.rm = FALSE))



# * Las funciones SUM y AVG -----------------------------------------------
alumnos

# Nuevamente, en cada operación dodne hay NA saldrá un NA (es un warning)
alumnos %>% 
  summarise(sum_nota = sum(nota))

alumnos %>% 
  summarise(sum_nota = sum(nota, na.rm = TRUE))

# En R el distinct es más restrictivo ya que se debe usar antes...
alumnos %>% 
  distinct(nota) %>% 
  summarise(sum_nota = sum(nota, na.rm = TRUE))


# GROUP_BY() --------------------------------------------------------------
# Se utiliza para generar grupos sobre los que se realizan cálculos.
rm(oficinas, categorias, empleados)

oficinas <- tibble(
  n_oficina = character(),
  poblacion = character(),
  region = character(),
  ventas = numeric(),
  objetivo = numeric()
)

categorias <- tibble(
  cargo = character(),
  sal = numeric()
)

empleados <- tibble(
  cod = numeric(),
  nombre = character(),
  oficina = character(),
  cargo = character(),
  comision = numeric()
)

oficinas <- 
  oficinas %>% 
  add_row(n_oficina = c('OFI_1', 'OFI_2', 'OFI_3'), 
          poblacion = c('Burgos', 'León', 'Burgos'), 
          region = c(NA, NA, NA), 
          ventas = c(NA, NA, NA), 
          objetivo = c(NA, NA, NA))

categorias <- 
  categorias %>% 
  add_row(cargo = c('GERENTE', 'SECRETARIO', 'VENDEDOR'), 
          sal = c(10000, 1000, 3000))


empleados <- 
  empleados %>% 
  add_row(cod = c(1,2,3,4,5,6), 
          nombre = c('Pepe', 'Juan', 'Jorge', 'Luis', 'Ana', 'Antonio'), 
          oficina = c('OFI_1', 'OFI_1', 'OFI_1', 'OFI_2', NA, 'OFI_3'), 
          cargo = c('VENDEDOR', 'VENDEDOR', 'GERENTE', NA, NA, NA), 
          comision = c(10,20,30,15,5,NA)
  )


oficinas
categorias
empleados

# null se reconocen como repetidos
empleados

# Group_by aplica funciones "agrupadas", no se comporta como SQL
empleados %>% 
  select(cargo) %>% 
  group_by()

# Para obtener los valores únicos que hay en el atributo cargo
empleados %>% 
  select(cargo) %>% 
  distinct()

# Para obtener los valores únicos que hay en el atributo oficina
empleados %>% 
  select(oficina) %>% 
  distinct()

# para calcular el promedio del campo comisión en cada oficina
empleados %>% 
  group_by(oficina) %>% 
  summarise(prom_com = mean(comision))

# Para solucionar los problemas de NA hay dos aproximaciones
# NA en el cálculo
empleados %>% 
  group_by(oficina) %>% 
  summarise(prom_com = mean(comision, na.rm = TRUE)) # NaN no es un problema

# NA como categoría única de oficina
empleados %>% 
  drop_na(., oficina) %>% 
  group_by(oficina) %>% 
  summarise(prom_com = mean(comision, na.rm = TRUE)) # NaN no es un problema


# Agrupamientos por más de un criterio
# para calcular el promedio del campo comisión en cada oficina y para cada cargo
empleados %>% 
  #drop_na(., oficina) %>% 
  group_by(oficina, cargo) %>% 
  summarise(prom_com = mean(comision, na.rm = TRUE)) # NaN no es un problema

# Si queremos hacer una proyección con el select hemos de tener cuidado de no dejar la variable fuera sino el group_by no la verá
empleados %>% 
  select(oficina, cargo) %>% 
  group_by(oficina, cargo) %>% 
  summarise(prom_com = mean(comision, na.rm = TRUE))

empleados %>% 
  select(oficina, cargo, comision) %>% 
  group_by(oficina, cargo) %>% 
  summarise(prom_com = mean(comision, na.rm = TRUE))


# Hacemos el producto cartesiano y filtramos por las oficinas que son iguales (join)
empleados %>% 
  crossing(., oficinas) %>% 
  filter(oficina == n_oficina)


# Si calculamos el promedio para 
empleados %>% 
  crossing(., oficinas) %>% 
  filter(oficina == n_oficina) %>% 
  group_by(oficina) %>% 
  summarise(prom_com = mean(comision, na.rm = TRUE))

# No da error como en SQL pero lo correcto sería incluir las variables en el group_by
empleados %>% 
  crossing(., oficinas) %>% 
  filter(oficina == n_oficina) %>% 
  group_by(oficina) %>% 
  summarise(prom_com = mean(comision, na.rm = TRUE), prom_oficina = unique(oficina), prom_poblacion = unique(poblacion))

# Manera correcta
empleados %>% 
  crossing(., oficinas) %>% 
  filter(oficina == n_oficina) %>% 
  group_by(oficina, poblacion) %>% 
  summarise(prom_com = mean(comision, na.rm = TRUE))


# La clausula HAVING/FILTER -----------------------------------------------
rm(oficinas, vendedores)

oficinas <- tibble(
  n_oficina = character(),
  poblacion = character()
)

vendedores <- tibble(
  cod = numeric(),
  nombre = character(),
  oficina = character(),
  ventas = numeric()
)

oficinas <-
  oficinas %>% 
  add_row(n_oficina = c('OFI_1', 'OFI_2', 'OFI_3'), 
          poblacion = c('Burgos', 'León', 'Burgos')
  )

vendedores <-
  vendedores %>% 
  add_row(cod = c(1,2,3,4,5,6), 
          nombre = c('Pepe', 'Juan', 'Jorge', 'Luis', 'Ana', 'Antonio'), 
          oficina = c('OFI_1', 'OFI_1', 'OFI_1', 'OFI_2', NA, 'OFI_3'), 
          ventas = c(100,200,300,1500,500, NA))


oficinas
vendedores


# Calculamos el promedio de las comisiones en las oficinas de Burgos en las que las sumas de las ventas sea mayor que 100Calculamos el promedio de las comisiones en las oficinas de Burgos en las que las sumas de las ventas sea mayor que 100.

# En dplyr el having se reemplaza por un mutate %>% filter.
oficinas %>% 
  crossing(., vendedores) %>% 
  filter(oficina == n_oficina & poblacion == 'Burgos') %>% 
  group_by(n_oficina) %>% 
  mutate(sum_ventas = sum(ventas)) %>% 
  filter(sum_ventas > 100) %>% 
  summarise(prom_ventas = mean(ventas, na.rm = TRUE))



# ** Intercambiar los filtrados  ------------------------------------------
# Se puede intercambiar el orden del filtrado, de tal manera que el ejericio anterior también se puede ejecutar como:

oficinas %>% 
  crossing(., vendedores) %>% 
  filter(oficina == n_oficina) %>% 
  group_by(n_oficina) %>% 
  mutate(sum_ventas = sum(ventas)) %>% 
  filter(sum_ventas > 100 & poblacion == 'Burgos') %>% 
  summarise(prom_ventas = mean(ventas, na.rm = TRUE)) 


# ¿Cuál es mejor? --> El tiempo es oro! --> Muy pocas filas para que haya diferencias

system.time({ oficinas %>% 
    crossing(., vendedores) %>% 
    filter(oficina == n_oficina & poblacion == 'Burgos') %>% 
    group_by(n_oficina) %>% 
    mutate(sum_ventas = sum(ventas)) %>% 
    filter(sum_ventas > 100) %>% 
    summarise(prom_ventas = mean(ventas, na.rm = TRUE)) })

system.time({ oficinas %>% 
    crossing(., vendedores) %>% 
    filter(oficina == n_oficina) %>% 
    group_by(n_oficina) %>% 
    mutate(sum_ventas = sum(ventas)) %>% 
    filter(sum_ventas > 100 & poblacion == 'Burgos') %>% 
    summarise(prom_ventas = mean(ventas, na.rm = TRUE)) })


# Consultas con join externo y agrupamiento -------------------------------
rm(oficinas, categorias, empleados)

oficinas <- tibble(
  n_oficina = character(),
  poblacion = character(),
  region = character(),
  ventas = numeric(),
  objetivo = numeric()
)

categorias <- tibble(
  cargo = character(),
  sal = numeric()
)

empleados <- tibble(
  cod = numeric(),
  nombre = character(),
  oficina = character(),
  cargo = character(),
  comision = numeric()
)

oficinas <- 
  oficinas %>% 
  add_row(n_oficina = c('OFI_1', 'OFI_2', 'OFI_3'), 
          poblacion = c('Burgos', 'León', 'Burgos'), 
          region = c(NA, NA, NA), 
          ventas = c(NA, NA, NA), 
          objetivo = c(NA, NA, NA))

categorias <- 
  categorias %>% 
  add_row(cargo = c('GERENTE', 'SECRETARIO', 'VENDEDOR'), 
          sal = c(10000, 1000, 3000))


empleados <- 
  empleados %>% 
  add_row(cod = c(1,2,3,4), 
          nombre = c('Pepe', 'Juan', 'Jorge', 'Luis'), 
          oficina = c('OFI_1', 'OFI_1', 'OFI_1', 'OFI_2'), 
          cargo = c('VENDEDOR', 'VENDEDOR', 'GERENTE', NA), 
          comision = c(10,20,30,15)
  )


oficinas
categorias
empleados

# Primero hacemos la unión
oficinas %>% 
  left_join(., empleados, by = join_by(n_oficina == oficina))

# Para evitar el warning
oficinas %>% 
  left_join(., empleados, by = join_by(n_oficina == oficina), multiple = "all")

# Contamos el número de filas usando n()
oficinas %>% 
  left_join(., empleados, by = join_by(n_oficina == oficina), multiple = "all") %>% 
  group_by(n_oficina) %>% 
  summarise(num_oficina = n())

# Para que no cuente los NAs deberemos quitarlos
oficinas %>% 
  left_join(., empleados, by = join_by(n_oficina == oficina), multiple = "all") %>% 
  group_by(n_oficina) %>% 
  drop_na(nombre) %>% 
  summarise(num_oficina = n())

# Contamos el número de filas usando count()
oficinas %>% 
  left_join(., empleados, by = join_by(n_oficina == oficina), multiple = "all") %>% 
  group_by(n_oficina) %>% 
  drop_na(nombre) %>% 
  count(., .drop = FALSE)

# Otra opción para que se parezca más a SQL, es pedirle que en vez de contar (no puede eliminar los NA), lo que le pedimos es que haga una suma de los casos para una variable determinada.
oficinas %>% 
  left_join(., empleados, by = join_by(n_oficina == oficina), multiple = "all") %>% 
  group_by(n_oficina) %>%  
  summarise_at(vars(cod), ~sum(!is.na(.)))


# Todos los cargos junto con el número de empleados que los ocupan

# Si no tomamos en cuenta los NA, el resultado es incorrecto
categorias %>% 
  left_join(., empleados, multiple = "all") %>% 
  group_by(cargo) %>% 
  count(., .drop = FALSE)

# Si tomamos en cuenta los NA y los eliminamos, el resultado es correcto pero no "luce como" SQL
categorias %>% 
  left_join(., empleados, multiple = "all") %>% 
  group_by(cargo) %>% 
  drop_na(nombre) %>% 
  count(., .drop = FALSE)


# Si aplicamos la suma en vez del conteo queda mejor
categorias %>% 
  left_join(., empleados, multiple = "all") %>% 
  group_by(cargo) %>% 
  #summarise_at(vars(everything()), ~sum(!is.na(.)))
  summarise_at(vars(nombre), ~sum(!is.na(.)))
