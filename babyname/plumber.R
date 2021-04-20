

library(plumber)
library(tidyverse)
library(babynames)
library(ggplot2)
library("png")
#* @apiTitle Plumber Example with Babynames dataset

#* Obtiene una gráfica que muestra la evolución de la popularidad de un nombre a lo largo de los años
#* @param nombre The message to echo
#* @serializer png
#* @get /plot
function(nombre) {
  babynames %>% 
    filter(name==nombre) %>% 
    select(year, prop) %>% 
    ggplot() +
    geom_line(aes(x = year, y = prop)) +
    labs(title = paste0("Popularity of the name ", name))
  ggsave("babynames.png",device="png")
  pp <- readPNG("babynames.png")
  return(pp)
  
}

#* Obtiene la cantidad de nombres distintos que hay en el dataset
#* @get /distinctbabynames
function(){
  babynames %>% 
    summarise(n = n(), distinct = n_distinct(name))
}

#* Obtiene cuanta gente se llama de cierta manera
#* @get /babynamespername
#* @param nombre Nombre a buscar
function(nombre){
  babynames %>% 
    filter(name == nombre) %>% 
    summarise(total = sum(n))
} 

#* Agrupa el dataset por el nombre y año y suma las instancias del mismo nombre
#* @get /namescount
function(){
babynames %>%
  group_by(name, sex) %>% 
  summarise(total = sum(n))
}


#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
    as.numeric(a) + as.numeric(b)
}
