######################
# Packages to install
######################

install.packages("ncdf4")
library(ncdf4)


###################################
# TEMPERATURE EXTRACTION 1901-2014
###################################

# Creating the get_cru function

get_cru <- function(lat, lon, variable, folder){
  CRU <- file.path(folder, sprintf('cru_ts3.23.1901.2014.tmp.dat.nc', variable))
  nc  <-  nc_open(CRU)
  lat.vals<-ncvar_get(nc,varid="lat")
  lon.vals<-ncvar_get(nc,varid="lon")
  days.since<-ncvar_get(nc,varid="time")
  start.time = 1
  
  lat.i  <-  which.min(abs(lat.vals-lat))[1]
  lon.i  <-  which.min(abs(lon.vals-lon))[1]
  
  vals = ncvar_get(nc=nc, varid=variable,start=c(lon.i,lat.i,start.time),count=c(1,1,length(days.since)))
  nc_close(nc)
  
  days.since = as.Date('1900-01-01')+days.since
  df <- data.frame("DateTime"=days.since,"vals"=vals)
  names(df)[2] <- variable
  return(df)
}

setwd("C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project\\test cloud")
data <- read.csv("algal.csv", header=TRUE)
head(data)
summary(data)
### Note --- the 3:4 will change depending on which columns your lat/long values are in
m <- data.frame(cbind(data[3:4]))
m
length(m[,1])
m[104,1]

############################################ 
# Extracting the Data to your data matrix
############################################ 

x=matrix(nrow = length(m[,1]), ncol = 1368)
x[1,] <- t(get_cru(m[1,1],m[1,2], variable = 'tmp', folder = 'C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project\\test cloud'))[2,]
y=matrix(nrow = length(m[,1]), ncol = 1368)
for (i in 1:length(m[,1]))
{
  y[i,]<-t(get_cru(m[i,1],m[i,2], variable = "tmp", folder = "C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project\\test cloud"))[2,]
  print(paste("i = ", i, "lat =", m[i,1], "lon =", m[i,2], "the first element =", x[i,1], "the second element =", y[i,1], sep =" "))
}
y

write.csv(y, file = "cru_temp.csv",row.names=FALSE, na="")




#####################################
# Precipitation EXTRACTION 1901-2014
#####################################

# Creating the get_cru function
# Change data file from above in file.path to the precipitation download

get_cru <- function(lat, lon, variable, folder){
  CRU <- file.path(folder, sprintf('cru_ts3.23.1901.2014.pre.dat.nc', variable))
  nc  <-  nc_open(CRU)
  lat.vals<-ncvar_get(nc,varid="lat")
  lon.vals<-ncvar_get(nc,varid="lon")
  days.since<-ncvar_get(nc,varid="time")
  start.time = 1
  
  lat.i  <-  which.min(abs(lat.vals-lat))[1]
  lon.i  <-  which.min(abs(lon.vals-lon))[1]
  
  vals = ncvar_get(nc=nc, varid=variable,start=c(lon.i,lat.i,start.time),count=c(1,1,length(days.since)))
  nc_close(nc)
  
  days.since = as.Date('1900-01-01')+days.since
  df <- data.frame("DateTime"=days.since,"vals"=vals)
  names(df)[2] <- variable
  return(df)
}

setwd("C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project\\test cloud")
data <- read.csv("algal.csv", header=TRUE)
head(data)
summary(data)
m <- data.frame(cbind(data[3:4]))
m
length(m[,1])
m[104,1]

############################################ 
# Extracting the Data to your data matrix
############################################

x=matrix(nrow = length(m[,1]), ncol = 1368)
x
x[1,] <- t(get_cru(m[1,1],m[1,2], variable = 'pre', folder = 'C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project\\test cloud'))[2,]
y=matrix(nrow = length(m[,1]), ncol = 1368)
y
for (i in 1:length(m[,1]))
{
  y[i,]<-t(get_cru(m[i,1],m[i,2], variable = "pre", folder = "C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project\\test cloud"))[2,]
  print(paste("i = ", i, "lat =", m[i,1], "lon =", m[i,2], "the first element =", x[i,1], "the second element =", y[i,1], sep =" "))
}
y

write.csv(y, file = "cru_precip.csv",row.names=FALSE, na="")

#####################################
# % Cloud Cover EXTRACTION 1901-2014
#####################################

get_cru <- function(lat, lon, variable, folder){
  CRU <- file.path(folder, sprintf('cru_ts3.23.1901.2014.cld.dat.nc', variable))
  nc  <-  nc_open(CRU)
  lat.vals<-ncvar_get(nc,varid="lat")
  lon.vals<-ncvar_get(nc,varid="lon")
  days.since<-ncvar_get(nc,varid="time")
  start.time = 1
  
  lat.i  <-  which.min(abs(lat.vals-lat))[1]
  lon.i  <-  which.min(abs(lon.vals-lon))[1]
  
  vals = ncvar_get(nc=nc, varid=variable,start=c(lon.i,lat.i,start.time),count=c(1,1,length(days.since)))
  nc_close(nc)
  
  days.since = as.Date('1900-01-01')+days.since
  df <- data.frame("DateTime"=days.since,"vals"=vals)
  names(df)[2] <- variable
  return(df)
}


setwd("C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project\\test cloud")
data <- read.csv("algal.csv", header=TRUE)
head(data)
summary(data)
m <- data.frame(cbind(data[3:4]))
m
length(m[,1])
m[104,1]

############################################ 
# Extracting the Data to your data matrix
############################################

x=matrix(nrow = length(m[,1]), ncol = 1368)
x
x[1,] <- t(get_cru(m[1,1],m[1,2], variable = 'cld', folder = 'C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project\\test cloud'))[2,]
y=matrix(nrow = length(m[,1]), ncol = 1368)
y
for (i in 1:length(m[,1]))
{
  y[i,]<-t(get_cru(m[i,1],m[i,2], variable = "cld", folder = "C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project\\test cloud"))[2,]
  print(paste("i = ", i, "lat =", m[i,1], "lon =", m[i,2], "the first element =", x[i,1], "the second element =", y[i,1], sep =" "))
}
y

write.csv(y, file = "cru_cloud.csv",row.names=FALSE, na="")
