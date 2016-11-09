# ui.R
library(shiny)
shinyUI(
  fluidPage(
    titlePanel("Ecological Fallacy"),
    sidebarPanel(
      sliderInput("grp",
        label = "Separate dataset into different groups by using varaible,
                 the percentage of students taking the exam",
        min = 4, max = 79, value = c(22, 49), step = 1),
        plotOutput("grp.hist")
    ),
    mainPanel(
      plotOutput("eco.plot")
    )
  )
)