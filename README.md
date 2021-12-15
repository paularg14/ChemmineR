###Autor: Paula Rastrilla Gutiérrez

# ChemmineR
En este repositorio se plantea el desarrollo de la vignette "ChemmineR". ChemmineR es un paquete que permite analizar datos de moléculas pequeñas similares a fármacos en R. Su última versión contiene funciones para el procesamiento eficiente de grandes cantidades de moléculas pequeñas, predicciones de propiedades fisicoquímicas / estructurales, búsqueda de similitudes estructurales, clasificación y agrupación de bibliotecas de compuestos con una amplia espectro de algoritmos,...

Se plantea el desarrollo del contenido en inglés de la vignette, aplicando principalmente los conceptos y funciones del paquete **_dplyr_**, que proporciona una "gramática" para la manipulación y operaciones con data frames. Las funciones que se van a utilizar principalmente son las siguientes:
lgunas de los principales "verbos" del paquete dplyr son:

  _select_: devuelve un conjunto de columnas
  _filter_: devuelve un conjunto de filas según una o varias condiciones lógicas
  _arrange_: reordena filas de un data frame
  _rename_: renombra variables en una data frame
  _mutate_: añade nuevas variables/columnas o transforma variables existentes
  _summarise/summarize_: genera resúmenes estadísticos de diferentes variables en el data frame, posiblemente con strata
  _%>%_ : el operador "pipe" es usado para conectar múltiples acciones en una única "pipeline" (tubería)
