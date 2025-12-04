# Install required packages
  
install.packages("leaflet")
install.packages("sf")
install.packages("sp")
install.packages("raster")
install.packages("ggplot2")
install.packages("ggiraph")
install.packages("RColorBrewer")
install.packages( "terra")
install.packages("dbscan")
install.packages("leafem")
install.packages("shiny")

# Load packages
library(shiny)
library(leaflet)
library(sf)
library(dbscan)
library(raster)
library(ggplot2)
library(ggiraph)
library(RColorBrewer)
library(terra)
library(leafem)
library(htmltools)


options(shiny.maxRequestSize = 1000 * 1024^2)

# Run global script containing all relevant data 
source("textcolorpurpleGlobal.R")

# Define UI for visualisation 
source("textcolorpurpleUI.R")

ui <- navbarPage("Instream large wood on the River Isonzo", id = 'nav',
                 tabPanel("map", 
                          div(class="outer",
                              leafletOutput("map", height = "calc(100vh - 70px)")
                          )
                 )
)

# Define the server that performs all necessary operations 
server <- function(input, output, session){
  source("textcolorpurpleServer.R", local = TRUE)
}
shinyApp(ui, server)





