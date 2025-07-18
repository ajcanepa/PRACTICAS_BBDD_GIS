<img src='INPUT/IMAGES/Data_Base_Schema_Pincho_Cajonera.png' align="right" height="100" /> <img src='INPUT/IMAGES/Escudo Color TL.png' align="right" height="100" />
# PRACTICAS asignatura "Bases de Datos" 

Repositorio en el que se desarrollará el código de las prácticas de la asignatura "Bases de Datos", del grado de [Ingeniería de la Salud](https://www.ubu.es/grado-en-ingenieria-de-la-salud), de la [Universidad de Burgos](https://www.ubu.es).

Más información en la [página del curso](https://ubuvirtual.ubu.es/course/view.php?id=13987) y a lo largo de las secciones de este `README`.

***

## Seminarios
La idea detrás de los seminarios es crear manualmente una base de datos (*i.e.* un conjunto de tablas relacionadas) para así introducir al estudiante en el uso de fuentes biomédicas. Especial interés en la estructuración de las tablas, el manejo teórico de las *Bases de Datos* y cómo se transfiere esto al código. 

Se trabajará básicamente con código el "*Structured Query Language* `SQL`" y con el paquete `dplyr` del lenguaje de programación **R**.

Las temáticas pueden estar relacionadas (no es obligatorio) al efecto de estresores ambientales sobre la salud humana (__Biometereología Humana__). Puedes ver más ejemplos en el [MCC Collaborative Research Network](https://mccstudy.lshtm.ac.uk/).

A modo de ejemplo, os dejo unos enlaces a algunos seminarios previos que han sido bien (o muy bien) evaluados en la siguiente sección [Hall of Fame - Seminarios](#hall-of-fame---seminarios)

### Estructura del Seminario
La entrega se basa en dos archivos y un repostorio que se solicitarán como mecanismo de evaluación del tercer control parcial (evaluación contínua). Los archivos que tendréis que entregar son: 

* __*i)*__ Archivo RMarkdown (Cuaderno de R) que contendrá tanto el texto como el código empleado en el seminario. Es de extensión `.Rmd`, y 
* __*ii*__) Archivo *HyperText Markup Language (__HTML__)*, de extensión `.html` que contendrá el seminario *renderizado*, es decir se unirá tanto el texto como el código y sus resultados (*i.e.* tablas.).

Podéis encontrar una explicación del seminario en este documento:

*  [Seminario Asignatura Bases de Datos](https://github.com/ajcanepa/PRACTICAS_BBDD_GIS/blob/main/12_Mini_Proyecto_Final/Seminario_Ejemplo.md)


La estructura del seminario contará con los identificadores básicos del seminario como es el `título`, los `autores` y `curso` al que corresponde y con los siguientes apartados específicos:

* __Introducción__: contextualiza la idea del seminario, entrega una idea general de la temática y de los datos con los que váis a trabajar (descripción formal de los datos).
* __Objetivo general__: en una frase un objetivo claro y general que muestre muy claramente la relación entre variables que váis a buscar/relacionar.
* __Objetivos específicos__: tres o cuatro preguntas específicas que permiten responder el objetivo general. 
* __Metodología y Resultados__: para cada objetivo específico se entregará el código y las representaciones necesarias (tablas) que permitan responder al objetivo específico en cuestión (es necesario mostrar el **esquema ERD** de la base de datos).
* __Conclusiones generales__: podréis generar conocimiento nuevo con vuestro seminario y es en este apartado donde váis a detallarlo de manera concisa y reconiendo sus limitaciones.
* __Referencias__: listado de las referencias utilizadas en el seminario (intentad que sean en formato APA) que os permitirán escribir la introducción y ver lo importante o no de vuestras conclusiones generales.


### Baremo de Calificación
Para la entrega, deberéis fijaros en: 

*  __i)__ Definición de los objetivos. 
*  __ii)__ Modelo ERD.
*  __iii)__ Calidad del código en general, número y tamaño de tablas, número de uniones (`JOINS`).
*  __iv)__ Apariencia del cuaderno (`.Rmd` y `.html`).
*  __v)__ Dominio de conceptos y calidad de la presentación (defensa) en clases.

***

### Hall of Fame - Seminarios

##### Edición 2024-2025
Para una correcta visualización de los archivos `.html`, deberás descargarlos ("*guardar enlace como*") y abrirlos en tu navegador.

