#------------LISTE----------------
#Una lista in R è un elenco ordinato di oggetti
#Gli oggetti possono essere di tipo diverso (es. vettori, matrici, liste, dataframe)


# 1) CREAZIONE DI LISTE

#Crea una lista di 4 elementi
lista <- list(rep(1,3), c(1,2,3,4), matrix(2:9,nrow=4), c("Piano","Forte"))
lista
#E' possibile assegnare nomi ai vari oggetti della lista
lista <- list(vec1=rep(1,3), vec2=c(1,2,3,4), mat=matrix(2:9,nrow=4), vec3=c("Piano","Forte"))
lista

# 2) FUNZIONI DI UTILITA'

#Numero di elementi della lista
length(lista)
#Vettore dei nomi degli oggetti (se presenti)
names(lista)
#Trasformare una lista in un vettore (vettore named se la lista ha nomi associati)
unlist(lista)


# 2) ESTRAZIONE DI OGGETTI DALLA LISTA

#E' possibile accedere agli oggetti della lista tramite doppia coppia di parentesi quadre [[]]
#Se la lista ha nomi associati si può usare [[]] e all'interno una stringa contenente il nome dell'oggetto
#In alternativa, si può usare anche la notazione dollaro $ seguito dal nome dell'oggetto
#Accedere ad un elemento dalla lista
lista[[3]]
#Usando una singola coppia di parentesi quadre, si ottiene una lista contenente l'oggetto
lista[3]
#Accedere ad un elemento del secondo vettore della lista
lista[[2]][1]
#Accedere ad un elemento della matrice terzo elemento della lista
lista[[3]][1,2]
#Accesso tramite il nome associato all'oggetto
lista[["vec2"]]
lista$vec2
#Le notazioni [[]] e $ si possono usare anche per modificare oggetti della lista
lista
lista$mat <- c(4.3,5.7)
lista
lista[[5]] <- matrix(c(1,2,4,7),nrow=2)
lista
#Per rimuovere un oggetto dalla lista basta assegnargli il valore NULL
lista[["vec3"]] <- NULL
lista

