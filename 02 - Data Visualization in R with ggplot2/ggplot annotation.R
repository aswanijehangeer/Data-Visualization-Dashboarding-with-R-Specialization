library(tidyverse)

kid <- c("Jahangir", "Love", "Saraj", "Arsu", "Sadhana")
time <- c(45,35,30,28, 28)
high_score <- c(100, 90, 70, 60, 50)

goals <- tibble(kid, time, high_score)

ggplot(goals, aes(x = time, y = high_score))+
      geom_point()+
      geom_text(aes(label = kid))


# Names are overlapping on dots, for this we will use nudge in geom text

ggplot(goals, aes(x = time, y = high_score))+
      geom_point()+
      geom_text(aes(label = kid), nudge_y = 5)

cel  <- drop_na(read_csv("CELL DATA.csv"))

cel %>% filter(congress == 115) %>%
      ggplot(aes(x = dwnom1, y = all_pass, label = thomas_name))+
      geom_point()+
      # we only want the geom text to apply to a subset of data
      geom_text( data = filter(cel, congress == 115 & all_pass > 8))
      

install.packages("ggrepel")
library(ggrepel)

cel %>% filter(congress == 115) %>%
      ggplot(aes(x = dwnom1, y = all_pass))+
      geom_point()+
      geom_text_repel(data = filter(cel, congress == 115 & all_pass > 8), mapping = 
                            aes(x = dwnom1, y = all_pass, label = thomas_name))



cel %>% filter(congress==115) %>% 
      ggplot(aes(x=dwnom1,y=all_pass))+
      geom_point()+
      geom_text_repel(filter(cel,congress==115 & all_pass>8),mapping=aes(x=dwnom1,y=all_pass,label=thomas_name))+
      annotate("rect",xmin=.05,xmax=.4,ymin=13,ymax=15,alpha=.2,fill="red")+
      annotate("text",x=.6,y=14,label="Most Passed",color="red")