*  [Enfermedades raras del sistema nervioso](/INPUT/SEMINARIOS/HALL_of_FAME/2024-2025/Enfermedades_raras_sistema_nervioso.html)
*  [Seminario Enfermedades Crónicas](/INPUT/SEMINARIOS/HALL_of_FAME/2024-2025/Seminario_Enfermedades_Cronicas.html)
*  [Registros Red de Hospitales](/INPUT/SEMINARIOS/HALL_of_FAME/2024-2025/Registros_Red_Hospitales.html)

***
## Recursos para `SQL`, `R` , `Tidyverse` y `Bases de Datos`

### SQL, PostgreSQL y pgAdmin
* [PostgreSQL](https://www.postgresql.org/)
* [pgAdmin](https://www.pgadmin.org/)
* [Database of Databases](https://dbdb.io/)

### Repositorios oficiales de R
*  [The Comprehensive R Archive Network](https://cran.r-project.org/)
*  [Bioconductor](https://www.bioconductor.org/)
*  [R-Universe](https://r-universe.dev)
*  [ROpenScience](https://ropensci.org/)
*  [ROpenSpain](https://ropenspain.es/)

### R y Bases de datos
* [CRAN Task View: Databases with R](https://cran.r-project.org/web/views/Databases.html)
* [R for Data Science - 21  Databases](https://r4ds.hadley.nz/databases.html)
* [Database Queries With R](https://solutions.posit.co/connections/db/getting-started/database-queries/)
* [Best Practices in Working with Databases](https://solutions.posit.co/connections/db/)
* [SQL databases and R](https://datacarpentry.github.io/R-ecology-lesson/instructor/05-r-and-databases.html)
* [SQL translation](https://solutions.posit.co/connections/db/advanced/translation/)

#### Herramientas para _Entity-Relationship Diagrams_ (**ERDs**)
* [dm - Rpackage](https://github.com/cynkra/dm/)
  * [dm - Vignette](https://dm.cynkra.com/)
* [ReDaMoR](https://github.com/patzaw/ReDaMoR/)
  * [Relational Data Modeler - ReDaMoR](https://patzaw.github.io/ReDaMoR/index.html)
  * [Modeling Relational Data in R with ReDaMoR](https://patzaw.github.io/ReDaMoR/articles/ReDaMoR.html)
* [ERDbuilder](https://github.com/gbasulto/ERDbuilder)
  * [ERDbuilder - Vignette](https://gbasulto.github.io/ERDbuilder/index.html)
* [dbdiagram.io](https://dbdiagram.io/home)


### Programación
*  [R for Data Science](https://r4ds.hadley.nz/)
*  [R Para Ciencia de Datos](https://es.r4ds.hadley.nz/)
*  [R4ULPGC: Introducción a R](https://estadistica-dma.ulpgc.es/cursoR4ULPGC/index.html)
*  [Fundamentos de ciencia de datos con R](https://cdr-book.github.io/index.html)
*  [R Programming for Data Science](https://bookdown.org/rdpeng/rprogdatascience/)
*  [R Avanzado](https://davidrsch.github.io/adv-res/)
*  [Advanced R](https://adv-r.hadley.nz/)
*  [fasteR: Fast Lane to Learning R!](https://github.com/matloff/fasteR)
*  [Big Book of R](https://www.bigbookofr.com/)
*  [The tidyverse style guide](https://style.tidyverse.org/index.html)

### Large Language Models (LLM - Generative AI)

#### Recursos para R
*  [Ingeniería de prompt con ChatGPT](https://www.promptingguide.ai/es/models/chatgpt)
*  [Biblioteca de prompts educativos](https://eduprompts.tiddlyhost.com)
*  [Claude - AI](https://claude.ai/new)

  
#### Artículos Científicos
*  2024  [The use of generative AI for coding in academia](https://besjournals.onlinelibrary.wiley.com/doi/10.1111/2041-210X.14454)
*  2024  [Harnessing LLM for coding, teaching and inclusion to empower research](https://besjournals.onlinelibrary.wiley.com/doi/10.1111/2041-210X.14325)

### Communicación

##### Documentos
*  [Introducción al uso de RMarkdown](https://bookdown.org/gboccardo/manual-ED-UCH/introduccion-al-uso-de-rmarkdown-para-la-compilacion-de-resultados-de-rstudio-en-diferentes-formatos.html)
*  [Informes con R Markdown - Capítulo](https://epirhandbook.com/es/new_pages/rmarkdown.es.html)
*  [Introducción a RMarkdown - PPT](https://mpaulacaldas.github.io/r-ladies-rmarkdown/#1)
*  [R markdown para abogados](https://bookdown.org/marcoyel21/r_markdown_abogados/)
*  [Cómo crear Tablas de información en R Markdown](http://destio.us.es/calvo/Qficheros/ComoCrearTablasRMarkdown_PedroLuque_2019Sep_librodigital.pdf)
*  [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/)
*  [R Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/)
*  [The bookdown package](https://bookdown.org/)

### Estadística y meta-análisis
*  [An Introduction to Statistical Learning](https://www.statlearning.com/)
*  [Doing Meta-Analysis with R](https://bookdown.org/MathiasHarrer/Doing_Meta_Analysis_in_R/)
*  [Modern Statistics with R](https://www.modernstatisticswithr.com/)
*  [Little Book of R for Biomedical Statistics!](https://a-little-book-of-r-for-biomedical-statistics.readthedocs.io/en/latest/)

### Ómicas y Salud
*  [The Epidemiologist R Handbook](https://epirhandbook.com/en/)
*  [R for Epidemiology](https://www.r4epi.com/)
*  [Reproducible Medical Research with R](https://bookdown.org/pdr_higgins/rmrwr/)
*  [R for Health Data Science](https://argoshare.is.ed.ac.uk/healthyr_book/)
*  [Sequence Analysis in R and Bioconductor](https://girke.bioinformatics.ucr.edu/GEN242/tutorials/rsequences/rsequences/)
*  [Little Book of R for Bioinformatics](https://a-little-book-of-r-for-bioinformatics.readthedocs.io/en/latest/)
*  [CRAN Task View: Genomics, Proteomics, Metabolomics, Transcriptomics, and Other Omics](https://cran.r-project.org/web/views/Omics.html)

### Machine Learning & R
*  [The caret Package](https://topepo.github.io/caret/index.html)
*  [Tidy Modeling with R](https://www.tmwr.org/)
*  [Building Reproducible Analytical Pipelines](https://rap4mads.eu/)
*  [Applied Machine Learning Using mlr3 in R](https://mlr3book.mlr-org.com/)
*  [Models Demystified](https://m-clark.github.io/book-of-models/)

### Formación
*  [Máster en Data Science & Business Analytics (con R software)](https://blog.uclm.es/tp-mbsba/)

### Comunidades
*  [R Consortium](https://www.r-consortium.org/)
*  [R Ladies](https://rladies.org/)
*  [R Ladies - GitHub](https://github.com/rladies)
*  [R-Ladies Madrid](https://github.com/rladies/meetup-presentations_madrid)
*  [R-Ladies Barcelona](https://github.com/rladies/meetup-presentations_barcelona)
*  [R-Ladies Bilbao (X.com)](https://twitter.com/RLadiesBIO)
*  [Comunidad R-Hispano](http://r-es.org/)
*  [NHS-R](https://nhsrcommunity.com/)

### Noticias 
*  [R-Project](https://www.r-project.org/)
*  [R-Bloggers](https://www.r-bloggers.com/)
*  [Revolutions](https://blog.revolutionanalytics.com/)
*  [II Congreso de R en España-Barcelona, 2023](https://eventum.upf.edu/101896/programme/ii-conference-of-r-and-xiii-workshop-for-r-users.html)
*  [III Congreso & XIV Jornadas de Usuarios de R, Sevilla - 2024](https://www.imus.us.es/congresos/IIIRqueR/)

### Publicaciones científicas sobre este lenguaje
*  2025 [Which programming language should I use? A guide for early-career researchers](https://www.nature.com/articles/d41586-025-01241-6)
*  2023 [Expansion and evolution of the R programming language](https://royalsocietypublishing.org/doi/10.1098/rsos.221550)
*  2022 [Ten simple rules for teaching yourself R](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1010372)
*  2018 [R generation](https://rss.onlinelibrary.wiley.com/doi/full/10.1111/j.1740-9713.2018.01169.x)
*  2017 [Evolution of the R software ecosystem: Metrics, relationships, and their impact on qualities](https://www.sciencedirect.com/science/article/pii/S0164121217301371)
*  2014 [Programming tools: Adventures with R](https://www.nature.com/articles/517109a)
*  2013 [The Evolution of the R Software Ecosystem](https://ieeexplore.ieee.org/document/6498472)

***
