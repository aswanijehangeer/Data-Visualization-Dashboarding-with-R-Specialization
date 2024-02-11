#Importing Data in R

#Import CSV File
# I do not specified full path here bcz right now this file is in my working directory
sample <- read.csv("sample data.csv")

sample
# Write CSV

View(sample)

class(sample)

median(sample$pew_religimp,na.rm=T)

table(sample$race)


