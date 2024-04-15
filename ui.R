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
library(tidyverse)
tobaccoData <- read_csv("Youth_Tobacco_Survey__YTS__Data.csv")


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
    
    #Youth Tobacco Plot
    titlePanel("Tobacco Use Between High School & Middle School"),
    
    sidebarLayout(
      sidebarPanel(
        radioButtons("buttonsTypeUse",  "Choose the type(s) of tobacco use:",
                     choices = list("Cigarettes" = 1, "Smokeless Tobacco" = 2), 
                     selected = 1),
        selectizeInput(
          "selectHabit", "How frequent:", 
          choices = list("One or two times" = 1, "20-30 days" = 2, "30+ days" = 3)), 
        
        selectizeInput(
          "selectStates", "Choose 5 states:", 
          choices = unique(tobaccoData$LocationDesc), 
          options = list(maxItems = 5)), 
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("barPlot")
      )
    ),
    
    #Storms Map Plot
    titlePanel("Heat Map Plot of #1 Active Storm"),
    
    sidebarLayout(
      sidebarPanel(
        sliderInput("mapYear", "Choose a year:", min = 1975, 
                    max = 1980, value = 1975),
        selectizeInput(
          "mapStatus", "Choose status of storm:", 
          choices = unique(storms$status))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("mapPlot")
      )
    )
)
