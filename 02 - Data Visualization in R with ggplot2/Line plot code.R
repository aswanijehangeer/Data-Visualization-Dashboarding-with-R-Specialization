library(tidyverse)

# creating a sequence of years
years <- seq(from = 2001, to = 2020, by = 1)

price <- rnorm(20, mean = 15, sd = 5)

# put years and price together in tibble

fig_data <- tibble("year" = years, "stock_price" = price)

ggplot(fig_data, aes(x= years, y= price))+
      geom_line()


#Now, making data for two stocks

fig_data$stock_id <- rep("stock_1", 20)

stock_1_time_series <- fig_data

 view(fig_data)

 # creating data for second company
 
stock_id <- rep("stock_2", 20) 
price1 <- rnorm(20, mean = 12, sd = 6) 
years1 <- seq(from = 2001, to = 2020, by = 1)

stock_2_time_series <- tibble("stock_id" = stock_id, "year" = years1, "stock_price" = price1)

all_stock_time_series <- bind_rows(stock_1_time_series,stock_2_time_series)

view(all_stock_time_series)

# making the line plot setting group to stock_id
ggplot(all_stock_time_series, 
      aes(x = year, y = stock_price, group = stock_id)) +
      geom_line()

# modify line plot, line type, color, facet wrap

ggplot(all_stock_time_series, 
      aes(x = year, y = stock_price, group = stock_id, linetype = stock_id, color = stock_id)) +
      geom_line() + 
      facet_wrap(~stock_id)


# lets practise with another datset

cel <- read_csv("CELL DATA.csv")

cel$Party <- recode(cel$dem,`1`="Democrat",`0`="Republican")

fig_data <- cel %>% 
      group_by(Party,year) %>% 
      summarize("Ideology"=mean(dwnom1,na.rm=T))

View(fig_data)

ggplot(fig_data,(aes(x=year,y=Ideology,group=Party,color=Party)))+
      geom_line()+
      scale_color_manual(values=c("blue","red"))



