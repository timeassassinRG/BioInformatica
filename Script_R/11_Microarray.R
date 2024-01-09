
#-----------------------AFFY--------------------------------

# Decommentare le seguenti linee di codice per installare Bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")

# Per installare i pacchetti decommentare queste linee di codice 
# BiocManager::install("affy")
# BiocManager::install("affydata")

#Carichiamo le librerie necessarie
library(affy)
library(affydata)


#LETTURA DI DATI RAW E CREAZIONE DI MATRICI DI ESPRESSIONE

#I microarray di esempio (file .CEL) sono contenuti nella cartella di installazione del pacchetto
#In particolare si trovano nella sottocartella "celfiles"
#Recuperiamo il percorso della sottocartella
#Il metodo system.file permette di recuperare file nelle cartelle di R dove sono stati
#installati i pacchetti
celpath <- system.file("celfiles",package="affydata")

#Portiamoci nella cartella individuata
setwd(celpath)


#METODO 1) WORKFLOW DI BASE

#Carichiamo i dati di microarray e normalizziamoli per convertirli in valori di espressione
#La funzione justRMA permette di leggere file CEL e semplicemente convertirli
#Invocata senza parametri legge i file dalla directory in cui ci troviamo
#Il risultato è caricato in un oggetto ExpressionSet
eset <- justRMA()

#Diamo un'occhiata alla descrizione di questo oggetto
#hgu133a è il file di annotazione che serve a risalire alle probes del microarray
#a partire dalle coordinate nel chip
eset

#Accediamo alla matrice di espressione
expr.data <- exprs(eset)

#Guardiamo il contenuto delle prime righe della matrice
head(expr.data)


#METODO 2) WORKFLOW DI BASE - SELEZIONE INTERATTIVA

#Questo metodo permette di selezionare da finestra i file CEL da caricare
#E' richiesto il package aggiuntivo "tkWidgets"

# Per installare il pacchetto decommentare queste linee di codice
#BiocManager::install("tkWidgets")

library(tkWidgets)

#Avvia la finestra di selezione dei file CEL
#L'oggetto restituito è di tipo AffyBatch
data <- ReadAffy(widget = T)

#Esegue la correzione, la normalizzazione e l'aggregazione dei valori delle probe
#che mappano allo stesso ID affymetrix usando RMA (come prima)
eset1 <- rma(data)
head(exprs(eset1))

#Esegue la correzione, la normalizzazione e l'aggregazione dei valori delle probe
#che mappano allo stesso ID affymetrix usando MAS5
eset2 <- mas5(data)
head(exprs(eset2))


#METODO 3) METODO AVANZATO - EXPRESSO

#Permette di personalizzare ciascuna operazione da effettuare 
#(normalizzazione, correzione, aggregazione dei valori di probe che mappano a ID uguali)

#Vogliamo usare expresso() per mimare esattamente il comportamento di RMA
#RMA usa come metodo di normalizzazione quello basato su quantili
#Inoltre usa solo i probe che sono mappate a geni
#Infine aggrega i valori di espressioni di probe che mappano alla stessa cosa
#usando il metodo medianpolish (cioè media calcolata sui logaritmi)
data("Dilution")
eset.cel <- expresso(Dilution,normalize.method = "quantiles", bgcorrect.method = "rma",
                       pmcorrect.method = "pmonly", summary.method = "medianpolish")
head(exprs(eset.cel))

#Variamo il processo usando come metodo di normalizzazione "qspline"
eset.cel.var <- expresso(Dilution,normalize.method = "qspline", bgcorrect.method = "rma",
                     pmcorrect.method = "pmonly", summary.method = "medianpolish")
head(exprs(eset.cel.var))



#-----------------------EXPRESSIONSET--------------------------------

#L'oggetto ExpressionSet contiene molte informazioni sui dati di espressione prodotti

#Lista dei geni o dei probe (indicati con ID Affymetrix)
featureNames(eset.cel)

#Lista dei sample
sampleNames(eset.cel)

#Informazioni sull'esperimento di microarray condotto
experimentData(eset.cel)
abstract(experimentData(eset.cel))

#Descrizione dei campioni usati nell'esperimento
#Il risultato è un oggetto di tipo "AnnotatedDataFrame"
info.samples <- phenoData(eset.cel)
info.samples
#Per ricavarne il contenuto devo convertirlo in un dataframe 
#che posso poi manipolare facilmente in R
info.samples <- as(info.samples,"data.frame")
info.samples

#Descrizione dei geni presenti nell'esperimento
info.feature <- featureData(eset.cel)
info.feature
info.feature <- as(info.feature,"data.frame")
info.feature
#Il dataframe è vuoto, significa che per ogni ID Affymetrix non ci sono altre info
#Possiamo in questo caso solo accedere alla lista dei nomi delle righe
row.names(info.feature)

#Salva la matrice di espressione su file
write.exprs(eset.cel,file="expressions.txt")



#-----------------------ANNOTATIONDBI--------------------------------

#MAPPARE GLI ID AFFYMETRIX DEI PROBES AI GENI (ad es. BRCA2, AKT)

#Per ricavare i geni corrispondenti a ciascun id affymetrix usiamo 
#uno dei database di annotazione messo a disposizione su Bioconductor
#https://bioconductor.org/packages/3.12/BiocViews.html#___AnnotationData
#Nel nostro caso uno dei pacchetti che iniziano con "hg"

#Per sapere qual è quello giusto dobbiamo vedere il campo Annotation
#dell'oggetto ExpressionSet creato, che ci dice il chip usato
eset.cel

#Il chip usato è identificato come "hgu95av2"
#Usiamo il pacchetto "hgu95av2"

