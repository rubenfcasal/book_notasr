# Notas de Programación en R

## Rubén Fernández Casal (rubenfcasal@gmail.com)

Este es un libro, ***en proceso de elaboración***, con notas personales sobre programación en R para el análisis de datos, en el que incluyen referencias a información y recursos adicionales (se asumen unos conocimientos básicos de R). 
El contenido está sesgado por la experiencia personal (es mi forma de programar en R) pero puede resultar útil para otras personas.
Cualquier sugerencia de mejora o comentario será bien recibido.

<!-- Envíame un correo si lo usas... -->

Este libro ha sido escrito en [R-Markdown](http://rmarkdown.rstudio.com) empleando el paquete [`bookdown`](https://bookdown.org/yihui/bookdown/)  y está disponible en el repositorio Github: [rubenfcasal/book_notasr](https://github.com/rubenfcasal/book_notasr). 
Se puede acceder a la versión en línea a través del siguiente enlace:

<https://rubenfcasal.github.io/book_notasr>.

donde puede descargarse en formato [pdf](https://rubenfcasal.github.io/book_notasr/Notas_R.pdf).

Para seguir los ejemplos mostrados en el libro (en la carpeta [ejemplos](https://github.com/rubenfcasal/book_notasr/tree/main/ejemplos) se incluyen algunos ejemplos adicionales) se recomienda tener instalados los siguientes paquetes (realmente no se emplean todos): [`Rcmdr`](https://CRAN.R-project.org/package=Rcmdr), [`caret`](https://github.com/topepo/caret/), [`tidymodels`](https://tidymodels.tidymodels.org), [`tidyverse`](https://tidyverse.tidyverse.org), [`openxlsx`](https://ycphs.github.io/openxlsx/index.html), [`DT`](https://github.com/rstudio/DT), [`rmarkdown`](https://github.com/rstudio/rmarkdown), [`knitr`](https://yihui.org/knitr/), [`remotes`](https://remotes.r-lib.org), [`devtools`](https://devtools.r-lib.org/).
Por ejemplo mediante el comando:
```{r eval=FALSE}
pkgs <- c("lattice", "car", "leaps", "RcmdrMisc", 
          "lmtest", "glmnet", "rmarkdown", "knitr", "tidyverse")
install.packages(setdiff(pkgs, installed.packages()[,"Package"]), dependencies = TRUE)
```
(puede que haya que seleccionar el repositorio de descarga, e.g. *Oficina de software libre (CIXUG)*).

El código anterior no reinstala los paquetes ya instalados, por lo que podrían aparecer problemas debidos a incompatibilidades entre versiones (aunque no suele ocurrir, salvo que nuestra instalación de R esté muy desactualizada). 
Si es el caso, en lugar de la última línea se puede ejecutar: 
```{r, eval=FALSE}
install.packages(pkgs, dependencies = TRUE) # Instala todos...
```

Para generar el libro (compilar) serán necesarios paquetes adicionales, 
para lo que se recomendaría consultar el libro de ["Escritura de libros con bookdown" ](https://rubenfcasal.github.io/bookdown_intro) en castellano.


Este obra está bajo una licencia de [Creative Commons Reconocimiento-NoComercial-SinObraDerivada 4.0 Internacional ](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es_ES) 
(esperamos poder liberarlo bajo una licencia menos restrictiva más adelante...).

![](https://licensebuttons.net/l/by-nc-nd/4.0/88x31.png)

