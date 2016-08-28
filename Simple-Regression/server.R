# server.R
library(shiny)
library(alr3)

# standardize data
s_dau <- scale(heights$Dheight)
s_mot <- scale(heights$Mheight)

# least-squares fitting
fit <- lm(s_dau ~ s_mot)
r_opt <- as.numeric(coef(fit)[2])
ls_opt <- anova(fit)[2, 2]

LS <- function(r){
  dau_hat <- s_mot * r
  return(sum((s_dau - dau_hat) ^ 2))
}

#
shinyServer(function(input, output){
  output$reg <- renderPlot({
    # plot curves
    par(pty="s")
    plot(s_mot, s_dau, xlab="Mother's height(standardized)",
			     ylab="Daughter's height(standardized)",
	   		     main="Regression plot", cex=0.6, pch=16)
    curve(r_opt * x, col="forestgreen", lwd=3, add=T)
    curve(input$r_cus * x, lty=2, col="indianred", lwd=3, add=T)
  })

  output$Res <- renderPlot({
    fit_val <- input$r_cus * s_mot
    res <- fit_val - s_dau
    par(pty="s")
    plot(res ~ fit_val, pch=".", cex=3,
	   xlim=c(-4, 4), ylim=c(-6, 6), main="Residual plot",
	   xlab="fitted daughter's height", ylab="Residuals")
    abline(h=0, lty=2)
    grid(nx=NA, ny=NULL)
  })

  output$LS <- renderPlot({
    # compute custom RSS
    ls_cus <- LS(input$r_cus)

    # draw parabolar
    ls_points <- sapply(seq(-1.45, 1.5, by=0.05), LS)
    par(pty="s")
    plot(seq(-1.45, 1.5, by=0.05), ls_points, type="l", col="gray", lwd=2,
         xlim=c(-1.4, 1.4), ylim=c(ls_opt - 500, 4500),
	   xlab="Estimated value of slope coefficient",
	   ylab="Residual sum of squares",
	   main="Least Squares Plot")
    abline(h=1043.147)
    abline(v=0.491)
    points(input$r_cus, ls_cus, col="indianred", pch=19)
    abline(h=ls_cus, lty=2)
    abline(v=input$r_cus, lty=2)
    grid()
  })
})

#    text(input$r_cus, ls_cus, 
#	   labels=paste("r=", input$r_cus,"\nRSS=", round(ls_cus, 3), sep=""),
#	   pos=3, cex=.9)
#    points(r_opt, ls_opt, col=4, pch=19)
#    text(r_opt, ls_opt, labels="r=0.491\nRSS=1043.147", pos=1)
