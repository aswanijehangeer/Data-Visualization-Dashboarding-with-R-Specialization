library(tidyverse)

data <- read_csv("CELL DATA.csv")

head(data)

# bar plot for dem variable in the 115th Congress. 0=Republican, 1=Democrat

data %>% 
      filter(congress == 115) %>% 
      ggplot(aes(x = dem))+
      geom_bar()

# proving our plot by comparing with frequency table
table(filter(data, congress == 115)$dem)  

# use st_name instead, so how counts of how many members of Congress from each state:
data %>% 
      filter(congress == 115) %>% 
      ggplot(aes(x = st_name)) + 
      geom_bar()

# Recoding the dem variable into a categorical variable

paarty <- recode(data$dem, '1' = "Democratic", '0' = "Republican")
data <- add_column(data, paarty)

data %>% 
      filter(congress == 115) %>%
      ggplot(aes(x = paarty))+
      geom_bar()
# Adding lables

data %>% 
      filter(congress == 115) %>%
      ggplot(aes(x = paarty, fill = paarty))+
      geom_bar()+
      labs(x = "Party", y = "Number of Members")

# Manually changing colors

data %>% 
      filter(congress == 115) %>%
      ggplot(aes(x = paarty, fill = paarty))+
      geom_bar()+
      labs(x = "Party", y = "Number of Members")+
      scale_fill_manual(values = c("blue", "red"))


# Dropping legends with guides function

data %>% 
      filter(congress == 115) %>%
      ggplot(aes(x = paarty, fill = paarty))+
      geom_bar()+
      labs(x = "Party", y = "Number of Members")+
      scale_fill_manual(values = c("blue", "red"))+
      guides(fill = FALSE)



# Making bar plots and manipulating data in R with fruit bowl data

apple <- rep("apple", 6)
orange <- rep("orange", 3)
banana <- rep("banana", 2)

fruit_bowl <- tibble("Fruits" = c(apple, orange, banana))

fruit_bowl

# create the table which count the summary or fruits

fruit_bowl_summary <- fruit_bowl %>%
      group_by(Fruits) %>%
      summarise("count"= n())
fruit_bowl_summary


# calculate the proportions

fruit_bowl_summary$proportion <- fruit_bowl_summary$count / sum(fruit_bowl_summary$count)
fruit_bowl_summary$proportion

# add the geom bar using stat to tell the command to plot exact values of proportions

ggplot(fruit_bowl_summary,aes(x=Fruits,y=proportion,fill=Fruits))+
      geom_bar(stat="identity")+
      scale_fill_manual(values=c("red","green","orange"))+
      guides(fill=FALSE)+
      labs(x="Fruits",y="Proportion of Fruits")



cecs <- read_csv("survey data.csv")

dem_rep <- recode(cecs$pid7, `1`="Democrat",`2`="Democrat",`3`="Democrat",
                  `4`="Independent",`5`="Republican",
                  `6`="Republican",`7`="Republican")
table(dem_rep)

cecs <- add_column(cecs, dem_rep)

# stacked bars
ggplot(cecs, aes(x = region, fill = dem_rep)) +
      geom_bar()

ggplot(cecs, aes(x = region, fill = dem_rep)) + 
      geom_bar(position = "dodge")








