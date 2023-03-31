REM Convierte una url a un fichero markdown
@echo off
set /p "url=Introduce url: "
set /p "file=Introduce fichero de salida: "

"C:\Program Files\RStudio\bin\quarto\bin\tools\pandoc.exe" %url% -f html -t markdown --extract-media %file%.media -o %file%

REM Emplea pandoc porporcionado por RStudio (rmarkdown::find_pandoc()). Cambia la ruta entre comillas por pandoc si está en el path.
