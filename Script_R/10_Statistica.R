#Il pacchetto base "stats" gia' presente in R contiene diverse funzioni per l'analisi statistica


# 1) CALCOLO DI STATISTICHE SU CAMPIONI DI VALORI

x <- c(4,7,6,5,6,7)
#Media aritmetica
mean(x)
#Mediana
median(x)
#Varianza
var(x)
#Deviazione standard
sd(x)
#Covarianza tra due vettori
a <- c(7,2,5,1,7,3)
cov(x,a)
var(x,a)
#Correlazione (di Pearson) tra due vettori
cor(x,a)
#Altre misure di correlazione tra due vettori
cor(x,a,method="spearman")
cor(x,a,method="kendall")
#Matrice di covarianza tra le colonne di una matrice
mat <- matrix(c(1,5,3,4,2,7,8,4,1),nrow=3)
mat
cov(mat)
var(mat)
#Matrice di correlazione tra le colonne di una matrice
cor(mat)


# 2) DISTRIBUZIONI DI PROBABILITA'

#In R le funzioni che riguardano le distribuzioni di probabilita' sono caratterizzate da un termine che identifica la distribuzione
#Il termine e' preceduto da una lettera che indica il tipo di funzione:
#Lettera "d": calcolo della funzione di densita' su un valore o un vettore di valori (es. "dunif()" per la distribuzione uniforme)
#Lettera "p": calcolo del valore della funzione cumulativa (es. "pbinom()" per la funzione binomiale)
#Lettera "r": estrazione di un campione di dati dalla distribuzione (es. "rexp()" per la distribuzione esponenziale)
#Ogni funzione ha parametri specifici che dipendono dal tipo di distribuzione

#Esempi
#Calcola i valori della distribuzione normale con media 2 e deviazione standard 3 su un vettore di valori
xval <- -5:10
xval
yval <- dnorm(-5:10,mean=2,sd=3)
yval
plot(xval,yval,type="l")
#Calcola i valori della funzione cumulativa della distribuzione normale con media 2 e deviazione standard 3
pnorm(-5:10,mean=2,sd=3)
#Campiona 10 valori dalla distribuzione normale con media 2 e deviazione standard 3
rnorm(10,mean=2,sd=3)


# 3) TEST STATISTICI

# I test statistici si effettuano usando funzioni del tipo "x.test()" dove x e' il nome del test
#shapiro.test() (test di Shapiro-Wilk), ks.test() (test di Kolmogorov-Smirnov), t.test() (t-test), 
#wilcox.test() (test signed-rank di Wilcoxon), var.test() (F test di Fisher), prop.test() (test binomiale),
#chisq.test() (test Chi-quadro), fisher.test() (test esatto di Fisher)

#Esempi

#Test di Shapiro-Wilk (se p-value < alpha allora la distribuzione e' diversa dalla normale)
x <- exp(rnorm(100))
x
shapiro.test(x)

#Test di Kolmogorov-Smirnov
y <- exp(rnorm(100))
ks.test(x,y)

#t-test di Student su singolo campione
#Parametro "mu": media di riferimento
mtcars$mpg
t.test(mtcars$mpg,mu=15)

#t-test di Student su due campioni disaccoppiati
down <- c(20,15,10,5,20,15,10,5,20,15,10,5,20,15,10,5)
up <- c(23,16,10,4,22,15,12,7,21,16,11,5,22,14,10,6)
t.test(down,up)
#t-test di Student su due campioni accoppiati (devono essere vettori della stessa lunghezza)
t.test(down,up,paired=T)
#t-test di Student su due campioni disaccoppiati con varianza uguale
t.test(down,up,var.equal=T)
#t-test di Student su due campioni accoppiati con varianza uguale
t.test(down,up,paired=T,var.equal=T)

#Test Wilcoxon signed rank
#Parametro "mu": mediana di riferimento
hist(mtcars$hp)
wilcox.test(mtcars$hp,mu=200)

#Test Wilcoxon rank-sum (Mann-Whitney U test)
v1 <- c(3,4,4,3,2,3,1,3,5,2)
v2 <- c(5,5,6,7,4,4,3,5,6,5)
wilcox.test(v1,v2)
#Test Wilcoxon rank-sum (Mann-Whitney U test) con campioni accoppiati
wilcox.test(v1,v2,paired=T)

#F test di Fisher per confronto di varianze
v1 <- c(5,5,6,7,4,4,3,5,6,5)
v2 <- c(3,3,2,1,10,4,3,11,3,10)
var(v1)
var(v2)
var.test(v1,v2)

#Test binomiale
#Parametri: due vettori "x" e "n", contenenti rispettivamente numeratori e denominatori delle frazioni (proporzioni) da confrontare
#Esempio: confronto tra le frazioni 4/40 e 196/3270
prop.test(x=c(4,196),n=c(40,3270))

#Test Chi-quadro
#Parametro "x": matrice che rappresenta la tabella delle contingenze
count <- matrix(c(38,14,11,51),nrow=2)
count
chisq.test(count)
#La funzione restituisce una lista di risultati
#Il campo "expected" contiene la matrice con i valori attesi per ogni contingenza
chisq.test(count)$expected

#Test esatto di Fisher
#Parametro "x": matrice che rappresenta la tabella delle contingenze
count <- matrix(c(6,4,2,8),nrow=2)
count
fisher.test(count)

