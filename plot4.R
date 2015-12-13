# Exploratory Data Analysis - Course Project 1
# Building Plot 4
# Date: December 13, 2015

# Checking whether we already have data set in variable tdata
if(!exists("tdata")) {
    library(dplyr)
    
    # If not - download and unpack data
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  "data.zip")
    unzip("data.zip")
    
    # Read data from file
    rdata <- read.table("household_power_consumption.txt", sep = ";",
                        na.strings = c("", "?"), header = TRUE,
                        colClasses = c("character", "character", "numeric", 
                                       "numeric", "numeric", "numeric", "numeric", 
                                       "numeric", "numeric"))
    
    #Tidy data: extract records for two defined dates, transform two character
    #columns with date and time to one column with POSIXct
    rdata <- filter(rdata, Date %in% c("1/2/2007", "2/2/2007"))
    DateTime <- strptime(paste(rdata$Date, rdata$Time), "%d/%m/%Y %H:%M:%S")
    rdata <- select(rdata, -(Date:Time))
    tdata <- cbind(DateTime, rdata)
}

#Change device mode to 2x2 plot
par(mfrow = c(2,2))

#Top left plot
plot(tdata$DateTime, tdata$Global_active_power, type = "l", col = "black", 
     main = "", ylab = "Global Active Power", xlab = "")

#Top right plot
plot(tdata$DateTime, tdata$Voltage, type = "l", col = "black", 
     main = "", ylab = "Voltage", xlab = "datetime")

#Bottom left plot
plot(tdata$DateTime, tdata$Sub_metering_1, type = "l", col = "black", 
     main = "", ylab = "Energy sub metering", xlab = "")
lines(tdata$DateTime, tdata$Sub_metering_2, col = "red")
lines(tdata$DateTime, tdata$Sub_metering_3, col = "blue")
legend("topright", legend = colnames(tdata)[6:8], lty = 1,
       col = c("black", "red", "blue"), bty = "n")

#Top right plot
plot(tdata$DateTime, tdata$Global_reactive_power, type = "l", col = "black", 
     main = "", ylab = "Global_reactive_power", xlab = "datetime")

#Copy to png file and close new png device
dev.copy(png, file = "plot4.png")
dev.off()
