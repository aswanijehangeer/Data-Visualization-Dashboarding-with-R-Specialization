# install.packages("gganimate")
# install.packages("gifski")
# install.packages("transformr")

library(tidyverse)
library(gganimate)
library(gifski)
library(transformr)

data(mtcars)

mtcars$gear

my_first_anim <- ggplot(mtcars, aes(x = factor(cyl), y = mpg))+
      geom_boxplot()+
      transition_states(gear)#gganimate code

?transition_states
?transition_time
?transition_layers
      
cel <- read_csv("Cel Election Data.csv")

cel$party<-recode(cel$dem,`1`="Democrat",`0`="Republican")
congress_data <- cel %>%
      group_by(year, party) %>%
      summarise("Seats" = n())

my_anim2 <-ggplot(congress_data, aes(x = year, y = Seats, fill = party))+
      geom_bar(stat = "identity")+
      geom_hline(yintercept = 215)+
      scale_fill_manual(values=c("blue","red"))+
      transition_time(year)

my_anim3  <- ggplot()+
      geom_jitter(aes(x=seniority,y=all_pass,color=party),data=filter(cel,congress==115 & party=="Democrat"))+
      geom_jitter(aes(x=seniority,y=all_pass,color=party),data=filter(cel,congress==115 & party=="Republican"))+
      geom_smooth(aes(x=seniority,y=all_pass,color=party),data=filter(cel,congress==115 & party=="Democrat"))+
      geom_smooth(aes(x=seniority,y=all_pass,color=party),data=filter(cel,congress==115 & party=="Republican"))+
      scale_color_manual(values=c("blue","red"))+
      transition_layers()






#entering and exiting

ggplot(mtcars, aes(factor(cyl), mpg)) +
      geom_boxplot()

anim <- ggplot(mtcars, aes(factor(cyl), mpg)) +
      geom_boxplot() +
      transition_states(factor(cyl))

# Fade-in, fade-out
anim4 <- anim +
      enter_fade() +
      exit_fade()

anim4

#Shadowing

anim5 <- ggplot(congress_data,aes(x=year,y=Seats,fill=party))+
      geom_bar(stat="identity")+
      geom_hline(yintercept=217)+
      scale_fill_manual(values=c("blue","red"))+
      transition_time(year)+
      shadow_wake(wake_length=1,alpha=FALSE,wrap=FALSE)

anim5

#the animation will save to your working directory
anim_save("test.gif",animation=anim5)





