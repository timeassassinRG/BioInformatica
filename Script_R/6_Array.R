#------------ARRAY----------------
#Un array è una tabella ordinata di elementi dello stesso tipo a due o più dimensioni. 
#Ciascun elemento è identificato da diversi indici, uno per ogni dimensione.


# 1) CREAZIONE DI ARRAY

#Crea un array tridimensionale. 
#Il numero di elementi passato deve coincidere col prodotto delle dimensioni
arr <- array(24:49,dim=c(4,2,3))
arr
#Dimensioni dell'array
dim(arr)
#Assegnare nomi alle dimensioni
dimnames(arr) <- list(c("X1","X2","X3","X4"),c("Y1","Y2"),c("Z1","Z2","Z3"))
#Togliere i nomi a tutte le dimensioni
unname(arr)


# 2) ESTRAZIONE DI ELEMENTI DA UN ARRAY

#Estrai una sottomatrice
arr[,,3]
arr[,,"Z2"]
arr[c(1,3),2,]
arr[-c(1,3),2,]
#Estrai un vettore
arr[1,,3]
#Estrai un elemento
arr[1,2,3]

