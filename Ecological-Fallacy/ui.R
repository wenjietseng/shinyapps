# ui.R
library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Ecological Fallacy"),
    sidebarPanel(
      radioButtons("Level", label = "Choose the level of data",
        choices = list("student", "school", "region"),
        selected = "student")
    ),
    mainPanel(
      plotOutput("plot.out")
    )
  )
)