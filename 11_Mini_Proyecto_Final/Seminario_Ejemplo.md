---
title: "Seminario Asignatura"
subtitle: "Bases de Datos"
author: "Antonio Canepa"
date: "2026-10-01"
output: 
  html_document:
    keep_md: true
    self_contained: true
---

# Crear una conexión a una BBDD local usando R

Para poder ejecutar los comandos de `sql` en un documento RMarkdown, deberemos utilizar los paquetes `DBI` y `RPostgres`.

A continuación se detalla los pasos necesarios para generar una conexión local.


``` r
library(DBI)
library(RPostgres)
library(tidyverse)

con <- dbConnect(
  RPostgres::Postgres(),
  host     = "localhost",  # Dirección del host
  port     = 5432,         # Puerto de PostgreSQL
  dbname   = "postgres",   # Nombre de la base de datos
  user     = "postgres",   # Tu usuario de PostgreSQL
  password = "postgres"    # Tu contraseña de PostgreSQL
)
```

## Función auxiliar para leer tablas en R

PostgreSQL **pasa a minúsculas** los identificadores que no van entre comillas (`Nombre` se guarda como `nombre`, `Ape1` como `ape1`) y el tipo `char(n)` **rellena con espacios** hasta la longitud declarada (`'Pepe'` en un `char(20)` se devuelve como `'Pepe                '`). Para que en R podamos comparar textos sin sorpresas, leemos las tablas con una pequeña función que elimina esos espacios sobrantes.


``` r
leer <- function(connection = con, tabla = tabla) {
  dbReadTable(con, tabla) %>%
    as_tibble() %>%
    mutate(across(where(is.character), str_trim))
}
```

# Idea de Seminario

En este semianrio tendréis que ser capáz de generar tablas con datos relativos a la salud humana y/o biomedicina. Para esto tendréis que buscar en diferentes repositorios de datos disponibles.

A continuación te dejo un **pequeño** listado con recursos, pero se valorará la obtención de datos de diversos orígenes.

