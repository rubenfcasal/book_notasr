REM Convierte un fichero docx a un fichero markdown
@echo off
set /p "file=Introduce fichero docx (sin extensión): "

"C:\Program Files\RStudio\bin\pandoc\pandoc.exe" -f docx -t markdown --extract-media %file%.media -o %file%.Rmd %file%.docx

REM Emplea pandoc porporcionado por RStudio (rmarkdown::find_pandoc()). Cambia la ruta entre comillas por pandoc si está en el path.