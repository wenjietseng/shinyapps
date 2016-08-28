#server.R
library(shiny)
source("ecological.R")

shinyServer(function(input, output){
  output$plot.out <- renderPlot({
    if (input$Level == "region") region
    else if (input$Level == "school") school
    else student
  })
})