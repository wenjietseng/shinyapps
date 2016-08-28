# ui.R

shinyUI(fluidPage(
  titlePanel("Signal Detection Theory"),
  sidebarLayout(
    sidebarPanel(
	sliderInput("d", label=h4("d'"), max=3, min=0, value=2, step=0.1),
	sliderInput("c", label=h4("criterion"), max=3, min=-3, value=1, step=0.1),
	sliderInput("sigma_sn", label=h4("sigma of SN"), max=2, min=1, value=1, step=0.1)
    ),

    mainPanel(
      fluidRow(
	  column(7, plotOutput("density_plot")),
	  column(5, plotOutput("ROC_curve"))
	)
    )
  )
))

# 12/9/2015
# delete sigma of N
#	sliderInput("sigma_n", label=h4("sigma of N"), max=3, min=1, value=1, step=0.1)

# 26/9/2015
# remove ROC table
# change the max value of "c", "sigma_sn", "d'"
# adjust density plot and ROC_curve into some row