#Visualizations with Base R

#Univariate Statistics

numbers1<- c(1,1,1,2,2,3,3,3,4,4,4,4,5,5,5,5,6,6,6)

hist(numbers1)

boxplot(numbers1)

numbers2<- c(5,5,5,5,5,6,6,6,7,7,7,8,8,8,9,9,9)

boxplot(numbers1,numbers2)

#Bivariate Statistics

#make some fake data to create a scatterplot

#rnorm - normal distribution
#rpois - poisson
#rbinom - binomial
#runif - uniform

variable1<-runif(50,0,100)
variable2<-runif(50,0,100)

variable1
variable2

my_dat<-data.frame(variable1,variable2)
my_dat

#this does the same thing as the previous three lines

my_dat<-data.frame("variable1"=runif(50,0,100),"variable2"=runif(50,0,100))

#Scatterplot

plot(my_dat$variable1,my_dat$variable2)

#this does the same thing

plot(x=my_dat$variable1,y=my_dat$variable2)

#Base R has some limited graphics customization ability

plot(my_dat$variable1,my_dat$variable2,
     main="My First Plot",              #add main title
     xlab="Variable 1",                 # x axis label
     ylab="Variable 2",                 # y axis label
     ylim=c(0,150),xlim=c(0,150))       # set the length of the x and y axes.

?plot

