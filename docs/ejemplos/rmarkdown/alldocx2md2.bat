for %%f in (*.docx) do (
    echo %%~nf
    "C:\Program Files\RStudio\bin\quarto\bin\tools\pandoc.exe" -f docx -t markdown --extract-media "%%~nf.media" -o "%%~nf.Rmd" "%%~nf.docx"
)
pause

