library("tidyverse")

# Load data as a list --------------------

net_ids <- list.files("./data/incidence_matrices") %>% 
  gsub(".csv", "", ., fixed = T)

net_id_list <- list()

for(i in net_ids ){
  net_id_list[[i]] <- read.csv(file = paste("./data/incidence_matrices/", i, ".csv", sep = ""), row.names = 1)
}


# Calculate metrics --------------------

# Here's an example of how you might get started with the analysis of 
# various network metrics using the bipartite package
library("bipartite")

# A few metrics that are fast
net_metrics <- lapply(net_id_list, function(x) {
  networklevel(x, index = c("connectance", "nestedness", "links per species"))
}) %>% 
  do.call(rbind,.) %>% 
  as.data.frame()



# Join to metadata --------------------

net_metadata <- read.csv("./data/network_metadata.csv")
net_metrics <- net_metrics %>% 
  mutate(net_id = rownames(net_metrics)) %>% 
  left_join(net_metadata)



# Visualization --------------------

net_metrics %>% 
  ggplot(aes(x = connectance, 
             y = nestedness, 
             color = `links per species`)) +
  geom_point() +
  theme_classic()



# Getting started with an igraph version  --------------------
library("igraph")
net_id_list_igraph <- lapply(net_id_list, igraph::graph_from_incidence_matrix)

plot(net_id_list_igraph[[22]])



