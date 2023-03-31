for %%f in (*.tex) do (
    echo %%~nf
    "C:\Program Files\RStudio\bin\pandoc\pandoc.exe" -f latex -t markdown -o "%%~nf.Rmd" "%%~nf.tex"
)
pause
