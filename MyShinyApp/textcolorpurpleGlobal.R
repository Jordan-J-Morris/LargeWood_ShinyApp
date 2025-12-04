#heatmap <- rast("Heatmap_Shiny_App.tif")

#heatmap <- project(heatmap, crs(river))



#pal_heatmap <- colorNumeric(palette = "inferno", domain = na.omit(values(heatmap)), na.color = "transparent")

#force(pal_heatmap)



# G1 Load large wood, river, and bridge data ----

#lw_points <- st_read("LW.shp")

#river <- st_read("RiverIsonzo.shp")

#bridges <- st_read("BridgesIsonzo.shp")

#distancetobridges <- st_read("distance to bridges.shp")



#Convert vectors to CRS 4326

#lw_points <- st_transform(lw_points, crs = 4326)

#river <- st_transform(river, crs = 4326)

#bridges <- st_transform(bridges, crs = 4326)

#distancetobridges <- st_transform(distancetobridges, crs = 4326)



#clusters <- st_read("clusters.shp")

#clusters <- st_transform(clusters, crs = 4326)





# generate colours based on number of unique clusters

#num_clusters <- length(unique(clusters$CLUSTER_ID))

#pal_clusters <- colorFactor(palette = colorRampPalette(brewer.pal(12, "Paired"))(num_clusters), domain = clusters$CLUSTER_ID)





#HEATMAP 

heatmap_raster <- rast("www/Heatmap_Shiny_App.tif")      # ← make sure file is in www/

heatmap_raster <- project(heatmap_raster, "EPSG:4326")



pal_heatmap <- colorNumeric("inferno", 
                            
                            domain = values(heatmap_raster), 
                            
                            na.color = "transparent")

force(pal_heatmap)       # ← this line kills the “missing function x” error forever



# VECTOR DATA

river <- st_read("www/RiverIsonzo.shp")             %>% st_transform(4326)

bridges  <- st_read("www/BridgesIsonzo.shp")           %>% st_transform(4326)

distancetobridges <- st_read("www/distance_to_bridges.shp")     %>% st_transform(4326)

clusters <- st_read("www/clusters.shp")                %>% st_transform(4326)

lw_points <- st_read("www/LW.shp") %>% st_transform(4326)



# Dynamic cluster palette

num_clusters <- length(unique(clusters$CLUSTER_ID))

pal_clusters <- colorFactor(
  
  palette = colorRampPalette(brewer.pal(12, "Paired"))(num_clusters),
  
  domain = clusters$CLUSTER_ID
  
)



catchers <- st_read("www/LW_Catchers.shp") %>% st_transform(4326)

