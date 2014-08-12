setwd('M:/wq_models/SWMP/')

dat <- read.csv('sampling_stations_cln.csv', header = T, stringsAsFactors = F)

dat <- data.frame(apply(dat, 2, trim.trailing), stringsAsFactors = F)
dat$Latitude <- as.numeric(dat$Latitude)
dat$Longitude <- as.numeric(dat$Longitude)
dat$GMT.Offset <- as.numeric(dat$GMT.Offset)

write.table(dat, 'sampling_stations.txt', quote = T,
  row.names = F, sep = ',')

meta <- read.table('sampling_stations.txt', sep = ',', header = T)
