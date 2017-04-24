library(shiny)
library(tidyverse)

#Sys.setenv(R_GSCMD = "C:\\Program Files\\gs\\gs9.20\\bin\\gswin64c.exe")
source("urban_theme_windows.R")

ui <- fluidPage(
  
  theme = "shiny.css",
  
  h2("Diamonds are Forever"),
  
  h3("Shiny Brownbag"),
  
  plotOutput("plot1"),
  
  sliderInput(inputId = "price", label = "Price", min = 0, max = 20000, value = c(0, 20000), step = 25),
  
  sliderInput(inputId = "carat", label = "Carat", min = 0, max = 5.5, value = c(0, 5.5), step = 0.1),
  
  selectInput(inputId = "element", label = "Element", choices = c("Cut" = "cut",
                                                                  "Color" = "color",
                                                                  "Clarity" = "clarity"))

  )

server <- function(input, output) {
  
  output$plot1 <- renderPlot({
  
    diamonds %>%
      select_("price", "carat", input$element) %>%
      filter(price >= input$price[1] & price <= input$price[2]) %>%
      filter(carat >= input$carat[1] & carat <= input$carat[2]) %>%
      ggplot(aes_string(x = input$element, fill = input$element)) +
        geom_bar() +
        labs(title = "Diamond Plot") +
        scale_y_continuous(expand = c(0, 0))
  
  })
  
  }

shinyApp(ui = ui, server = server)