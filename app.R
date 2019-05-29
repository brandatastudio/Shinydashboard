
library(shiny)
library(ggplot2)
library(rsconnect)

rsconnect::setAccountInfo(name='brandatastudio',
                          token='E0109646B9A418B94E6AA2C873BE47F2',
                          secret='bjuzjSjdMNPa3QCO72A/hT8VbsXznqOcxWkkqI8G')


#setwd("C:/Users/stefano/Dropbox/Aprendizaje util/Programacion learning/practicaviz/visualization-practica")
datawind <- read.csv2(file="datawind.csv", header=TRUE, sep=",")



dataset <- na.omit(datawind)
dataset[sapply(dataset, is.null)] <- NaN


ui <- fluidPage(
  
  title = "Wind data for USA",
  # Sidebar with a slider input
  
  sidebarLayout(
    
    
    sidebarPanel(
      selectInput(inputId= "info", label= "info of interest to appear on bar",
                  choices= colnames(dataset[-1])
      ),selectInput(inputId= "infofill", label= "info of interest to fill the bars",
                    choices= colnames(dataset[-1]))),
                 mainPanel(plotOutput("info_to_plot"))
    ) 
  )
  
  
  
  server <- function(input, output) {
    output$info_to_plot <- renderPlot({
      ggplot(dataset,aes(x = dataset[["State"]], y = dataset[[input$info]], fill = dataset[[input$infofill]])) +  geom_bar( stat = "identity"  , width = 0.5 ) + 
        xlab(colnames(dataset["State"])) + ggtitle(colnames(dataset[input$info]))  + 
        labs(fill = colnames(dataset[input$infofill])) +
        geom_text(stat = 'summary', fun.y = sum, angle = 90, hjust = -.05, size = 2, aes(label = dataset[["State"]])) +
        theme(axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.title.y = element_blank(),
              panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(),
              panel.background = element_blank(), axis.line = element_line(colour = "black")) +
        coord_cartesian(expand = TRUE)
      
    })
  }
  
  shinyApp(ui = ui, server = server)
  
  

  