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
    
    selectInput(inputId = 'sites',
                label = h3('Choose site'),
                choices = sites)
    
    })
  
  # plots
  output$simplot <- renderPlot({

    # debugging
#     input <- list(
#       year = '2012',
#       day = c('1', '365'),
#       reserve = 'Sapelo Island',
#       sites = c('Hunt Dock'),
#       wqparms = c('Temp', 'Sal', 'DO_mgl', 'Depth')
#       )
    
    # input controls
    year <- input$year
    day <- as.numeric(input$day)
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
    sel_vec <- dat$Year %in% year & dat$jday >= day[1] & dat$jday <= day[2]
    dat <- dat[sel_vec, ]
    dat <- dat[, c('DateTimeStamp', parms)]
    dat$sites <- gsub('.[0-9]*$', '', row.names(dat))
    
    # prep for plotting
    to.plo <- melt(dat, id.var = c('DateTimeStamp', 'sites'))
    
    # plot
    p1 <- ggplot(to.plo, aes(x = DateTimeStamp, y = value)) +
      geom_line() + 
      facet_wrap(~ variable, scales = 'free_y', ncol = 1) +
      theme_bw()
    
    print(p1)
    
    },height = 900, width = 700)
  
})