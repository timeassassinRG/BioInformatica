#Costrutto IF-THEN-ELSE
x <- 3

if(!is.numeric(x)) print("x non è un numero")

if(x==5) print("x==5") else print("x diverso da 5")

if(x%%2==0) {
  print("x è pari")
} else {
  print("x è dispari")
}

if(x%%2==0) {
  print("x è pari")
} else if(x%%3==0) {
  print("x è divisibile per 3")
} else {
  print("x è dispari")
}


#Ciclo FOR
sum <- 0
prod <- 1
for(t in 1:10)
{
  sum <- sum+t
  prod <- prod*t
}
sum
prod

sum <- 0
prod <- 1
for(t in seq(from=1,to=10,by=2))
{
  sum <- sum+t
  prod <- prod*t
}
sum
prod


#Ciclo WHILE
sum <- 0
prod <- 1
t <- 1
while(t<=10)
{
  sum <- sum+t
  prod <- prod*t
  t <- t+1
}
sum
prod


#Ciclo REPEAT
sum <- 0
prod <- 1
t <- 1
repeat
{
  sum <- sum+t
  prod <- prod*t
  t <- t+1
  if(t==10) break()
}
sum
prod
