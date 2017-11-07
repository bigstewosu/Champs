## Course Project Data Products Coursera
## author: "Dale Stewart"
## date: "Nov. 7, 2017"

## Load Shiny library
library(shiny)
library(datasets)
library(dplyr)
library(ggplot2)
library(scales)

dt <- read.csv("Champions1950.csv")

shinyServer(function(input, output) {
  # We'll render the selected columns of our dataset and will use datatable techniques to filter and search data
  output$Details <- renderDataTable({
    # We need the selected text e.g.; state name from ui.R
    output$league <- renderText({ 
    })
    # Read our dataset
    dt <- read.csv("Champions1950.csv")
    # filter based on the league selected
    dt_league <- filter(dt, League == input$league)
    # fill datatable based on the years selected
    dt_state_league <- filter(dt_league, Year >= input$year[1] & Year <= input$year[2])
    final_data <- dt_state_league %>% group_by(State) %>% tally(sort=TRUE)
    final_data2 <- final_data %>% rename(Championships = n)
    final_data2
    # Implement page wise menu
  }, options = list(lengthMenu = c(5, 10, 20), pageLength = 10))
  
  # Finally lets use ggplot2 to demonstrate a horizontal bar chart to show the states
  output$plot1 <- renderPlot({
    dt <- read.csv("Champions1950.csv")
    # filter based on the league selected
    dt_league <- filter(dt, League == input$league)
    # fill datatable based on the years selected
    dt_state_league <- filter(dt_league, Year >= input$year[1] & Year <= input$year[2])
    final_data <- dt_state_league %>% group_by(State) %>% tally(sort=TRUE)
    final_data2 <- final_data %>% rename(Championships = n)
    final_data2
    title <- paste("Championships won by State from", input$year[1], "-", input$year[2])
    g <- ggplot(data=final_data2, aes(x=reorder(State, Championships), y=Championships)) + 
      geom_bar(stat = "identity") +
      coord_flip() +
      labs(x = "State", y = "Championships", title = title) +
      theme(
        plot.title = element_text(face="bold", hjust = 0.5)
      )
    
    print(g)
    
    
  })
})