# Importación de Datos ----------------------------------------------------


# Se importan las librerías que se van a utilizar
library(tidyverse)
# Librerías ya incluidas en tidyverse:
#library(readr)
#library(dplyr)

# Carga de datos de ejemplo de ChemmineR
Datos_ChemmineR <- read.SDFset("INPUT/DATA/sdfsample.sdf")
Datos_ChemmineR #Vemos que los datos son correctos

#El archivo con extensión sdf tiene características especiales, explicadas en el markdown

#Se instala el paquete BiocManager, dentro del cual se encuentra ChemmineR
install.packages("BiocManager")
library(BiocManager)
#Se instala ChemmineR a partir de BiocManager, no aparece en la guía de instalación normal
BiocManager::install("ChemmineR")
library(ChemmineR)

library(help="ChemmineR") #Proporciona una guía con todas las funciones incluidas

#Se crea una instancia del dataset que contenga 100 moléculas
data(sdfsample) 
sdfset <- sdfsample
sdfset

summary(sdfset)

#Se seleccionan las primeras 4 moléculas de la instancia. Recordar que el primer índice en 
#R se corresponde con el número 1, no el 0
sdfset[1:4]

#Se selecciona 1 molécula a mostrar, utilizando los dobles corchetes

sdfset[[1]]

#Muestra el número de identificación del compuesto, CID, 6500001
#Si se utiliza PubChem se obtendrá el nombre del compuesto

#N-Cyclopentylcarbamoylmethyl-N-(2,3-dihydro-benzo[1,4]dioxin-6-yl)-N'-(5-methyl-isoxazol-3-yl)-succinamide

#Nombre tradicional: N'-[2-(cyclopentylamino)-2-keto-ethyl]-N'-(2,3-dihydro-1,4-benzodioxin-6-yl)-N-(5-methylisoxazol-3-yl)succinamide

#La instancia de sdf se subdivide en un cabecero con el nombre de la molécula, un bloque de
#átomos que muestra qué elementos componen la molécula, un bloque de uniones que muestra los
#tipos de enlaces entre los átomos y un bloque de datos con los identificadores moleculares
#que se usan para localizarla dentro de los buscadores

view(sdfset[1:4]) #Con el comando view se puede ver la información que contiene el conjunto
#seleccionado entre corchetes

#Devuelve el contenido de dicha posición del sdfset en forma de lista
as(sdfset[1], "list")

#También se puede acceder a bloques o contenido específico de una o varias posiciones del sdfset

header(sdfset[[1]]) #Encabezado
atomblock(sdfset[1:3]) #Atomos
bondblock(sdfset[[1]])[1:5,] #Muestra los 5 primeros enlaces atómicos de la primera molécula
datablock(sdfset[[1]])[1:4]  #Muestra los primeros 4 datos sobre la primera molécula
sdfid(sdfset)[1:6] # Muestra solo los IDs dentro del cabecero, de las seis primeras moléculas

#El sdfset no acepta operaciones del paquete dplyr, por lo que para operar sobre el set de datos 
#este debería cambiarse de formato

#Se carga otro set de datos en formato csv

PequeñasMoléculas <- read.delim("INPUT/DATA/SmallMolecules.csv", sep = ";")
PequeñasMoléculas

summary(PequeñasMoléculas)


