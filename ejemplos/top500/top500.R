# Descripción ----
# ····························································
# Datos de los 500 supercomputadores comerciales más potentes conocidos.
# Fuente: https://www.top500.org/
# ····························································

library(openxlsx)
library(stringr)
library(forcats)

# Carga y preprocesado inicial ----
# ····························································
# Variables
vars <- readWorkbook("TOP500_202211.xlsx", sheet = 2)
vars <- vars[vars$filter == 1, ]

# Datos
top500 <- readWorkbook("TOP500_202211.xlsx", cols = vars$var)
names(top500) <- vars$name
variable.labels <- vars$label
names(variable.labels) <- vars$name
attr(top500, "variable.labels") <- variable.labels

# Convertir a factor
ifactor <- which(vars$factor == 1)
top500[ifactor] <- lapply(top500[ifactor], as.factor)

# Guardar (provisional)
save(top500, file = "top500.RData")


# Procesado final ----
# ····························································
# load("top500.RData")
knitr::kable(as.data.frame(variable.labels))
View(top500)
summary(top500)


# Añadir nuevos factores
# ····························································

# procvendor a partir de proctech
# levels = c("AMD", "Intel", "Other")
table(top500$proctech)

top500$procvendor <- fct_lump_n(word(top500$proctech, 1), 2)
table(top500$procvendor)
variable.labels <- c(variable.labels, 
    procvendor = "Processor manufacturer")

# Agrupar country
sort(table(top500$country), decreasing = TRUE)

top500$country2 <- fct_lump_n(top500$country, 2)
table(top500$country2)
variable.labels <- c(variable.labels, 
    country2 = "Country (grouped)")


# Transformar variables numéricas
# ····························································
# PENDENTE

hist(log(top500$rmax))
hist(log(top500$efficiency))
hist(log(top500$hpcg))


# Guardar ----
# ····························································
attr(top500, "variable.labels") <- variable.labels
save(top500, file = "top500b.RData")


# Autodescriptivo
# ····························································
# PENDENTE
