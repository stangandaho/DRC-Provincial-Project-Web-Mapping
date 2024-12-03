library(leaflet)
library(shiny)
library(sf)


## Import province boundaries
prv_bound <- st_read("inst/datasets/rd_congo_admin_4_provinces.geojson")
project_info <- st_read("inst/datasets/points_and_project.geojson")
points <- project_info %>% 
    st_coordinates() %>% 
    as.data.frame()


# Define UI for application that draws a histogram
ui <- leafletOutput("map", width = "100%", height = "100vh")#,  # The map output


# Define server logic required to draw a histogram
server <- function(input, output, session){
    
    base_map <- leaflet() %>% 
        leaflet::setView(lat = -2.867277, lng = 23.64774, zoom = 6) %>% 
        leaflet::addTiles(attribution = "Project in DRC") %>%
        leaflet::addProviderTiles("OpenStreetMap.Mapnik", group = "OSM") %>%
        leaflet::addProviderTiles("OpenStreetMap.France", group = "OSM France") %>%
        leaflet::addProviderTiles("Esri.WorldImagery", group = "Natural") %>%
        leaflet::addProviderTiles("OpenTopoMap", group = "OpenTopoMap") %>%
        leaflet::addProviderTiles("USGS.USImagery", group = "USGS USImagery") %>%
        leaflet::addLayersControl(
            baseGroups = c("OSM", "OSM France", "Natural", "OpenTopoMap", "USGS USImagery"),
            options = layersControlOptions(collapsed = T)
        ) 
    
    
    fullmap <- base_map %>% 
        addPolygons(data = prv_bound, 
                    opacity = 1, 
                    stroke = TRUE, 
                    fill = TRUE,
                    fillColor = "#ffa76d",
                    fillOpacity = 0.2,
                    weight = .5) %>% 
        addMarkers(lng = points$X, lat = points$Y,
                   popup = paste(ifelse (project_info$`Secteur d’intervention` != "", 
                                         paste0(h3("Secteur d'intervention:"), project_info$`Secteur d’intervention`),
                                         ""), 
                                 #title
                                 ifelse (project_info$Intitulé.du.projet != "", 
                                         paste0(h3("Titre du projet:"), project_info$Intitulé.du.projet),
                                         ""),
                                 # periode
                                 ifelse(project_info$Début != "" & project_info$Fin != "",
                                        paste0(h3("Période:"), paste0(project_info$Début, " - ", project_info$Fin)),
                                        ifelse(project_info$Début == "", "", paste0(h3("Durée:"), paste0(project_info$Début)))
                                 ),
                                 # montant
                                 ifelse(project_info$Montant != "", 
                                        paste0(h3("Montant du projet:"), toupper(project_info$Montant)),
                                        ""),
                                 # structure
                                 ifelse(project_info$Structure.d.exécution.Contact != "", 
                                        paste0(h3("Structure d'exécution:"), project_info$Structure.d.exécution.Contact),
                                        ""),
                                 ifelse(project_info$Bailleur != "", 
                                        paste0(h3("Bailleur:"), project_info$Bailleur),
                                        "")
                                 ),
                   
                   options = markerOptions(riseOnHover = TRUE),
                   icon = list(iconUrl = "inst/media/pin.png", iconSize = c(10, 10))
        )
    
    
    output$map <- renderLeaflet(fullmap)
}


# Run the application 
shinyApp(ui = ui, server = server)
