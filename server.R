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
        data <- dataset()

        if (a == 'State'){
            p <- ggplot(data,
                        aes(x = State,
                            y = value,
                            group = variable)
                        ) + geom_line(aes(color = variable))
        } else {
            p <- ggplot(data,
                        aes(x = City,
                            y = value,
                            group = variable)
                        ) + geom_line(aes(color = variable))
        }

        p <- p + xlab(a) + ylab('RSPM') + ggtitle(paste('RSPM vs', a, sep = ' ')) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
            geom_point(aes(color = variable)) +
            scale_colour_discrete(name = "Year")
        print(p)
    })
})
