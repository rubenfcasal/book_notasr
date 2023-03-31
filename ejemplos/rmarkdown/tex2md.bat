REM Convierte un fichero latex a un fichero markdown
@echo off
set /p "file=Introduce fichero latex (sin extensión): "

"C:\Program Files\RStudio\bin\pandoc\pandoc.exe" -f latex -t markdown -o %file%.Rmd %file%.tex

REM Emplea pandoc porporcionado por RStudio (rmarkdown::find_pandoc()). Cambia la ruta entre comillas por pandoc si está en el path.
