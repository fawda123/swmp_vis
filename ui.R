library(shiny)

# Define UI for application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Visualization of combined SWMP data"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    
    selectInput(inputId = 'reserve',
                label = h3('Choose reserve'),
                choices = c('Ashepoo Combahee Edisto Basin',
                  'Apalachicola Bay', 'Chesapeake Bay',                'Delaware',                    
                  'Elkhorn Slough', 'Grand Bay',                    
                  'Great Bay', 'Guana Tolomato Mantanzas',     
                  'Hudson River', 'Jacques Cousteau',             
                  'Jobos Bay', 'Kachemak Bay',                 
                  'Lake Superior', 'Mission Aransas',              
                  'Narragansett Bay', 'North Inlet-Winyah Bay',       
                  'North Carolina', 'Old Woman Creek',              
                  'Padilla Bay', 'Rookery Bay',                  
                  'Sapelo Island', 'San Francisco Bay',            
                  'South Slough', 'Tijuana River',                
                  'Wells', 'Weeks Bay',                    
                  'Waquoit Bay'),
                selected = 'Sapelo Island'),

    uiOutput("reserveControls"),
    
    dateRangeInput("daterange", h3("Date range"),
                   start = "2012-01-01",
                   end   = "2012-12-31", 
                   min   = "2000-01-01", 
                   max   = "2013-12-31"),
    
    checkboxGroupInput(inputId = "wqparms", 
                       label = h3("Parameters"), 
                       choices = list(
                         "Temperature" = 'Temp', 
                         "Salinity" = 'Sal', 
                         "DO" = 'DO_mgl',
                         "Tidal Height" = 'Depth'
                         ),
                       selected = c('Temp'))

  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("simplot", width = "100%")
  )
))