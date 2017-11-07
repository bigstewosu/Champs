## Course Project Data Products Coursera
## Author: "Dale Stewart"
## date: "Nov 7, 2017"
## Build User interface (ui.R), which will control the layout and appearance 

## Load Shiny library
library(shiny)

shinyUI(fluidPage(
  # Application title
  titlePanel("Number of Major Championships per State in 4 Major U.S. Sporting Leagues"),
  br(),
  br(),
  
  
  sidebarPanel(
    helpText("Documentation and Instructions:"),
    helpText("In the input boxes below please choose one of the 4 major sporting leagues in the United States as well as a range of years.  The output on the left will display associated counts for championships won in that state as well as a horizontal bar chart representing the same data."),
    selectInput("league", 
                label = "Choose a league",
                choices = c("NBA", "MLB",
                            "NFL", "NHL"),
                selected = "NBA"),
    
    sliderInput("year", "Year Range:", min = 1950, max = 2017, value = c(1993, 2011), sep = ""),
    
    helpText("Based on the league selection that you have made this page will show you the data and a histogram of the states that have won championships in the time frame selected")),
  br(),
  br(),
  # Call Data table    
  mainPanel(dataTableOutput('Details'),
            # Pass state name
            textOutput("league"),
            br(),
            br(),
            # Plot coliform levels state-wise
            plotOutput("plot1"))
)
)