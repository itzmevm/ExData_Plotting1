#=====================================#
## Plot3
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

input$DateTime <- as.POSIXct(paste(input$Date,input$Time))

input$Sub_metering_1  = as.numeric(input$Sub_metering_1)
input$Sub_metering_2  = as.numeric(input$Sub_metering_2)
input$Sub_metering_3  = as.numeric(input$Sub_metering_3)
 
# Convert time variable to time from character

input$Time <- as.POSIXct(input$Time,format = "%H:%M:%S") 

 
#=====================================#
# Making Plot3
#=====================================#
 
plot(input$DateTime,input$Sub_metering_1,type="l", 
            xlab="",ylab="Engery sub metering" )
 
lines(input$Sub_metering_2~input$DateTime,type="l",col="red",add=TRUE)
 
lines(input$Sub_metering_3~input$DateTime,type="l",col="blue")
 
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),cex=0.7)
  
  # Copy plot to png

dev.copy(png,'plot3.png') 
dev.off()
