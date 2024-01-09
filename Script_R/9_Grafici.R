# 1) GRAFICI TRAMITE FUNZIONE GENERICA PLOT()

# La funzione generica per disegnare plot di vario tipo è la funzione plot()

#Dataframe di esempio: "mtcars" che contiene dati su consumi, design e performance di 32 automobili
mtcars

#Funzione plot() con un solo parametro vettore numerico: scatter plot o grafico di dispersione
#Sull'asse x si trovano le posizioni degli elementi del vettore
mtcars$qsec
plot(mtcars$qsec)

#Funzione plot() con due vettori numerici: scatter plot
mtcars$mpg
plot(mtcars$qsec, mtcars$mpg)
#Di default con vettori numerici plot() produce grafici con punti
#Per disegnare grafici con linee e/o punti occorre impostare il parametro "type"
x <- seq(0,10,0.5)
#Grafico a punti
plot(x,sin(x))
plot(x,sin(x),type="p")
#Grafico a linee
plot(x,sin(x),type="l")
#Grafico a linee e punti
plot(x,sin(x),type="b")

#Funzione plot() con un solo parametro factor: grafico a barre
#Ogni barra indica il numero di volte che un livello (categoria) è presente nel vettore factor
mtcars$cyl
factor(mtcars$cyl)
plot(factor(mtcars$cyl))

#Funzione plot() con due parametri, un factor e un vettore numerico: boxplot o grafico a scatole e baffi
#Produce una serie di boxplot, uno per ogni livello (categoria) del factor
plot(factor(mtcars$cyl),mtcars$mpg)


# 2) PERSONALIZZAZIONE DI UN PLOT

#Modifica delle impostazioni di visualizzazione di un plot tramite i parametri di plot()
x
#Parametro "type": tipo di linea ("l"=solo linee, "p"=solo punti, "b"=punti e linee)
plot(x,sin(x),type="b")
#Parametro "col": colore del grafico
plot(x,sin(x),type="b",col="red")
#Parametro "pch": tipo di punto (ad es. pallino vuoto, pallino pieno, asterisco)
plot(x,sin(x),type="b",col="red",pch="*")
#Parametro "lty": tipo di linea (ad es. "dashed"=tratteggiata, "solid"=continua)
plot(x,sin(x),type="b",col="red",pch="*",lty="dashed")
#Parametro "lwd": spessore del grafico
plot(x,sin(x),type="b",col="red",pch="*",lty="dashed", lwd=2)
#Parametri "xlab" e "ylab": nomi degli assi
plot(x,sin(x),type="b",col="red",pch="*",lty="dashed", lwd=2, xlab="Tempo", ylab="Seno")
#Parametri "xlim" e "ylim": vettori contenenti minimo e massimo valore da riportare sugli assi x e y
plot(x,sin(x),type="b",col="red",pch="*",lty="dashed", lwd=2, xlab="Tempo", ylab="Seno",
     ylim=c(-2,2))
#Parametro "main": titolo del grafico
plot(x,sin(x),type="b",col="red",pch="*",lty="dashed", lwd=2, xlab="Tempo", ylab="Seno",
     ylim=c(-2,2),main="Funzione seno")


# 3) SOVRAPPOSIZIONE DI GRAFICI

#Sovrapporre grafici a punti e/o linee a grafici già esistenti
#Funzione lines(): sovrappone un grafico a punti
plot(x,sin(x),type="b",col="red",pch="*",lty="dashed", lwd=2, xlab="Tempo", 
     ylab="Seno",main="Funzione seno")
lines(x,cos(x),col="blue")
#Funzione points(): sovrappone un grafico a punti
points(x-1,sin(x),col="magenta")
#Se si vuole sovrapporre un grafico a linee e punti occorre impostare il parametro "type" a partire da lines() o points()
points(x-1,sin(x),col="magenta",type="b")


# 4) GRAFICI TRAMITE FUNZIONI SPECIFICHE

#Funzione hist(): istogramma con le frequenze dei valori di un vettore
hist(sample(0:100,1000,replace=T))
#Parametro "breaks": numero di barre da visualizzare
hist(sample(0:100,1000,replace=T),breaks=50)
#Parametro "probability": tratta le frequenze come frequenze relative o percentuali (valori tra 0 e 1)
hist(sample(0:100,1000,replace=T),breaks=50,probability=T)

