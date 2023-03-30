# Manipulación de datos con dplyr y tidyr {#dplyr}



<!-- 
---
title: "Manipulación de datos con dplyr y tidyr"
author: "Notas de Programación en R"
date: "Rubén Fernández-Casal (rubenfcasal@gmail.com)"
output:
  bookdown::html_document2:
    toc: yes
    toc_float: yes
    # mathjax: local            # copia local de MathJax, hay que establecer:
    # self_contained: false     # las dependencias se guardan en ficheros externos
    pandoc_args: ["--number-offset", "1,0"]
  bookdown::pdf_document2:
    latex_engine: xelatex
    # keep_tex: yes
    toc: yes 
    pandoc_args: ["--number-offset", "1,0"]
header-includes:
- \usepackage[spanish]{babel}
- \setcounter{section}{1} 
---
-->

En este capítulo se realiza una breve introducción al paquete  [`dplyr`](https://dplyr.tidyverse.org) y se comentan algunas de las utilidades del paquete [`tidyr`](https://tidyr.tidyverse.org) que pueden resultar de interés^[Otra alternativa (más rápida) es [`data.table`](https://rdatatable.gitlab.io/data.table) pero en versiones recientes ya se puede emplear desde `dplyr`, como se comenta más adelante.]. 

La referencia recomendada para iniciarse en esta herramienta es el Capítulo [5 Data transformation](http://r4ds.had.co.nz/transform.html) de 
[R for Data Science](http://r4ds.had.co.nz).
También puede resultar de utilidad la viñeta del paquete [Introduction to dplyr](https://dplyr.tidyverse.org/articles/dplyr.html) o la [chuleta](https://posit.co/wp-content/uploads/2022/10/data-transformation-1.pdf).


## El paquete dplyr {#dplyr-pkg}


```r
library(dplyr)
```

La principal ventaja de [`dplyr`](https://dplyr.tidyverse.org/index.html) es que permite trabajar (de la misma forma) con datos en distintos formatos:
     
- `data.frame`, [`tibble`](https://tibble.tidyverse.org/).

- [`data.table`](https://rdatatable.gitlab.io/data.table): extensión (paquete *backend*) [`dtplyr`](https://dtplyr.tidyverse.org).

- conjuntos de datos más grandes que la memoria disponible: extensiones [`duckdb`](https://duckdb.org/docs/api/r) y [`arrow`](https://arrow.apache.org/docs/r/) (incluyendo almacenamiento en la nube, e.g. [AWS](https://aws.amazon.com/es/s3)). 

- bases de datos relacionales (lenguaje SQL, locales o remotas); extensión [`dbplyr`](https://dbplyr.tidyverse.org).

- grandes volúmenes de datos (incluso almacenados en múltiples servidores; ecosistema [Hadoop](http://hadoop.apache.org/)/[Spark](https://spark.apache.org/)): extensión [`sparklyr`](https://spark.rstudio.com).


El paquete dplyr permite sustituir operaciones con funciones base de R (como [`subset`](NA), [`split`](NA), [`apply`](NA), [`sapply`](NA), [`lapply`](NA), [`tapply`](NA), [`aggregate`](NA)...) por una "gramática" más sencilla para la manipulación de datos.
En lugar de operar sobre vectores como la mayoría de las funciones base,
opera sobre conjuntos de datos (de forma que es compatible con el operador `%>%`).
Los principales "verbos" (funciones) son:

- [`select()`](https://dplyr.tidyverse.org/reference/select.html): seleccionar variables (ver también [`rename`](https://dplyr.tidyverse.org/reference/rename.html), [`relocate`](https://dplyr.tidyverse.org/reference/rename.html), [`pull`](https://dplyr.tidyverse.org/reference/rename.html)).

- [`mutate()`](https://dplyr.tidyverse.org/reference/mutate.html): crear variables (ver también `transmute()`).

- [`filter()`](https://dplyr.tidyverse.org/reference/filter.html): seleccionar casos/filas (ver también `slice()`).

- [`arrange()`](https://dplyr.tidyverse.org/reference/arrange.html): ordenar casos/filas.

- [`summarise()`](https://dplyr.tidyverse.org/reference/summarise.html): resumir valores.

- [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html): permite operaciones por grupo empleando el concepto "dividir-aplicar-combinar" (`ungroup()` elimina el agrupamiento).

NOTA: Para entender el funcionamiento de ciertas funciones (como [`rowwise()`](https://dplyr.tidyverse.org/reference/rowwise.html)) y las posibilidades en el manejo de datos, hay que tener en cuenta que un `data.frame` no es más que una lista cuyas componentes (variables) tienen la misma longitud.
Realmente las componentes también pueden ser listas de la misma longitud y, por tanto, podemos almacenar casi cualquier estructura de datos en un `data.frame`.

En la primera parte de este capítulo consideraremos solo  `data.frame` por comodidad.
Emplearemos como ejemplo los datos de empleados de banca almacenados en el fichero *empleados.RData* (y supondremos que estamos interesados en estudiar si hay discriminación por cuestión de sexo o raza).


```r
load("datos/empleados.RData")
# En R < 4.2: load("datos/empleados.latin1.RData")
# Eliminamos las etiquetas para que no molesten...
attr(empleados, "variable.labels") <- NULL                  
```

En la Sección \@ref(dbplyr) final emplearemos una base de datos relacional como ejemplo.


## Operaciones con variables (columnas) {#dplyr-variables}

Podemos **seleccionar variables con [`select()`](https://dplyr.tidyverse.org/reference/select.html)**:

```r
emplea2 <- empleados %>% select(id, sexo, minoria, tiempemp, salini, salario)
head(emplea2)
```

```
##   id   sexo minoria tiempemp salini salario
## 1  1 Hombre      No       98  27000   57000
## 2  2 Hombre      No       98  18750   40200
## 3  3  Mujer      No       98  12000   21450
## 4  4  Mujer      No       98  13200   21900
## 5  5 Hombre      No       98  21000   45000
## 6  6 Hombre      No       98  13500   32100
```

Se puede cambiar el nombre (ver también [`rename()`](https://dplyr.tidyverse.org/reference/rename.html)):

```r
empleados %>% select(sexo, noblanca = minoria, salario) %>% head()
```

```
##     sexo noblanca salario
## 1 Hombre       No   57000
## 2 Hombre       No   40200
## 3  Mujer       No   21450
## 4  Mujer       No   21900
## 5 Hombre       No   45000
## 6 Hombre       No   32100
```

Se pueden emplear los nombres de variables como índices:

```r
empleados %>% select(sexo:salario) %>% head()
```

```
##     sexo    fechnac educ         catlab salario
## 1 Hombre 1952-02-03   15      Directivo   57000
## 2 Hombre 1958-05-23   16 Administrativo   40200
## 3  Mujer 1929-07-26   12 Administrativo   21450
## 4  Mujer 1947-04-15    8 Administrativo   21900
## 5 Hombre 1955-02-09   15 Administrativo   45000
## 6 Hombre 1958-08-22   15 Administrativo   32100
```

```r
# empleados %>% select(-(sexo:salario)) %>% head()
empleados %>% select(!(sexo:salario)) %>% head()
```

```
##   id salini tiempemp expprev minoria      sexoraza
## 1  1  27000       98     144      No  Blanca varón
## 2  2  18750       98      36      No  Blanca varón
## 3  3  12000       98     381      No Minoría varón
## 4  4  13200       98     190      No Minoría varón
## 5  5  21000       98     138      No  Blanca varón
## 6  6  13500       98      67      No  Blanca varón
```

Se pueden emplear distintas herramientas (*[selection helpers](https://tidyselect.r-lib.org/reference/language.html)*) para seleccionar variables (ver paquete [`tidyselect`](https://tidyselect.r-lib.org)):

- [`starts_with`](https://tidyselect.r-lib.org/reference/starts_with.html), [`ends_with`](https://tidyselect.r-lib.org/reference/starts_with.html), [`contains`](https://tidyselect.r-lib.org/reference/starts_with.html), [`matches`](https://tidyselect.r-lib.org/reference/starts_with.html), [`num_range`](https://tidyselect.r-lib.org/reference/starts_with.html): variables que coincidan con un patrón.

- [`all_of`](https://tidyselect.r-lib.org/reference/all_of.html), [`any_of`](https://tidyselect.r-lib.org/reference/all_of.html): variables de un vectores de caracteres.

- [`everything`](https://tidyselect.r-lib.org/reference/everything.html), [`last_col`](https://tidyselect.r-lib.org/reference/everything.html): todas las variables o la última variable.

- [`where()`](https://tidyselect.r-lib.org/reference/where.html): a partir de una función (e.g. `where(is.numeric)`)

Por ejemplo:

```r
empleados %>% select(starts_with("s")) %>% head()
```

```
##     sexo salario salini      sexoraza
## 1 Hombre   57000  27000  Blanca varón
## 2 Hombre   40200  18750  Blanca varón
## 3  Mujer   21450  12000 Minoría varón
## 4  Mujer   21900  13200 Minoría varón
## 5 Hombre   45000  21000  Blanca varón
## 6 Hombre   32100  13500  Blanca varón
```

Podemos **crear variables con [`mutate()`](https://dplyr.tidyverse.org/reference/mutate.html)**:

```r
emplea2 %>% mutate(incsal = salario - salini, tsal = incsal/tiempemp) %>% head()
```

```
##   id   sexo minoria tiempemp salini salario incsal      tsal
## 1  1 Hombre      No       98  27000   57000  30000 306.12245
## 2  2 Hombre      No       98  18750   40200  21450 218.87755
## 3  3  Mujer      No       98  12000   21450   9450  96.42857
## 4  4  Mujer      No       98  13200   21900   8700  88.77551
## 5  5 Hombre      No       98  21000   45000  24000 244.89796
## 6  6 Hombre      No       98  13500   32100  18600 189.79592
```


## Operaciones con casos (filas) {#dplyr-casos}

Podemos **seleccionar casos con [`filter()`](https://dplyr.tidyverse.org/reference/filter.html)**:

```r
emplea2 %>% filter(sexo == "Mujer", minoria == "Sí") %>% head()
```

```
##   id  sexo minoria tiempemp salini salario
## 1 14 Mujer      Sí       98  16800   35100
## 2 23 Mujer      Sí       97  11100   24000
## 3 24 Mujer      Sí       97   9000   16950
## 4 25 Mujer      Sí       97   9000   21150
## 5 40 Mujer      Sí       96   9000   19200
## 6 41 Mujer      Sí       96  11550   23550
```

Podemos **reordenar casos con [`arrange()`](https://dplyr.tidyverse.org/reference/arrange.html)**:

```r
emplea2 %>% arrange(salario) %>% head()
```

```
##    id  sexo minoria tiempemp salini salario
## 1 378 Mujer      No       70  10200   15750
## 2 338 Mujer      No       74  10200   15900
## 3  90 Mujer      No       92   9750   16200
## 4 224 Mujer      No       82  10200   16200
## 5 411 Mujer      No       68  10200   16200
## 6 448 Mujer      Sí       66  10200   16350
```

```r
emplea2 %>% arrange(desc(salini), salario) %>% head()
```

```
##    id   sexo minoria tiempemp salini salario
## 1  29 Hombre      No       96  79980  135000
## 2 343 Hombre      No       73  60000  103500
## 3 205 Hombre      No       83  52500   66750
## 4 160 Hombre      No       86  47490   66000
## 5 431 Hombre      No       66  45000   86250
## 6  32 Hombre      No       96  45000  110625
```

Podemos **resumir valores con [`summarise()`](https://dplyr.tidyverse.org/reference/summarise.html)**:

```r
empleados %>% summarise(sal.med = mean(salario), n = n())
```

```
##    sal.med   n
## 1 34419.57 474
```

Para realizar **operaciones con múltiples variables podemos emplear [`across()`](https://dplyr.tidyverse.org/reference/across.html)** (admite selección de variables [`tidyselect`](https://tidyselect.r-lib.org)):

```r
empleados %>% summarise(across(where(is.numeric), mean), n = n())
```

```
##      id     educ  salario   salini tiempemp  expprev   n
## 1 237.5 13.49156 34419.57 17016.09  81.1097 95.86076 474
```

```r
# empleados %>% summarise(across(where(is.numeric) & !id, mean), n = n())
empleados %>% summarise(if_any(is.numeric, mean), n = n())
```

```
##   if_any(is.numeric, mean)   n
## 1                     TRUE 474
```

NOTA: Esta función sustituye a las "variantes de ámbito" `_at()`, `_if()` y  `_all()` de versiones anteriores de dplyr (como `summarise_at()`, `summarise_if()`, `summarise_all()`, `mutate_at()`, `mutate_if()`...) y también el uso de `vars()`.
En el caso de `filter()` se puede emplear [`if_any()`](https://dplyr.tidyverse.org/reference/across.html) e [`if_all()`](https://dplyr.tidyverse.org/reference/across.html).

Podemos **agrupar casos con [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)**:

```r
empleados %>% group_by(sexo, minoria) %>% 
    summarise(sal.med = mean(salario), n = n()) %>%
    ungroup()
```

```
## # A tibble: 4 x 4
##   sexo   minoria sal.med     n
##   <fct>  <fct>     <dbl> <int>
## 1 Hombre No       44475.   194
## 2 Hombre Sí       32246.    64
## 3 Mujer  No       26707.   176
## 4 Mujer  Sí       23062.    40
```

```r
empleados %>% group_by(sexo, minoria) %>% 
    summarise(sal.med = mean(salario), n = n(), .groups = "drop")
```

```
## # A tibble: 4 x 4
##   sexo   minoria sal.med     n
##   <fct>  <fct>     <dbl> <int>
## 1 Hombre No       44475.   194
## 2 Hombre Sí       32246.    64
## 3 Mujer  No       26707.   176
## 4 Mujer  Sí       23062.    40
```

```r
# dplyr >= 1.1.0 # packageVersion("dplyr")
# empleados %>% summarise(sal.med = mean(salario), n = n(), 
#                         .by = c(sexo, minoria))
```

Por defecto la agrupación se mantiene para el resto de operaciones, habría que emplear `ungroup()` (o el argumento `.groups = "drop"`) para eliminarla (se puede emplear `group_vars()` o `str()` para ver la agrupación).
Desde dplyr 1.1.0 (2023-01-29) está disponible un parámetro `.by/by` en `mutate()`, `summarise()`, `filter()` y `slice()` como alternativa a agrupar y desagrupar posteriormente.
Para más detalles ver [Per-operation grouping with .by/by](https://dplyr.tidyverse.org/reference/dplyr_by.html).


## Herramientas tidyr

Algunas funciones del paquete [`tidyr`](https://tidyr.tidyverse.org) que pueden resultar de especial interés son:

- [`pivot_wider()`](https://tidyr.tidyverse.org/reference/pivot_wider.html): permite transformar valores de grupos de casos a nuevas variables.
- [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html): realiza la transformación inversa, colapsar varias columnas en una. 

Ver la viñeta [Pivoting](https://tidyr.tidyverse.org/articles/pivot.html) para más detalles.

- [`separate()`](https://tidyr.tidyverse.org/reference/separate.html): permite separar una columna de texto en varias (ver también [`extract()`](https://tidyr.tidyverse.org/reference/extract.html)).

Ver [mortalidad.R](ejemplos/mortalidad/mortalidad.R) en [ejemplos](https://github.com/rubenfcasal/book_notasr/tree/main/ejemplos).


## Operaciones con tablas de datos {#dplyr-join}

Se emplean funciones `xxx_join()` (ver la documentación del paquete 
[Join two tbls together](https://dplyr.tidyverse.org/reference/join.html),
o la vignette [Two-table verbs](https://dplyr.tidyverse.org/articles/two-table.html)):

- `inner_join()`: devuelve las filas de `x` que tienen valores coincidentes en `y`, 
  y todas las columnas de `x` e `y`. Si hay varias coincidencias entre `x` e `y`, 
  se devuelven todas las combinaciones.
  
- `left_join()`: devuelve todas las filas de `x` y todas las columnas de `x` e `y`. 
  Las filas de `x` sin correspondencia en `y` contendrán `NA` en las nuevas columnas. 
  Si hay varias coincidencias entre `x` e `y`, se devuelven todas las combinaciones
  (duplicando las filas).

    `right_join()` hace lo contrario, devuelve todas las filas de `y`.
    
    `full_join()` devuelve todas las filas de `x` e `y` (duplicando o asignando `NA` si es necesario).

- `semi_join()`: devuelve las filas de `x` que tienen valores coincidentes en `y`, 
  manteniendo sólo las columnas de `x` (al contrario que `inner_join()` no duplica filas).
  
    `anti_join()` hace lo contrario, devuelve las filas sin correspondencia. 

El parámetro `by` determina las variables clave para las correspondencias.
Si no se establece se considerarán todas las que tengan el mismo nombre en ambas tablas.
Se puede establecer a un vector de nombres coincidentes y en caso de que los nombres sean distintos a un vector con nombres de la forma `c("clave_x" = "clave_y")`.

Adicionalmente, si las tablas `x` e `y` tienen las mismas variables, se pueden combinar las observaciones con operaciones de conjuntos:

- `intersect(x, y)`: observaciones en `x` y en `y`.

- `union(x, y)`: observaciones en `x` o `y` no duplicadas.

- `setdiff(x, y)`: observaciones en `x` pero no en `y`.


## Bases de datos con dplyr {#dbplyr}

Para poder usar tablas en bases de datos relacionales con `dplyr` hay que emplear el paquete [dbplyr](https://dbplyr.tidyverse.org) (convierte automáticamente el código de dplyr en consultas SQL).

Algunos enlaces:

- [Best Practices in Working with Databases](https://solutions.posit.co/connections/db)

- [Introduction to dbplyr](https://dbplyr.tidyverse.org/articles/dbplyr.html)

- [Data Carpentry](https://datacarpentry.org/R-ecology-lesson/index.html):
  [SQL databases and R](https://datacarpentry.org/R-ecology-lesson/05-r-and-databases.html), 

- [R and Data – When Should we Use Relational Databases? ](https://intellixus.com/2018/06/29/r-and-data-when-should-we-use-relational-databases)


### Ejemplos

Como ejemplo emplearemos la base de datos de [SQLite Sample Database Tutorial](https://www.sqlitetutorial.net/sqlite-sample-database/), almacenada en el archivo [*chinook.db*](datos/chinook.db).


```r
# install.packages('dbplyr')
library(dplyr)
library(dbplyr)
```

En primer lugar hay que conectar la base de datos:

```r
chinook <- DBI::dbConnect(RSQLite::SQLite(), "datos/chinook.db")
```

Podemos listar las tablas:

```r
src_dbi(chinook)
```

```
## src:  sqlite 3.39.4 [E:\OneDrive - Universidade da Coruña\__Actual\__IGE\_book_notasr\datos\chinook.db]
## tbls: albums, artists, customers, employees, genres, invoice_items, invoices,
##   media_types, playlist_track, playlists, sqlite_sequence, sqlite_stat1, tracks
```

Para enlazar una tabla:

```r
invoices <- tbl(chinook, "invoices")
invoices
```

```
## # Source:   table<invoices> [?? x 9]
## # Database: sqlite 3.39.4 [E:\OneDrive - Universidade da Coruña\__Actual\__IGE\_book_notasr\datos\chinook.db]
##    InvoiceId CustomerId InvoiceD~1 Billi~2 Billi~3 Billi~4 Billi~5 Billi~6 Total
##        <int>      <int> <chr>      <chr>   <chr>   <chr>   <chr>   <chr>   <dbl>
##  1         1          2 2009-01-0~ Theodo~ Stuttg~ <NA>    Germany 70174    1.98
##  2         2          4 2009-01-0~ Ullevå~ Oslo    <NA>    Norway  0171     3.96
##  3         3          8 2009-01-0~ Grétry~ Brusse~ <NA>    Belgium 1000     5.94
##  4         4         14 2009-01-0~ 8210 1~ Edmont~ AB      Canada  T6G 2C7  8.91
##  5         5         23 2009-01-1~ 69 Sal~ Boston  MA      USA     2113    13.9 
##  6         6         37 2009-01-1~ Berger~ Frankf~ <NA>    Germany 60316    0.99
##  7         7         38 2009-02-0~ Barbar~ Berlin  <NA>    Germany 10779    1.98
##  8         8         40 2009-02-0~ 8, Rue~ Paris   <NA>    France  75002    1.98
##  9         9         42 2009-02-0~ 9, Pla~ Bordea~ <NA>    France  33000    3.96
## 10        10         46 2009-02-0~ 3 Chat~ Dublin  Dublin  Ireland <NA>     5.94
## # ... with more rows, and abbreviated variable names 1: InvoiceDate,
## #   2: BillingAddress, 3: BillingCity, 4: BillingState, 5: BillingCountry,
## #   6: BillingPostalCode
```

Ojo `[?? x 9]`: de momento no conoce el número de filas.

```r
nrow(invoices)
```

```
## [1] NA
```

Podemos mostrar la consulta SQL correspondiente a una operación:

```r
show_query(head(invoices))
```

```
## <SQL>
## SELECT *
## FROM `invoices`
## LIMIT 6
```

```r
# str(head(invoices))
```

Al trabajar con bases de datos, dplyr intenta ser lo más vago posible:

-  No exporta datos a R a menos que se pida explícitamente (`colect()`).

-  Retrasa cualquier operación lo máximo posible: 
   agrupa todo lo que se desea hacer y luego hace una única petición a la base de datos.
   

```r
invoices %>% head %>% collect
```

```
## # A tibble: 6 x 9
##   InvoiceId CustomerId InvoiceDate Billi~1 Billi~2 Billi~3 Billi~4 Billi~5 Total
##       <int>      <int> <chr>       <chr>   <chr>   <chr>   <chr>   <chr>   <dbl>
## 1         1          2 2009-01-01~ Theodo~ Stuttg~ <NA>    Germany 70174    1.98
## 2         2          4 2009-01-02~ Ullevå~ Oslo    <NA>    Norway  0171     3.96
## 3         3          8 2009-01-03~ Grétry~ Brusse~ <NA>    Belgium 1000     5.94
## 4         4         14 2009-01-06~ 8210 1~ Edmont~ AB      Canada  T6G 2C7  8.91
## 5         5         23 2009-01-11~ 69 Sal~ Boston  MA      USA     2113    13.9 
## 6         6         37 2009-01-19~ Berger~ Frankf~ <NA>    Germany 60316    0.99
## # ... with abbreviated variable names 1: BillingAddress, 2: BillingCity,
## #   3: BillingState, 4: BillingCountry, 5: BillingPostalCode
```

```r
invoices %>% count # número de filas
```

```
## # Source:   SQL [1 x 1]
## # Database: sqlite 3.39.4 [E:\OneDrive - Universidade da Coruña\__Actual\__IGE\_book_notasr\datos\chinook.db]
##       n
##   <int>
## 1   412
```

Por ejemplo, para obtener el importe mínimo, máximo y la media de las facturas:


```r
res <- invoices %>% summarise(min = min(Total, na.rm = TRUE), 
                        max = max(Total, na.rm = TRUE), med = mean(Total, na.rm = TRUE))
# show_query(res)
res  %>% collect
```

```
## # A tibble: 1 x 3
##     min   max   med
##   <dbl> <dbl> <dbl>
## 1  0.99  25.9  5.65
```

Para obtener el total de las facturas de cada uno de los países:


```r
res <- invoices %>% group_by(BillingCountry) %>% 
          summarise(n = n(), total = sum(Total, na.rm = TRUE))
# show_query(res)
res  %>% collect
```

```
## # A tibble: 24 x 3
##    BillingCountry     n total
##    <chr>          <int> <dbl>
##  1 Argentina          7  37.6
##  2 Australia          7  37.6
##  3 Austria            7  42.6
##  4 Belgium            7  37.6
##  5 Brazil            35 190. 
##  6 Canada            56 304. 
##  7 Chile              7  46.6
##  8 Czech Republic    14  90.2
##  9 Denmark            7  37.6
## 10 Finland            7  41.6
## # ... with 14 more rows
```

Para obtener un listado con Nombre y Apellidos de cliente y el importe de cada una de sus facturas (Hint: WHERE customer.CustomerID=invoices.CustomerID):


```r
customers <- tbl(chinook, "customers")
tbl_vars(customers) 
```

```
## <dplyr:::vars>
##  [1] "CustomerId"   "FirstName"    "LastName"     "Company"      "Address"     
##  [6] "City"         "State"        "Country"      "PostalCode"   "Phone"       
## [11] "Fax"          "Email"        "SupportRepId"
```

```r
res <- customers %>% inner_join(invoices, by = "CustomerId") %>% select(FirstName, LastName, Country, Total) 
show_query(res)
```

```
## <SQL>
## SELECT `FirstName`, `LastName`, `Country`, `Total`
## FROM (
##   SELECT
##     `LHS`.`CustomerId` AS `CustomerId`,
##     `FirstName`,
##     `LastName`,
##     `Company`,
##     `Address`,
##     `City`,
##     `State`,
##     `Country`,
##     `PostalCode`,
##     `Phone`,
##     `Fax`,
##     `Email`,
##     `SupportRepId`,
##     `InvoiceId`,
##     `InvoiceDate`,
##     `BillingAddress`,
##     `BillingCity`,
##     `BillingState`,
##     `BillingCountry`,
##     `BillingPostalCode`,
##     `Total`
##   FROM `customers` AS `LHS`
##   INNER JOIN `invoices` AS `RHS`
##     ON (`LHS`.`CustomerId` = `RHS`.`CustomerId`)
## )
```

```r
res  %>% collect
```

```
## # A tibble: 412 x 4
##    FirstName LastName  Country Total
##    <chr>     <chr>     <chr>   <dbl>
##  1 Luís      Gonçalves Brazil   3.98
##  2 Luís      Gonçalves Brazil   3.96
##  3 Luís      Gonçalves Brazil   5.94
##  4 Luís      Gonçalves Brazil   0.99
##  5 Luís      Gonçalves Brazil   1.98
##  6 Luís      Gonçalves Brazil  13.9 
##  7 Luís      Gonçalves Brazil   8.91
##  8 Leonie    Köhler    Germany  1.98
##  9 Leonie    Köhler    Germany 13.9 
## 10 Leonie    Köhler    Germany  8.91
## # ... with 402 more rows
```

Para listar los 10 mejores clientes (aquellos a los que se les ha facturado más cantidad) indicando Nombre, Apellidos, Pais y el importe total de su facturación:


```r
customers %>% inner_join(invoices, by = "CustomerId") %>% group_by(CustomerId) %>% 
    summarise(FirstName, LastName, country, total = sum(Total, na.rm = TRUE)) %>%  
    arrange(desc(total)) %>% head(10) %>% collect
```

```
## # A tibble: 10 x 5
##    CustomerId FirstName LastName   Country        total
##         <int> <chr>     <chr>      <chr>          <dbl>
##  1          6 Helena    Holý       Czech Republic  49.6
##  2         26 Richard   Cunningham USA             47.6
##  3         57 Luis      Rojas      Chile           46.6
##  4         45 Ladislav  Kovács     Hungary         45.6
##  5         46 Hugh      O'Reilly   Ireland         45.6
##  6         28 Julia     Barnett    USA             43.6
##  7         24 Frank     Ralston    USA             43.6
##  8         37 Fynn      Zimmermann Germany         43.6
##  9          7 Astrid    Gruber     Austria         42.6
## 10         25 Victor    Stevens    USA             42.6
```


Al finalizar hay que desconectar la base de datos:


```r
DBI::dbDisconnect(chinook)            
```




