# server
library(shiny)
library(ggplot2)


dta <- read.table("InData.txt", h = T)

shinyServer(function(input, output) {
  output$OutPlot <- renderPlot({
    dta.sample.num <- sample(row.names(dta),
                             dim(dta)[1] * as.numeric(input$checkG))
    dta.sample <- dta[dta.sample.num, ]
    ggplot(data = dta, aes(x = Number, y = Mathmean)) +
      stat_smooth(data = dta, method = "lm", col = "gray50")+
      labs(x = "Enrollment", y = "Math Score") +
      geom_point(cex = 0.5) +
      stat_smooth(data = dta.sample, aes(x = Number, y = Mathmean),
                  method = "lm", se = F, col = 2, lty = 2) +
      geom_point(data = dta.sample, aes(x = Number, y = Mathmean),
                 cex = 0.5, col = 2) +
      theme_bw()
    
  })
})
#shinyServer(function(input, output){
#  output$OutPlot <- renderPlot({
#    if("H" %in% input$checkG) {
#      if("L" %in% input$checkG) {
#        p <- p + geom_point(col = dta$both)
#        p
#      } else {
#        p <- p + geom_point(col = dta$high)
#        p
#      }
#    } else {
#      if("L" %in% input$checkG) {
#        p <- p + geom_point(col = dta$low)
#        p
#      } else {
#        p <- p + geom_point(col = dta$default)
#        p
#      }
#    }
#  })
#})


#The idea is that the the overall regression line should not be too different from 
#smaller samples by random sampling but would be greatly affected by 
#range restriction (which is kind of like arbitrary sampling). 