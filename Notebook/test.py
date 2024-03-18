import pandas as pd
import numpy as np
import networkx as nx
import seaborn as sns
import matplotlib.pyplot as plt
import tqdm.notebook as tqdm

# Carico il dataset di espressione genica
data_expression = pd.read_csv('../data/COAD_expression.csv', sep=';')

# Calcolo la matrice di correlazione
correlation_matrix = data_expression.set_index('GENE').T.corr(method='pearson')

# Scegliamo una soglia di correlazione per determinare gli archi significativi
threshold = 0.8

# Creo la lista degli archi basati sulla soglia di correlazione
edges = []
for gene1 in tqdm(correlation_matrix.index, desc='Correlation Progress'):
    for gene2 in correlation_matrix.columns:
        if (gene1 != gene2) and (abs(correlation_matrix.loc[gene1, gene2]) > threshold):
            edges.append((gene1, gene2))

# Creo la rete
G = nx.Graph()
G.add_edges_from(edges)

# Visualizzo la rete
plt.figure(figsize=(12, 12))
nx.draw(G, with_labels=True)
plt.show()