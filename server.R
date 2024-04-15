#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(babynames)

#Getting inputs and filtering data
function(input, output, session) {
#Render line plot & graph line plot
  output$linePlot <- renderPlot({
    #filteredData <- getInputs()
    selected1stYear <- input$selectFirstYear
    selected2ndYear <- input$selectSecondYear
    selectedNames <- input$selectName
    filtered <- filter(babynames, name %in% selectedNames, year >= selected1stYear & year <= selected2ndYear)
    #ggplot(filtered, aes(year, prop, color = name)) + geom_line() + geom_point()
    
    if (nrow(filtered) == 0) {
      # Print a message if the filtered dataset is empty
      cat("Filtered dataset is empty.")
    } else {
      # Plot line graph if the filtered dataset is not empty
      ggplot(filtered, aes(year, prop, color = name)) + geom_line() + geom_point()
    }
  })
}
