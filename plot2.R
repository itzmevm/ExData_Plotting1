#=====================================#
## Plot2
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

input$DateTime <- as.POSIXct(paste(input$Date,input$Time))
 
#=====================================#
# Filter data from the dates 
# 2007-02-01 and 2007-02-02
#=====================================#

input  <- input[(input$Date >= as.Date("2007-02-01") & 
                    input$Date <= as.Date("2007-02-02")),]

# Convert time variable to time from character

input$Time <- as.POSIXct(input$Time,format = "%H:%M:%S") 

 
#=====================================#
# Making Plot2
#=====================================#
 
plot(input$Global_active_power~input$DateTime,type="l", 
            xlab="",ylab="Global Active Power(kilowatt)" )
# Copy plot to png

dev.copy(png,'plot2.png') 
dev.off()
