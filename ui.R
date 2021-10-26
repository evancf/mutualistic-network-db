library(tidyverse)
library(shiny)
library(visNetwork)
library(leaflet)


# UI -------------------
fluidPage(
  
  
  
  # Map
  fluidRow(
    leafletOutput("mymap"),
    
  ),
  
  # Network
  fluidRow(
    
    visNetworkOutput("network_proxy_nodes", 
                     height = "400px"),
    
    
    # Button
    downloadButton("downloadData", "Download this network"),
    
    verbatimTextOutput('citation_text'),
    
    
  ),
  
  # fluidRow(
  #   
  # )
)