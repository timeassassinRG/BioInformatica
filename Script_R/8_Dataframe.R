#------------DATAFRAME----------------
#Il dataframe è l'oggetto più importante in R.
#Simile ad un matrice, ma può contenere dati di diverso tipo.
#Ogni riga corrisponde ad un osservazione, mentre ogni colonna è una variabile
#Le variabili possono essere booleane, numeriche, stringhe o variabili categoriali (factor).


#1) CREAZIONE DI DATAFRAME

#Creare un dataframe a partire da vettori, avente due colonne (Nome e Sesso) con dati passati dall'utente
data <- data.frame(Nome=c("Paolo","Marta","Luca","Giorgio","Luisa"),Sesso=c("M","F","M","M","F"))
data
#Creare un dataframe vuoto avente due colonne (Nome e Sesso)
data.empty <- data.frame(Nome=character(),Sesso=character())
data.empty
#Creare un dataframe a partire da una matrice
mat <- matrix(c(2,3,4,5,6,7,8,9),ncol=2)
mat
data.mat <- as.data.frame(mat)
data.mat
#Accedere a o assegnare nomi a righe del dataframe
rownames(data) <- c("P1","P2","P3","P4","P5")
data
#Accedere a o assegnare nomi a colonne del dataframe
colnames(data)
names(data)


#2) CARICAMENTO E UTILIZZO DI DATAFRAME PREDEFINITI IN R

#Alcuni dataframe sono già disponibili in R, per vedere la lista completa basta scrivere
data()
#Uno di questi dataframe è "iris", molto utilizzato in data mining
#Se un dataframe è già presente nei pacchetti base di R, si può richiamare direttamente
iris
#Se il dataframe da visualizzare è molto grande possiamo usare il comando View()
View(iris)
#Se il dataframe da usare è in un pacchetto non di base di R occorre prima caricare il pacchetto, quindi caricare in memoria il dataset usando la funzione data()
library(rpart)
data(stagec)
stagec
#Visualizza i dataframe presenti in un pacchetto R
data(package="rpart")


#3) CARICAMENTO DI DATAFRAME DA FILE DI TESTO E SCRITTURA DI DATAFRAME SU FILE DI TESTO

#La funzione read.table() creare un dataframe a partire da un file di testo
#Nella lettura specifichiamo se la prima riga contiene i nomi delle colonne e quindi è una riga di intestazione ("header")
#Inoltre occorre indicare il carattere separatore ("sep") (ad es. la virgola o il carattere di tabulazione \t)
#Per gli altri parametri di read.table vedere l'help
data <- read.table(file="C:/Users/gmgmi/OneDrive - dmi.unict.it/Didattica/Informatica/Bioinformatica/Esempi_R/worms.txt",
                   header=T, sep="\t")
data
#Scrittura di un dataframe su file
write.table(data,file="C:/Users/gmgmi/OneDrive - dmi.unict.it/Didattica/Informatica/Bioinformatica/Esempi_R/worms2.txt",
            sep="\t")
#Per togliere i doppi apici "" nel file di output prodotto basta settare quote=F
#Per rimuovere gli indici di riga basta settare row.names=F
write.table(data,file="C:/Users/gmgmi/OneDrive - dmi.unict.it/Didattica/Informatica/Bioinformatica/Esempi_R/worms2.txt",
            sep="\t", quote=F, row.names=F)
#Nelle funzioni read.table() e write.table() è richiesto il parametro "file" che indica il percorso assoluto o relativo del file da leggere
#Il path relativo è calcolato rispetto alla cartella corrente di lavoro di R
#La funzione getwd() permette di visualizzare la cartella corrente di lavoro di R
getwd()
#Tramite setwd() è possibile modificare la cartella corrente
setwd("..")
getwd()


#4) ESTRAZIONE DI ELEMENTI DA UN DATAFRAME

