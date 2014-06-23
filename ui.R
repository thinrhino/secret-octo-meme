library(shiny)
library(ggplot2)
library(markdown)
source("helper.R")


shinyUI(fluidPage(

    title = "RSPM Explorer",

    plotOutput('plot'),

    hr(),

    fluidRow(
        column(4,
               selectInput(inputId = 'x',
                           label = 'Aggregate data on City or States',
                           choices = c('State', 'City')
                           )
               ),
        column(7,
               includeMarkdown("instructions.md"))
    )
)
)
