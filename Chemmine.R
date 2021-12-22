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

#Pueden convertirse los datos a una matriz
dedatablockamatriz <- datablock2ma (datablocklist = datablock(sdfset))

#Se divide la matriz en numéricos y caracteres, y se selecciona parte para ver los resultados
numchar <- splitNumChar(dedatablockamatriz) 
numchar[[1]][1:2,1:2]  
numchar[[2]][1:2,10:11] 

#Se juntan en un dataframa los valores de frecuencia atómica, masa molecular y fórmula atómica
propma <- data.frame(MF = MF(sdfset), MW = MW(sdfset), atomcountMA(sdfset))
propma[1:3, ] 

#Con la función plot se obtiene la visualización de la estructura molecular
plot(sdfset[1:4], print=FALSE) 


#El sdfset no acepta operaciones del paquete dplyr, por lo que para operar sobre el set de datos 
#este debería cambiarse de formato

#Se carga otro set de datos en formato csv

PequeñasMoléculas <- read.delim("INPUT/DATA/SmallMolecules.csv", sep = ";")
PequeñasMoléculas

summary(PequeñasMoléculas)

# Una vez observadas las columnas disponibles, se seleccionan aquellas con las que 
#se va a trabajar, renombrándolas

#Dado que en la columna ChEMBL.ID solo nos interesa el código numérico, se va a 
#eliminar de cada fila las letras mediante el método substring

DatosMoleculares <- PequeñasMoléculas %>%
  select(ChEMBL.ID, Molecular.Weight, Polar.Surface.Area, CX.Acidic.pKa, CX.Basic.pKa, Aromatic.Rings, Molecular.Species, Molecular.Formula) %>%
  rename(ID = ChEMBL.ID, Peso_Molecular = Molecular.Weight, Superficie = Polar.Surface.Area, pKa_Acido = CX.Acidic.pKa, pKa_Basico = CX.Basic.pKa, Anillos = Aromatic.Rings, Tipo_Molecula = Molecular.Species, Formula_Molecular = Molecular.Formula ) %>%
  mutate(ID = substr(ID, 7, 14))
DatosMoleculares

#Con esta tabla se va a trabajar para seleccionar las moléculas que cumplan ciertos criterios

#Se seleccionan las moléculas grandes, que cuenten con varios anillos y que sean neutras en cuanto
#a cargas atómicas

Moleculas_Grandes <- DatosMoleculares %>% 
  filter(Peso_Molecular >= 530.00, Anillos >= 4, Tipo_Molecula == "NEUTRAL")

Moleculas_Grandes

#Se van a agrupar los pesos moleculares para reducir el número de filas y poder trabajar con ellas
#más fácilmente


pesoMol_numAnillos0 <- DatosMoleculares %>%
  filter(Anillos == 0) %>%
  mutate(Peso_Promedio = mean(Peso_Molecular, na.rm = TRUE)) %>%
  select(Peso_Promedio, Anillos)

sinAnillos <- distinct(pesoMol_numAnillos0)

sinAnillos

pesoMol_numAnillos1 <- DatosMoleculares %>%
  filter(Anillos == 1) %>%
  mutate(Peso_Promedio = mean(Peso_Molecular, na.rm = TRUE)) %>%
  select(Peso_Promedio, Anillos)

unAnillo <- distinct(pesoMol_numAnillos1)

unAnillo

pesoMol_numAnillos2 <- DatosMoleculares %>%
  filter(Anillos == 2) %>%
  mutate(Peso_Promedio = mean(Peso_Molecular, na.rm = TRUE)) %>%
  select(Peso_Promedio, Anillos)

dosAnillos <- distinct(pesoMol_numAnillos2)

dosAnillos

pesoMol_numAnillos3 <- DatosMoleculares %>%
  filter(Anillos == 3) %>%
  mutate(Peso_Promedio = mean(Peso_Molecular, na.rm = TRUE)) %>%
  select(Peso_Promedio, Anillos)

tresAnillos <- distinct(pesoMol_numAnillos3)

tresAnillos

pesoMol_numAnillos4 <- DatosMoleculares %>%
  filter(Anillos == 4) %>%
  mutate(Peso_Promedio = mean(Peso_Molecular, na.rm = TRUE)) %>%
  select(Peso_Promedio, Anillos)

cuatroAnillos <- distinct(pesoMol_numAnillos4)

cuatroAnillos

pesoMol_numAnillos5 <- DatosMoleculares %>%
  filter(Anillos == 5) %>%
  mutate(Peso_Promedio = mean(Peso_Molecular, na.rm = TRUE)) %>%
  select(Peso_Promedio, Anillos)

cincoAnillos <- distinct(pesoMol_numAnillos5)

cincoAnillos

#Se crea una tabla que contengan las anteriores y se muestra una gráfica, para evaluar si hay
#relación entre el número de anillos de una molécula y su peso molecular

AnillosPeso = data.frame(rbind(sinAnillos, unAnillo, dosAnillos, tresAnillos, cuatroAnillos, cincoAnillos))

AnillosPeso

#Se representan de forma simple con plot. 
plot(AnillosPeso)

#A simple vista parece que existe una correlación pero esto se debe al formato de la gráfica

#No existe relación entre el peso molecular y los anillos que tenga un compuesto




