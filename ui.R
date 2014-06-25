# 
#  ui.R
#  
#  Application to allow user to forecast the weight of a chick based on
#  the Diet type being fed and the Time representing the number of days since
#  birth of the chick.
#

shinyUI(fluidPage(
    titlePanel("Chicken Weight"),
    
    sidebarPanel(
        
        helpText("This application uses the ChickWeight data set that records the weight of each chick that was fed with a certain type of diet."),
        helpText("The application will show a plot of the Weight against Time of each chick by Diet type and also plot a linear regression line that best fit the points."),
        helpText("You can use this application to forecast the weight of a chick by choosing the diet type and the chick's number of days since birth."),
        
        selectInput("diet", label="Choose a diet type.", 
                    choices = list("ALL", "1","2", "3", "4"), 
                    selected = "ALL"),
        
        sliderInput("time", label="Choose number of days since birth.", 
                    min = 0, max = 21, value = 21)
        ),
    
    mainPanel(
        plotOutput("main_plot"),
        htmlOutput("text1")
        )
    
))
