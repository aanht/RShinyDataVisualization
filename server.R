#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

install.packages("babynames")
library(babynames)
library(tidyverse)
library(sf)
library(rnaturalearth)
tobaccoData <- read_csv("Youth_Tobacco_Survey__YTS__Data.csv")

function(input, output, session) {
  #Baby names over the years
  output$linePlot <- renderPlot({
    #Getting inputs
    selectedRange <- input$yearRange
    selectedNames <- input$selectName
    selectedSex <- input$selectSex

    #Filtering data & graph line plot
    filtered <- filter(babynames, name %in% selectedNames, year >= selectedRange[1] & year <= selectedRange[2], sex == selectedSex)
    ggplot(filtered, aes(year, prop, color = name)) + 
      geom_line() + 
      labs(y = "proportion") +
      scale_color_manual(values = c('goldenrod1', 'palegreen4', 'steelblue', 'indianred2')) + 
      theme_bw() + 
      theme(panel.grid.major = element_line(color = "grey", linetype = "dotted"), 
            panel.grid.minor = element_blank(), 
            axis.line.x = element_line(color="black"), 
            axis.line.y = element_line(color="black"))
  })
  
  output$barPlot <- renderPlot({
    selectedType <- input$buttonsTypeUse
    selectedHabits <- input$selectHabit
    selectedStates <- input$selectStates
    
    if (selectedType == 1) {
      selectedType <- "Cigarette Use (Youth)"
    } else {
      selectedType <- "Smokeless Tobacco Use (Youth)"
    }
    
    if (selectedHabits == 1) {
      selectedHabits <- "Ever"
    } else if (selectedHabits == 1) {
      selectedHabits <- "Frequent"
    } else {
      selectedHabits <- "Current"
    }
    
    filtered <- filter(tobaccoData, TopicDesc == selectedType & Response == selectedHabits & LocationDesc %in% selectedStates)
    aggregated_data <- filtered %>%
      group_by(LocationDesc, Education) %>%
      summarise(count = n())
    
    aggregated_data
    ggplot(aggregated_data, aes(x= LocationDesc, y= count, fill = Education)) + 
      geom_col(position = "dodge") + 
      labs(x = "states") +
      theme_bw() + 
      theme(panel.grid.major = element_line(color = "grey", linetype = "dotted"), 
            panel.grid.minor = element_blank(), 
            axis.line.x = element_line(color="black"), 
            axis.line.y = element_line(color="black"))
  })
  
  output$mapPlot <- renderPlot({
    mapYear <- input$mapYear
    mapStatus <- input$mapStatus
    
    usa <- ne_states(country = "United States of America", returnclass = "sf")
    map <- ggplot(data = usa) + geom_sf(fill = "gray95") + coord_sf(xlim = c(-100, -40), ylim = c(10, 52)) + theme_minimal() 
    
    filtered <- filter(storms, status == mapStatus, year == mapYear)
    active <- group_by(filtered, name) %>%
      summarise(active = n()) %>%
      arrange(desc(active))
    activeStorms <- head(active, 1)
    activeStormNames <- filter(storms, name %in% pull(activeStorms, name))
    
    map + geom_tile(data = activeStormNames, aes(x = long, y = lat, color = name, fill = wind), width = 1.4, height = 1.4, alpha = 0.8, linetype = "blank") +
      scale_fill_gradient(low = "lightblue", high = "red", name = "Wind Speed") 
  })
}
