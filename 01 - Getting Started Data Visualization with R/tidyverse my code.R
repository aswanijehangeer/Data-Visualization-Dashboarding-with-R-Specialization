#install.packages("tidyverse")
#library(tidyverse)


data <- read_csv("sample data.csv")

data

class(data)

vignette("tibble")

#if you need to switch back and forth between tibble and dataframe for some reason

#data_dataframe <- as.data.frame(data)
#data_tibble <- as_tibble(data_dataframe)

#droping rows with missing values
data <- drop_na(data)
data

#filtering the data

women <- filter(data,gender == 2)
women

dim(data)
dim(women)

table(data$gender)

women$gender


republican_women <- filter(data,gender == 2 & pid7 > 4)
republican_women

dim(republican_women)
table(republican_women$pid7)


republican_women$gender
republican_women$pid7

head(republican_women)

#selecting certain columns from table

select(republican_women, "educ", "employ")


#combine multiple commands using piping

# x %>% f(y) is the same as f(x, y) 
# y %>% f(x, ., z) is the same as f(x, y, z)

women_republicans_educ_employ <- data %>% filter(gender==2 & pid7>4) %>% select("educ","employ")
women_republicans_educ_employ


#recode variables

party <- recode(data$pid7,`1`="Democrat",`2`="Democrat",`3`="Democrat",`4`="Independent",`5`="Republican",`6`="Republican",`7`="Republican")
party

data$party <- party

#rename variables

test <- rename(data,trump_approval=CC18_308a)

test$trump_approval

data <- test
data$trump_approval


data

#calculate new numeric variables

rec_sen1_01 <- recode(data$CC18_310b,`1`=0,`5`=0,`2`=1,`3`=1,`4`=1)

rec_sen2_01 <- recode(data$CC18_310c,`1`=0,`5`=0,`2`=1,`3`=1,`4`=1)

data$rec_sen1_01<- rec_sen1_01

data$rec_sen2_01<- rec_sen2_01

data <- mutate(data, know_sens = rec_sen1_01 + rec_sen2_01)
data$know_sens



#grouping and summarising data

#ordering rows with column values

sortedbygenderandparty <- data %>% group_by(gender,pid7)
view(sortedbygenderandparty)

sortedbygenderandparty <- data %>% arrange(gender,desc(pid7))
view(sortedbygenderandparty)

#summarise the data

summarise(data, pid7_mean = mean(pid7), mean_faminc = mean(faminc_new))

#we can do the same thing with piping

data %>% summarise(mean_pid7=mean(pid7),mean_faminc=mean(faminc_new))

















