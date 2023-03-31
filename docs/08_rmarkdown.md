# Generación de informes {#informes}




<!-- 
---
title: "Generación de informes"
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


Este documento se ha generado empleando RMarkdown, una extensión de [Markdown](https://es.wikipedia.org/wiki/Markdown) que permite incorporar código y resultados de R. 
RMarkdown es recomendable para difundir análisis realizados con R en formato HTML, PDF y DOCX (Word), entre otros. 

## RMarkdown

El paquete [`rmarkdown`](https://github.com/rstudio/rmarkdown) permite combinar Markdown con R para la generación de documentos.  [Markdown](http://daringfireball.net/projects/markdown/) se diseñó inicialmente para la creación de páginas web a partir de documentos de texto de forma muy sencilla y rápida (tiene unas reglas sintácticas muy simples). 
Es lo que se conoce como un lenguaje de marcado ligero, tiene unas reglas sintácticas muy simples y se busca principalmente la facilidad de lectura.
Posteriormente se fueron añadiendo funcionalidades, por ejemplo para incluir opciones de publicación en muchos otros formatos.
La implementación original de Markdown es de [John Gruber](http://daringfireball.net/projects/markdown/), 
pero actualmente están disponibles múltiples dialectos (sobre todo para publicar en gestores de contenido).
RMarkdown utiliza las extensiones de la sintaxis proporcionada por *Pandoc* (ver Apéndice \@ref(pandoc)), y adicionalmente permite la inclusión de código R.

Al renderizar un fichero RMarkdown se generará un documento que incluye el código R y los resultados incrustados en el documento^[Se llama al paquete `knitr` para "tejer" el código de R y los resultados en un fichero Markdown, que posteriormente es procesado con *pandoc*]. 
En RStudio basta con hacer clic en el botón *Knit*. 
En R se puede emplear la funcion `render` del paquete `rmarkdown` (por ejemplo `render("Informe.Rmd")`).
También se puede abrir directamente el informe generado:
```
library(rmarkdown)
browseURL(url = render("Informe.Rmd"))
```

A continuación se darán algunos detalles sobre RMarkdown (y las extensiones Markdown de Pandoc que admite: notas al pie de página, tablas, citas, ecuaciones LaTeX, ...).
Para más información (incluyendo introducciones a Markdown y RMarkdown), se recomienda consultar alguna de las numerosas fuentes disponibles, comenzando por la web oficial  <http://rmarkdown.rstudio.com/>.

También se dispone de información en la ayuda de RStudio:

-   *Help > Markdown Quick Reference*

-   *Help > Cheatsheets > [R Markdown Cheat Sheet](https://www.rstudio.org/links/r_markdown_cheat_sheet)*

-   *Help > Cheatsheets > [R Markdown Reference Guide](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf)*


Otras fuentes permiten obtener documentación más detallada, como por ejemplo:

- Web del paquete `knitr` [@R-knitr]: <https://yihui.name/knitr>.

- @xie2018r : R Markdown: The Definitive Guide, 
  <https://bookdown.org/yihui/rmarkdown/>.

- Extensiones RMarkdown de Pandoc: <https://rmarkdown.rstudio.com/authoring_pandoc_markdown.html%23raw-tex>.


## Sintaxis de Markdown {#markdown}

Como ya se comentó la sintaxis de Markdown es muy secilla. 
El texto no marcado se renderiza como texto normal aunque es necesario dejar una línea en blanco para insertar un salto de línea. 
Las principales reglas de Markdown se sumarizan en la siguiente tabla:

+--------------------------+-----------------------------+--------------------------+
| Escribir                 | o alternativamente          | para obtener ...         |
+==========================+=============================+==========================+
| ```                      | ```                         |                          |
| # Título 1               | Título 1                    | Los distintos            |
|                          | ========                    | niveles de encabezados   |
| ## Título 2              | Título 2                    |                          |
|                          | --------                    |                          |
| ### Título 3             | ### Título 3                |                          |
| ```                      | ```                         |                          |
+--------------------------+-----------------------------+--------------------------+
| ```                      | ```                         |                          |
| *Cursiva*                | _Cursiva_                   | *Cursiva*                | 
| ```                      | ```                         |                          |
+--------------------------+-----------------------------+--------------------------+
| ```                      | ```                         |                          |
| **Negrita**              | __Negrita__                 | **Negrita**              |
| ```                      | ```                         |                          |
+--------------------------+-----------------------------+--------------------------+
| ```                      | ```                         |                          |
| [Enlace](http://url.gz)  | [Enlace][1]                 | [Enlace](http://rmark    |
|                          | Más adelante...             | down.rstudio.com)        |
|                          | [1]: http://url.gz          |                          |
| ```                      | ```                         |                          |
+--------------------------+-----------------------------+--------------------------+
| ```                      | ```                         |                          |
| ![Imagen](rmarkdown.png) | ![Imagen][1]                | ![Imagen](figuras/rmd.png) |
|                          | Más adelante...             |                          |
|                          | [1]:http://url/b.jpg        |                          |
| ```                      | ```                         |                          |
+--------------------------+-----------------------------+--------------------------+
| ```                      |                             |                          |
| > Blockquote             |                             | > Blockquote             |
| >                        |                             | >                        |
| > --- El Autor           |                             | > --- El Autor           |
| ```                      |                             |                          |
+--------------------------+-----------------------------+--------------------------+
| ```                      | ```                         |                          |
| * Lista                  | -  Lista                    | -   Lista                |
| * Lista                  | -  Lista                    | -   Lista                |
|    + Sub-lista           |    - Sub-lista              |     -   Sub-lista        |
| ```                      | ```                         |                          |
+--------------------------+-----------------------------+--------------------------+
| ```                      | ```                         |                          |
| 1. Uno                   | 1) Uno                      | 1.  Uno                  |
| 2. Dos                   | 2) Dos                      | 2.  Dos                  |
|    a. A                  |    a) A                     |     a. A                 |
| ```                      | ```                         |                          |
+--------------------------+-----------------------------+--------------------------+
| ```                      | ```                         |                          |
| Regla horizontal         | Regla horizontal            | Regla horizontal         |
|                          |                             |                          |
| ---                      | ***                         | ---                      |
| ```                      | ```                         |                          |
+--------------------------+-----------------------------+--------------------------+
| ```                      |                             |                          |
| `código en línea` entre  |                             | `código en línea` entre  |
| comillas invertidas      |                             | comillas invertidas      |
| ```                      |                             |                          |
+--------------------------+-----------------------------+--------------------------+
| ````                     | ```                         |                          |
| ```                      | [····]# bloque de código    | ```                      |
| # bloque de código       | [····]3 comillas invertidas | # bloque de código       |
| 3 comillas invertidas    | [····]o sangría de 4 espaci | 3 comillas invertidas    |
| o sangría de 4 espacios  | os                          | o sangría de 4 espacios  |
| ```                      | ```                         | ```                      |
| ````                     |                             |                          |
+--------------------------+-----------------------------+--------------------------+

Es muy recomendable dejar siempre una linea de separación entre elementos distintos consecutivos.



## Inclusión de código R {#codigormd}

Se puede incluir código R entre los delimitadores ` ```{r} ` y ` ``` `. 
Por defecto, se mostrará el código, se evaluará y se mostrarán los resultados justo a continuación.
Por ejemplo el siguiente código:
````markdown
```{r}
head(mtcars[1:3])
summary(mtcars[1:3])
```
````
produce:

```r
head(mtcars[1:3])
```

```
##                    mpg cyl disp
## Mazda RX4         21.0   6  160
## Mazda RX4 Wag     21.0   6  160
## Datsun 710        22.8   4  108
## Hornet 4 Drive    21.4   6  258
## Hornet Sportabout 18.7   8  360
## Valiant           18.1   6  225
```

```r
summary(mtcars[1:3])
```

```
##       mpg             cyl             disp      
##  Min.   :10.40   Min.   :4.000   Min.   : 71.1  
##  1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8  
##  Median :19.20   Median :6.000   Median :196.3  
##  Mean   :20.09   Mean   :6.188   Mean   :230.7  
##  3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0  
##  Max.   :33.90   Max.   :8.000   Max.   :472.0
```

En RStudio pulsando *Ctrl + Alt + I* o en el icono correspondiente se incluye un trozo de código.

También se puede incluir código en línea empleando `` `r código` ``, 
por ejemplo `` `r 2 + 2` `` produce 4.


### Gráficos

Si el código genera un gráfico, este se incluirá en el documento justo después de donde fué generado 
(por defecto). Por ejemplo el siguiente gráfico:


\begin{center}\includegraphics[width=0.8\linewidth]{08_rmarkdown_files/figure-latex/figura1-1} \end{center}

se generó empleando:
````markdown
```{r figura1, echo=FALSE}
hist(mtcars$mpg)
```
````

aunque no se mostró previamente el código al haber establecido la opción ` ```{r, echo=FALSE} `.

### Opciones de bloques de código {#opcodigo}

Los trozos de código pueden tener nombre y opciones, se establecen en la cabecera de la forma 
` ```{r nombre, op1, op2} `. 
Para un listado de las opciones disponibles ver <http://yihui.name/knitr/options>
(en la [Sección 2.6](https://bookdown.org/yihui/rmarkdown/r-code.html) del libro de RMarkdown se incluye un resumen).
En RStudio se puede pulsar en los iconos en la parte superior derecha del bloque de código para establecer opciones, ejecutar todo el código anterior o sólo el correspondiente trozo.

Algunas opciones sobre evaluación y resultados:

* `eval`: si `=FALSE` no se evalúa el código.
* `echo`: si `=FALSE` no se muestra el código.
* `include`: si `=FALSE` no se muestra el código ni ningún resultado.
* `message, warning, error`: oculta el correspondiente tipo de mensaje de R 
  (los errores o warnings se mostrarán en la consola).
* `cache`: si se activa, guarda los resultados de la última evaluación 
  y se reutilizan si no cambió el bloque de código 
  (más detalles [aquí](https://yihui.name/knitr/options/#cache)).
  Puede ser de utilidad durante la redacción del documento para reducir el tiempo de renderizado
  (usándolo con cuidado y desactivándolo al terminar). 

Algunas opciones sobre resultados gráficos:

* `fig.width, fig.height, fig.dim`: dimensiones del dispositivo gráfico de R 
  (no confundir con el tamaño del resultado), e.g. `fig.width = 5`.
* `out.width, out.heigh`: tamaño del gráfico, e.g. `='80%'`.
* `fig.align`: `='left', 'center', 'right'`, establece la alineación.
* `fig.cap`: leyenda de la figura^[Si se genera un documento en PDF/LaTeX el gráfico 
  se mostrará en un entorno flotante y se puede ajustar la posición empleando la opción 
  `fig.pos` (por ejemplo, `fig.pos = '!htb'`).].
* `dev`: dispositivo gráfico de R, por defecto `='pdf'` para LaTeX y `'png'` para HTML.
  Otras opciones son `'svg'` o `'jpeg'`.

Para establecer valores por defecto para todos los bloques de código 
se suele incluir uno de configuración al principio del documento, por ejemplo:

````markdown
```{r, setup, include=FALSE}
knitr::opts_chunk$set(comment=NA, prompt=TRUE, dev='svg', fig.dim=c(5, 7), collapse=TRUE)
```
````

## Tablas {#tablas}

En Markdown se pueden escribir tablas en varios formatos (ver [Pandoc Tables](https://pandoc.org/MANUAL.html#tables)).
Por ejemplo:
```
  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1   
```

También:
```
Variable   | Descripción
---------  | -----------------------------------------------------------
mpg	  |  Millas / galón (EE.UU.) 
cyl	  |  Número de cilindros
disp  |	 Desplazamiento (pulgadas cúbicas)
hp	  |  Caballos de fuerza bruta
drat  |  Relación del eje trasero
wt    |  Peso (miles de libras)
qsec  |  Tiempo de 1/4 de milla
vs    |  Cilindros en V/Straight (0 = cilindros en V, 1 = cilindros en línea)
am    |  Tipo de transmisión (0 = automático, 1 = manual)
gear  |  Número de marchas (hacia adelante)
carb  |  Número de carburadores 
```
que resulta en:

Variable   | Descripción
---------  | -----------------------------------------------------------
mpg	  |  Millas / galón (EE.UU.) 
cyl	  |  Número de cilindros
disp  |	 Desplazamiento (pulgadas cúbicas)
hp	  |  Caballos de fuerza bruta
drat  |  Relación del eje trasero
wt    |  Peso (miles de libras)
qsec  |  Tiempo de 1/4 de milla
vs    |  Cilindros en V/Straight (0 = cilindros en V, 1 = cilindros en línea)
am    |  Tipo de transmisión (0 = automático, 1 = manual)
gear  |  Número de marchas (hacia adelante)
carb  |  Número de carburadores


Para convertir resultados de R en tablas de una forma simple se puede emplear la función [`ktable()`](NA) del paquete [`knitr`](https://yihui.org/knitr/). Por ejemplo la Tabla \@ref(tab:kable) se obtuvo mediante el siguiente código:

```r
knitr::kable(
  head(mtcars), 
  caption = "Una kable knitr"
)
```

\begin{table}

\caption{(\#tab:kable)Una kable knitr}
\centering
\begin{tabular}[t]{l|r|r|r|r|r|r|r|r|r|r|r}
\hline
  & mpg & cyl & disp & hp & drat & wt & qsec & vs & am & gear & carb\\
\hline
Mazda RX4 & 21.0 & 6 & 160 & 110 & 3.90 & 2.620 & 16.46 & 0 & 1 & 4 & 4\\
\hline
Mazda RX4 Wag & 21.0 & 6 & 160 & 110 & 3.90 & 2.875 & 17.02 & 0 & 1 & 4 & 4\\
\hline
Datsun 710 & 22.8 & 4 & 108 & 93 & 3.85 & 2.320 & 18.61 & 1 & 1 & 4 & 1\\
\hline
Hornet 4 Drive & 21.4 & 6 & 258 & 110 & 3.08 & 3.215 & 19.44 & 1 & 0 & 3 & 1\\
\hline
Hornet Sportabout & 18.7 & 8 & 360 & 175 & 3.15 & 3.440 & 17.02 & 0 & 0 & 3 & 2\\
\hline
Valiant & 18.1 & 6 & 225 & 105 & 2.76 & 3.460 & 20.22 & 1 & 0 & 3 & 1\\
\hline
\end{tabular}
\end{table}

Otros paquetes proporcionan opciones adicionales: [`xtable`](http://xtable.r-forge.r-project.org/), [`stargazer`](https://CRAN.R-project.org/package=stargazer), [`pander`](https://rapporter.github.io/pander/), [`tables`](https://r-forge.r-project.org/projects/tables/) y [`ascii`](https://github.com/mclements/ascii).


## Cabecera YAML {#yaml}

En un fichero RMarkdown se puede incluir metadatos en una cabecera en formato YAML 
(YAML Ain’t Markup Language, https://en.wikipedia.org/wiki/YAML), 
comenzando y terminando con tres guiones `---`. 
Los metadatos de YAML son típicamente opciones de renderizado consitentes en 
pares de etiquetas y valores separados por dos puntos. 
Por ejemplo:

```yaml
---
title: "Creación de contenidos con RMarkdown"
author: "Fernández-Casal, R. y Cotos-Yáñez, T.R."
date: "`r Sys.Date()`"
output: html_document
---
```

Aunque no siempre es necesario, se recomienda que los valores de texto se introduzcan entre comillas (se puede incluir código R en línea, como por ejemplo `` `r Sys.Date()` `` para obtener la fecha actual). Para valores lógicos se puede emplear `yes/true` y `no/false` para verdadero y falso, respectivamente.

Los valores pueden ser vectores, por ejemplo las siguientes opciones son equivalentes:
```yaml
bibliography: [book.bib, packages.bib]
```
```yaml
bibliography:
- book.bib
- packages.bib
```
También pueden ser listas, añadiendo una sangría de dos espacios (importante):
```yaml
output:
  html_document:
    toc: yes
    toc_float: yes
  pdf_document:
    toc: yes
```
El campo `output` permite especificar el formato y las opciones de salida (por defecto se empleará la primera). Empleando este campo también se pueden especificar opciones gráficas para los bloques de código, por ejemplo:
```yaml
output:
  html_document:
    fig_width: 7
    fig_height: 6
    fig_caption: true
```

La mayoría de los campos YAML son opciones que el paquete [`rmarkdown`](https://github.com/rstudio/rmarkdown) le pasa a Pandoc (ver documentación en el Apéndice \@ref(pandoc)).

Un ejemplo adicional^[Puede ser interesante ejecutar `str(rmarkdown::html_document())` para ver un listado de todas las opciones disponibles de `html_document`]:

```yaml
---
title: "Creación de contenidos con RMarkdown"
subtitle: "Curso de introducción a R"
author:
- name: "Rubén Fernández Casal (ruben.fcasal@udc.es)"
  affiliation: "Universidade da Coruña"
- name: "Tomás R. Cotos Yáñez (tcotos@uvigo.es)"
  affiliation: "Universidade de Vigo"
date: "2023-03-31"
logo: rmarkdown.png
output:
  html_document:
    toc: yes                  # incluir tabla de contenido
    toc_float: yes            # toc flotante a la izquierda
    number_sections: yes      # numerar secciones y subsecciones
    code_folding: hide        # por defecto el código aparecerá oculto
    mathjax: local            # emplea una copia local de MathJax, hay que establecer:
    self_contained: false     # las dependencias se guardan en ficheros externos
    lib_dir: libs             # directorio para librerías (Bootstrap, MathJax, ...)
  pdf_document:
    toc: yes
    toc_depth: 2
    keep_tex: yes             # conservar fichero latex
---
```
Como se puede deducir del ejemplo anterior, en el formato YAML podemos incluir comentarios con el carácter `#` 
(por ejemplo para no emplear alguna de las opciones sin borrarla del encabezado).

En el [Capítulo 3](https://bookdown.org/yihui/rmarkdown/documents.html) del libro de RMarkdown se tiene información detallada sobre las opciones de los distintos formatos de salida (sobre ficheros HTML en la sección [HTML document](https://bookdown.org/yihui/rmarkdown/html-document.html) y sobre PDF/LaTeX en [PDF document](https://bookdown.org/yihui/rmarkdown/pdf-document.html)).


## Extracción del código R

Para generar un fichero con el código R se puede emplear la función [`knitr::ktable()`](NA). 
Por ejemplo:
```
purl("Informe.Rmd")
```

Si se quiere además el texto RMarkdown como comentarios tipo [`spin()`](https://rdrr.io/pkg/knitr/man/spin.html), se puede emplear:
```
purl("Informe.Rmd", documentation = 2)
```

## Spin

Una forma rápida de crear este tipo de informes a partir de un fichero de código R es emplear la función [`spin()`](https://rdrr.io/pkg/knitr/man/spin.html) del paquete [`knitr`](https://yihui.org/knitr/) (ver p.e. <https://yihui.org/knitr/demo/stitch/#spin-comment-out-texts>).

Para ello se debe comentar todo lo que no sea código R de una forma especial:

-   El texto RMarkdown se comenta con `#' `. 


    Por ejemplo:
    ```
    #' # Este es un título de primer nivel
    #' ## Este es un título de segundo nivel
    ```
-   Las opciones de un trozo de código se comentan con `#+`. 


    Por ejemplo:
    ```
    #+ setup, include=FALSE
    opts_chunk$set(comment=NA, prompt=TRUE, dev='svg', fig.height=6, fig.width=6)
    ```

Para generar el informe se puede emplear la función [`knitr::purl()`](https://rdrr.io/pkg/knitr/man/knit.html). 
Por ejemplo: `spin("Ridge_Lasso.R")`.
También se podría abrir directamente el informe generado:
```
browseURL(url = knitr::spin("Ridge_Lasso.R"))
```
Pero puede ser recomendable renderizarlo con rmarkdown:
```
library(rmarkdown)
browseURL(url = render(knitr::spin("Ridge_Lasso.R", knit = FALSE)))
```
En RStudio basta con pulsar *Ctrl + Shift + K*, el icono correspondiente en la barra superior, o seleccionar *File > Compile Report...*.

Por ejemplo, si se quiere convertir la salidas de un fichero de código de R a formato LaTeX 
(para añadirlas fácilmente a un documento en este formato), bastaría con incluir una cabecera de
la forma:
```markdown
#' ---
#' title: "Título"
#' author: "Autor"
#' date: "Fecha"
#' output:
#'   pdf_document:
#'      keep_tex: true
#' ---
```


## Extensiones RMarkdown de pandoc

Como ya se comentó, RMarkdown utiliza la sintaxis extendida proporcionada por Pandoc. 
Por ejemplo, se pueden añadir sub~índices~ y super^índices^ con `sub~índices~` y `super^índices^`,  
y notas al pie con `^[texto]`.

Podemos incluir expresiones matemáticas en formato LateX:

*   En linea escribiendo la expresión latex entre dos símbolos de dolar, 
    por ejemplo ``$\alpha, \beta, \gamma, \delta$ ``
    resultaría en $\alpha, \beta, \gamma, \delta$.
  
*   En formato ecuación empleando dos pares de símbolos de dolar. Por ejemplo:
    ```
    $$\Theta = \begin{pmatrix}\alpha & \beta\\
    \gamma & \delta
    \end{pmatrix}$$
    ```
    resultaría en:
    $$\Theta = \begin{pmatrix}\alpha & \beta\\
    \gamma & \delta
    \end{pmatrix}$$

También admite bibliografía, ver p.e. [Pandoc Citations](https://pandoc.org/MANUAL.html#citations).
Lo más cómodo puede ser emplear un archivo de bibliografía en formato BibTeX, lo que se describe con detalle en [Citations](https://bookdown.org/yihui/bookdown/citations.html).
Será necesario añadir un campo `bibliography` en la cabezera YAML, por ejemplo:
```yaml
bibliography: bibliografia.bib
csl: apa.csl  # opcional
```
Suponiendo que en el directorio de trabajo están los ficheros de bibliografía *bibliografia.bib* 
y de estilo *apa.csl* (ver  <http://citationstyles.org/>, desde donde se pueden descargar 
distintos archivos de estilo). 

Las referencias en el texto RMarkdown se incluyen con `@referencia` o `[@referencia]`. 
Pandoc generará el listado de referencias al final del documento, 
por lo que nos puede interesar insertar una última sección `# Bibliografía {-}`
al generar documentos HTML (en PDF se hará automáticamente al emplear LaTeX).
En RStudio se puede instalar el "[Addin](https://rstudio.github.io/rstudioaddins/)"
[`citr`](https://github.com/crsh/citr) para insertar
citas a referencias bibliográficas en formato BibTeX.

Para más detalles de las extensiones de Pandoc ver por ejemplo [Pandoc’s Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown).





