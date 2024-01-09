#------------MATRICI----------------
#Un matrice è una tabella ordinata di elementi dello stesso tipo. 
#Ciascun elemento è identificato da due indici: l'indice di riga e l'indice di colonna.


# 1) GENERAZIONE DI MATRICI

#Crea una matrice a partire da un vettore disponendo gli elementi su m righe ed n colonne
#Gli elementi vengono sistemati nella matrice colonna per colonna
x <- matrix(c(1,3,2,2,1,4,8,9,5),nrow=3,ncol=3)
x
#Per la creazione della matrice è sufficiente in realtà specificare solo il numero di righe o il numero di colonne
x <- matrix(c(1,3,2,2,1,4,8,9,5),nrow=3)
x
#Crea una matrice a partire da un vettore sistemando gli elementi riga per riga
x <- matrix(c(1,3,2,2,1,4,8,9,5),byrow=T,nrow=3)
x
#Crea una matrice concatenando riga per riga due o più vettori
a <- c(1,4,5,6)
b <- c(4,7,1,3)
c <- c(9,4,8,4)
rbind(a,b,c)
#Crea una matrice concatenando colonna per colonna due o più vettori
cbind(a,b,c)
#Le funzioni rbind() e cbind() possono essere usate anche per aggiungere righe o colonne ad una matrice
w <- matrix(c(1,4,9,4,7,4,5,1,8,6,3,4),nrow=3)
rbind(w,c(7,4,6,6))
cbind(w,w)
#Per aggiungere nomi alle righe possiamo usare la funzione rownames() a cui passiamo il vettore di nomi desiderati
rownames(x) <- c("R1","R2","R3")
rownames(x)
#Per aggiungere nomi alle colonne possiamo usare la funzione colnames()
colnames(x) <- c("C1","C2","C3")
colnames(x)
#Togliere i nomi a righe e colonne
unname(x)


# 2) ESTRAZIONE DI ELEMENTI DA UNA MATRICE

#Per estrarre elementi valgono le stesse regole viste per i vettori
#La selezione può essere fatta sulle righe e/o sulle colonne
#Mostra solo la terza colonna. Restituisce un vettore
x
x[,3]
#La funzione precedente restituisce un vettore. Se vogliamo evitare la conversione da matrice 
#a vettore e avere quindi una matrice con una sola colonna usiamo il parametro "drop"
x[,3,drop=F]
#Mostra solo la prima riga. Restituisce un vettore a meno di usare "drop"
x[2,]
#Mostra l'elemento alla prima riga e terza colonna
x[1,3]
#Mostra solo le prime due righe
x[1:2,]
#Mostra le colonne 1 e 3
x[,c(1,3)]
#Mostra solo la prima e la seconda riga e la seconda e la terza colonna
x[-1,2:3]
#Estrai gli elementi maggiori di 5. Il risultato è un vettore!
x[x>5]
#Filtrare righe sulla base di alcune condizioni su righe e/o colonne
#Estrai le righe della matrice il cui terzo elemento è maggiore di 7
x[x[,3]>7,]
#Estrai le colonne della matrice il cui primo elemento è minore di 5 e prendi solo le prime due righe
x[1:2,x[1,]<5]
#Se la matrice ha dei nomi su righe e colonne, possiamo riferirci ad essi usando i nomi
x["R1",,drop=F]
x[,c("C1","C2")]


# 3) FUNZIONI DI UTILITA'

#Restituisce un vettore con le dimensioni della matrice (num di righe e colonne)
dim(x)
#Numero di righe della matrice
nrow(x)
#Numero di colonne della matrice
ncol(x)
#Numero di elementi della matrice
length(x)
#Vettore contenente gli elementi della diagonale della matrice
diag(x)
#Trasposta della matrice
t(x)
#Matrice inversa
solve(x)
#Massimo elemento della matrice
max(x)
#Minimo elemento della matrice
min(x)
#Somma degli elementi della matrice
sum(x)
#Media dei valori della matrice
mean(x)
#Somma riga per riga. Restituisce un vettore di somme, una per ogni riga
rowSums(x)
#Somma colonna per colonna. Restituisce un vettore di somme, una per ogni colonna
colSums(x)
#Analoghe funzioni per la media riga per riga e media colonna per colonna
rowMeans(x)
colMeans(x)


# 4) OPERAZIONI TRA MATRICI

#Prodotto ountuale, ovvero prodotto elemento per elemento
z <- t(x)
x*z
#Prodotto matriciale (riga per colonna)
x%*%z
#L'operatore %in% controlla se ogni elemento della prima matrice sta nella seconda
#Gli elementi vengono processati colonna per colonna. Restituisce un vettore di booleani
y <- matrix(c(1,0,0,1,1,0),ncol=3)
y %in% x

