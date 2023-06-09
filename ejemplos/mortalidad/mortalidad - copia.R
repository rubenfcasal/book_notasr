# Descripción ====================================
# Prepara archivos de datos para comparar la mortalidad (defunciones)
# en el año 2020 respecto al 2019 por CCAA (datos INE)
# Fecha última modificación: 2023-03-22
# ················································

## Fuente ----------------------------------------
# INEbase > Fenómenos demográficos > Movimiento Natural de la Población
# Defunciones (Cifras anuales) > Por lugar de residencia y sexo.
# Total nacional y comunidades autónomas
# https://www.ine.es/jaxiT3/Tabla.htm?t=6546&L=0
# Descargar > Pc-Axis
# https://www.ine.es/jaxiT3/files/t/es/px/6546.px?nocab=1
# Con grupo de edad: https://www.ine.es/jaxiT3/files/t/es/px/6550.px?nocab=1
# ················································

# Notas:
# ················································
# - Código estilo RStudio + tidyverse (Pulsar Ctrl + Shift + O para Outline)
#   Versión anterior https://github.com/rubenfcasal/estadistica_espacial/blob/main/datos/mortalidad.R
# - Actualmente defunciones por CCAA de residencia y sexo,
#   aunque se ignora sexo en datos espaciales

# Pendiente:
# ················································
# - Tener en cuenta grupo de edad
#   Análisis exploratorio de incremento mortalidad por grupo de edad y sexo
#   Autodescriptivo?
#   Tabla DT con medidas descriptivas?
#   Informe automático con secciones por grupo de edad?
# - Convertir "ccaa.code" y "ccaa.name" a factores
# - Añadir etiquetas de variables

## Paquetes  -------------------------------------

library(pxR) # install.packages("pxR")
library(dplyr)
library(tidyr)
library(forcats)
library(sf)
library(mapSpain) # install.packages("mapSpain")

## Descarga y preparación datos -----------------

px.file <- read.px("https://www.ine.es/jaxiT3/files/t/es/px/6546.px?nocab=1")
mortalidad <- as.data.frame(px.file)
names(mortalidad) <- tolower(names(mortalidad))
names(mortalidad)[3] <- "ccaa"
# library(stringr)
# txt <- levels(mortalidad$ccaa)
# dput(txt)
# stringr::str_extract(txt, "^[0-9]+") # ccaa.code
# stringr::str_split(txt, "(?<=^[0-9]{2}) ", simplify = TRUE) # ccaa.code ccaa.name

mortalidad <- mortalidad %>%
  mutate(ccaa = fct_recode(ccaa,
                        "00 España" = "Total", "99 Extranjero" = "No residente")) %>%
  separate(ccaa, c("ccaa.code", "ccaa.name"), "(?<=^[0-9]{2}) ")
# str(mortalidad)
# PENDENTE: Convertir a numérica/factor, operar con niveles (drop)
# Problema: ccaa.code character en esp_get_ccaa() más adelante

# Guardar
# ················································
save(mortalidad, file = "mortalidad.RData")
# load("mortalidad.RData")

## Creación objeto sf ----------------------------

mort_sf <- mortalidad %>%
  filter(!ccaa.code %in% c("00", "99"), periodo %in% c("2019", "2020"), sexo == "Total") %>%
  select(-sexo, -ccaa.name) %>%
  pivot_wider(names_from = periodo, values_from = value, names_prefix = "mort_") %>%
  mutate(incremento = 100 * (mort_2020 - mort_2019) / mort_2019)

# CUIDADO: el primer elemento de xxx_join debe ser un objeto sf
# para que lo procese el paquete sf

mort_sf <- esp_get_ccaa() %>%
  left_join(mort_sf, by = c("codauto" = "ccaa.code"))

# Guardar
# ················································
save(mort_sf, file = "mort_sf.RData")
# load("mort_sf.RData")

## Representar -----------------------------------

# plot(mort_sf["incremento"])

library(ggplot2)
ggplot(mort_sf) +
  geom_sf(aes(fill = incremento),
    color = "grey70",
    lwd = .3
  ) +
  geom_sf(data = esp_get_can_box(), color = "grey70") +
  geom_sf_label(aes(label = paste0(round(incremento, 1), "%")),
    fill = "white", alpha = 0.5,
    size = 3,
    label.size = 0
  ) +
  scale_fill_gradientn(
    colors = hcl.colors(10, "Blues", rev = TRUE),
    n.breaks = 10,
    labels = function(x) sprintf("%1.1f%%", x),
    guide = guide_legend(title = "Incremento")
  ) +
  theme_void() +
  theme(legend.position = c(0.1, 0.6))

