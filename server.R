#
#  server.R
#
#  Server side code to plot the weight of the chicken against the Time,
#  a linear regression line and 1 vertical and horizontal line representing
#  the selected number of days since birth and the forecasted weight of the
#  chick.
#

library(shiny)
data(ChickWeight)

shinyServer(
    function(input, output) {

        #
        #  Subset the data set according to the Diet choice.
        #
        df <- reactive({
            if (input$diet == "ALL") {
                ChickWeight
            } else {
                ChickWeight[ChickWeight$Diet==input$diet,]
            }
        })
        
        #
        #  Plot a scatter plot with a linear regression line.
        #  Also plot the horizontal line with respect to Time value 
        #  chosen by the user and then plot a vertical line showing the 
        #  forecasted weight.
        #
        output$main_plot <- renderPlot({
            x <- lm(weight ~ Time, data=df())
            plot(weight ~ Time, data = df(), 
                 main=paste("Chicken Weight over Time for Diet",input$diet),
                 cex.main=1.5, cex.lab=1.2,
                 xlab="Days since birth",
                 ylab="Weight (grams)",
                 pch=20, cex=1.5, col=df()$Diet)
            abline(x, lwd=3, col="purple")
            abline(v=input$time, 
                   col="orange", lwd=2)
            abline(h=round(predict(x, data.frame(Time = input$time))),
                   col="orange", lwd=2)
        })
        
        #
        #  Show the Time chosen by the user and the forecasted weight.
        #
        output$text1 <- renderUI({
            str1 <- p(paste("You have chosen the number of days since birth as ", 
                            input$time),align="center")
            x <- lm(weight ~ Time, data=df())
            str2 <- p(paste("The forecasted weight of the chick is ",
                          round(predict(x, data.frame(Time = input$time))), 
                          "grams."), align="center")
            HTML(paste('<b>', str1, '<br/>', str2, '</b>'))
            
        })
        
    }
)