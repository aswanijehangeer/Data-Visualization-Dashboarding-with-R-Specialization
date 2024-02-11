library(tidyverse)

cces <- drop_na(read_csv("Cces data.csv")) 
cel <- drop_na(read_csv("Cel Election Data.csv"))


#Variations on Scatterplots
#Add a best-fit line with geom_smooth

ggplot(cces, aes(x = educ, y = ideo5))+
      geom_jitter()

# geom_smooth will add the default loess line to the scatterplot

ggplot(cces, aes(x = educ, y = ideo5))+
      geom_jitter()+
      geom_smooth() # default loess line

# linear regression best fit line

ggplot(cces, aes(x = educ, y = ideo5))+
      geom_jitter()+
      geom_smooth(method = "lm") #linear regression line

#changing confidence interval

ggplot(cces, aes(x = educ, y = ideo5))+
      geom_jitter()+
      geom_smooth(method = "lm", level = 0.9) # CI = 0.9

#install.packages("GGally")
library(GGally)

# making a fake data, two variables will be positively related, one negatively

var1 <- runif(100, 0, 1)
var2 <- var1 + rnorm(100, 0, 0.2)
var3 <- var1 * (-rnorm(100, 0, 0.2))


data <- tibble(var1, var2, var3)


ggpairs(data)


# correlatioplot

#install.packages("ggcorrplot")
library(ggcorrplot)
library(ggthemes)

# data from cces data
data1 <- cces %>% select("educ", "pid7", "pew_religimp")
#calculating correlations cofficients
correlation <- cor(data1, use = "complete.obs")

ggcorrplot(correlation)

ggcorrplot(correlation, type = "lower")

#some visual modification

ggcorrplot(correlation, type = "upper",
           title = "Correlations",
           colors = c("black", "yellow", "blue"),
           outline.color = "purple")

#using ggtheme

ggcorrplot(correlation, type = "lower",
           title = "Correlations", 
           ggtheme = theme_wsj())

#Cleveland dotplots

cel_114 <- cel %>% filter(congress == 114)
members <- sample_n(cel_114, 10)

ggplot(members, aes(x = les, y = thomas_name))+
   geom_point()

#some refinements to the plot

ggplot(members, aes(x = reorder(thomas_name, les), y = les))+
   geom_point(size = 3)+
   theme(panel.grid.major.x=element_blank(),
         panel.grid.minor.x=element_blank(),
         panel.grid.major.y=element_line(linetype="dashed",color="blue"))+
   labs(x="Legislative Effectivness",y="")

   
#Lollipop figures

ggplot(members,aes(x=reorder(thomas_name,les),y=les))+
   geom_point()+
   geom_segment(aes(x=thomas_name,xend=thomas_name,y=0,yend=les))+
   theme(axis.text.x=element_text(angle=90))


# Some temporal figures

# geom_aera function

var1 <- runif(10, 0, 25)
time <- seq(1:10)

data2 <- tibble(var1, time)

ggplot(data2, aes(x = time, y = var1, fill = "red"))+
   geom_area()+
   guides(fill = FALSE)


# Stacked line plot
# fake data for three different peoples at three different times

jahangir <- tibble(person = rep("jahangir",5), time = seq(1:5), change = runif(5,0,25))
arsu <- tibble(person = rep("arsu",5), time = seq(1:5), change = runif(5,0,25))
saraj <- tibble(person = rep("saraj",5), time = seq(1:5), change = runif(5,0,25))

data3 <- bind_rows(jahangir, arsu, saraj)
#stacked plot
ggplot(data3, aes(x = time, y = change, fill = person))+
   geom_area()

data3_wide <- data3 %>%
   pivot_wider(id_cols=time,values_from=change,names_from=person)

#Stacked area adds upto totals

data3_wide$total <- 
   data3_wide$jahangir + data3_wide$arsu + data3_wide$saraj
data3_wide$total

# Dumbell charts

# install.packages("ggalt")
library(ggalt)

#Reformat the data from stacked plot, here we are comparing times at 1 and 5 for persons

data4 <- data3 %>%
   filter(time == 1 | time == 5) %>%
   pivot_wider(names_from = time, values_from = change) %>%
   rename(year1 = '1', year5 = '5')

# Basic Dumbell plot

ggplot(data4, aes(y = person, 
                  x = year1,
                  xend = year5)) + geom_dumbbell()
# changing colors and sizes

ggplot(data4, aes(y = reorder(person, year1), x =year1, xend = year5))+
   geom_dumbbell(colour_x = "red",
                 colour_xend = "black",
                 size_x = 3, 
                 size_xend = 3)+
   labs(title = "Jahangir, Arsu and Saraj", x = "", y = "Persons")
      
      
# alluvial diagrams

# install.packages("ggalluvial")
library(ggalluvial)

group1 <- tibble(groupid = groupid <- rep("group1", 7),
                 studentID = sample(seq(from= 1, to= 20), 7),
                 gender = sample(c("M", "F"), 7, replace = TRUE),
                 grades = sample(c("High Pass", "Pass", "Fail"), 7, replace = TRUE))


group2 <- tibble(groupid = groupid <- rep("group2", 7),
                 studentID = sample(seq(from= 21, to= 30), 7),
                 gender = sample(c("M", "F"), 7, replace = TRUE),
                 grades = sample(c("High Pass", "Pass", "Fail"), 7, replace = TRUE))

group3 <- tibble(groupid = groupid <- rep("group3", 7),
                 studentID = sample(seq(from= 31, to= 40), 7),
                 gender = sample(c("M", "F"), 7, replace = TRUE),
                 grades = sample(c("High Pass", "Pass", "Fail"), 7, replace = TRUE))


Students = bind_rows(group1, group2, group3)

# summarizing the data

Students_table <- Students %>%
   group_by(groupid, gender, grades) %>%
   count()

# bareones alluvial

ggplot(Students_table, aes(axis1 = groupid, axis2 = grades, y = n))+
   geom_alluvium() +
   geom_stratum() +
    geom_text(stat = "stratum", aes(label = after_stat(stratum))) # Labels

# Colors

ggplot(Students_table, aes(axis1 = groupid, axis2 = grades, y = n))+
   geom_alluvium(aes(fill = gender)) +
   geom_stratum() +
   geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
   scale_fill_manual(values = c("purple", "green"))


# Packed Circle Figures

#install.packages("packcircles")
library(packcircles)



cel_114 <- cel %>% filter(congress == 114)
members <- sample_n(cel_114, 25)
     
#circleProgressiveLayout automatically creates a data frame with x and y centers
#for circles and radii, based on the values for the data you feed it.
     
packing <- circleProgressiveLayout(members$all_pass, sizetype = "area")      
      
members <- add_column(members, packing)

#Provides more points for ggplot to draw the perimeters of the circles
dat.gg<-circleLayoutVertices(packing,npoints=50)

ggplot()+
   geom_polygon(data = dat.gg, 
                aes(x = x, y = y, group = id, fill = as.factor(id),alpha = 0.6))+
   geom_text(data = members, aes(x = x, y = y, size = all_pass, label = thomas_name))+
   theme(legend.position = "none")+
   coord_equal()


# Pie charts

pieee <- c(9,4,6,7,8)

pie(pieee)
