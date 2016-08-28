# ui.R
library(shiny)

shinyUI(fluidPage(
  titlePanel("Simple Regression and Least Squares"),
  fluidRow(
    h4("Simple Regression: Zy = r Zx"),
    sliderInput("r_cus", label="Slope coefficient: r", value=-1,
		    max=1, min=-1, step=0.01)
  ),
  fluidRow(
    column(4, plotOutput("reg")),
    column(4, plotOutput("Res")),
    column(4, plotOutput("LS"))
  )  
))