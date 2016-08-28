# server.R

library(gplots)
set.seed(2000)
shinyServer(function(input, output){
  output$Plot <- renderPlot({
    y <- rnorm(input$n, 100 + input$diff, 15)
    set.seed(1)
    x <- rnorm(input$n, 100, 15)
    grp <- as.factor(rep(c(1, 2), c(input$n, input$n)))
    dta <- data.frame(iq=c(x, y), grp=grp)
    result <- t.test(x, y)

    par(mfrow=c(1, 2))
    #
    plotmeans(iq ~ grp, data=dta, xlab="Group", ylab="IQ Score",
		  ylim=c(80, 125))
    abline(h = mean(x), lty=2, col="indianred")
    abline(h = mean(y), lty=2, col="indianred")
    #
    plot(0, mean(x - y), type="p", ylim=c(-30, 30),
	   xlab="Difference of means", ylab="", bty="n",
	   xaxt="n", pch=16, col="indianred")
    abline(h=0, col="darkgray", lty=2)
    lines( c(0, 0), result$conf.int, col="indianred")
    grid(nx=NA, ny=NULL)
    legend('topleft', legend=paste('p-val=', round(result$p.val, 3), sep=""),
	     horiz=T, bg="gray80")
  })
})

#10/15
#x <- seq(-.5, 1.5, by = .1)
#plot(x ~ rep(1,length(x)), bty="n", xaxt="n", ylim = c(-3,3), type="n",
#     xlab = "", ylab = "Difference of means")
#lines(rep(1,length(x)), x, col="peru")
#abline(h=0, lty=2, col="darkgray")

# 12/9/2015
# remove significance level
# 27/9/2015
# Change the label for y-axis to "IQ score" (left panel) 
# Change the label for x-axis to "Difference of two means" 
# indicate the p-value on the CI panel. 
# flip the two panels (left to right and right to left). 
