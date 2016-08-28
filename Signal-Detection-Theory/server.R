# server.R

shinyServer(function(input, output){

  # plot the distribution of the S+N and N
  output$density_plot <- renderPlot({
    curve(dnorm(x, 0, 1), xlim=c(-3.2, 8.5), ylim=c(0, .55),
		xlab="Perceptual dimension", ylab="Probability")
    legend("topright", legend=c("SN", "N"), lty=c(2, 1))
    abline(h=0, col="gray31")  
    curve(dnorm(x, input$d, input$sigma_sn), lty=2, add=T)


    #
    z_n <- seq(from=input$c, to=pi, length=50)
    polygon(x=c(input$c, z_n, pi),
		y=c(0, dnorm(z_n), 0),
		col=rgb(70/255, 130/255, 180/255, .85), border=NA)
    #
    z_sn <- seq(from=input$c, to=2*pi+input$d, length=100)
    polygon(x=c(input$c, z_sn, input$d+2*pi),
		y=c(0, dnorm(z_sn, input$d, input$sigma_sn), 0),
		col=rgb(135/255, 206/255, 235/255, 0.35), border=NA)
    lines(x=c(input$c, input$c), y=c(0, .5), col="pink3", lwd=2)
    text(input$c, 0.52, "c")
    segments(0, 0.42, input$d, 0.42)
    segments(0, 0, 0, 0.43, lty=3)
    segments(input$d, 0, input$d, 0.43, lty=3)
    text(input$d/2, 0.44, "d'")
  })
  
  # plot the ROC curve
  output$ROC_curve <- renderPlot({
    c_points <- seq(-3, input$d + 3, by=0.01)
    pF <- 1 - pnorm(c_points, 0, 1)
    pH <- 1 - pnorm(c_points, input$d, input$sigma_sn)

    # ROC curve
    par(pty="s")
    plot(pF, pH, type="l", xlim=c(0, 1), ylim=c(0, 1),
	   main="ROC curve", xlab="False alarm rate", ylab="Hit rate")
    grid()
    abline(a=0, b=1, lty=2)

    # plot criterion
    Hc <- 1 - pnorm(input$c, input$d, input$sigma_sn)
    FAc <- 1 - pnorm(input$c, 0, 1)
    segments(FAc, 0, FAc, Hc, col="skyblue", lwd=2)
    segments(0, Hc, FAc, Hc, col="steelblue", lwd=2)
    points(FAc, Hc, pch=19, col="pink3", cex=1.25)
  })
})

# 12/9/2015
# delete sigma of N

# 26/9/2015
# remove ROC table
# add vertical(cyan) and horizontal(darkorange) lines
# add areas which corresponding to both lines
# revise labels
###
# set up a data table to store probability values
#Response <- c("Yes", "No")
#Stimuli <- c("N", "SN")
#sr <- matrix(0, 2, 2)
#dimnames(sr) <- list(Response, Stimuli)
#
# show the probability of the SDT model
#  output$SR_table <- renderTable({
#    H <- 1 - pnorm(input$c, input$d, input$sigma_sn)
#    FA <- 1 - pnorm(input$c, 0, 1)
#    M <- pnorm(input$c, input$d, input$sigma_sn)
#    CR <- pnorm(input$c, 0, 1)
#    sr[] <- c(FA, CR, H, M)
#    return(sr)
#  })