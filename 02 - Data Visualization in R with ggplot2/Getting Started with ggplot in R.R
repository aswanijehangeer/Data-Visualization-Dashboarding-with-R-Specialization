# library(tidyverse)

# Loading the DATA

data <- read_csv("CELL DATA.csv")
view(data)
names(data)
dim(data)
table(data$year)
summary(data$all_bills)


# Filter the data

Fig115 <- data %>% filter(congress == 115) %>% select("seniority", "all_pass")  

head(Fig115)

# blank plot, we did not specofy geom function for markings
ggplot(Fig115, aes(x = seniority, y = all_pass )) 

ggplot(Fig115, aes(x = seniority, y = all_pass )) + geom_point()

# we use jitter instead of point, jitter avoid overplotting

ggplot(Fig115, aes(x = seniority, y = all_pass )) + geom_jitter()

# Adding labels and title

ggplot(Fig115, aes(x = seniority, y = all_pass )) + 
      geom_jitter() +
      labs(x = "Seniority", y = "Bill Passed", title = "Seniority and Bill Passed by 115th Congress")

# Modifying filter and select to gram dem for color
Fig115 <- data %>% 
      filter(congress == 115) %>% 
      select("seniority", "all_pass", "dem")

Fig115$dem


ggplot(Fig115, aes(x = seniority, y = all_pass, color = dem)) + 
      geom_jitter() + 
      labs(x = "Seniority", y = "Bill Passed", title = "Seniority and Bill Passed by 115th Congress")



# Colors are strange, lets fix it
# Make dem a categorical variable

party <- recode(Fig115$dem, '1' = "Democrat", '0' = "Republican")
Fig115 <- add_column(Fig115,party)
      
Fig115$party

ggplot(Fig115, aes(x = seniority, y = all_pass, color = party)) + 
      geom_jitter() + 
      labs(x = "Seniority", y = "Bill Passed", title = "Seniority and Bill Passed by 115th Congress")

# lets make the colors traditional for democrat and republicans, blue and red 

ggplot(Fig115, aes(x = seniority, y = all_pass, color = party)) + 
      geom_jitter() + 
      labs(x = "Seniority", y = "Bill Passed", title = "Seniority and Bill Passed by 115th Congress")+
      scale_color_manual(values = c("blue", "red"))



# Make two differnt plots for democrat and republicans by facet wrap function

ggplot(Fig115, aes(x = seniority, y = all_pass, color = party)) + 
      geom_jitter() + 
      labs(x = "Seniority", y = "Bill Passed", title = "Seniority and Bill Passed by 115th Congress")+
      scale_color_manual(values = c("blue", "red"))+
      facet_wrap(~party)


      
      
