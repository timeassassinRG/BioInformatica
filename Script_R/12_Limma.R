# ANALISI DIFFERENZIALE - LIMMA

# Per installare il pacchetto decommentare queste linee di codice
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
#BiocManager::install("limma")
#BiocManager::install("GEOquery")
#BiocManager::install("marray")
library(limma)
library(GEOquery)
library(marray)


#CASO 1) AFFYMETRIX ARRAY - UNA VARIABILE DI CONTROLLO, CASO/CONTROLLO

#Usiamo questo dataset GEO ma per evitare eccessivi download scarichiamo solo il GSE
#Non scarichiamo i dati della piattaforma usata che servono solo per l'annotazione
dataset <- getGEO("GSE163046", getGPL = F)
dataset <- dataset[[1]]
View(exprs(dataset))

#Ricaviamo le info sui campioni presenti
sample.info <- as(phenoData(dataset),"data.frame")
View(sample.info)

#Ci sono 12 campioni divisi in 4 classi
#Crea la matrice di design
group <- factor(c(1,1,1,1,2,2,2,3,3,4,4,4))
design.matrix <- model.matrix(~ 0+group)
design.matrix

#Modifichiamo i nomi dei 4 gruppi nella matrice di design
colnames(design.matrix) <- c("Control","GM453","Paclitaxel","GNE140")
design.matrix

#Crea il modello lineare
fit <- lmFit(dataset, design.matrix)
fit

#Crea la matrice dei constrasti. 
#Decidiamo di concentrarci su GM453 vs Control, Paclitaxel vs Control e Paclitaxel vs GM453
cont.matrix <- makeContrasts(GM453vsControl=GM453-Control, 
                             PaclitaxelvsControl=Paclitaxel-Control,
                             PaclitaxelvsGM453=Paclitaxel-GM453,
                             levels=design.matrix)
cont.matrix

#Effettua i confronti richiesti tirando fuori dei log-fold change
fit2 <- contrasts.fit(fit, cont.matrix)
fit2

#Modera gli errori standard dei log-fold change 
#e calcola P-value delle differenze osservate
fit2 <- eBayes(fit2)

#Effettua la correzione del p-value con Benjamini-Hochberg per test multipli con soglia 0.05
#e restituisci i 20 geni con gli adjusted p-value più bassi (ovvero le differenze più significative)
#sul primo confronto (GM453 vs Control)
results <- topTable(fit2, coef=1, number=20, adjust.method="BH", p.value=0.05)
View(results)

#Effettua la correzione del p-value con Benjamini-Hochberg per test multipli con soglia 0.05
#e restituisci i 20 geni con gli adjusted p-value più bassi (ovvero le differenze più significative)
#sul terzo confronto (Paclitaxel vs GM453)
#In questo caso la tabella restituisce solo 13 geni, perché i successivi hanno p-value adjusted > 0.05 e quindi non vengono mostrati
results <- topTable(fit2, coef=3, number=20, adjust.method="BH", p.value=0.05)
View(results)

#Effettua il test statistico per stabilire, per ogni gene g e confronto C, 
#se g è significativamente differenzialmente espresso per quel confronto
#Effettua la correzione di Benjamini-Hochberg con una soglia di 0.05 sul p-value corretto
significance.res <- decideTests(fit2,adjust.method = "BH", p.value = 0.05)
View(significance.res)

# Il risultato è una matrice in cui per ogni gene e ogni confronto abbiamo 0, -1 o 1
#0 indica che non è significativamente differenzialmente espresso
#-1 indica che è significativamente sottoespresso
#1 indica che è significativamente sovraespresso
#Da questa matrice filtriamo solo i geni che sono significativamente sotto o sovraespressi
only.significant <- significance.res[rowSums(abs(significance.res))>0,]
only.significant

#Diagramma di Venn che mostra quanti geni sotto o sovraespressi ci sono in comune 
#tra i vari confronti
vennDiagram(significance.res)

#Disegna il volcano plot
volcanoplot(fit2,coef=1)

#Disegna il volcano plot colorando di blu i sottoespressi significativamente
#e di rosso i sovraespressi significativamente
colors <- rep("grey",nrow(significance.res))
colors[which(significance.res[,1]==-1)] <- "blue"
colors[which(significance.res[,1]==1)] <- "red"
volcanoplot(fit2,coef=1,col=colors)



#CASO 2) AFFYMETRIX ARRAY - PIU' VARIABILI DI CONTROLLO

#Usiamo questo dataset GEO ma per evitare eccessivi download scarichiamo solo il GSE
#Non scarichiamo i dati della piattaforma usata che servono solo per l'annotazione
dataset <- getGEO("GSE122664", getGPL = F)
dataset <- dataset[[1]]

#In questo caso abbiamo due variabili di controllo: 
#il tessuto (rene o fegato) e il tipo (caso o controllo)
View(exprs(dataset))
sample.info <- as(phenoData(dataset),"data.frame")
View(sample.info)

#Crea la matrice di design sulla base delle combinazioni dei valori delle due variabili
#Un gruppo per ogni combinazione di valori
group <- factor(c(1,2,1,2,1,2,3,4,3,4,3,4))
design.matrix <- model.matrix(~ 0+group)
design.matrix

#Modifichiamo i nomi dei due gruppi nella matrice di design
colnames(design.matrix) <- c("KidneyCase","LiverCase","KidneyControl","LiverControl")
design.matrix

