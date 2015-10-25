
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

library(rCharts)

rsector <- c( "aluminium, alumina, bauxite" = "aluminium, alumina, bauxite", "coal" = "coal", "copper"="copper" , "gold" ="gold" , "infrastructure" = "infrastructure" , "iron ore" ="iron ore",  "lead, zinc, silver"="lead, zinc, silver" , "lng, gas, oil" ="lng, gas, oil", "nickel"="nickel" , "other commodities" = "other commodities", "uranium"="uranium")

shinyUI(
  navbarPage("Australia Resource Projects Data Explorer",
             tabPanel("Visualisation",
                      sidebarPanel(
                        sliderInput("range", 
                                    "Year:", 
                                    min = 2014, 
                                    max = 2021, 
                                    value = c(2015, 2020),
                                    sep =""),
                        
                        checkboxGroupInput('sector', 'Resource Sector', rsector , selected=rsector)
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          
                          # Data by state
                          tabPanel(p(icon("bar-chart"), "By State"),
                                   h4('Number of Projects based on Type category per State', align = "center"),
                                   showOutput("typeCount", "nvd3"),
                                   h4('Number of Projects based on Status category per State', align = "center"),
                                   showOutput("statusCount", "nvd3"),
                                   h4('Projects Costs based on Type category per State', align = "center"),
                                   showOutput("typeCost", "nvd3"),
                                   h4('Projects Costs based on Status category per State', align = "center"),
                                   showOutput("statusCost", "nvd3")  
                                   
                                   
                          ),
                          
                          # Summary data
                          tabPanel(p(icon("map-marker"), "Summary by State"),
                                   
                                   h4(textOutput("projectsByState")),
                                   htmlOutput("projectsPerState"),
                                   
                                   h4(textOutput("costByState")),
                                   htmlOutput("costsPerState")
                                   
                          ),
                          
                          tabPanel(p(icon("line-chart"), "By year"),
                                   h4('Number of Projects by year', align = "center"),
                                   plotOutput("projectsByYear"),
                                   h4('Project Costs by year', align = "center"),
                                   showOutput("costsByYear", "polycharts")
                                   
                          ),                          
                          
                          # Data 
                          tabPanel(p(icon("table"), "Data"),
                                   dataTableOutput(outputId="table"),
                                   downloadButton('downloadData', 'Download')
                          )
                        )
                      )
                      
             ),
             
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("about.md")
                      )
             )
  )
)