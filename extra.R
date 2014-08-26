# add date, year, jday columns to each swmp site

files <- dir('swmp')

for(fil in files){
  
  cat(fil, '\n')
  
  load(paste0('swmp/', fil))
  nm <- gsub('.RData', '', fil)
  
  dat <- get(nm)
  
#   dat$Date <- as.Date(dat$DateTimeStamp)
  
  dat$Year <- as.numeric(format(dat$DateTimeStamp, '%Y'))
  dat$jday <- as.numeric(format(dat$DateTimeStamp, '%j'))
  
  assign(nm, dat)
  
  save(list = nm, file = paste0('swmp/', fil))
  
  rm(list = nm)
  
  }