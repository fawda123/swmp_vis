######
# gets station location data for ggmap plotting
# 'val_in' is character string of first chrs of reserve, or five chrs for a site
# 'full' is logical specifying if input is full string for reserve name
# if only reserve is given, all sites are returned
# input is not case-sensitive
# returns appropriate row(s) from sampling_stations.csv
get_map_meta <- function(val_in, full = F){
  
  # station metadata
  if(!exists('meta'))
    meta<-read.table('sampling_stations.txt', header = T, sep = ',')
  
  # subset by active sites 
  stats<-meta[grep('Active*', meta$Status),]
  
  # subset by reserve
  if(full){
    stats <- stats[grep(val_in, stats[, 'Reserve.Name']),]
  } else {
    stats <- stats[grep(paste0(tolower(val_in),'.*wq'), stats[,'Station.Code']),]
  }
  
  stats$Longitude <- -1*stats$Longitude
  stats$Station <- as.character(stats$Station.Name)
  stats$Station.Code <- toupper(substr(as.character(stats$Station.Code),1,5))
  
  return(stats)
  
  }