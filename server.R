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
  #Babynames over the years
  output$linePlot <- renderPlot({
    #Getting inputs
    selected1stYear <- input$selectFirstYear
    selected2ndYear <- input$selectSecondYear
    selectedNames <- input$selectName
    selectedSex <- input$selectSex

    #Filtering data & graph line plot
    filtered <- filter(babynames, name %in% selectedNames, year >= selected1stYear & year <= selected2ndYear, sex == selectedSex)
    ggplot(filtered, aes(year, prop, color = name)) + 
      geom_line() + 
      scale_color_manual(values = c('goldenrod1', 'palegreen4', 'steelblue', 'indianred2')) + 
      theme_bw() + 
      theme(panel.grid.major = element_line(color = "grey", linetype = "dotted"), 
            panel.grid.minor = element_blank(), 
            axis.line.x = element_line(color="black"), 
            axis.line.y = element_line(color="black"))
  })
}
