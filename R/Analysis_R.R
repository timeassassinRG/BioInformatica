# install.packages("devtools")
# devtools::install_github("manlius/muxViz")
# install.packages("igraph")

library(ggplot2)
library(ggraph)
library(grid)
library(igraph)
library(muxViz)
library(RColorBrewer)

rm(list = ls())
grafo <- read_graph("multilayer.graphml", format = "graphml")

# Verifica il numero di nodi e archi
num_nodi <- gorder(grafo)
num_archi <- gsize(grafo)

plot(grafo)
Layers <- 3
Nodes <- num_nodi
layerCouplingStrength <- 1
networkOfLayersType <- "categorical"
isDirected <- F
layer.colors <- brewer.pal(3, "Set2")

lay <- layoutMultiplex(grafo, layout="fr", ggplot.format=F, box=T)
