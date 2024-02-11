# installing packages

# install.packages("RColorBrewer")
# install.packages("ggthemes")

library(tidyverse)
library(RColorBrewer)
library(ggthemes)

# import survey data

data <- drop_na(read_csv("survey data.csv"))

# make small dataset with some variables

data1 <- select(data,"CC18_308a","ideo5","educ","faminc_new","employ") %>% drop_na()

ggplot(data1, aes(x = CC18_308a, y = ideo5, color = educ, size = faminc_new))+
      geom_jitter()

ggplot(data1, aes(x = CC18_308a, y = ideo5, color = educ, size = faminc_new))+
      geom_jitter()+
      scale_color_gradient(low = "purple", high = "grey")

# use emploment variable as categorical variable 

data1$employ_cat <- recode(data1$employ, `1`="Full-time",`2`="Part-time",
                           `3`="Temp. Layoff",
                           `4`="Unemployed",`5`="Retired",`6`="Disabled",
                           `7`="Homemaker",`8`="Student",`9`="Other")
data1 <- rename(data1, "Employment" = employ_cat)

ggplot(data1, aes(x = CC18_308a, y = ideo5, color = employ_cat))+
      geom_jitter()+
      scale_color_brewer(name = "Employment",palette = "RdYlGn")+
      theme(legend.position = "bottom", 
            axis.text.x = element_text(angle = 90, hjust = 1, color = "red"))+
      labs(x = "Trump Ideology", y = "Trump Approval", 
           title = "Trump Approval, Ideology, and Employment",
           caption="A caption might have a quick note about the figure or a sourcing.")


# ggthemes contains pre-baked themes that you can try and modify

# wall street journal theme

ggplot(data1, aes(x = CC18_308a, y = ideo5, color = Employment))+
      geom_jitter()+
      theme_wsj()+
      theme(axis.text = element_text(angle=90))

      



