# add date columns to each swmp site

files <- dir('swmp')

for(fil in files){
  
  cat(fil, '\t')
  
  load(paste0('swmp/', fil))
  nm <- gsub('.RData', '', fil)
  
  dat <- get(nm)
  
  dat$Date <- as.Date(dat$DateTimeStamp)
  
  assign(nm, dat)
  
  save(list = nm, file = paste0('swmp/', fil))
  
  rm(list = nm)
  
  }