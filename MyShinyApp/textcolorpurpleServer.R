
## Server.R – FINAL VERSION: ALL POINTS HAVE HOVER LABELS ##




output$map <- renderLeaflet({
  
  leaflet() %>%
    
    setView(lng = 13.533545, lat = 45.850065, zoom = 11.3) %>%
    
    addProviderTiles(providers$OpenStreetMap, group = "Colour") %>%
    addScaleBar(position = "bottomleft") %>% 
    addControl(
      html = HTML("
    <div style='
      position: relative;
      width: 0;
      height: 0;
      border-left: 12px solid transparent;
      border-right: 12px solid transparent;
      border-bottom: 24px solid black;
      margin: 10px;
    '></div>
    <div style='
      text-align: center;
      font-weight: bold;
      margin-top: -5px;
      color: black;
    '>N</div>
  "),
      position = 'topright'
    ) %>%
    
    
    
    addPolylines(data = river, color = "blue", weight = 3, opacity = 0.9, group = "River") %>%
    
    addPolylines(data = distancetobridges, color = "black", weight = 2, opacity = 0.8, group = "Distance Lines") %>%
    
    addRasterImage(heatmap_raster, colors = pal_heatmap, opacity = 0.7, group = "Heatmap") %>%
    
    addImageQuery(heatmap_raster, layerId = "Heatmap", prefix = "Density: ", digits = 2,
                  
                  type = "mousemove", position = "topright", group = "Heatmap") %>%
    
    
    
    addLayersControl(
      
      baseGroups = "Colour",
      
      overlayGroups = c("River", "Bridges", "Distance Lines", "Large Wood", "Heatmap", "LW Catchers"),
      
      options = layersControlOptions(collapsed = FALSE)
      
    )
  
})



# Large Wood clusters – with hover label

observe({
  
  leafletProxy("map") %>%
    
    clearGroup("Large Wood") %>%
    
    addCircleMarkers(data = clusters,
                     
                     radius = 6,
                     
                     color = "black",
                     
                     weight = 1,
                     
                     fillColor = ~pal_clusters(CLUSTER_ID),
                     
                     fillOpacity = 0.8,
                     
                     popup = ~paste("<b>Type:</b>", Type,
                                    
                                    "<br><b>Imagery:</b>", Satellite,
                                    
                                    "<br><b>Cluster ID:</b>", CLUSTER_ID),
                     
                     label = ~as.character(CLUSTER_ID),        # hover label
                     
                     labelOptions = labelOptions(noHide = FALSE, textOnly = TRUE,
                                                 
                                                 style = list("font-weight" = "bold", "color" = "white",
                                                              
                                                              "background" = "rgba(0,0,0,0.6)", padding = "2px 6px")),
                     
                     group = "Large Wood")
  
})



# Bridges – with hover label

observe({
  
  leafletProxy("map") %>%
    
    clearGroup("Bridges") %>%
    
    addCircleMarkers(data = bridges,
                     
                     radius = 9,
                     
                     color = "black",
                     
                     weight = 2,
                     
                     fillColor = "purple",
                     
                     fillOpacity = 0.9,
                     
                     popup = ~paste("<b>Bridge:</b>", Name, "<br><b>ID:</b>", id),
                     
                     label = ~Name,                             # hover label
                     
                     labelOptions = labelOptions(noHide = FALSE, textOnly = TRUE,
                                                 
                                                 style = list("font-weight" = "bold", "color" = "white",
                                                              
                                                              "background" = "rgba(0,0,0,0.7)", padding = "3px 8px")),
                     
                     group = "Bridges")
  
})



# TASK 9 – LW CATCHERS – with hover label (exactly like the others)

observe({
  
  leafletProxy("map") %>%
    
    clearGroup("LW Catchers") %>%
    
    addCircleMarkers(data = catchers,
                     
                     radius = 13,
                     
                     color = "red",
                     
                     weight = 4,
                     
                     fillColor = "orange",
                     
                     fillOpacity = 0.95,
                     
                     popup = ~paste0(
                       
                       "<b>Proposed Large Wood Catcher</b><br>",
                       
                       "Lon: ", round(st_coordinates(geometry)[,1], 5), " E<br>",
                       
                       "Lat: ", round(st_coordinates(geometry)[,2], 5), " N"
                       
                     ),
                     
                     label = ~"LW Catcher",                     # hover label – you can change this
                     
                     labelOptions = labelOptions(noHide = FALSE, textOnly = TRUE,
                                                 
                                                 style = list("font-weight" = "bold", "color" = "white",
                                                              
                                                              "background" = "rgba(255,0,0,0.8)", padding = "4px 10px")),
                     
                     group = "LW Catchers")
  
})