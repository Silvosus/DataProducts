library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    # read in the data
    crime <- read.csv("Crime_Counts.csv")

    # operate on this to get reactive table space
    c2 = reactive({
        crime[crime$Year >= input$years[1] & crime$Year <= input$years[2] & crime$District %in% input$district, ]
    })

    # this is the main element - the graph
    output$crimePlot <- renderPlot({
        ggplot(c2(), aes(x = Year, y = Total, colour = District)) + geom_line()
    })

    # now we add the table
    output$percentTable <- renderTable({

        # finds the percentage of incidence per district vs city-wide total
        distpercs = function(cr) {
            # find the total number of incidences
            totalCr = sum(c2()[cr])

            # determine the
            distCr = sapply(sort(unique(c2()$District)),
                       function(x){
                           sum(c2()[c2()$District == x, which(names(c2()) == cr)])
                       }
                )

            # return the percentages of the incidences by district
            paste(round((distCr/totalCr) * 100), "%")
        }

        # make and return the data frame
        data.frame(District = factor(sort(unique(c2()$District))),
                   Overall = distpercs("Total"),
                   Arson = distpercs("Arson"),
                   Assualt = distpercs("Assualt"),
                   Drugs = distpercs("Narcotics"),
                   Homicide = distpercs("Homicide"),
                   Kidnapping = distpercs("Kidnapping"),
                   Robbery = distpercs("Robbery")
                  )
    },
        align = 'c'
    )


})
