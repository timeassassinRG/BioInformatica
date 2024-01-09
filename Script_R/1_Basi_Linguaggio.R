#E' possibile scrivere delle istruzioni o comandi R direttamente dal prompt in basso o caricando uno script R contenente una lista di istruzioni
source("Esempi_Array.R")

#Le istruzioni in R possono essere scritte su righe diverse o sulla stessa riga usando ";"
t <- 1; sum <- 0
product <- 1
cat(t)

#Assegnamento di valori a variabili usando ->, <- o =
#Per convenzione si usa la notazione -> per gli assegnamenti
#Per i nomi delle variabili occorre evitare caratteri quali !,",$ e %
x <- 5
#Scrivendo il nome della variabile, il valore viene stampato sul prompt 
x
6 -> y
y
z = 2
z

#R è case-sensitive (sensibile alle maiuscole) sui nomi delle variabili
x
X

#Tipi di dato Numeric
#Integer
z <- 17
#Double
z <- 1.7
#Complex
z <- 1+2i

#Altri tipi di dati primitivi
#Character
z <- "home"
#Logical
z <- TRUE
z <- T
z <- FALSE
z <- F

#Valori speciali NULL (valore indefinito), NA (valore mancante), NaN (valore numerico indefinito), Inf e -Inf (più e meno infinito)
0/0
2/0
-2/0

#Controllo e conversione di tipi di dato
z <- 15
is.numeric(z)
is.character(z)
t <- as.character(z)
t
z <- "home"
t <- as.numeric(z)
t

#Visualizzazione dei valori delle variabili su RStudio in stile Excel
x <- matrix(c(1,3,2,2,1,4,8,9,5),nrow=3)
x
View(x)

#Visualizza tutte le variabili definite dall'utente e che stanno nell'environment
ls()
#Rimuovi una variabile definita precedentemente
rm(x)

#Operatori aritmetici
3+2
3-2
3*2
3/2
3^2
#Divisione intera, restituisce il quoziente della divisione
3%/%2
#Resto della divisione intera
3%%2

#Operatori logici
TRUE&FALSE
T|F
!TRUE

#Operatori relazionali
3==2
3!=2
3<2
3>2
3<=2
3>=2

#Operatori aritmetici applicati a booleani
T+T
T+F
T-T
T-F
T+T-F
T+T+T+T

