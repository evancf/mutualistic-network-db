library(shiny)
library(visNetwork)
#library(htmlwidgets)
#library(shinyWidgets) #install.packages("shinyWidgets")
library(leaflet)
#library("shinythemes")


# Pull in data

net_long <- read.csv("data/network_data_long.csv")[,-1]


net_ids <- list.files("./data/incidence_matrices") %>% 
  gsub(".csv", "", ., fixed = T)

net_id_list <- list()

for(i in net_ids ){
  net_id_list[[i]] <- read.csv(file = paste("./data/incidence_matrices/", i, ".csv", sep = ""), row.names = 1)
}

net_metadata <- read.csv("./data/network_metadata.csv")


function(input, output){
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      setView(lng = 0, lat = 0, zoom = 2) %>%
      addProviderTiles(providers$Esri.WorldImagery,
                       options = providerTileOptions(minZoom = 1, maxZoom = 10)
      ) %>%
      addMarkers(~longitude, ~latitude, 
                 popup = ~as.character(study_id), 
                 label = ~as.character(net_id),
                 layerId = ~as.character(net_id),
                 data = net_metadata,
                 clusterOptions = markerClusterOptions(maxClusterRadius = 40))
  })
  
  
  clicked_net <- reactive({
    if(is.null(input$mymap_marker_click$id)){
      net <- "Fricke 2018 Saipan"
    } else{
      net <- input$mymap_marker_click$id
    }
    
    return(net)
  })
  
  
  
  # This returns the correct dataset
  datasetInput <- reactive({
      dataset <- net_long %>% 
        filter(net_id == clicked_net()) %>% 
        select(animal_id, plant_id)
    return(dataset)
  })
  
  # https://community.rstudio.com/t/changing-datasets-based-on-select-input-in-r-shiny/67891
  
  
  ### Network
  
  output$network_proxy_nodes <- renderVisNetwork({
    nodes <- tibble(id = datasetInput() %>% unlist() %>% unique() %>% sort())
    edges <- data.frame(from = datasetInput()[,1], 
                        to = datasetInput()[,2])
    if(dim(edges)[2] > 0){
      nodes <- nodes %>% mutate(group = factor(ifelse(nodes$id %in% edges[,1], "plant", "animal"), labels = c("plant", "animal")))
      nodes <- nodes[order(nodes$group),]
    }
    
    visNetwork(nodes, edges) %>%
      visLayout(randomSeed = 444) %>% 
      visExport() %>%
      visEdges(smooth = F) %>%  # 
      visOptions(highlightNearest = list(enabled = TRUE, degree = 1),
                 nodesIdSelection = list(enabled = TRUE, main = "Species to highlight")) %>% 
      visPhysics(maxVelocity = 2,
                 barnesHut = list(gravitationalConstant = -50000),
                 stabilization = T) %>%
      visInteraction(zoom = T) %>%
      visEvents(click = "function(nodes){
        Shiny.onInputChange('click', nodes.nodes[0]);
        ;}"
      )
    
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(clicked_net(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(net_id_list[[clicked_net()]], file, row.names = T)
    }
  )
  
  
}

