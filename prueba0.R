#load packages --------

library(tidyverse)
library(here)
library(skimr)
#read in the data -------
beaches <-read_csv(here("data","sydneybeaches.csv"))
#Exploring the data -------
View(beaches)
#Nos permite esto ver las dimensiones
dim(beaches)
#Ponerlo como string
str(beaches)
#Otra manera de visualizarlo
glimpse(beaches)
head(beaches)
tail(beaches)
#Muestra info de las variables
summary(beaches)
#Skim da un output con formato más util
skim(beaches)
#Si está en un subdirectorio se hace kidEMG <- read_csv(here("data","myowndata","JustkidCleanEMG.csv"))
#Para archivos excel install.packages("readx1")
#Para archivos SPSS/Stata/SAS install.packages("haven")
#Para archivos Google sheets install.packages("googlesheets")
#Para datapasta install.packages("datapasta")



library(tidyverse)
library(babynames)
library(ggplot2)
library(png)

res <- function(name) {
  babynames %>% 
    filter(name==name) %>% 
    select(year, prop) %>% 
    ggplot() +
    geom_line(aes(x = year, y = prop)) +
    labs(title = paste0("Popularity of the name ", name))
  ggsave("babynames.png",device="png")
  pp <- readPNG("babynames.png")
  return(pp)
}
name <- "Diego"
res(name)
