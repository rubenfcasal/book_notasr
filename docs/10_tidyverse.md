# (PART) Tidyverse {-}

# La colección de paquetes tidyverse {#tidyverse}




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
-->


***En preparación...***

En los capítulos de esta parte se pretende realizar una breve introducción al *ecosistema* [**Tidyverse**](https://dplyr.tidyverse.org), una colección de paquetes diseñados de forma uniforme (con la misma filosofía y estilo) para trabajar conjuntamente.

La referencia recomendada para usuarios de R que deseen iniciarse en el uso de estos paquetes es: 

Wickham, H., y Grolemund, G. (2016). *[R for data science: import, tidy, transform, visualize, and model data](http://r4ds.had.co.nz)*, [online-castellano](https://es.r4ds.hadley.nz), [O'Reilly](http://shop.oreilly.com/product/0636920034407.do).

El paquete [`tidyverse`](https://tidyverse.tidyverse.org) está diseñado para facilitar la instalación y carga de los paquetes principales de la colección tidyverse con un solo comando.
Al instalar este paquete se instalan paquetes que forman el denominado núcleo de tidyverse (se cargan con `library(tidyverse)`):

* [`ggplot2`](https://ggplot2.tidyverse.org): visualización de datos.
* [`dplyr`](https://dplyr.tidyverse.org): manipulación de datos.
* [`tidyr`](https://tidyr.tidyverse.org): reorganización (limpieza) de datos.
* [`readr`](https://readr.tidyverse.org): importación de datos.
* [`tibble`](https://tibble.tidyverse.org): tablas de datos (modificación de `data.frame`).
* [`purrr`](https://purrr.tidyverse.org): programación funcional.
* [`stringr`](https://github.com/tidyverse/stringr): manipulación de cadenas de texto.
* [`forcats`](https://github.com/tidyverse/forcats): manipulación de factores.
* [`lubridate`](https://github.com/tidyverse/lubridate): manipulación de fechas y horas.

y un conjunto de paquetes recomendados ([`feather`](https://github.com/wesm/feather), [`haven`](https://github.com/tidyverse/haven), [`modelr`](https://github.com/tidyverse/modelr), [`broom`](https://github.com/tidymodels/broom)...), entre los que destacaría: 

* [`readxl`](https://github.com/tidyverse/readxl): ficheros excel.
* [`hms`](https://github.com/tidyverse/hms): manipulación de valores temporales.
* [`httr`](https://github.com/r-lib/httr): web APIs.
* [`jsonlite`](https://github.com/jeroen/jsonlite): JSON.
* [`rvest`](https://github.com/tidyverse/rvest): web scraping.
* [`xml2`](https://github.com/r-lib/xml2): XML.

También hay paquetes "asociados":

* [`tidymodels`](https://tidymodels.tidymodels.org)

Muchos otros paquetes están adaptando este estilo (ver e.g. [tidyverts](https://tidyverts.org/)): [`fable`](https://fable.tidyverts.org), [`sf`](https://r-spatial.github.io/sf/)...

Resumiendo, está muy de moda y puede terminar convirtiéndose en un dialecto del lenguaje R... para mi ya lo es... todo lo que resulte de utilidad es bien venido...


## Operador *pipe* (tubería, redirección) {#pipe}

El operador `%>%` (paquete [`magrittr`](https://magrittr.tidyverse.org)) permite canalizar la salida de una función a la entrada de otra. 
Por ejemplo, `segundo(primero(datos))` se traduce en `datos %>% primero %>% segundo`, lo que facilita la lectura de operaciones (funciones) al escribirlas de izquierda a derecha.

Desde la versión 4.X de R `|>`, yo sigo prefiriendo `%>%`...

Ejemplos:


```r
load("datos/empleados.RData")
# Listamos las etiquetas
# data.frame(Etiquetas = attr(empleados, "variable.labels"))  
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
##  1st Qu.: 19.75   Sí: 4   Minoría varón: 4  
##  Median : 52.00           Blanca mujer :10  
##  Mean   : 77.62           Minoría mujer: 0  
##  3rd Qu.:125.25                             
##  Max.   :285.00
```

```r
# ?"|>"
# empleados |> subset(catlab != "Seguridad") |> droplevels() |> 
#     boxplot(salario ~ sexo*catlab, data = .)

library(magrittr)
empleados %>% subset(catlab != "Seguridad") %>% droplevels() %>%
    boxplot(salario ~ sexo*catlab, data = .)
```



\begin{center}\includegraphics[width=0.8\linewidth]{10_tidyverse_files/figure-latex/unnamed-chunk-1-1} \end{center}



