
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Plotting 
library(ggplot2)
library(rCharts)
library(ggvis)

# Data processing libraries
library(data.table)
library(reshape2)
library(dplyr)
suppressPackageStartupMessages(library(googleVis))

# Required by aboutMarkdown
library(markdown)



# Load data processing functions
# source("dataprocess.R", local = TRUE)
#options(datatable.optimize = 1)

# Load data 
dt <- fread('./data/AUProjects.csv') %>% mutate(SECTOR = tolower(SECTOR))
dt$YEAR <- as.numeric(dt$YEAR)
sector <- sort(unique(dt$SECTOR))

rsector <- c( "aluminium, alumina, bauxite" = "aluminium, alumina, bauxite", "coal" = "coal", "copper"="copper" , "gold" ="gold" , "infrastructure" = "infrastructure" , "iron ore" ="iron ore",  "lead, zinc, silver"="lead, zinc, silver" , "lng, gas, oil" ="lng, gas, oil", "nickel"="nickel" , "other commodities" = "other commodities", "uranium"="uranium")

# Shiny server 
shinyServer(function(input, output, session) {
  
  # Define and initialize reactive values
  values <- reactiveValues()
  values$sector <- sector
  
  
  
  # Preapre datasets
  
  # Prepare dataset for maps
  dt.agg <- reactive({
    
    # Filter based on the year selected and the resource sector   
    dt %>% filter(YEAR >= as.numeric(input$range[1]), YEAR <= as.numeric(input$range[2]), 
                  SECTOR %in% input$sector) %>% group_by(STATE) 
    
  })
  
  dt.type.cnt <- reactive( {
    # mydt1 <-  as.data.frame(with(dt.agg(), table(STATE, TYPE)))
    as.data.frame(with(dt.agg(), table(STATE, TYPE)))
  })
  
  dt.status.cnt <- reactive( {
    # mydt2 <-  as.data.frame(with(dt.agg(), table(STATE, STATUS)))
    as.data.frame(with(dt.agg(), table(STATE, STATUS)))
    
  })
  
  dt.type.cst <- reactive( {
    
    mydt3 <- ( dt.agg() %>% select (STATE, TYPE, COST) %>% group_by(STATE, TYPE) %>% melt(id = c("STATE", "TYPE"))
               %>% select(STATE,TYPE, value) %>% group_by(STATE, TYPE) %>% summarise_each(funs(sum), value)
               %>% melt(id = c("STATE", "TYPE")) %>% select (-variable) 
    )
    
    mydt3_sub <- filter(dt.type.cnt(), Freq == 0)
    colnames(mydt3_sub) <- colnames(mydt3)
    
    rbind(mydt3,mydt3_sub)
    
  })
  
  dt.status.cst <- reactive( {
    mydt4 <- (dt.agg() %>% select (STATE, STATUS, COST) %>% group_by(STATE, STATUS) %>% melt(id = c("STATE", "STATUS"))
              %>% select(STATE,STATUS, value) %>% group_by(STATE, STATUS) %>% summarise_each(funs(sum), value)
              %>% melt(id = c("STATE", "STATUS")) %>% select (-variable)
    )
    mydt4_sub <- filter(dt.status.cnt(), Freq == 0)
    colnames(mydt4_sub) <- colnames(mydt4)
    
    rbind(mydt4,mydt4_sub)
  })
  
  
  dt.type.agg <- reactive( {
    dt.agg() %>% select(STATE, TYPE ) %>%  count(STATE)
    
  })
  
  
  
  dt.status.cost <- reactive( {
    
    #we only need to take the costs associated to the status for each state
    mydt5 <- dt.agg() %>% select (STATE, STATUS, COST) %>% group_by(STATE) %>% melt(id = c("STATE", "STATUS"))
    # now prepare for the final output
    mydt5 %>% select(STATE,value) %>% group_by(STATE) %>% summarise_each(funs(sum), value)
    
  })
  
  # Prepare dataset for time series that is by year data
  dt.agg.year <- reactive({
    #   aggregate_by_year(dt, as.numeric(input$range[1]), as.numeric(input$range[2]), input$sector)
    
    # Filter based on the year selected and the resource sector 
    dt %>% filter(YEAR >= as.numeric(input$range[1]), YEAR <= as.numeric(input$range[2]), SECTOR %in% input$sector) %>%
      # Group and aggregate
      group_by(YEAR)    
    
  })
  
  # Prepare dataset for downloads
  dataTable <- reactive({
    
    mydt5 <- dt.agg() %>% select(YEAR, STATE, SECTOR, TYPE, STATUS, COST) %>%group_by(YEAR, STATE)
    #  prepare_downolads(dt.agg())
  })
  
  # Render Plots
  
  output$typeCount <- renderChart({
    
    p1 <- nPlot(Freq ~ STATE, group = 'TYPE', data = dt.type.cnt(), 
                type = 'multiBarChart', dom = 'typeCount')
    # p1$chart(color = c('brown', 'blue', '#594c26', 'green'))
    return(p1)
  })
  
  
  output$statusCount <- renderChart({
    
    p2 <- nPlot(Freq ~ STATE, group = 'STATUS', data = dt.status.cnt(), 
                type = 'multiBarChart', dom = 'statusCount')
    # p2$chart(color = c('brown', 'blue', '#594c26', 'green'))
    return(p2)
  })
  
  output$typeCost <- renderChart({
    
    p3 <- nPlot(value ~ STATE, group = 'TYPE', data = dt.type.cst(), 
                type = 'multiBarChart', dom = 'typeCost')
    # p3$chart(color = c('brown', 'blue', '#594c26', 'green'))
    return(p3)
  })
  
  
  output$statusCost <- renderChart({
    
    p4 <- nPlot(value ~ STATE, group = 'STATUS', data = dt.status.cst(), 
                type = 'multiBarChart', dom = 'statusCost')
    # p4$chart(color = c('brown', 'blue', '#594c26', 'green'))
    return(p4)
  })  
  
  
  
  
  # Projects by State
  output$projectsByState <- renderText({ 
    paste ("Number of Projects per State from Year " , input$range[1], " to " , input$range[2])})
  
  
  output$projectsPerState <- renderGvis({
    
    gvisGeoChart(dt.type.agg(), locationvar = "STATE", colorvar = "n", 
                 options = list(width = 600, height = 600, region = "AU", resolution = "provinces", 
                                displaymode = "regions",colorAxis="{colors:['#fff5eb', '#d94801']}"))
    
  })
  
  output$costByState <- renderText({
    paste("Project Costs per  State from Year " , input$range[1] , " to " , input$range[2])
  })
  
  # by Project Costs  by state
  output$costsPerState <- renderGvis({
    
    gvisGeoChart(dt.status.cost(), locationvar = "STATE", colorvar = "value", 
                 options = list(width = 600, height = 600, region = "AU", resolution = "provinces", 
                                displaymode = "regions",colorAxis="{colors:['#fff5eb', '#d94801']}"))
    
  })
  
  output$projectsByYear <- renderPlot({
    
    p21 <- ggplot(dt.agg(), aes(x = YEAR, y = SECTOR, colour = STATE)) + geom_point(aes(size = COST)) + facet_grid( STATUS ~TYPE) + theme_bw()
    
    
    
    plot(p21)
  })
  
  output$costsByYear <- renderChart2({
    
    p22 <- rPlot(x = 'YEAR', y = factor('SECTOR'), facet= 'TYPE', data = dt.agg(), type = "point", color = "STATE", size = "COST")
    p22$addParams(dom = 'costsByYear')
    #     p22$params$width = 600
    #     p22$params$height = 400
    return(p22)
  })  
  
  # Render data table and create file download handler
  output$table <- renderDataTable(
    {dataTable()}, options = list())
  
  output$downloadData <- downloadHandler(
    filename = 'data.csv',
    content = function(file) {
      write.csv(dataTable(), file, row.names=FALSE)
    }
  )
})