#L'estrazione degli elementi di un dataframe avviene come per le matrici (tramite [])
iris[3,4]
iris[14:19,3]
iris[14:19,3,drop=F]
iris[1:5,2:3]
iris[3,]
iris[,5]
iris[-(6:15),]
#Se le righe e/o colonne hanno nomi associati, è possibile usare i nomi per estrarre gli elementi
iris[,"Sepal.Length"]
iris[,c("Sepal.Length","Sepal.Width")]
#E' possibile anche usare la notazione delle liste con $ per selezionare singole colonne
iris$Sepal.Length
#Anche la selezione basata su condizioni funziona allo stesso modo delle matrici
iris[iris[,"Species"] == "versicolor",]
iris[iris$Sepal.Length > 5.0 & iris$Sepal.Width > 3.0,"Species"]


#5) MODIFICA DI DATAFRAME

#Rimuovere una o più righe
iris.red <- iris[-c(15,18),]
#Rimuovere una colonna
iris.red <- iris
iris.red$Sepal.Length <- NULL
iris.red
#Rimuovere una o più colonne
iris.red <- iris[,-c(2,4)]
#Aggiungere una o più righe al dataframe tramite funzione rbind()
#Il secondo argomento di rbind() può essere un vettore o un dataframe (con lo stesso numero di colonne)
iris.ext <- rbind(iris,c(3.2,7.8,6.4,2.5,"setosa"))
iris.ext
#Aggiungere una colonna
iris.red
iris.red$Sepal.Length <- iris$Sepal.Length
iris.red
#Aggiungere una o più colonne al dataframe tramite funzione cbind()
#Il secondo argomento di cbind() può essere un vettore o un dataframe (con lo stesso numero di righe)
iris.red$Sepal.Length <- NULL
iris.red <- cbind(iris.red,Sepal.Length=iris$Sepal.Length)
iris.red


#6) FUNZIONI DI UTILITA'

#Numero di variabili (colonne)
length(iris)
ncol(iris)
#Numero di osservazioni (righe)
nrow(iris)
#Vettore contenente numero di osservazioni e variabili
dim(iris)
#Visualizzare solo le prime 6 righe del dataframe
head(iris)
#Visualizzare solo le prime n righe del dataframe
head(iris,n=3)
#Visualizzare solo le ultime 6 righe del dataframe
tail(iris)
#Visualizzare solo le ultime n righe del dataframe
tail(iris,n=5)
#Ordinamento delle righe del dataframe per Sepal.Width
iris[order(iris$Sepal.Width),]
#Ordina per Sepal.Width in senso decrescente
iris[order(iris$Sepal.Width,decreasing = T),]
iris[order(-iris$Sepal.Width),]
#Ordina per Sepal.Width e in caso di parità per Sepal.Length
iris[order(iris$Sepal.Width,iris$Sepal.Length),]
#Ordina per Sepal.Width in senso crescente e in caso di parità per Sepal.Length in senso decrescente
iris[order(iris$Sepal.Width,-iris$Sepal.Length),]
#Rimuovere righe duplicate
airquality.def <- unique(airquality)
#Calcolare dati aggregati di una o più variabili reference rispetto a una o più variabili controllo
#Il primo parametro di aggregate rappresenta i valori della/delle variabili reference
#Il secondo parametro è la lista delle variabili di controllo
#Il terzo parametro è la funzione di aggregazione da applicare
#Eventuali altri parametri sono parametri opzionali da passare alla funzione se necessario
#Calcolare sul dataframe "airquality" la temperatura media mensile
aggregate(x=airquality[,"Temp"],by=list(month=airquality$Month),FUN=mean)


#7) GESTIONE DEI VALORI NA

#Rimuovi le righe del dataframe che contengono uno o più valori NA
airquality.def <- na.omit(airquality)
#Sapere se le righe del dataframe sono complete (ovvero non contengono NA)
complete.cases(airquality)
#La funzione complete.cases() può essere usata per rimuovere righe del dataframe contenenti valori NA
airquality.def <- airquality[complete.cases(airquality),]
#Sostituire i valori NA con valori di default (ad es. 0)
airquality[is.na(airquality)] <- 0

