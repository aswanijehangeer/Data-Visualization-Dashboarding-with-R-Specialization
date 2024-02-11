library(shiny)
library(tidyverse)


dat <- read_csv("cces_sample_coursera.csv")

dat <- dat %>% select(c("pid7","ideo5"))


ui <- fluidPage(
      
      sidebarLayout(
            
            sidebarPanel(
                  
                  sliderInput("my_party",
                              
                              "Select Five Point Ideology (1 = Very liberal, 5 = Very conservative", 
                              
                              value = 1, 
                              
                              min = 1, 
                              
                              max = 5)), 
            
            
            
            mainPanel(
                  
                  plotOutput("partyPlot") 
                  
            )
            
      )
      
)

server <- function(input, output) {
      
      
      
      output$partyPlot <- renderPlot({
         
         dat1 <- filter(dat, ideo5 == input$my_party)
         
         ggplot(dat1, aes(x = pid7,
                          
                          group = ideo5)) + 
            
            geom_bar() + 
            
            xlab("7 Point Party ID, 1 = Very D, 7 = Very R") + 
            
            ylab("Count") + 
            
            xlim(0, 8)
         
            
            
            
            
      })
      
}

shinyApp(ui = ui, server = server)