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
                  'Apalachicola Bay', 'Chesapeake Bay', 'Delaware',                    
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
    
    selectInput(inputId = 'year',
                label = h3('Choose year'),
                choices = seq(2001, 2012),
                selected = '2012'),
  
    sliderInput("day", label = h3("Choose day range"),
        min = 1, max = 365, value = c(1,365)),
    
    checkboxGroupInput(inputId = "wqparms", 
                       label = h3("Parameters"), 
                       choices = list(
                         "Temperature" = 'Temp', 
                         "Conductivity" = 'SpCond',
                         "Salinity" = 'Sal', 
                         "DO saturation" = 'DO_pct',
                         "DO" = 'DO_mgl',
                         "Tidal Height" = 'Depth',
                         "pH" = 'pH', 
                         "Turbidity" = 'Turb',
#                          "Chl Fluorescence" = 'ChlFluor',
                         "Air temperature" = 'ATemp', 
                         "Relative humidity" = 'RH',
                         "Pressure" = 'BP'
                         ),
                       selected = c('Temp', 'SpCond', 'Sal', 'DO_pct', 
                         'DO_mgl', 'Depth', 'pH', 'Turb', #'ChlFluor', 
                         'ATemp', 'RH', 'BP'))

  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("simplot", width = "100%")
  )
))