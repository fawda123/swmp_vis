source('vis_funs.r')

meta <- read.table('sampling_stations.txt', header = T, sep = ',')

require(ggplot2)
require(scales)
require(gridExtra)
require(reshape2)
require(RColorBrewer)

# Define server logic required to generate and plot data
shinyServer(function(input, output) {
  
  # dynamic controls
  # outputs list of sites for each reserve in ui
  output$reserveControls <- renderUI({
    
    # sites, subsetted by those in ~/swmp/
    sites <- get_map_meta(input$reserve, full = T)
    codes <- sites$Station.Code
    codes <- codes %in% gsub('.RData','',dir('swmp'))
    sites <- unique(sites$Station[codes])
    
    checkboxGroupInput("sites", h3("Choose sites"), sites)
    
    })
  
  # plots
  output$simplot <- renderPlot({

#     # debugging
#     input <- list(
#       daterange = c('2012-01-01', '2012-12-31'),
#       reserve = 'Ashepoo Combahee Edisto Basin',
#       sites = c('Big Bay', 'St. Pierre'),
#       wqparms = c('Temp', 'Sal', 'DO_mgl', 'Depth')
#       )
    
    # input controls
    dates <- input$daterange
    parms <- input$wqparms
    reserve <- input$reserve
    sites <- input$sites
    
    # site metadata from reserve and site inputs
    site_meta <- get_map_meta(reserve, full = T)
    site_meta <- site_meta[site_meta$Station %in% sites, ]
    
    # load data
    files <- unique(site_meta$Station.Code)
    for(fil in files) load(paste0('swmp/', fil, '.RData'))
    dat <- sapply(files, function(x) get(x), simplify = F)
    dat <- do.call('rbind', dat)
    
    # subset data by daterange and input params
    # add column for site
    dat <- dat[dat$Date >= dates[1] & dat$Date <= dates[2], ]
    dat <- dat[, c('DateTimeStamp', parms)]
    dat$sites <- gsub('.[0-9]*$', '', row.names(dat))
    
    # prep for plotting
    to.plo <- melt(dat, id.var = c('DateTimeStamp', 'sites'))
    
    # plot
    p1 <- ggplot(to.plo, aes(x = DateTimeStamp, y = value)) +
      geom_line() + 
      facet_wrap(sites ~ variable, scales = 'free_y', ncol = 1) +
      theme_bw()
    
    print(p1)
    
    },height = 700, width = 700)
  
})