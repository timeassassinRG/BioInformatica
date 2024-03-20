import pandas as pd
import numpy as np
import networkx as nx
import seaborn as sns
import matplotlib.pyplot as plt
from tqdm.auto import tqdm
import time

# Caricamento e preparazione dei dati
data_expression = pd.read_csv('data/COAD_expression.csv', sep=';')
data_array = data_expression.set_index('GENE').T.values

# Calcolo della matrice di correlazione
correlation_matrix_expression = np.corrcoef(data_array, rowvar=False)

# Calcolo della matrice di correlazione
threshold = 0.9
edges_expression = []
genes_expression = data_expression['GENE'].values  # Lista di geni per l'etichettatura

# Calcolo delle correlazioni e costruzione della lista degli archi
threshold_expression = 0.95
for i in tqdm(range(len(genes_expression)), desc='Correlation Progress'):
    for j in range(i+1, len(genes_expression)):  # Evita di confrontare ogni gene con se stesso e duplicati
        if abs(correlation_matrix_expression[i, j]) > threshold_expression:
            edges_expression.append((genes_expression[i], genes_expression[j]))

# Creazione del grafo
G_expression = nx.Graph()
G_expression.add_edges_from(edges_expression)

# Disegno del grafo
plt.figure(figsize=(20, 20))
nx.draw(G_expression, with_labels=True, node_size=50, font_size=5) # Labels false, altrimenti non si vede niente
print('number of nodes:', G_expression.number_of_nodes())
print('number of edges:', G_expression.number_of_edges())
plt.show()
