# (PART) El entorno estadístico R {-}

# El lenguaje R {#r}



<!-- 
---
title: "El lenguaje R"
author: "Notas de Programación en R"
date: "Rubén Fernández-Casal (rubenfcasal@gmail.com)"
output:
  bookdown::html_document2:
    toc: yes
    # toc_float: yes
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

bookdown::preview_chapter("01-Introduccion.Rmd")
knitr::purl("01-Introduccion.Rmd", documentation = 2)
knitr::spin("01-Introduccion.R", knit = FALSE)
-->


Cualquier análisis de R requiere programación, aunque normalmente se puede llevar a cabo sin conocimientos profundos del lenguaje (*useR*). 
Sin embargo, para desarrollar nuevas herramientas de forma efectiva (*programeR*) es necesario tener una idea del funcionamiento interno de R.
La referencia recomendada para usuarios de R que deseen mejorar sus conocimientos de programación y comprensión del lenguaje es: 

Wickham, Hadley (2019). *[Advanced R, 2ª edición](https://adv-r.hadley.nz/)*, [Chapman & Hall](https://www.amazon.com/dp/0815384572), [1ª edición](http://adv-r.had.co.nz/).

También puede ser de utilidad el manual [R Language Definition](https://cran.r-project.org/doc/manuals/R-lang.html)
para consultas adicionales^[Los manuales oficiales también están disponibles en formato bookdown en este [post](https://colinfay.me/r-manuals).].


## Paquetes {#paquetes}

Al instalar R se instalan los denominados **paquetes base** y (por defecto) los **paquetes recomendados** por los desarrolladores de R (el *R Core Team*).
Podemos acceder a la lista de paquetes instalados:


```r
pkgs <- installed.packages()
names(which(pkgs[ ,"Priority"] == "base"))
```

```
##  [1] "base"      "compiler"  "datasets"  "graphics"  "grDevices" "grid"     
##  [7] "methods"   "parallel"  "splines"   "stats"     "stats4"    "tcltk"    
## [13] "tools"     "utils"
```

```r
names(which(pkgs[ ,"Priority"] == "recommended"))
```

```
##  [1] "boot"       "class"      "cluster"    "codetools"  "foreign"   
##  [6] "KernSmooth" "lattice"    "MASS"       "Matrix"     "mgcv"      
## [11] "nlme"       "nnet"       "rpart"      "spatial"    "survival"
```

Para instalar paquetes adicionales se puede emplear `install.packages()` (actualmente, 2023-03-31, están disponibles 19214 en [CRAN](https://cran.r-project.org/web/packages/available_packages_by_date.html), incluso para interactuar con ChatGPT como [`gptstudio`](https://michelnivard.github.io/gptstudio)).
Por ejemplo:

```r
pkgs <- c("Rcmdr", "caret", "tidymodels", "tidyverse", "remotes", "devtools",
          "sf", "gstat", "geoR", "quadprog", "DEoptim", "spam", "openxlsx",
	        "bookdown", "blogdown", "pkgdown")
install.packages(setdiff(pkgs, installed.packages()[,"Package"]), dependencies = TRUE)
```

<!-- 
Paquetes libro estadística espacial y aprendizaje estadístico
pxR, sf, mapSpain, DT
shiny
-->

En Windows (y en MacOS) esta función instala por defecto paquetes compilados (`type = "binary"`, que dependen del sistema operativo y de la versión R) disponibles en CRAN.
Aunque podría instalar paquetes disponibles en otros repositorios.
Por ejemplo:

```r
url <- "https://github.com/rubenfcasal/simres/releases/download/v0.1/simres_0.1.3.zip"
install.packages(url, repos = NULL)
```

También se pueden instalar paquetes directamente a partir del código fuente con `type = "source"` (por defecto en Linux), pero en ciertos casos es necesario tener instaladas herramientas adicionales (por ejemplo [Rtools](https://cran.r-project.org/bin/windows/Rtools) en Windows si el paquete contiene código en C, C++ o Fortran).
Esto permitiría incluso instalar paquetes retirados de CRAN (e.g. actualmente [`kedd`](https://CRAN.R-project.org/package=kedd)), ya que siempre se mantiene el código (en un archivo comprimido de la forma `paquete_x.y.z.tar.gz`).

Si se quieren instalar paquetes de repositorios distintos de CRAN (GitHub, GitLab, Bitbucket, ...), puede ser recomendable instalar [`remotes`](https://remotes.r-lib.org/). 
Por ejemplo:

```r
remotes::install_github("rubenfcasal/simres", INSTALL_opts = "--with-keep.source")
```
Además puede ser de utilidad mantener los comentarios originales del paquete para entender mejor el código (por ejemplo si se quiere modificar).

<!-- 
Para el desarrollo de paquetes es recomendable instalar [`devtools`](https://devtools.r-lib.org).
-->

Otras funciones que pueden ser de interés son: `remove.packages()`, `update.packages()` y `available.packages()`.

Al iniciar el programa `R` se cargan por defecto en memoria los principales paquetes base, añadiéndolos a la ruta de búsqueda (a continuación del entorno de trabajo `.GlobalEnv` y siempre terminando con en el paquete `base`, el primero que se carga):

```r
search()
```

```
##  [1] ".GlobalEnv"        "package:dbplyr"    "package:forcats"  
##  [4] "package:stringr"   "package:dplyr"     "package:purrr"    
##  [7] "package:readr"     "package:tidyr"     "package:tibble"   
## [10] "package:ggplot2"   "package:tidyverse" "package:magrittr" 
## [13] "package:stats"     "package:graphics"  "package:grDevices"
## [16] "package:utils"     "package:datasets"  "package:methods"  
## [19] "Autoloads"         "package:base"
```
Concretamente se añade a la ruta de búsqueda un entorno que contiene el conjunto de objetos exportables del paquete, definido en el denominado ***namespace*** del paquete.
Esta ruta determina los objetos visibles en el entorno global y el orden en se buscan (para más detalles ver [7.2 Environment basics](https://adv-r.hadley.nz/environments.html#env-basics) y [7.4 Special environments](https://adv-r.hadley.nz/environments.html#special-environments) de [Advanced R](https://adv-r.hadley.nz/index.html)).

Podemos cargar paquetes adicionales (previamente instalados) con `library()` o `require()`, por ejemplo:

```r
if (!require(knitr)) {
  install.packages("knitr")
  library(knitr)
}
spin("01-Introduccion.R", knit = FALSE)
```
Aunque **no se recomienda que el código instale automáticamente paquetes** (en general que haga cambios en la configuración del equipo en el que se ejecuta).

Al cargar un paquete se añade por defecto en la segunda posición de la ruta de búsqueda (justo después del entorno global, desplazando al resto).
También se podrían añadir otros objetos, por ejemplo data.frames, con la función `attach()` pero **no se recomienda** (se puede utilizar `with()` como alternativa).

Hay que tener cuidado con las versiones instaladas de los paquetes:

```r
packageVersion("dplyr")
```

```
## [1] '1.0.10'
```
y con sus dependencias (los paquetes tienen su propia ruta de búsqueda, determinada por el *namespace* del paquete).
Al actualizar o instalar nuevos paquetes pueden aparecer problemas al ejecutar código antiguo (a veces al trabajar en nuevos proyectos acabamos haciendo que los antiguos dejen de funcionar).

Se puede instalar versiones específicas de un paquete con [`remotes::install_version()`](https://remotes.r-lib.org/reference/install_version.html):

```r
remotes::install_version("dplyr", version = "1.11") # repos = "https://ftp.cixug.es/CRAN")
```

Para asegurarse que el código de un proyecto se pueda ejecutar a lo largo del tiempo se puede emplear el paquete [`renv`](https://rstudio.github.io/renv/) (se puede configurar automáticamente al crear un proyecto de RStudio).
Este paquete permite registrar las versiones exactas de los paquetes de los que depende un proyecto y volver a instalarlas (incluso en otro equipo) si es necesario. Para más detalles ver la viñeta [Introduction to renv](https://rstudio.github.io/renv/articles/renv.html).

Sin embargo de esta forma aún dependemos del sistema operativo que deberíamos configurar adecuadamente.
La recomendación para que un proyecto en R (por ejemplo una aplicación shiny) se pueda ejecutar en cualquier equipo, es emplear un [contenedor docker](https://es.wikipedia.org/wiki/Docker_(software)).
Para más detalles ver [Docker overview](https://docs.docker.com/get-started/overview/) y [The Rocker Project](https://rocker-project.org/).
Ver [ejemplos/covid19/prediccion_cooperativa](ejemplos/covid19/prediccion_cooperativa/vii_xornadasr.html).


## Funciones {#funciones}

> "Everything that happens in R is the result of a function call".
>
> --- John M. Chambers

Como es bien conocido, en R se pueden asignar los argumentos de una función por posición o por nombre (del correspondiente parámetro en la definición de la función, denominado *argumento formal en R*). 
En general, la recomendación es asignar los argumentos por nombre:

`funcion(parametro1 = argumento1, parametro2 = argumento2, ...)`

De esta forma no importa el orden de los parámetros y, por ejemplo, evitaremos problemas si en el futuro hay cambios en la definición de la función.
Los parámetros pueden tener valores por defecto y solo sería necesario especificarlos para asignarles un valor distinto.

Podemos llamar a una función de un paquete sin necesidad de cargarlo (añadirlo a la ruta de búsqueda) empleando `paquete::funcion`.
Esto es especialmente recomendable al desarrollar nuevas funciones (es un requisito para subir paquetes a CRAN), ya que de esta forma se evitan conflictos entre funciones con el mismo nombre en paquetes distintos.
Por ejemplo:

```r
if (!requireNamespace("knitr")) stop("'knitr' package required")
knitr::spin("01-Introduccion.R", knit = FALSE)
```

Hay que tener en cuenta que R emplea [Lazy evaluation](https://adv-r.hadley.nz/functions.html#lazy-evaluation), los argumentos no se evalúan hasta que se necesitan (lo cual puede producir mensajes de error inesperados, pero también permite añadir funcionalidades adicionales empleando la denominada [evaluación no estándar](http://adv-r.had.co.nz/Computing-on-the-language.html) o [metaprogramación](https://adv-r.hadley.nz/metaprogramming.html)).

R es un lenguaje interpretado y podemos evaluar expresiones empleando código.
Por ejemplo, podemos reproducir el proceso de introducir un comando en la consola con las funciones `eval()` y `parse()` (aunque esta forma de proceder no es la más eficiente):

```r
eval(parse(text = "1:10"))
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
distr <- "norm"  # "unif", "exp", "t"
ddistr <- eval(parse(text = paste0("d", distr)))
# str(ddistr)
# curve(ddistr(x, 0, 0.5), -3, 3)
```

Para llamar a una función especificando los parámetros de forma dinámica (empleando una lista) podemos emplear `do.call()`.
Por ejemplo:

```r
# Listar ficheros csv 
files.csv <- dir(path = "datos", pattern = "*.csv", full.names = TRUE)
# Leer datos a una lista
# (suponemos variante local con ; para separar valores)
data.list <- lapply(files.csv, read.csv2)
# Combinar 
datos <- do.call('rbind', data.list)
```

R dispone además de otras herramientas que permiten la programación dinámica. 
Por ejemplo [`reformulate()`](https://rdrr.io/r/stats/delete.response.html) permite construir formulas para ajuste de modelos o análisis descriptivos.

Hay que tener en cuenta que las funciones tienen su propio entorno y su propia ruta de búsqueda, determinada por el entorno donde se crearon (el *namespace* en el caso de las funciones de un paquete). 
Esto es lo que se conoce como [Lexical scoping](https://adv-r.hadley.nz/functions.html#lexical-scoping).


```r
x <- 1
addx <- function(y) {
  x + y
}
addx(10)
```

```
## [1] 11
```

```r
addx10 <- function() {
  x <- 10   # x <<- 10   # assign("x", 10, envir = .GlobalEnv)
  addx(x)
}
addx10()
```

```
## [1] 11
```

```r
x
```

```
## [1] 1
```


<!-- 
Pendiente: sección objetos, comentarios objetos básicos de R
-->


## Programación orientada a objetos (funciones genéricas) {#oop}

> "Everything that exists in R is an object".
>
> --- John M. Chambers

R implementa programación orientada a objetos (OOP).
Por ejemplo, es bien conocido que algunas funciones (entre ellas `print()`, `plot()` o `summary()`) se comportan de manera diferente dependiendo de la clase (el tipo de objeto) de sus argumentos, son las denominadas *funciones genéricas*. 

Realmente R dispone de varios sistemas de OOP, entre ellos podríamos destacar (ver capítulos en [Object-oriented programming](https://adv-r.hadley.nz/oo.html) de [Advanced R](https://adv-r.hadley.nz)):

- [S3](https://adv-r.hadley.nz/s3.html): Es un sistema muy simple, las clases no tienen una definición formal (no se verifica su consistencia). Es el empleado en el paquete `base` de R y en la mayoría de paquetes que usan OOP. 
    Descrito inicialmente en:

    Becker R.A., Chambers J.M. y Wilks A.R. (1988), *[The New S Language: A Programming Environment for Data Analysis and Graphics](https://www.amazon.es/dp/053409192X)* (A.K.A. the *Blue Book*). Chapman & Hall. 
    
    Chambers J.M. y Hastie T.J. eds. (1992), *[Statistical Models in S](https://www.amazon.com/gp/product/0534167659)* (A.K.A. the *White Book*). Chapman & Hall.

- [S4](https://adv-r.hadley.nz/s4.html) (**no lo recomiendo**): Es similar a S3 pero mucho más formal. Está implementado en el paquete `methods` (uno de los *paquetes base*) de R. Se emplea por ejemplo en los paquetes [`sp`](https://github.com/edzer/sp/) y [`distr`](http://distr.r-forge.r-project.org/).
    Descrito inicialmente en:

    Chambers J.M. (1998), *[Programming with Data](https://www.amazon.com/gp/product/0387985034)* (A.K.A. the *Green Book*). Springer. 

- [R6](https://adv-r.hadley.nz/r6.html): Es un sistema OOP encapsulado similar al de otros lenguajes de programación. Está implementado en el paquete [`R6`](https://r6.r-lib.org) (no se instala por defecto).

Yo en principio **recomendaría usar el sistema S3**, aunque es bastante rudimentario y puede resultar inicialmente confuso a programadores con experiencia en otros lenguajes.
En cualquier caso es muy recomendable conocer su funcionamiento.
Este sistema esta basado en funciones genéricas.
La clase es un atributo de los objetos (*encapsulación*), una cadena de texto o un vector de cadenas (*herencia*), al que se puede acceder con la función [`class()`](https://rdrr.io/r/base/class.html).
A partir de la clase del argumento, la función genérica determina el método (función especializada) al que debe llamar (*polimorfismo*).
En S3 el despacho de métodos (*method dispatch*) es muy simple, si la función genérica es `generica()` y la clase del primer argumento es `"clase"`, se llama a la función (método) `generica.clase()` si existe.
Si la clase del objeto es heredada (un vector de cadenas), se van buscando los métodos por orden de parentesco y si no se encuentra ninguno, se llama al método por defecto `generica.default()` (se llama a la primera función de `paste0("generica.", c(class(x), "default"))` que se encuentre en la ruta de búsqueda; podríamos reemplazarla...).

La función genérica suele ser muy sencilla, básicamente incluye una llamada a `UseMethod("generica")`.
Por ejemplo:

```r
plot
```

```
## function (x, y, ...) 
## UseMethod("plot")
## <bytecode: 0x000000001e09ef38>
## <environment: namespace:base>
```

Podemos obtener los métodos asociados a una función genérica con `methods(genérica)`.
Por ejemplo:

```r
methods(plot)
```

```
##  [1] plot,ANY-method     plot,color-method   plot.acf*          
##  [4] plot.data.frame*    plot.decomposed.ts* plot.default       
##  [7] plot.dendrogram*    plot.density*       plot.ecdf          
## [10] plot.factor*        plot.formula*       plot.function      
## [13] plot.ggplot*        plot.gtable*        plot.hcl_palettes* 
## [16] plot.hclust*        plot.histogram*     plot.HoltWinters*  
## [19] plot.isoreg*        plot.lm*            plot.medpolish*    
## [22] plot.mlm*           plot.ppr*           plot.prcomp*       
## [25] plot.princomp*      plot.profile.nls*   plot.R6*           
## [28] plot.raster*        plot.spec*          plot.stepfun       
## [31] plot.stl*           plot.table*         plot.trans*        
## [34] plot.ts             plot.tskernel*      plot.TukeyHSD*     
## see '?methods' for accessing help and source code
```
Podemos acceder a la ayuda del correspondiente método de la forma habitual (e.g. `?plot.lm`), pero puede que algunos métodos no sean objetos definidos como exportables en el *namespace* del paquete que los implementa (los marcados con un `*`) y por tanto no son en principio accesibles para el usuario.
Siempre podemos acceder a ellos empleando `paquete:::metodo` o `getAnywhere(metodo)` (e.g. `stats:::plot.lm` o `getAnywhere(plot.lm)`).

Para listar los métodos disponibles para una clase, podemos emplear el parámetro `class`.
Por ejemplo:

```r
methods(class = "lm")
```

```
##  [1] add1           alias          anova          case.names     coerce        
##  [6] confint        cooks.distance deviance       dfbeta         dfbetas       
## [11] drop1          dummy.coef     effects        extractAIC     family        
## [16] formula        fortify        hatvalues      influence      initialize    
## [21] kappa          labels         logLik         model.frame    model.matrix  
## [26] nobs           plot           predict        print          proj          
## [31] qr             residuals      rstandard      rstudent       show          
## [36] simulate       slotsFromS3    summary        variable.names vcov          
## see '?methods' for accessing help and source code
```

Para una programación orientada a objetos más formal la recomendación es emplear el sistema R6.


## Desarrollo de funciones y paquetes {#desarrollo}

<!-- 
Pendiente: nociones básicas de creación de funciones
-->

Antes de ponerse a programar, sobre todo si puede terminar siendo un código complejo, la recomendación es hacer una búsqueda por si resulta que ya está implementado (o hay algo que podemos tomar como base; es lo bueno de GNU!): en la descripción de los paquetes en [CRAN](https://cran.r-project.org/web/packages/available_packages_by_date.html), en los buscadores especializados ([rdrr.io](https://rdrr.io/), [RDocumentation](https://www.rdocumentation.org/) o [RSeek](http://rseek.org/)), en foros de programación ([StackOverflow](http://stackoverflow.com/questions/tagged/r), [StackOverflow.es](https://es.stackoverflow.com/questions/tagged/r), [Cross Validated](https://stats.stackexchange.com)), en listas de correo ([r-project.org](https://stat.ethz.ch/mailman/listinfo), [r-help-es](https://r-help-es.r-project.narkive.com)) o directamente en [Google](https://www.google.com/search?q=r-project) (añadiendo "r-project" o similar en la búsqueda).

El primer paso es escribir el código como si fuese un programa, asignando valores de prueba a los parámetros, y cuando nos aseguramos de que funciona, reescribirlo como función (yo suelo mantener unos valores de prueba como comentarios por si quiero ejecutar paso a paso el cuerpo de la función).

Al finalizar, la recomendación es **documentar la función**, preferiblemente empleando el formato [`roxygen2`](https://roxygen2.r-lib.org) (ver el menú de RStudio *Help > Roxygen Quick Reference*).
Por ejemplo:


```r
# read_excel_list(path, pattern, ...) 
# ·············································
#' Lee los ficheros xls y xlsx de un directorio
#' 
#' @param path Ruta al directorio con los ficheros excel 
#' (por defecto el directorio de trabajo).
#' @param pattern Expresión regular empleada en la selección de ficheros 
#' (ver `list.files()`).
#' @param ... Parámetros adicionales de `readxl::read_excel()`.
#' @return Una lista cuyas componentes son las correspondientes tablas de datos 
#' (`tibble`) y con nombres los nombres de los archivos sin extensión.
#' @examples \dontrun{
#' data_list <- read_excel_list("datos") # "./datos"
#' data_all <- dplyr::bind_rows(data_list)
#' }
# ·············································
# Pruebas: 
#   readxl::readxl_example("geometry.xls")
#   path = "C:/Program Files/R/R-4.2.2/library/readxl/extdata"
#   pattern = "\\.(xls|xlsx)$"
# Pendiente:
#   - Controlar posible error al leer
# ·············································
read_excel_list <- function(path = ".", pattern = "\\.(xls|xlsx)$", ...) {
  if (!requireNamespace(readxl))  stop("'readxl' package required")
  files <- dir(path, pattern = pattern, full.names = TRUE) # ?list.files
  data_list <- vector(length(files), mode = 'list')
  for (i in seq_along(files)) 
      data_list[[i]] <- readxl::read_excel(files[i], ...)
  data_names <- sub('\\.xlsx$', '', basename(files)) 
  names(data_list) <- data_names
  data_list
}
```

Como ya se comentó, en ocasiones se emplea como punto de partida una función ya implementada en algún paquete de R.
En RStudio la forma más sencilla de obtener el código de la función es emplear `View(funcion)` (si la función es visible, en caso contrario `View(paquete:::funcion)`).
Si la función llama a funciones internas (que no se exportan en el namespace) del paquete que la implementa, podríamos emplear también los tres dobles puntos para llamarlas, pero la recomendación sería descargar el código del paquete (si está en CRAN, un fichero comprimido de la forma `paquete_x.y.z.tar.gz` que se puede descargar en la sección *Downloads* de la web del paquete *https://CRAN.R-project.org/package=paquete*).

La mejor forma de organizar funciones es crear un paquete.
Para ello se recomienda seguir:

Wickham, Hadley (2015). *[R packages: organize, test, document, and share your code](http://r-pkgs.had.co.nz/)* (actualmente 2ª edición en desarrollo con H. Bryan), [O'Reilly, 1ª edición](http://shop.oreilly.com/product/0636920034421.do).

También puede ser de utilidad el manual [Writing R Extensions](http://colinfay.me/writing-r-extensions) para información adicional.


