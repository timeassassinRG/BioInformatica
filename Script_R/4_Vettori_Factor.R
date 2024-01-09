#------------VETTORI----------------
#Un vettore è una sequenza ordinata di oggetti dello stesso tipo (es. logical, numeric)


# 1) GENERAZIONE DI VETTORI

#Passo direttamente l'elenco di elementi che devono far parte del vettore
#c() è la funzione di concatenazione
N <- c(55,76,92,103,84,88,121,91,65,77,99)
N

#Genero un vettore di numeri da un minimo ad un massimo a incrementi di 1
0:10
#Genero un vettore di numeri da un massimo ad un minimo a decrementi di 1
15:5

#La funzione seq() permette di generalizzare il metodo di generazione visto prima 
#indicando il tipo di incremento/decremento o il numero di elementi desiderato
#Genera un vettore di numeri da un minimo ad un massimo con incremento 1
seq(1,10)
#Genera un vettore di numeri da un minimo ad un massimo con incremento personalizzato
seq(1,10,by=2)
#Genera un vettore di numeri da un massimo ad un minimo con decremento personalizzato
seq(6,4,by=-0.2)
#Genera un vettore di n elementi indicando il valore di partenza e l'incremento
seq(1,100,length=10)
seq(1,100,length=9)

#La funzione rep() permette di generare un vettore di elementi ripetuti
#Genera un vettore formato da 5 elementi tutti pari a 9.
rep(9, times=5)
#Genera un vettore in cui la sequenza 1,2,3,4 è ripetuta due volte
rep(1:4, times=2)
#Genera un vettore in cui ogni elemento della sequenza è ripetuto due volte
rep(1:4, each=2)
#Genera un vettore in cui ogni elemento della sequenza è ripetuto due volte e ripetilo tutto per tre volte
rep(1:4, each=2, times=3)
#Genera un vettore in cui il numero di volte per cui un elemento è ripetuto è dato dagli 
#elementi del secondo vettore. I due vettori parametro della funzione devono avere la stessa lunghezza
rep(1:4, times=1:4)
rep(1:4, times=c(4,1,4,2))
rep(c("cat","dog","gerbil","goldfish","rat"), times=c(2,3,2,1,3))


# 2) OPERAZIONI SU VETTORI

x <- 0:6
x
#In R è possibile effettuare operazioni aritmetiche e logiche non solo su variabili ma anche su vettori
#Per operatori aritmetici il risultato è un vettore numerico in cui l'operatore è applicato ad ogni elemento
x*5
#Per operatori logici il risultato è un vettore di booleani TRUE/FALSE a seconda che la condizione 
#sia vera o falsa per quell'elemento
x < 4


# 3) FUNZIONI DI UTILITA' SU VETTORI

x <- c(4,7,6,5,6,7)
#La funzione length() restituisce il numero di elementi del vettore
length(x)
#La funzione names() permette di assegnare delle etichette/nomi agli elementi (vettore named)
a <- c(1,3,5,6)
names(a) <- c("a","b","c","d")
a
#Se vogliamo rimuovere i nomi basta usare unname()
a <- unname(a)
#Tutti gli elementi del vettore soddisfano la condizione? (restituisce un valore non un vettore!)
all(x>4)
#Almeno un elemento del vettore soddisfa la condizione? (restituisce un valore non un vettore!)
any(x<4)
#Calcola il massimo
max(x)
#Calcola il minimo
min(x)
#Calcola la media
mean(x)
#Somma degli elementi
sum(x)
#Se il vettore è formato da booleani i booleani vengono prima convertiti in numeri (1 per TRUE e 0 per FALSE) e poi si effettua la somma
sum(c(T,T,F))
#Posso applicare questo comportamento della funzione sum per contare quanti elementi di un vettore soddisfano una condizione
sum(x<4)
#Prodotto degli elementi
prod(x)
#Restituisci il vettore senza valori duplicati
unique(x)
#La funzione table() permette di ottenere la frequenza di ogni elemento nel vettore
#Restituisce un vettore named con le frequenze per ogni elemento
table(x)
#Calcola il vettore reverse (nell'ordine dall'ultimo al primo elemento)
rev(x)
#La funzione sample() permette di campionare N elementi da un vettore
#Estrai 3 valori a caso dal vettore (senza possibili ripetizioni di elementi)
vec <- c(1,3,5,6,7)
sample(vec,size=3)
#Estrai 3 valori a caso dal vettore (con possibili ripetizioni di elementi)
sample(vec,size=3,replace=T)
#Estrai 3 valori a caso dal vettore (senza ripetizioni) secondo un vettore di pesi o probabilità
sample(vec,size=3,prob=c(1,2,2,4,1))
#Ordina gli elementi del vettore (Attenzione: il vettore non viene modificato)
sort(x)
#Per ottenere il vettore x modificato devo assegnare a x il risultato dell'operazione
x <- sort(x)
#Ordina in senso decrescente
sort(x,decreasing = T)
#Permutazione che devo effettuare per ordinare gli elementi del vettore
order(x)
#Permutazione che devo effettuare per ordinare gli elementi del vettore in modo decrescente
order(-x)
order(x,decreasing = T)
#Intersezione tra vettori
x <- c(4,7,6,5,6,7)
a <- c(7,2,5,1,7,3)
intersect(x,a)
#Unione tra vettori
union(x,a)
#Differenza insiemistica tra vettori
setdiff(x,a)
#Verificare se un elemento del primo vettore è presente nel secondo vettore.
#Restituisce un vettore di booleani lungo quanto il primo vettore
b <- c(8,3,2)
b %in% a
#Molte funzioni presentano un parametro na.rm che permette di calcolare correttamente il risultato della funzione anche in presenza di valori NA (mancanti)
z <- c(2,4,5,NA,8)
mean(z)
mean(z,na.rm=T)


