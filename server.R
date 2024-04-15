#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(babynames)


function(input, output, session) {
  #Getting inputs, filtering data, graph line plot
  output$linePlot <- renderPlot({
    selected1stYear <- input$selectFirstYear
    selected2ndYear <- input$selectSecondYear
    selectedNames <- input$selectName
    filtered <- filter(babynames, name %in% selectedNames, year >= selected1stYear & year <= selected2ndYear)
    ggplot(filtered, aes(year, prop, color = name)) + geom_line()
    
 
  })
}
