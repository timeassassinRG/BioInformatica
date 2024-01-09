#Definizione di una funzione
valuta <- function(valX, div)
{
  if(valX%%div==0) {
    t <- 1
  }
  else {
    t <- 2
  }
  return(t)
}

#Applicazione (chiamata) della funzione
valuta(10,2)
#E' possibile esplicitare nella chiamata a quali parametri assegnare i valori
#I valori non esplicitamente assegnati vengono assegnati ai parametri rimanenti nell'ordine in cui sono definiti nella funzione
valuta(valX=10,2)
valuta(div=2,10)
valuta(valX=10,div=2)
valuta(div=2,valX=10)
#L'importante è che a tutti i parametri siano assegnati dei valori
valuta(10)

#Parametri opzionali con valori di default già specificati nella definizione della funzione
valuta <- function(valX, div=2)
{
  if(valX%%div==0) {
    t <- 1
  }
  else {
    t <- 2
  }
  t
}
valuta(10)
valuta(10,3)

#Richiamare il manuale di R per avere informazioni su una funzione
help(sum)
?sum
#Richiamare il manuale di R su una funzione di cui non si conosce il nome esatto o si conosce solo una parte del nome
help.search("sum")

#Funzioni matematiche predefinite
#Somma di valori
sum(2,4,7)
#Prodotto di valori
prod(2,4,7)
#Radice quadrata
sqrt(14)
#Calcola la potenza n-esima di e (numero di Nepero)
exp(2)
#Calcola il logaritmo naturale (base e) di un numero
log(4)
#Calcola il logaritmo in base x di un numero
log(4,base=2)
#Calcola il seno di un valore
sin(35)
#Calcola il coseno di un valore
#pi = pi-greco
cos(pi)
#Calcola il massimo da un insieme di valori
max(2,5,7)
#Calcola il minimo da un insieme di valori
min(2,5,7)
#Arrotonda un valore decimale al più vicino valore intero
round(3.4)
#Calcola il segno di un numero
sign(3.5)
sign(-3.5)
#Approssima un valore decimale x al più piccolo intero maggiore di x
ceiling(4.2)
#Approssima un valore decimale x al più grande intero minore di x
floor(4.2)

#Caricamento di pacchetti contenenti altre funzioni e dati
library(splines)
#Se il pacchetto non è presente, occorre installarlo col comando install.packages()
install.packages("splines")
#Lista delle funzioni disponibili in un pacchetto
lsf.str("package:splines")

