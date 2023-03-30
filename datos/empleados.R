#' ## Datos de empleados
#'
#' El fichero *Empleados.RData* contiene datos de empleados de un banco.
#' Estamos interesados en estudiar si hay discriminación por cuestión de sexo o raza.

# Se puede emplear el menú File > Import Dataset > From SPSS...
# Paquete `haven` no recomendado
# library(haven)
# Employee_data <- read_sav("Employee data.sav")
# str(Employee_data)

# Paquete `foreign`
library(foreign)
# ?read.spss
empleados <- read.spss('Employee data.sav', to.data.frame = TRUE)
str(empleados)

# Eliminamos atributo codepage
attr(empleados, "codepage") <- NULL

# Etiquetas de variables
var.lab <- attr(empleados, "variable.labels")
# dput(var.lab)
var.lab <- c(id = "Código de empleado", sexo = "Sexo", fechnac = "Fecha de nacimiento",
    educ = "Nivel educativo  (años)", catlab = "Categoría laboral",
    salario = "Salario actual", salini = "Salario inicial",
    tiempemp = "Meses desde el contrato", expprev = "Experiencia previa (meses)",
    minoria = "Clasificación étnica")
attr(empleados, "variable.labels") <- var.lab
# Si cambiamos los nombres:
# names(empleados) <- names(var.lab)

# Problemas con las fechas
# Puede ser recomendable emplear la función `spss.get()` del paquete `Hmisc`.
# (SPSS las almacena como segundos desde la adopción en EEUU del calendario Gregoriano).
empleados$fechnac <- as.POSIXct(empleados$fechnac, origin="1582/10/14")
empleados$fechnac <- as.Date(empleados$fechnac)








load("Empleados.RData")
as.data.frame(attr(Empleados, "variable.labels"))


empleados <- Empleados
names(empleados) <- c("id", "sexo", "fechnac", "educ", "catlab", "salario", "salini",
                 "tiempemp", "expprev", "minoria", "sexoraza") # tolower(names(empleados))
names(attr(empleados, "variable.labels")) <- names(empleados)

as.data.frame(attr(empleados, "variable.labels"))
save(empleados, file = "empleados.RData")

load("empleados.RData")
dput(as.vector(attr(empleados, "variable.labels")))

etiquetas <- c("Código de empleado", "Sexo", "Fecha de nacimiento", "Nivel educativo (años)",
"Categoría Laboral", "Salario actual", "Salario inicial", "Meses desde el contrato",
"Experiencia previa (meses)", "Clasificación étnica", "Clasificación por sexo y raza")
names(etiquetas) <- names(empleados)
data.frame(etiquetas)


# Problemas con la fecha de nacimiento
library(foreign)
?read.spss
datos <- read.spss('Datos de empleados.sav', to.data.frame = TRUE)

#' Cuidado con las fechas
#' (SPSS las almacena como segundos desde la adopción en EEUU del calendario Gregoriano).

datos$FECHNAC <- as.POSIXct(datos$FECHNAC, origin="1582/10/14")

#' Puede ser recomendable emplear la función *spss.get()* del paquete *Hmisc*.

load("empleados.RData")
empleados$fechnac <- as.POSIXct(empleados$fechnac, origin="1582/10/14")
save(empleados, file = "empleados.RData")

# Actualizacion sexoraza
library(foreign)
datos <- read.spss('Datos de empleados.sav', to.data.frame = TRUE)

load("empleados.RData")
empleados$sexoraza <- datos$sexoraza
save(empleados, file = "empleados.RData")


