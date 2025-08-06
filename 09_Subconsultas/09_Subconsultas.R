
# SUBCONSULTAS ------------------------------------------------------------
# EN R las subconsultas las revisaremos solo mirando los joins.

rm(oficinas, categorias, empleados)

oficinas <- tibble(
  n_oficina = character(),
  poblacion = character(),
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
          ventas = c(1000, 2000, NA), 
          objetivo = c(10000, 20000, 30000))

categorias <- 
  categorias %>% 
  add_row(cargo = c('GERENTE', 'SECRETARIO', 'VENDEDOR'), 
          sal = c(10000, 1000, 3000))


empleados <- 
  empleados %>% 
  add_row(cod = c(1,2,3,4), 
          nombre = c('Pepe', 'Juan', 'Alicia', 'Luis'), 
          oficina = c('OFI_1', 'OFI_1', 'OFI_1', 'OFI_2'), 
          cargo = c('VENDEDOR', 'VENDEDOR', 'GERENTE', NA), 
          comision = c(10,20,30,15)
  )


oficinas
categorias
empleados

# Si hacemos un join (left_join) completo, tendremos: 
oficinas %>% 
  left_join(x = ., y = empleados, by = c("n_oficina" = "oficina"), multiple = "all")

# Pero si solo queremos aquellos de la tabla empleados con una comision superior a 10, deberemos hacer una subconsulta 
oficinas %>% 
  left_join(x = .,
            y = empleados %>% 
              filter(comision > 10),
            by = c("n_oficina" = "oficina"), multiple = "all")