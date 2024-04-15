#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(babynames)
library(sf)
library(rnaturalearth)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Babynames Over the Years"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        sliderInput("yearRange", "Choose a range of years:", min = 1880, 
                    max = 2017, value = c(1880, 2017)),

        selectizeInput(
          "selectName", "Choose 4 names:", 
          choices = unique(babynames$name[startsWith(babynames$name, "A")][1:10]), 
          options = list(maxItems = 4)), 
        
        selectizeInput(
          "selectSex", "Male or Female:", 
          choices = unique(babynames$sex))
          
      ),
      #Show a plot of the generated distribution
      mainPanel(
          plotOutput("linePlot")
      )
    ),
    
    #Youth Tobacco Map Plot
    titlePanel("Tobacco Use Between High School & Middle School"),
    
    sidebarLayout(
      sidebarPanel(
        radioButtons("buttonsTypeUse",  "Choose the type(s) of tobacco use:",
                     choices = list("Cigarettes" = 1, "Smokeless Tobacco" = 2, "Cessation (want to quit or quit attempted)" = 3), 
                     selected = 1),
        selectizeInput(
          "selectHabit", "How frequent:", 
          choices = list("One or two times" = 1, "20-30 days" = 2, "30+ days" = 3),)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("barPlot")
      )
    )
)
