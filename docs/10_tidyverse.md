# (PART) Tidyverse {-}

# El ecosistema tidyverse {#tidyverse}




<!-- 
---
title: "Tidyverse"
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

***En preparación...***
-->


En los capítulos de esta parte se pretende realizar una breve introducción al *ecosistema* [**Tidyverse**](https://dplyr.tidyverse.org), una colección de paquetes diseñados de forma uniforme (con la misma filosofía y estilo) para trabajar conjuntamente.

La referencia recomendada para usuarios de R que deseen iniciarse en el uso de estos paquetes es: 

Wickham, H., y Grolemund, G. (2016). *[R for data science: import, tidy, transform, visualize, and model data](http://r4ds.had.co.nz)*, [online-castellano](https://es.r4ds.hadley.nz), [O'Reilly](http://shop.oreilly.com/product/0636920034407.do).

El paquete [`tidyverse`](https://tidyverse.tidyverse.org) está diseñado para facilitar la instalación y carga de los paquetes principales de la colección tidyverse con un solo comando.
Al instalar este paquete se instalan paquetes que forman el denominado núcleo de tidyverse (se cargan con `library(tidyverse)`):

- [`ggplot2`](https://ggplot2.tidyverse.org): visualización de datos.
- [`dplyr`](https://dplyr.tidyverse.org): manipulación de datos.
- [`tidyr`](https://tidyr.tidyverse.org): reorganización (limpieza) de datos.
- [`readr`](https://readr.tidyverse.org): importación de datos.
- [`tibble`](https://tibble.tidyverse.org): tablas de datos (extensión de `data.frame`).
- [`purrr`](https://purrr.tidyverse.org): programación funcional.
- [`stringr`](https://github.com/tidyverse/stringr): manipulación de cadenas de texto.
- [`forcats`](https://github.com/tidyverse/forcats): manipulación de factores.
- [`lubridate`](https://github.com/tidyverse/lubridate): manipulación de fechas y horas.

y un conjunto de paquetes recomendados ([`feather`](https://github.com/wesm/feather), [`haven`](https://github.com/tidyverse/haven), [`modelr`](https://github.com/tidyverse/modelr), [`broom`](https://github.com/tidymodels/broom)...), entre los que destacaría: 

- [`readxl`](https://github.com/tidyverse/readxl): archivos excel.
- [`hms`](https://github.com/tidyverse/hms): manipulación de medidas de tiempo.
- [`httr`](https://github.com/r-lib/httr): web APIs.
- [`jsonlite`](https://github.com/jeroen/jsonlite): archivos JSON.
- [`rvest`](https://github.com/tidyverse/rvest): web scraping.
- [`xml2`](https://github.com/r-lib/xml2): archivos XML.


```r
library(tidyverse)
```

También hay paquetes "asociados":

- [`rlang`](https://rlang.r-lib.org)
- [`tidyselect`](https://tidyselect.r-lib.org)
- [`tidymodels`](https://tidymodels.tidymodels.org)

Muchos otros paquetes están adaptando este estilo (ver e.g. [tidyverts](https://tidyverts.org/)): [`fable`](https://fable.tidyverts.org), [`sf`](https://r-spatial.github.io/sf/)...

Resumiendo, está muy de moda y puede terminar convirtiéndose en un dialecto del lenguaje R... para mi ya lo es... todo lo que resulte de utilidad es bien venido... Recomiendo evitar estos paquetes en las primeras etapas de formación en R...

El estilo de programación tiene como origen la gramática de [`ggplot2`](https://ggplot2.tidyverse.org) para crear gráficos de forma declarativa, basado a su vez en:

Wilkinson, L. (2005). *The Grammar of Graphics*. [Springer](https://www.google.es/books/edition/The_Grammar_of_Graphics/YGgUswEACAAJ?hl=es).

Yo empleo este paquete como sustituto de los gráficos [`lattice`](http://lattice.r-forge.r-project.org/), en algunos informes finales o aplicaciones para empresas, o para gráficos muy especializados. 
En condiciones normales **prefiero emplear los gráficos estándar** de R (mucho más rápidos de generar y programar).

<!-- capítulo ggplot2? -->

Para iniciarse en este paquete lo recomendado es consultar los capítulos [Data     Visualización](https://r4ds.had.co.nz/data-visualisation.html) y [Graphics for communication](https://r4ds.had.co.nz/graphics-for-communication.html) de [R for Data Science](https://r4ds.had.co.nz). 
También puede resultar de interés la [chuleta](https://github.com/rstudio/cheatsheets/blob/master/data-visualization.pdf)).
La referencia que cubre con mayor profundidad este paquete es:

Wickham, H. (2016). *[ggplot2: Elegant graphics for Data Analysis](https://ggplot2-book.org)* (3ª edición, en desarrollo junto a Navarro, D. y Pedersen, T.L.). [Springer](https://www.amazon.com/gp/product/331924275X).

Aunque yo recomendaría:

Chang, W. (2023). *[The R Graphics Cookbook](https://r-graphics.org)*. [O’Reilly](https://www.amazon.com/dp/1491978600). 

En [`ggplot2`](https://ggplot2.tidyverse.org) se emplea el operador `+` para añadir componentes de los gráficos (ver , en *Tidyverse* se emplea un operador de redirección para añadir operaciones.


## Operador *pipe* (redirección) {#pipe}

El operador `%>%` (paquete [`magrittr`](https://magrittr.tidyverse.org)) permite canalizar la salida de una función a la entrada de otra. 
Por ejemplo, `segundo(primero(datos))` se traduce en `datos %>% primero %>% segundo`, lo que facilita la lectura de operaciones al escribir las funciones de izquierda a derecha.

Desde la versión 4.1 de R está disponible un operador interno `|>` (aunque yo sigo prefiriendo `%>%`).
Por ejemplo:


```r
# El fichero 'empleados.RData' contiene datos de empleados de un banco.
# Supongamos por ejemplo que estamos interesados en estudiar si hay
# discriminación por cuestión de sexo o raza.

load("datos/empleados.RData")
# NOTA: Cuidado con la codificación latin1 (no declarada) 
# al abrir archivos creados en versiones anteriores de R < 4.2: 
# load("datos/empleados.latin1.RData")

# Listamos las etiquetas
knitr::kable(attr(empleados, "variable.labels"), col.names = "Etiqueta")
```


\begin{tabular}{l|l}
\hline
  & Etiqueta\\
\hline
id & Código de empleado\\
\hline
sexo & Sexo\\
\hline
fechnac & Fecha de nacimiento\\
\hline
educ & Nivel educativo  (años)\\
\hline
catlab & Categoría laboral\\
\hline
salario & Salario actual\\
\hline
salini & Salario inicial\\
\hline
tiempemp & Meses desde el contrato\\
\hline
expprev & Experiencia previa (meses)\\
\hline
minoria & Clasificación étnica\\
\hline
sexoraza & Clasificación por sexo y raza\\
\hline
\end{tabular}

```r
# Eliminamos las etiquetas para que no molesten...
# attr(empleados, "variable.labels") <- NULL  

empleados |>  subset(catlab == "Directivo", catlab:sexoraza) |>  summary()
```

```
##             catlab      salario           salini         tiempemp    
##  Administrativo: 0   Min.   : 34410   Min.   :15750   Min.   :64.00  
##  Seguridad     : 0   1st Qu.: 51956   1st Qu.:23063   1st Qu.:73.00  
##  Directivo     :84   Median : 60500   Median :28740   Median :81.00  
##                      Mean   : 63978   Mean   :30258   Mean   :81.15  
##                      3rd Qu.: 71281   3rd Qu.:34058   3rd Qu.:91.00  
##                      Max.   :135000   Max.   :79980   Max.   :98.00  
##     expprev       minoria          sexoraza 
##  Min.   :  3.00   No:80   Blanca varón :70  
##  1st Qu.: 19.75   Sí: 4   Blanca mujer : 4  
##  Median : 52.00           Minoría varón:10  
##  Mean   : 77.62           Minoría mujer: 0  
##  3rd Qu.:125.25                             
##  Max.   :285.00
```

Para que una función sea compatible con este tipo de operadores el primer parámetro debería ser siempre los datos.
Sin embargo, el operador `%>%` permite redirigir el resultado de la operación anterior a un parámetro distinto mediante un `.`.
Por ejemplo:


```r
# ?"|>"
# empleados |> subset(catlab != "Seguridad") |> droplevels |> 
#     boxplot(salario ~ sexo*catlab, data = .) # ERROR

library(magrittr)
empleados %>% subset(catlab != "Seguridad") %>% droplevels() %>%
    boxplot(salario ~ sexo*catlab, data = .)
```



\begin{center}\includegraphics[width=0.8\linewidth]{10_tidyverse_files/figure-latex/unnamed-chunk-3-1} \end{center}