#Funzione pie(): grafico a torta a partire da un vettore di frequenze
mtcars$cyl
table(mtcars$cyl)
pie(table(mtcars$cyl))
#Parametro "col": modifica i colori dei settori
pie(table(mtcars$cyl),col=c("red","green","blue"))
#Parametro "labels": modifica le etichette dei settori
pie(table(mtcars$cyl),col=c("red","green","blue"),labels=c("cyl=4","cyl=6","cyl=8"))

#Funzione barplot(): grafico a barre a partire da un vettore di frequenze
table(mtcars$cyl)
barplot(table(mtcars$cyl))
#Parametro "horiz": visualizza le barre in orizzontale
barplot(table(mtcars$cyl),horiz=T)
#Parametro "col": modifica i colori delle barre
barplot(table(mtcars$cyl),col=c("red","green","blue"))
#Parametro "names.arg": modifica i nomi sull'asse x
barplot(table(mtcars$cyl),col=c("red","green","blue"),names.arg = c("cyl=4","cyl=6","cyl=8"))
#Funzione barplot() con due vettori: grafico a barre raggruppate
#Esempio: plottare il numero di macchine per ogni valore di cilindrata ("cyl") e per ogni numero di marce ("gear")
#La funzione table() con due vettori restituisce il numero di elementi per ogni combinazione di valori dei due vettori
table(mtcars$cyl,mtcars$gear)
#Grafico a barre raggruppato e impilato (barre una sopra l'altra)
barplot(table(mtcars$cyl,mtcars$gear))
barplot(table(mtcars$cyl,mtcars$gear),col=c("red","green","blue"),names.arg = c("gear=3","gear=4","gear=5"))
#Parametro "beside": affianca le barre in un grafico a barre raggruppato
barplot(table(mtcars$cyl,mtcars$gear),col=c("red","green","blue"),names.arg = c("gear=3","gear=4","gear=5"),beside=T)

#Funzione boxplot(): boxplot o grafico a scatole e baffi
#Il primo parametro "formula" descrive cosa si vuole plottare e in funzione di cosa
#Il secondo parametro è il dataframe da cui sono prese le colonne indicate nella formula
boxplot(formula=mpg ~ cyl, data=mtcars)
#Parametro "names": modifica i nomi sull'asse x
boxplot(formula=mpg ~ cyl, data=mtcars, names=c("cyl=4","cyl=6","cyl=8"))


# 5) AGGIUNTA DELLA LEGENDA

#Funzione legend(): aggiunge la legenda al grafico (va aggiunta dopo aver creato il plot)
#Parametri da specificare
#Parametro "legend": voci della legenda
#Parametro "x": posizione della legenda (es. "topright", "bottom")
#Parametro "pch": tipi di punti (se presenti) associati alle voci della legenda (solo per grafici a linee e punti)
#Parametri "lty": tipi di linee associate alle voci della legenda (solo per grafici a linee e punti)
#Parametro "col": colori delle linee associate alle voci della legenda (solo per grafici a linee e punti)
#Parametro "fill": colori di riempimento (solo per boxplot, grafici a barre e grafici a torta)

#Esempio: grafici a linee e punti sovrapposti
plot(x,sin(x),type="b",col="red",pch="*",lty="dashed", lwd=2, xlab="Tempo", 
     ylab="Seno",main="Funzione seno")
lines(x,cos(x),col="blue")
legend(legend=c("sin","cos"),x="bottomleft",pch=c("*",""),lty=c("dashed","solid"),
       col=c("red","blue"))

#Esempio: grafico a torta
pie(table(mtcars$cyl),col=c("red","green","blue"),labels=c("cyl=4","cyl=6","cyl=8"))
legend(x="topright",legend=c("cyl=4","cyl=6","cyl=8"),fill=c("red","green","blue"))

#Esempio: grafico a barre raggruppato
barplot(table(mtcars$cyl,mtcars$gear),col=c("red","green","blue"),names.arg = c("gear=3","gear=4","gear=5"),beside=T)
legend(x="topright",legend=c("cyl=4","cyl=6","cyl=8"),fill=c("red","green","blue"))


# 6) SALVATAGGIO DI UN PLOT SU FILE

#Passo 1: selezionare l'estensione del file tramite la funzione opportuna (es. pdf(), jpeg(), png())
#Il primo parametro è il nome del file
#I parametri "width" e "height" consentono di impostare le dimensioni dell'immagine
jpeg("plot.jpg",width=600,height=400)

#Passo 2: creare il plot (tramite plot() o una delle funzioni specifiche)
plot(mtcars$qsec)

#Passo 3: chiudere la connessione al file tramite la funzione dev.off()
dev.off()