-   [Datos abiertos Gob. España](https://datos.gob.es/es/catalogo) / [`opendataes`](https://github.com/rOpenSpain/opendataes)
-   [Datos abiertos CyL](https://datosabiertos.jcyl.es/web/es/datos-abiertos-castilla-leon.html) / [`opendataes`](https://github.com/rOpenSpain/opendataes)
-   [Datos espaciales de hospitales](https://opendata.esri.es/datasets/ComunidadSIG::hospitales-de-espa%C3%B1a/about)
-   [INE (Instituto Nacional de Estadística) package](https://inebaser.wordpress.com/)
-   [rOpenSpain community](https://ropenspain.es/) / [GitHub-Repo](https://github.com/rOpenSpain)
-   [European Health Information Initiative (EHII)](https://www.euro.who.int/en/data-and-evidence/european-health-information-initiative-ehii)
-   [World Health Organization (WHO)](https://www.who.int/data)
-   [rOpenHealth](https://github.com/rOpenHealth)

## Datos del seminario

Los datos deberán ser ingresados "*manualmente*"; es decir, que tendréis que crear las tablas vosotros mismos y así poder aplicar todas (o la gran mayoría) de conceptos y restricciones que veamos en prácticas.

## Tablas del seminario

El número de tablas creadas no está definido pero han de ser más de dos. De esta manera podréis construir preguntas/ejemplos en los que poner en práctica la unión de tablas y el calculo de variables y operaciones (sumarias, de conjunto, etc).

## Texto del seminario

El texto deberá seguir el orden de un informe/artículo científico; en el que se vean claramente:

-   **Introducción**: se hablará del tema a tratar y de dónde provienen los datos.
-   **Objetivos/Preguntas**: se detallarán un máximo de 4 preguntas (u objetivos), los cuales serán respondidos con consultas en SQL.
-   **Métodología y Resultados**: se corresponde con la ejecución del código y la obtención de las tablas resultantes que responderán a las pregunats anteriores.

# Ejemplo de seminario

A continuación os dejo un ejercicio muy básico para que veáis cómo estructurar el trabajo del seminario. Reitero que es muy básico y un seminario similar a este ejemplo, **no estaría a la altura de ser aprobado**.

## Introducción

Estos datos se corresponden a un ejemplo sintético (*i.e.* ficticio) de **epidemiología**.

En total se crearán tres **tablas**.

1.  **Tabla pacientes**: Contendrá los datos de los pacientes.
2.  **Tabla consultas**: Contendrá los registros de consultas médicas.
3.  **Tabla tratamientos**: Contendrá los tratamientos que se administran a los pacientes.

## Objetivos/Preguntas

A continuación se responderán las siguientes preguntas:

1.  ¿Cuáles son los nombres de los pacientes y los tratamientos que están recibiendo?
2.  Cuántas consultas han sido diagnosticadas con cada tipo de diagnóstico?
3.  ¿Cuál es la dosis promedio de tratamiento que están recibiendo los pacientes en cada diagnóstico?

## Metodología y Resultados

Código del seminario

### Creación de tablas

#### **Tabla pacientes**

Contendrá los datos de los pacientes.


``` sql
CREATE TABLE pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    edad INTEGER CHECK (edad >= 0), -- La edad no puede ser negativa
    genero VARCHAR(10) CHECK (genero IN ('Masculino', 'Femenino', 'Otro')), -- Género debe ser uno de estos valores
    peso DECIMAL(5,2) CHECK (peso > 0), -- Peso debe ser mayor a 0
    altura DECIMAL(4,2) CHECK (altura > 0) -- Altura debe ser mayor a 0
);
```

Ahora agregamos los datos de los pacientes


``` sql
INSERT INTO pacientes (nombre, edad, genero, peso, altura) 
VALUES 
    ('Juan Pérez', 45, 'Masculino', 80.5, 1.75),
    ('Ana López', 30, 'Femenino', 65.3, 1.68),
    ('Carlos Martínez', 60, 'Masculino', 90.2, 1.80);
```

Mostramos la tabla


``` sql
SELECT * FROM pacientes; 
```


<div class="knitsql-table">


Table: 3 records

|id_paciente |nombre          | edad|genero    | peso| altura|
|:-----------|:---------------|----:|:---------|----:|------:|
|1           |Juan Pérez      |   45|Masculino | 80.5|   1.75|
|2           |Ana López       |   30|Femenino  | 65.3|   1.68|
|3           |Carlos Martínez |   60|Masculino | 90.2|   1.80|

</div>
Si queremos traer la tabla desde `PostgreSQL` al directorio de trabajo de R (`Global Environment`) debemos usar:


``` r
pacientes <- leer(connection = con, tabla = "pacientes")
pacientes
```

```
## # A tibble: 3 × 6
##   id_paciente nombre           edad genero     peso altura
##         <int> <chr>           <int> <chr>     <dbl>  <dbl>
## 1           1 Juan Pérez         45 Masculino  80.5   1.75
## 2           2 Ana López          30 Femenino   65.3   1.68
## 3           3 Carlos Martínez    60 Masculino  90.2   1.8
```

#### **Tabla consultas**

Contendrá los registros de consultas médicas.


``` sql
CREATE TABLE consultas (
    id_consulta SERIAL PRIMARY KEY,
    id_paciente INTEGER REFERENCES pacientes(id_paciente), -- Clave foránea a 'pacientes'
    fecha DATE NOT NULL,
    diagnostico VARCHAR(255),
    CONSTRAINT chk_fecha CHECK (fecha <= CURRENT_DATE) -- La fecha de consulta no puede ser futura
);
```

Ahora agregamos valores a las tablas de consultas


``` sql
INSERT INTO consultas (id_paciente, fecha, diagnostico) 
VALUES 
    (1, '2024-01-10', 'Hipertensión'),
    (2, '2024-02-15', 'Diabetes Tipo 2'),
    (3, '2024-03-01', 'Insuficiencia Cardíaca');
```

Mostramos la tabla


``` sql
SELECT * FROM consultas; 
```


<div class="knitsql-table">


Table: 3 records

|id_consulta | id_paciente|fecha      |diagnostico            |
|:-----------|-----------:|:----------|:----------------------|
|1           |           1|2024-01-10 |Hipertensión           |
|2           |           2|2024-02-15 |Diabetes Tipo 2        |
|3           |           3|2024-03-01 |Insuficiencia Cardíaca |

</div>


Si queremos traer la tabla desde `PostgreSQL` al directorio de trabajo de R (`Global Environment`) debemos usar:


``` r
consultas <- leer(connection = con, tabla = "consultas")
consultas
```

```
## # A tibble: 3 × 4
##   id_consulta id_paciente fecha      diagnostico           
##         <int>       <int> <date>     <chr>                 
## 1           1           1 2024-01-10 Hipertensión          
## 2           2           2 2024-02-15 Diabetes Tipo 2       
## 3           3           3 2024-03-01 Insuficiencia Cardíaca
```

#### **Tabla tratamientos**

Contendrá los tratamientos que se administran a los pacientes.


``` sql
CREATE TABLE tratamientos (
    id_tratamiento SERIAL PRIMARY KEY,
    id_consulta INTEGER REFERENCES consultas(id_consulta), -- Clave foránea a 'consultas'
    nombre_tratamiento VARCHAR(100) NOT NULL,
    duracion_dias INTEGER CHECK (duracion_dias > 0), -- La duración del tratamiento debe ser mayor a 0
    dosis_mg DECIMAL(5,2) CHECK (dosis_mg > 0) -- La dosis debe ser mayor a 0
);
```

Ahora agregamos valores a la tabla de tratamientos


``` sql
INSERT INTO tratamientos (id_consulta, nombre_tratamiento, duracion_dias, dosis_mg) 
VALUES 
    (1, 'Enalapril', 30, 10.5),
    (2, 'Metformina', 60, 850.0),
    (3, 'Furosemida', 15, 40.0);
```

Mostramos la tabla


``` sql
SELECT * FROM tratamientos; 
```


<div class="knitsql-table">


Table: 3 records

|id_tratamiento | id_consulta|nombre_tratamiento | duracion_dias| dosis_mg|
|:--------------|-----------:|:------------------|-------------:|--------:|
|1              |           1|Enalapril          |            30|     10.5|
|2              |           2|Metformina         |            60|    850.0|
|3              |           3|Furosemida         |            15|     40.0|

</div>

Si queremos traer la tabla desde `PostgreSQL` al directorio de trabajo de R (`Global Environment`) debemos usar:


``` r
tratamientos <- leer(connection = con, tabla = "tratamientos")
tratamientos
```

```
## # A tibble: 3 × 5
##   id_tratamiento id_consulta nombre_tratamiento duracion_dias dosis_mg
##            <int>       <int> <chr>                      <int>    <dbl>
## 1              1           1 Enalapril                     30     10.5
## 2              2           2 Metformina                    60    850  
## 3              3           3 Furosemida                    15     40
```


### Pregunta 1

1.  ¿Cuáles son los nombres de los pacientes y los tratamientos que están recibiendo?


``` sql
SELECT pacientes.nombre, tratamientos.nombre_tratamiento
FROM pacientes 
JOIN consultas ON pacientes.id_paciente = consultas.id_paciente
JOIN tratamientos ON consultas.id_consulta = tratamientos.id_consulta;
```


<div class="knitsql-table">


Table: 3 records

|nombre          |nombre_tratamiento |
|:---------------|:------------------|
|Juan Pérez      |Enalapril          |
|Ana López       |Metformina         |
|Carlos Martínez |Furosemida         |

</div>


``` r
pacientes %>%
  inner_join(consultas, by = "id_paciente") %>%
  inner_join(tratamientos, by = "id_consulta") %>%
  select(nombre, nombre_tratamiento)
```

```
## # A tibble: 3 × 2
##   nombre          nombre_tratamiento
##   <chr>           <chr>             
## 1 Juan Pérez      Enalapril         
## 2 Ana López       Metformina        
## 3 Carlos Martínez Furosemida
```



### Pregunta 2

2.  Cuántas consultas han sido diagnosticadas con cada tipo de diagnóstico?


``` sql
SELECT consultas.diagnostico, COUNT(consultas.id_consulta) AS total_consultas
FROM consultas 
GROUP BY consultas.diagnostico;
```


<div class="knitsql-table">


Table: 3 records

|diagnostico            | total_consultas|
|:----------------------|---------------:|
|Insuficiencia Cardíaca |               1|
|Hipertensión           |               1|
|Diabetes Tipo 2        |               1|

</div>


``` r
consultas %>%
  group_by(diagnostico) %>%
  summarise(total_consultas = sum(!is.na(id_consulta)))
```

```
## # A tibble: 3 × 2
##   diagnostico            total_consultas
##   <chr>                            <int>
## 1 Diabetes Tipo 2                      1
## 2 Hipertensión                         1
## 3 Insuficiencia Cardíaca               1
```





### Pregunta 3

3.  ¿Cuál es la dosis promedio de tratamiento que están recibiendo los pacientes en cada diagnóstico?


``` sql
SELECT consultas.diagnostico, AVG(tratamientos.dosis_mg) AS dosis_promedio
FROM consultas 
JOIN tratamientos ON consultas.id_consulta = tratamientos.id_consulta
GROUP BY consultas.diagnostico;
```


<div class="knitsql-table">


Table: 3 records

|diagnostico            | dosis_promedio|
|:----------------------|--------------:|
|Insuficiencia Cardíaca |           40.0|
|Hipertensión           |           10.5|
|Diabetes Tipo 2        |          850.0|

</div>


``` r
consultas %>%
  inner_join(tratamientos, by = "id_consulta") %>%
  group_by(diagnostico) %>%
  summarise(dosis_promedio = mean(dosis_mg, na.rm = TRUE))
```

```
## # A tibble: 3 × 2
##   diagnostico            dosis_promedio
##   <chr>                           <dbl>
## 1 Diabetes Tipo 2                 850  
## 2 Hipertensión                     10.5
## 3 Insuficiencia Cardíaca           40
```



# Finalizando el documento

Para finalizar el documento (y no entorpecer con las prácticas), es necesario crear un código que nos permita **borrar todas las tablas creadas**.


``` r
# Obtener la lista de todas las tablas en la base de datos
tables <- dbListTables(con)
print(tables)
```

```
## [1] "consultas"    "pacientes"    "tratamientos"
```

``` r
# Borrar todas las tablas
for (table in tables) {
  dbExecute(con, paste0("DROP TABLE IF EXISTS ", table, " CASCADE;"))
}

# Verificar que no queden tablas
tables_after <- dbListTables(con)
print(tables_after)
```

```
## character(0)
```

Finalmente, desconectamos la base de datos local.


``` r
# Cerrar la conexión
dbDisconnect(con)
```
