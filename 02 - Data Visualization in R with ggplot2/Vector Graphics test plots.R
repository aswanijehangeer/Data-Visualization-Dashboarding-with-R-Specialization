library(tidyverse)

# Line Plot 

unit <- LETTERS[1:2]
time <- seq(1:10) 

time_series <- expand.grid(unit = unit, time = time)

time_series$variable <- runif(20, 0, 5)

ggplot(time_series, aes(x = time, y = variable, group = unit))+
      geom_line()

# scatter plot

x_axis <- seq(1:10)
y_axis <- runif(10, 0, 5)

scatterdata <- data.frame(X = x_axis, Y = y_axis)

ggplot(scatterdata, aes(x = X, y = Y))+
      geom_point()


# barplot

cases <- letters[1:5]
y_axis1 <- runif(5,0,5)
y_axis2 <- runif(5,0,5)
y_axis3 <- runif(5,0,5)



bardata <- data.frame(cases = cases, y1 = y_axis1, y2 = y_axis2, y3 = y_axis3)

longbardata <- pivot_longer(bardata, c("y1","y2","y3"), names_to = "measure", values_to = "values")


ggplot(longbardata, aes(x = cases, y = values, fill = measure))+
      geom_bar(stat = "identity", position = "dodge")


#setwd(YOUR FILE PATH) -- that's where the files are going to go when you ggsave them

ggsave("lineplot.jpg",plot=line_plot)
ggsave("lineplot.pdf",plot=line_plot)

#to save files as .svg from ggsave

install.packages("svglite")
library(svglite)

ggsave("lineplot.svg",plot=line_plot)