# 4) ESTRAZIONE DI ELEMENTI DA UN VETTORE

#L'accesso agli elementi di un vettore avviene usando le parentesi quadre []
#All'interno delle parentesi quadre è possibile specificare numeri, vettori di numeri o vettori di booleani
#I numeri indicano le posizioni degli elementi che si vuole estrarre dal vettore. In R le posizioni partono sempre da 1!
x <- c(4,7,6,5,6,7)
#Estrarre un singolo elemento
x[4]
#Estrai il vettore privato di un elemento
x[-1]
#Estrarre un vettore di elementi
x[c(2,3,6)]
#Estrai il vettore privato di pi? elementi
x[-c(2,3,6)]
#Estrai gli elementi la cui posizione va da un minimo ad un massimo
x[1:3]
#Estrai gli elementi la cui posizione va da un minimo ad un massimo ad incremento personalizzato
x[seq(2,length(x),2)]
#Se si specifica all'interno di [] un vettore di booleani, quest'ultimo deve essere lungo quanto il vettore di partenza
#R estrarrà dal vettore tutti quegli elementi per cui nella posizione corrispondente nel vettore dei booleani si osserva valore TRUE
#Seleziono gli elementi che soddisfano una condizione booleana
x[x<6]
#Se il vettore è named, possiamo usare anche i nomi per riferirci agli elementi
#In questo caso però non è possibile usare ":" e "-"
a
a["b"]
a[c("b","c")]
#Restituisci solo gli elementi del primo vettore che stanno nel secondo vettore
b
b[b %in% a]
#Un metodo alternativo per estrarre elementi da un vettore consiste nell'usare la funzione which (o le funzioni which.min e which.max)
#La funzione which() Restituisce le posizioni degli elementi del vettore che soddisfano una condizione
which(x>4)
#Restuisci gli elementi che soddisfano una condizione. Analogo a x[x>4]
x[which(x>4)]
#La funzione which.max() restuisce la posizione della prima occorrenza del massimo elemento
which.max(x)
#La funzione which.min() restuisce la posizione della prima occorrenza del minimo elemento
which.min(x)
#Ordinamento dei vettori con la funzione order() e le parentesi quadre []
#Meno efficiente che applicare direttamente la funzione sort()
x
order(x)
x[order(x)]
x[order(-x)]
x[order(x,decreasing=T)]


# 5) MODIFICA DEGLI ELEMENTI DEL VETTORE

#Come per l'accesso, anche per la modifica si usano le parentesi quadre []
#Nel fare modifiche, è importante che i vettori a sinistra e a destra dell'assegnamento abbiano lo stesso numero di elementi
x <- c(4,7,6,5,6,7)
x
x[2] <- 8
x
x[c(3,5)] <- c(2,4)
x


# 6) VETTORI DI TIPO FACTOR

#I factor sono particolari vettori di stringhe o interi che rappresentano classi/categorie di appartenenza
#Rispetto ai vettori classici mantengono anche informazioni sulle varie classi presenti
#I factor sono solitamente i tipi di dato associati alle colonne contenenti stringhe di un dataframe quando vengono letti da file
#Creazione di factor
gender <- factor(c("female", "male", "female", "male", "female"))
gender
#Classi degli elementi del factor
levels(gender)
#Numero di classi
nlevels(gender)
#Cambiare l'ordine dei livelli
levels(gender) <- c("male","female")
levels(gender)
gender
#Conversione in un vettore di caratteri. Perdo le info sulle categorie presenti
as.vector(gender)

