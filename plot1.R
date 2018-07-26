#=====================================#
## Plot1 
#=====================================#

install.packages("data.table")
library(data.table)
library(dplyr)
setwd("../power")
# Source URL : 
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#=====================================#
# Extract data from the URL :
#=====================================#

download.file(url,destfile="srcfiles.zip")
 
 
zipF <- "../power/srcfiles.zip"
outDir<-"../power/unzip_fldr"
unzip(zipF,exdir=outDir)
setwd("../power/unzip_fldr")

#=====================================#
## Read power consumption file 
#=====================================#

input <- fread("household_power_consumption.txt")
 
# Convert data type for the Date variable 
# to Date from character

input$Date <- as.Date(input$Date,"%d/%m/%Y")

#=====================================#
# Filter data from the dates 
# 2007-02-01 and 2007-02-02
#=====================================#

input  <- input[(input$Date >= as.Date("2007-02-01") & 
                    input$Date <= as.Date("2007-02-02")),]

# Convert time variable to time from character

input$Time <- as.POSIXct(input$Time,format = "%H:%M:%S") 

 
#=====================================#
# Making Plot1
#=====================================#

par(mfrow=c(1,1),mar = c(4, 4, 2, 1))
hist(as.numeric(input$Global_active_power),col="red",main = "Global Active Power",xlab="Global Active Power (kilowatts)")

# Copy plot to png

dev.copy(png,'plot1.png') 
dev.off()
