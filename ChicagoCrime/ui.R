library(shiny)

# Values to go in the Crime Selection Box
districts = c("District 1", "District 2", "District 3", "District 4",
    "District 5", "District 6", "District 7", "District 8", "District 9",
    "District 10", "District 11", "District 12", "District 13", "District 14",
    "District 15", "District 16", "District 17", "District 18", "District 19",
    "District 20", "District 21", "District 22", "District 23", "District 24",
    "District 25", "District 31")

shinyUI(fluidPage(
    # Application title
    titlePanel("Yearly Crime Data for Chicago"),

    p("This data comes from Cogence, and can be found at this ", a("Cogence Link", href="https://www.cogence.io/data-set/crimes-2001-to-present-by-city-of-chicago/4/"), ".  It has been changed from individual data points to a summary by the script DataTransformations.R, available on GitHub."),

    # Show a plot of the generated distribution
    sidebarLayout(
        sidebarPanel(
            h4("Years to Examine"),
            p("Select which years look at.  By narrowing the number of years you can zoom in on changes in the trends."),
            sliderInput("years", "", min = 2001, max = 2016, value = c(2001, 2016), sep = ""),
            h4("Select Districts to Examine"),
            p("Narrow the data geographically by selecting the districts (a map of the districts is ", a("here", href="http://gis.chicagopolice.org/pdfs/district_beat.pdf" )),
            checkboxGroupInput("district", "", districts, selected = districts, inline = TRUE)
        ),
        mainPanel(
            p("The graph shows the year-by-year trend of total criminal activity in Chicago for the given time period.  There is data for the year 2017 but it is removed since there is only 2 months of data available."),
            plotOutput("crimePlot")
        )
    ),
    h2("Percentage of Charges by District"),
    tableOutput("percentTable")
))
