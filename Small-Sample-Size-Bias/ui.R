# UI
library(shiny)

shinyUI(fluidPage(
  titlePanel("Small sample size bias"),
  sidebarPanel(
    radioButtons("checkG",
      label = h3("sample different size of data"),
      choices = list("10%" = .10,
                     "25%" = .25,
                     "50%" = .50,
                     "75%" = .75,
                     "90%" = .90),
      selected = NULL)
#    checkboxGroupInput("checkG",
#      label = h3("select specific part of data"),
#      choices = list("high score group" = "H",
#                     "low score group" = "L")
  ),
  mainPanel(plotOutput("OutPlot"))
))