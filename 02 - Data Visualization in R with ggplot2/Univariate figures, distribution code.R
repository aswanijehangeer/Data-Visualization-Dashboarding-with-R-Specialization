library(tidyverse)

dead <- read_csv("Survey Data.csv")
dead

#Making boxplot
ggplot(dead, aes(y = faminc_new)) + geom_boxplot()

#Breaking boxplot by educaation group
ggplot(dead, aes(y = faminc_new, group = educ)) + geom_boxplot()

#Adding labels and Title
ggplot(dead, aes(y = faminc_new, group = educ)) +
      geom_boxplot() + 
      labs(x = "Income Level", y = "Family Income", title = "Family Inc. by Respondent Ed. Level")


# Reformat the data to form the dichotomous categorical variable is mapped to x rather than group
dead$educ_category <- recode(dead$educ,`1`="<4 yr Degree",`2`="<4 yr Degree",`3`="<4 yr Degree",`4`="<4 yr Degree",`5`="4 yr Deg. +",`6`="4 yr Deg. +")


ggplot(dead, aes(y = faminc_new, group = educ_category)) +
      geom_boxplot() + 
      labs(x = "Income Level", y = "Family Income", title = "Family Inc. by Respondent Ed. Level")


# making histogram

ggplot(dead, aes(x = faminc_new))+
      geom_histogram()

# making density plots

ggplot(dead, aes(x = faminc_new))+
      geom_density()

      