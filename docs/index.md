--- 
title: "Notas de Programación en R"
author: "Rubén Fernández Casal (rubenfcasal@gmail.com)"  
date: "Edición: Marzo de 2023. Impresión: 2023-04-01"
output: bookdown::gitbook
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: rubenfcasal/notasr
description: "Libro con notas personales sobre programación en R"
---

# Prólogo {-}



<!-- 
Pendiente: 
- Añadir nombres a todos los chunks (para purl)
- Sección objetos, comentarios objetos básicos de R
- Capítulo RMarkdown/Informes
- Revisar libros en abierto en bibliografías
- Agradecimientos:
  Manuel Oviedo, Julián Costa
-->


Este es un libro, ***en proceso de elaboración***,  con notas personales sobre programación en R para el análisis de datos, en el que incluyen referencias a información y recursos adicionales (se asumen unos conocimientos básicos de R). 
El contenido está sesgado por la experiencia personal (es mi forma de programar en R) pero puede resultar útil para otras personas.
Cualquier sugerencia de mejora o comentario será bien recibido.

<!-- Envíame un correo si lo usas... -->

Este libro ha sido escrito en [R-Markdown](http://rmarkdown.rstudio.com) empleando el paquete [`bookdown`](https://bookdown.org/yihui/bookdown/)  y está disponible en el repositorio Github: [rubenfcasal/book_notasr](https://github.com/rubenfcasal/book_notasr). 
Se puede acceder a la versión en línea a través del siguiente enlace:

<https://rubenfcasal.github.io/book_notasr>.

donde puede descargarse en formato [pdf](https://rubenfcasal.github.io/book_notasr/Notas_R.pdf).

Para seguir los ejemplos mostrados en el libro (en la carpeta [ejemplos](https://github.com/rubenfcasal/book_notasr/tree/main/ejemplos) se incluyen algunos ejemplos adicionales) se recomienda tener instalados los siguientes paquetes (realmente no se emplean todos):
[`Rcmdr`](https://www.r-project.org), [`caret`](https://github.com/topepo/caret/), [`tidymodels`](https://tidymodels.tidymodels.org), [`tidyverse`](https://tidyverse.tidyverse.org), [`openxlsx`](https://ycphs.github.io/openxlsx/index.html), [`DT`](https://github.com/rstudio/DT), [`rmarkdown`](https://github.com/rstudio/rmarkdown), [`knitr`](https://yihui.org/knitr/), [`remotes`](https://remotes.r-lib.org), [`devtools`](https://devtools.r-lib.org/).
Por ejemplo mediante los siguientes comandos:

```r
pkgs <- c("Rcmdr", "caret", "tidymodels", "tidyverse", "openxlsx", "DT", 
          "rmarkdown", "knitr", "remotes", "devtools")
install.packages(setdiff(pkgs, installed.packages()[,"Package"]), dependencies = TRUE)
```
(puede que haya que seleccionar el repositorio de descarga, e.g. *Oficina de software libre (CIXUG)*).

El código anterior no reinstala los paquetes ya instalados, por lo que podrían aparecer problemas debidos a incompatibilidades entre versiones (aunque no suele ocurrir, salvo que nuestra instalación de R esté muy desactualizada). 
Si es el caso, en lugar de la última línea se puede ejecutar: 

```r
install.packages(pkgs, dependencies = TRUE) # Instala todos...
```

Para generar el libro (compilar) serán necesarios paquetes adicionales, 
para lo que se recomendaría consultar el libro de ["Escritura de libros con bookdown" ](https://rubenfcasal.github.io/bookdown_intro) en castellano.

Este obra está bajo una licencia de [Creative Commons Reconocimiento-NoComercial-SinObraDerivada 4.0 Internacional ](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es_ES) 
(esperamos poder liberarlo bajo una licencia menos restrictiva más adelante...).


\includegraphics[width=1.22in]{by-nc-nd-88x31} 



