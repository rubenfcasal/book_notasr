for %%f in (*.tex) do (
    echo %%~nf
    "C:\Program Files\RStudio\bin\quarto\bin\tools\pandoc.exe" -f latex -t markdown -o "%%~nf.Rmd" "%%~nf.tex"
)
pause
