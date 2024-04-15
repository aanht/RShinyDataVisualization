#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
install.packages("babynames")
library(babynames)
library(tidyverse)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Babynames Over the Years"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput(
              "selectFirstYear", "Choose First Year:",
              min = 1880,
              max = 2017,
              step = 10,
              value = 2017),
            sliderInput(
              "selectSecondYear", "Choose Second Year:",
              min = 1880,
              max = 2017,
              step = 10,
              value = 2017),
            selectizeInput(
              "selectName", "Choose 4 names:", 
              choices = unique(babynames$name[startsWith(babynames$name, "T")][1:10]), 
              options = list(maxItems = 4))
        ),
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("linePlot")
        )
    )
)