# Per installare il pacchetto decommentare queste linee di codice
#BiocManager::install("hgu95av2.db")

library(hgu95av2.db)

#Il database contiene corrispondenze tra varie tipologie di informazioni
#Ogni tipologia di informazione è rappresentata da una chiave
#Per sapere i nomi delle due chiavi corrispondenti al simbolo del gene e
#all'ID del probe usiamo la funzione keytypes()
keytypes(hgu95av2.db)

#Approfondire il significato di una chiave
help("SYMBOL")

#Le chiavi che ci interessano sono PROBEID e SYMBOL

#Salviamo in un vettore la lista degli ID Affymetrix
list.affy <- featureNames(eset.cel)

#Usiamo mapIds per mappare gli id Affy al simbolo del/dei geni corrispondenti
gene.map <- mapIds(hgu95av2.db,keys=list.affy,column="SYMBOL",
                   keytype="PROBEID")
head(gene.map)

#In caso di mapping multipli, la funzione mappa la probe al primo gene che ha trovato
#Per avere tutti i mapping per una stessa probe modifichiamo il parametro "multiVals"
gene.map <- mapIds(hgu95av2.db,keys=list.affy,column="SYMBOL",
                   keytype="PROBEID",multiVals = "list")
head(gene.map)

#In alternativa per il mapping possiamo usare la funzione select()
gene.map <- select(hgu95av2.db,keys=list.affy,column="SYMBOL",
                   keytype="PROBEID")
head(gene.map)



#-----------------------MARRAY--------------------------------

# Per installare il pacchetto decommentare queste linee di codice
#BiocManager::install("marray")

library(marray)

#"marray" contiene dei file di esempio relativi al dataset contenente
#dati di espressione su Swirl zebrafish (zebrafish mutanti sul gene BMP2)

#Portiamoci sulla cartella contenente i file
datadir <- system.file("swirldata", package="marray")

#Analizziamo i file contenuti nella cartella
dir(datadir)

#A partire dai dati sulle intensità dei vari spot vogliamo ottenere
#anzitutto i dati grezzi (raw)

#Passo 1) Lettura info su ibridizzazione
#Il file .txt contiene informazioni sul processo di ibridizzazione
#Il metodo read.marrayInfo permette di leggerne il contenuto
swirlTargets <- read.marrayInfo(file.path(datadir, "SwirlSample.txt"))
swirlTargets

#Passo 2) Lettura file annotazione
#Il file .gal contiene le annotazioni sulle varie probes
#il metodo read.Galfile permette di leggerne il contenuto
galinfo <- read.Galfile("fish.gal", path=datadir)
galinfo
#galInfo è una lista che contiene tra i vari campi "gnames" e "layout"
names(galinfo)

#Passo 3) Lettura dati raw di fluorescenza
#Leggiamo i dati raw sui valori di fluorescenza
#I file relativi sono in formato .spot, quindi sono stati ottenuti col software Spot
swirl <- read.Spot(targets = swirlTargets, path=datadir,
                  layout = galinfo$layout, gnames = galinfo$gnames)
swirl

#Passo 4) Normalizzazione dati
swirl.norm <- maNorm(swirl)

#Visualizzare i dati di espressione in forma di matrice
expr.data <- as(swirl.norm,"matrix")

#Per convertire i dati di espressione in ExpressionSet occorre la libreria "convert"
#Per installare il pacchetto decommentare queste linee di codice
#BiocManager::install("convert")

library(convert)

expr.data <- as(swirl.norm, "ExpressionSet")

#Una volta trasformato in ExpressionSet possiamo come fatto in
#precedenza accedere alle varie info su dati di espressione, campioni, probe
head(exprs(expr.data))
as(phenoData(expr.data),"data.frame")
head(as(featureData(expr.data),"data.frame"),n=100)



#-----------------------GEOQUERY--------------------------------

# Per interrogare GEO usiamo la libreria GEOquery

# Per installare il pacchetto decommentare queste linee di codice
#BiocManager::install("GEOquery")

library(GEOquery)


#Caso 1) Serie di campioni

#Scarichiamo tutti i dati su una serie di campioni
#Indichiamo anche che non vogliamo scaricare dati aggiuntivi sulla piattaforma usata
dataset <- getGEO("GSE57820",getGPL = F)

#Il dataset scaricato non è un ExpressionSet, ma una lista
#contenente un solo elemento che è un ExpressionSet
dataset
dataset[[1]]

#Accediamo alla matrice di espressione
head(exprs(dataset[[1]]))

#Accediamo alle info sui campioni
info.samples <- as(phenoData(dataset[[1]]),"data.frame")
View(info.samples)

#Accediamo alle info sulle probes
info.probes <- as(featureData(dataset[[1]]),"data.frame")
#Il dataset è vuoto, possiamo solo vedere i nomi delle righe (ovvero le probe)
#Ciò è dovuto al fatto che non abbiamo scaricato dati sulla piattaforma (getGPL=F)
info.probes
rownames(head(info.probes))


# Caso 2) Dataset

#Scarichiamo un dataset relativo ad una serie di campioni
#In questo caso verranno scaricate anche le relative annotazioni sulla piattaforma e le probe 
dataset2 <- getGEO("GDS5881")

#L'oggetto ottenuto è di tipo GDS, non un ExpressionSet
dataset2

#Conversione da GDS a ExpressionSet
dataset2 <- GDS2eSet(dataset2)

#Una volta trasformato in ExpressionSet possiamo come fatto in
#precedenza accedere alle varie info su dati di espressione, campioni, probe
head(exprs(dataset2))
as(phenoData(dataset2),"data.frame")
View(head(as(featureData(dataset2),"data.frame")))
