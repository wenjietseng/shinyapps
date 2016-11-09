# server.R
library(shiny)
library(ggplot2)
library(dplyr)

# load data
dta <- read.table("sat.txt", h = T)
#head(dta)
#str(dta)
names(dta) <- c("state", "expend", "ratio", "salary",
                "frac", "verbal", "math", "sat")

shinyServer(function(input, output) {
  output$grp.hist <- renderPlot({
    if (input$grp[1] == input$grp[2]) {
  	  dta <- mutate(dta, fracf = cut(frac,
  	                     breaks = c(0, input$grp[1], 81),
  	                     labels = c("Low", "High")))
  	} else {
  	  dta <- mutate(dta, fracf = cut(frac,
  	                     breaks = c(0, input$grp[1],
  	                                input$grp[2], 81),
                         labels = c("Low", "Middle", "High")))
    }
    # plot histogram
    ggplot(dta, aes(x = frac, fill = fracf)) +
      geom_histogram(binwidth = 3) +
      labs(x = "Percentage of all eligible students taking SAT",
           y = "Counts") +
      theme_bw() + coord_fixed(ratio = 8) +
      theme(legend.position = c(.9, .88),
            legend.title=element_blank())
  
  })
  output$eco.plot <- renderPlot({
    if (input$grp[1] == input$grp[2]) {
  	  dta <- mutate(dta, fracf = cut(frac,
  	                     breaks = c(0, input$grp[1], 81),
  	                     labels = c("Low", "High")))
  	} else {
  	  dta <- mutate(dta, fracf = cut(frac,
  	                     breaks = c(0, input$grp[1],
  	                                input$grp[2], 81),
                         labels = c("Low", "Middle", "High")))
    }
    # plot ecological fallcy
    ggplot(dta,aes(x = salary,y = sat,label = state,group=fracf)) +
      stat_smooth(method = "lm", se = F, size = rel(.5), 
                  color="grey", lty = 2) +
      stat_smooth(aes(x = salary, y = sat, group = 1), method ="lm", 
                  se = F, color = "gray40", size = rel(0.5)) +
      geom_text(aes(color = fracf), check_overlap = TRUE, 
                show.legend = F, size = 2) +
      labs(x = "Salary ($1000)", y = "SAT Score") + 
      theme_bw()
  	
  })
})