#Crea il modello lineare
fit <- lmFit(dataset, design.matrix)

#Crea la matrice dei constrasti. 
#Decidiamo di concentrarci su:
#a) Geni diff. espressi tra KidneyCase e KidneyControl
#b) Geni diff. espressi tra LiverCase e LiverControl
#c) Geni che si comportano in maniera diversa tra Kidney e Liver rispetto ai controlli   
cont.matrix <- makeContrasts(KidneyvsControl=KidneyCase-KidneyControl, 
            LivervsControl=LiverCase-LiverControl,
            KidneyvsLiver=(KidneyCase-KidneyControl)-(LiverCase-LiverControl),
            levels=design.matrix)

#Effettua i confronti richiesti tirando fuori dei log-fold change
fit2 <- contrasts.fit(fit, cont.matrix)

#Modera gli errori standard dei log-fold change 
#e calcola P-value delle differenze osservate
fit2 <- eBayes(fit2)

#Effettua la correzione del p-value con Benjamini-Hochberg per test multipli con soglia 0.05
#e restituisci i 20 geni con gli adjusted p-value più bassi (ovvero le differenze più significative)
#sul primo confronto (KidneyCase vs KidneyControl)
results <- topTable(fit2, coef=1, number=20, adjust.method="BH", p.value=0.05)
View(results)

#Effettua la correzione del p-value con Benjamini-Hochberg per test multipli con soglia 0.05
#e restituisci i 20 geni con gli adjusted p-value più bassi (ovvero le differenze più significative)
#sul terzo confronto (Kidney vs Liver)
results <- topTable(fit2, coef=3, number=20, adjust.method="BH", p.value=0.05)
View(results)

#Effettua il test statistico
significance.res <- decideTests(fit2,adjust.method = "BH", p.value = 0.05)

#Filtra solo i geni che sono significativamente sotto o sovraespressi in almeno un confronto
only.significant <- significance.res[rowSums(abs(significance.res))>0,]
only.significant

#Diagramma di Venn che mostra quanti geni sotto o sovraespressi ci sono in comune 
#tra i vari confronti
vennDiagram(significance.res)

#Disegna il volcano plot
colors <- rep("grey",nrow(significance.res))
colors[which(significance.res[,3]==-1)] <- "blue"
colors[which(significance.res[,3]==1)] <- "red"
#Inserisci nel plot anche i nomi dei 5 geni col p-value non corretto più basso (parametro highlight)
volcanoplot(fit2,coef=3,col=colors,names=rownames(significance.res),highlight = 5)



#CASO 3) CDNA MICROARRAY - UNA VARIABILE DI CONTROLLO

#Carichiamo il file con le info sui sample
datadir <- system.file("swirldata", package="marray")
swirlTargets <- read.marrayInfo(file.path(datadir, "SwirlSample.txt"))
#Tramite il metodo maInfo() estraiamo dall'oggetto creato con read.marrayInfo() la matrice con le info sui campioni
targets <- maInfo(swirlTargets)

#Per i CDNA microarray possiamo sfruttare la funzione specifica di limma "modelMatrix"
#per costruire la matrice di design
#La funzione vuole due colonne chiamate "Cy3" e "Cy5" che indicano chi sono i casi 
#e chi sono i controlli

#Ridenominiamo le colonne
names(targets)[3] <- "Cy3"
names(targets)[4] <- "Cy5"

#Costruiamo la matrice di design indicando chi sono i controlli
design.matrix <- modelMatrix(targets,ref="wild type")
#La matrice di design contiene -1 che indicano che in quei casi Cy3 e Cy5 sono stati
#scambiati (cioè è stata usata la tecnica dye-swap)
design.matrix

#Leggiamo i dati grezzi e li normalizziamo ottenendo la matrice finale di espressione
galinfo <- read.Galfile("fish.gal", path=datadir)
swirl <- read.Spot(targets = swirlTargets, path=datadir,
                   layout = galinfo$layout, gnames = galinfo$gnames)
swirl.norm <- maNorm(swirl)

#Crea il modello lineare
fit <- lmFit(swirl.norm, design.matrix)

#Crea la matrice dei constrasti. 
cont.matrix <- makeContrasts(SwirlvsWild=swirl,
                             levels=design.matrix)

#Effettua i confronti richiesti tirando fuori dei log-fold change
fit2 <- contrasts.fit(fit, cont.matrix)

#Modera gli errori standard dei log-fold change 
#e calcola P-value delle differenze osservate
fit2 <- eBayes(fit2)

#Effettua la correzione del p-value con Benjamini-Hochberg per test multipli con soglia 0.05
#e restituisci i 20 geni con gli adjusted p-value più bassi
results <- topTable(fit2, coef=1, number=20, adjust.method = "BH", p.value = 0.05)
View(results)

#Effettua il test statistico 
significance.res <- decideTests(fit2, adjust.method = "BH", p.value = 0.05)

#Filtra solo i geni che sono significativamente sotto o sovraespressi
only.significant <- significance.res[rowSums(abs(significance.res))>0,]
only.significant

#Disegna il volcano plot
colors <- rep("grey",nrow(significance.res))
colors[which(significance.res[,1]==-1)] <- "blue"
colors[which(significance.res[,1]==1)] <- "red"
volcanoplot(fit2,coef=1,col=colors)

