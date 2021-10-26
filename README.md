# mutualistic-network-db
Data from published studies of ecological networks involving plants and seed dispersers


### Data

These data are presented using two formats:

The first format is a single tidy dataset (network_data_long.csv) where each row represents a pairwise interaction involving a given plant and frugivore. When available, this shows the interaction frequency as reported in the publication. Otherwise, it represents a binary indicating whether the interaction was observed or not. The columns in this dataframe provide some additional taxonomic information relevant to the plant and frugivore species (further metadata relevant to each column will be presented below).

The second format is an individual incidence matrices for each network. The 01_construct_networks.R script allows the user to adjust how the networks are constructed. For example, including or excluding non-fleshy fruited plant species, only including species where accepted scientific names were discernible from the original study (along with other taxonomy harmonization), or combining interactions across spatially or temporally distinct networks (e.g., networks reported for each season). The default will be to include all taxa reported by the original publications and to present the networks at the finest spatial or temporal scale at which the data were reported.

Metadata relevant to each study is also presented in network_metadata.csv. This includes descriptors of the spatial and temporal coverage of each network as well as basics of the study methods used to collect data. This includes field methods (e.g., bat mistnetting, focal tree watches), how data were reported (e.g., data reported for all or a subset of species), and the definition of interaction frequency presented in the paper. Further details relevant to each column will be presented below.


### A typical workflow

The 02_network_analysis.R script gives an example of how you might start working with these data in R. 


### Citing this resource and asking for help

Please feel free to reach out with questions to ef13 *at* rice.edu or evanfricke *at* gmail.com. If you use this resource for a publication, please include the following citations associated with the original publication (https://www.nature.com/articles/s41586-020-2640-y) and associated dataset:

Fricke, E. C., & Svenning, J. C. (2020). Accelerating homogenization of the global plant–frugivore meta-network. Nature, 585(7823), 74-78. 

Fricke, Evan; Svenning, Jens-Christian (2020), Data from: Accelerating homogenization of the global plant–frugivore meta-network, Dryad, Dataset, https://doi.org/10.5061/dryad.44j0zpcbx

Note that the data in this repo were presented via Dryad with the above publication, but are reformatted here for ease of use.


### Network data column descriptions

"study_id" - a unique ID for the study that presented a focal network<br />
"net_id" - a unique ID for the network reported in the study. Sometimes an individual study presents multiple networks<br />
"freq" - the frequency of interaction<br />
"animal_id" - the identifier for the animal taxon, with taxonomy harmonized whenever possible. Sometimes not identified ("unid") at the species level<br />
"animal_accepted_species" - the accepted ITIS species name. NA if no accepted species could be determined for the taxa (or identified only above the species level)<br />
"animal_genus"<br />
"animal_family"<br />
"animal_order" <br /> 
"animal_class"<br />
"animal_group" - the groups are birds, bats, primates, primarily herbivorous mammals, primarily carnivorous mammals, other mammals, fish, squamates, turtles, crabs<br />

"plant_id", "plant_accepted_species", "plant_genus", "plant_family" - equivalent as for animals. Accepted species according to The Plant List<br />

"plant_phylo_id" - an identifier used for a phylogeny built for Fricke & Svenning 2020.<br />
"bird_tree_id" - following the names in the phylogeny from W. Jetz, G. H. Thomas, J. B. Joy, K. Hartmann, A. O. MooersThe global diversity of birds in space and time  Nature, 491: 444-448. Available at https://birdtree.org<br />
"mamm_tree_id" - following the names in the phylogeny from PHYLACINE. Faurby, S., Davis, M., Pedersen, R. Ø., Schowanek, S. D., Antonelli, A., & Svenning, J. C. (2018). PHYLACINE 1.2: the phylogenetic atlas of mammal macroecology. Ecology, 99(11), 2626. Available https://github.com/MegaPast2Future/PHYLACINE_1.2<br />

"fleshy" - describes whether the focal plant species produces fleshy fruit ("f") or dry fruit ("d"). NA if this could not be determined.<br />


### Network metadata column descriptions

#### Describing the location
"latitude" <br />
"longitude" <br />
"latlon_id" - a unique ID for spatial location<br />
"locality_id" - the nearest place name<br />
"locality" - country or similar<br />
"location_notes" <br />
"region" - Bioregion defined by Holt, B. G., Lessard, J. P., Borregaard, M. K., Fritz, S. A., Araújo, M. B., Dimitrov, D., ... & Rahbek, C. (2013). An update of Wallace’s zoogeographic regions of the world. Science, 339(6115), 74-78.<br />
"continental_island" - whether the observations were conducted on a continental island<br />
"oceanic_island" - whether the observations were conducted on a continental island<br />
"elevation" - elevation if reported in the paper<br />
"anthro_drivers" - any particular global change drivers that were mentioned in the paper<br />
"season_id" - the focal season if mentioned in the paper<br />

#### Describing the sampling methods and period
"data_type" - quantiative or qualitative (binary) data<br />
"sampling_method" - focal obs / transect walk / mistnetting / found feces / general obs / gut contents. There are several general methods for sampling. Focal observations of trees, walking transects to record observed interactions, mistnetting to capture animals and recovering seeds, finding feces (usually alongside a transect), a very few studies simply do general observations not along a transect or trail, or examining the gut contents of dead animals.<br />
"sampling_unit" - bin / fruits / seeds / visits / other. This describes the unit of the value represented in the bipartite matrix. Number of feeding visits is the most reported unit, so this is what is represented in the networks if the data were presented in two ways (e.g., feeding visits and seeds consumed).<br />
"ind_quant_unit" - describes whether the sampling unit was a quantitative count (rather than binary or percentage or per hour or something)<br />
"sampling_hours" <br />
"sampling_days" <br />
"sampling_period_months"<br /> 
"year" <br />

"plant_coverage" - Whether all fruiting plant species were targetted for observation and reported on (comp), or only a subset (sub) such as a target list of plant species targetted for observation or interactions with introduced plants not reported.<br />
"plant_sampling_type" - Whether plants were sampled to standardize observation effort (stand; same number of observation hours per plant species) or whether plant species were sampled representative to their abundance (repr).<br />

"target_birds" - Whether the sampling method targetted this focal taxon, and whether they study observed/reported only a subset of the focal taxa (sub) or any member of that taxon (comp).<br />
"target_bats" <br />
"target_primates" <br />
"target_mamm_carns" <br />
"target_mamm_herbs" <br />
"target_mamm_others" <br />
"target_fish" <br />
"target_herps" <br />
"specify_nfm_targets" - further description of the non flying mammals targetted for observation


