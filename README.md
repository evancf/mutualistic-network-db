# mutualistic-network-db
Sharing data from published studies of ecological networks involving plants and seed dispersers

These data are presented using two formats:

The first format is a single tidy dataset (network_data_long.csv) where each row represents a pairwise interaction involving a given plant and frugivore. When available, this shows the interaction frequency as reported in the publication. Otherwise, it represents a binary indicating whether the interaction was observed or not. The columns in this dataframe provide some additional taxonomic information relevant to the plant and frugivore species (further metadata relevant to each column will be presented below).

The second format is an individual adjacency matrices for each network. The 01_construct_networks.R script allows the user to adjust how the networks are constructed. For example, including or excluding non-fleshy fruited plant species, only including species where accepted scientific names were discernible from the original study (along with other taxonomy harmonization), or combining interactions across spatially or temporally distinct networks (e.g., networks reported for each season). The default will be to include all taxa reported by the original publications and to present the networks at the finest spatial or temporal scale at which the data were reported.

Metadata relevant to each study is also presented in network_metadata.csv. This includes descriptors of the spatial and temporal coverage of each network as well as basics of the study methods used to collect data. This includes field methods (e.g., bat mistnetting, focal tree watches), how data were reported (e.g., data reported for all or a subset of species), and the definition of interaction frequency presented in the paper. Further details relevant to each column will be presented below.

Please feel free to reach out with questions to ef13 *at* rice.edu or evanfricke *at* gmail.com. If you use this resource for a publication, please include the following citations:

Fricke, E. C., & Svenning, J. C. (2020). Accelerating homogenization of the global plant–frugivore meta-network. Nature, 585(7823), 74-78.

Fricke, Evan; Svenning, Jens-Christian (2020), Data from: Accelerating homogenization of the global plant–frugivore meta-network, Dryad, Dataset, https://doi.org/10.5061/dryad.44j0zpcbx
