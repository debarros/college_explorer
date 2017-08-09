# functions.R

library(shiny)
library(shinyjs)
library(leaflet)
library(tidyverse)


#plot.csv is generated using program called "get using full ipeds datafiles.R"
# it has cleaned up IPEDS and College Scorecard data
plot <- read_csv("www/plot.csv")



