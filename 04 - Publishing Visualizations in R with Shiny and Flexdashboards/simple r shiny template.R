library(shiny)

# Define the user interface

ui <- fluidPage(
      
      titlePanel("My First Shiny App"),
      
      textInput(inputId = "my_text", label = "Enter Some Text"),
      
      textOutput(outputId = "print_text")
      
)




server <- function(input, output){
      
      output$print_text <- renderText(input$my_text)
}
      
shinyApp(ui = ui, server = server)      




