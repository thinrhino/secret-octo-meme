library(shiny)
library(ggplot2)
library(reshape2)
source("helper.R")

shinyServer(function(input, output) {
    dataset <- reactive({
        agg.by = eval(parse(text=paste("data$",
                                       input$x,
                                       sep = "")))
        agg.data <- aggregate(cbind(data$RSPM.2006,
                                    data$RSPM.2007,
                                    data$RSPM.2008),
                              by = list(agg.by),
                              FUN = "mean")
        colnames(agg.data) <- c(input$x, '2006', '2007', '2008')
        data.melt <- melt(agg.data, id=input$x)

        return(data.melt)
    })

    output$plot <- renderPlot({
        a <- input$x

        p <- ggplot(dataset(),
                    aes(x = eval(parse(text=a)),
                        y = value,
                        group = variable))

        p <- p + geom_line(aes(color = variable))
        print(p)
    })
})
