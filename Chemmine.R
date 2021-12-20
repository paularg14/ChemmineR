# Importación de Datos ----------------------------------------------------


# Se importan las librerías que se van a utilizar
library(tidyverse)
# Librerías ya incluidas en tidyverse:
#library(readr)
#library(dplyr)

# Carga de datos de ejemplo de ChemmineR
Datos_ChemmineR <- read_csv("INPUT/DATA/sdfsample.sdf")
Datos_ChemmineR #Vemos que los datos son correctos

#Se instala el paquete BiocManager, dentro del cual se encuentra ChemmineR
install.packages("BiocManager")
library(BiocManager)
BiocManager::install("ChemmineR")
