# ui.R

shinyUI(fluidPage(
  h3("Comparing the difference of two independent means"),
  sidebarLayout(
    sidebarPanel(
	sliderInput("diff", label="Difference of means", value=8, max=15,
			min=-15, step=1),
	sliderInput("n", label="Sample size", value=27, max=50, min=10, step=1)
    ),
    mainPanel(
	plotOutput("Plot")
    )
  )
))

# 12/9/2015
# remove significance level
#	radioButtons("alpha", label="on how much confidence",
#				 choices=c(".90"=.90,
#					     ".95"=.95,
#					     ".99"=.99), selected=.95)
# 27/9/2015
# change title and label
