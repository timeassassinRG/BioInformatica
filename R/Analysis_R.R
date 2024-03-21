library(ggplot2)
library(ggraph)
library(grid)
library(igraph)
library(muxViz)
library(RColorBrewer)

rm(list = ls())


#Lettura del grafo completo
grafo <- read_graph("multilayer.graphml", format = "graphml")
#verifica Archi e nodi
num_nodi <- gorder(grafo)
num_archi <- gsize(grafo)

#Network setup
Layers <- 3
Nodes <- gorder(grafo)
layerCouplingStrength <- 1
networkOfLayersType <- "categorical"
layer.colors <- brewer.pal(8, "Set2")

cat("####################################\n")
cat("# Multilayer connected components\n")
cat("####################################\n\n")

#Generate an edge-colored network
nodeTensor <- list()
g.list <- list()
nomi_nodi <- V(grafo)$id
layer_nodi <- sapply(strsplit(nomi_nodi, "', '"), function(x) gsub("['()]", "", x[2]))
layer_unici <- unique(layer_nodi)
print(layer_unici)

#Generate an edge-colored network
tutti_i_nodi <- sort(unique(unlist(lapply(layer_nodi, unique))))

# Inizializza nodeTensor come lista vuota di matrici sparse
nodeTensor <- list()

for (layer in layer_unici) {
  nodi_layer <- which(layer_nodi == layer)
  sottografo <- induced_subgraph(grafo, vids = nodi_layer)
  sottografo <- delete_edges(sottografo, E(sottografo)[E(sottografo)$type == "interlayer"])
  
  # Inizializza una matrice sparsa di dimensioni [tutti_i_nodi x tutti_i_nodi]
  matrice <- sparseMatrix(i = integer(0), j = integer(0), dims = c(length(tutti_i_nodi), length(tutti_i_nodi)))
  
  # Riempila con le adiacenze del sottografo corrente
  adiacenze <- as_adjacency_matrix(sottografo, sparse = TRUE)
  indici <- match(names(V(sottografo)), tutti_i_nodi)
  matrice[indici, indici] <- adiacenze
  
  nodeTensor[[layer]] <- matrice
}


#Define the network of layers
layerTensor <-
  BuildLayersTensor(
    Layers = Layers,
    OmegaParameter = layerCouplingStrength,
    MultisliceType = networkOfLayersType
  )

M <- BuildSupraAdjacencyMatrixFromEdgeColoredMatrices(nodeTensor, layerTensor, Layers, Nodes)


