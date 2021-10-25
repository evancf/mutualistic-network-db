library("tidyverse")

# Load network in long form and the metadata --------------------

net_long <- read.csv("data/network_data_long.csv")[,-1]
net_metadata <- read.csv("data/network_metadata.csv")[,-1]


# Do any filtering --------------------

# As a default, I will not filter out any plants or frugivores. This means
# that all plant-animal interactions reported in the original studies will
# appear in the networks.

# # For example, if we only wanted to keep only fleshy fruits
# net_long <- net_long %>% 
#   filter(fleshy == "f")

# # Or if we only wanted to keep only interactions involving birds
# net_long <- net_long %>% 
#   filter(animal_group == "birds")



# Convert from tidy (long) format to incidence matrix --------------------

as.num.char <- function(x) as.numeric(as.character(x))

# A couple functions that help go from long format to bipartite matrix format
net_spread_inside <- function(split_by = split_by, split_vals = split_vals, 
                              tax_type = tax_type, data_type = data_type,
                              long_df = long_df){
  
  x <- long_df[which(long_df[,split_by] == split_vals),]
  a <- x[ ,paste("animal", tax_type, sep = "_")]
  p <- x[ ,paste("plant", tax_type, sep = "_")]
  identifier <- paste(a, p, sep = " ~ ")
  y <- tapply(x$freq, identifier, sum)
  
  if(data_type == "bin"){
    y <- ifelse(y > 0, 1, 0)
  }
  
  z <- spread(as.data.frame(cbind(str_split_fixed(names(y), " ~ ", 2), y)),
              value = 3,
              key = 1,
              fill = 0)
  #print(split_vals) # In case you want to track down problems
  
  rownames(z) <- z[,1]
  
  z <- z[which(!rownames(z) == "NA"), ]
  z <- z[, which(!colnames(z) == "NA")]
  
  
  # This chunk was added to make it so cases where there is 1 or 0 of the 
  # focal plant/frug taxa (at whatever focal taxa level, e.g., accepted species)
  # the first column doesn't have to get removed (because it's sort of 
  # irrelevant because these will not be added to the list).
  if(!is.null(dim(z))){
    
    z <- z[,-1] 
    # Can do z[,-1, drop = F] to retain a 1 column dataframe rather than vector
    
    if(!is.null(dim(z))){ # The next chunk wont work if there is only 1 
      z[] <- mutate_all(z, list(as.num.char)) # Make numeric while retaining row names...
      
      z <- z[which(!rowSums(z) == 0), ] # Get rid of plant or animal taxa with no interactions
      z <- z[, which(!colSums(z) == 0)]
    }
    
  }
  
  z
  
}

net_spread <- function(split_by, split_vals, 
                       tax_type, data_type, 
                       long_df = long_df,
                       min_taxa = 2){
  if(min_taxa <= 1) stop("cannot make network with only one plant or animal taxon") # This may be obvious
  zz <- apply(cbind(split_by, as.character(split_vals), tax_type, data_type), 1, 
              function(xx) net_spread_inside(split_by = xx[1], 
                                             split_vals = xx[2], 
                                             tax_type = xx[3], 
                                             data_type = xx[4], 
                                             long_df = long_df))
  names(zz) <- split_vals
  zz <- zz[!unlist(lapply(zz, function(zzz) any(dim(zzz) <= min_taxa) | is.null(dim(zzz))))]
  zz
}


# Now build a list containing each incidence matrix
# Takes a few seconds
net_id_list <- net_spread(split_by = "net_id", 
                          split_vals = unique(net_long$net_id),
                          tax_type = "id", 
                          data_type = "quant",
                          long_df = net_long)


# Note that this can be modified to give only binary matrices (data_type = "bin"),
# or you could do a genus-level network (tax_type = "genus") or build networks
# not based on the net_id values, but do one network per study (even if the
# networks were presented at finer spatial/temporal resolution) by changing the
# split_by values (split_by = "study_id" and split_vals = unique(net_long$study_id))



# Output these to csv within a folder called "incidence_matrices" in the data folder
for(i in names(net_id_list)){
  write.csv(net_id_list[[i]], 
            file = paste("./data/incidence_matrices/", i, ".csv", sep = ""),
            row.names = T)
}

