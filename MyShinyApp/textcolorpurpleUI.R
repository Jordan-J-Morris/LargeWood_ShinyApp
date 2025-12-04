# ---- UI.R: Define UI for LW Visualisation Application ----

library(shiny)
library(leaflet)

ui <- fluidPage(
  titlePanel("Large Wood Cluster Visualization and Analysis"),
  leafletOutput("map", height = "800px")
)