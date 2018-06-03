##step 1: Download, unzip and read the data. If this has been done before, the data will be overwritten
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "dataset.zip")
unzip("dataset.zip", overwrite = TRUE)
filelist <- unzip("dataset.zip", list = TRUE) #all this does is write the filename into filelist
dataset <- read.table(filelist[1,1], sep = ";", header = TRUE, na.strings = "?")

##step 2: Fixing the variables Date and Time using the lubridate package
library(lubridate)
library(dplyr)
dataset <- dataset %>% mutate(Date = dmy(Date)) %>% mutate(Time = hms(Time))

##step 3: subsetting the two required dates 2007-02-01 and 2007-02-02
subset <- filter(dataset, Date == "2007-02-01" | Date == "2007-02-02")

##step 4: plot the linegraphs into a png-file
png(file = "plot4.png")
par(mfrow = c(2,2))
##plot 1: Upper left
with(subset, plot(Global_active_power, type = "l",xaxt='n', xlab="", ylab = "Global Active Power (kilowatts)"))
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"),tick = TRUE)
##plot 2: Upper right
with(subset, plot(Voltage, type = "l", xaxt = 'n', xlab = "datetime", ylab = "Voltage"))
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"),tick = TRUE)
##plot 3: Lower left
with(subset, plot(Sub_metering_1, type = "l",xaxt='n', xlab="", ylab = "Energy sub metering"))
lines(subset$Sub_metering_2, col="red")
lines(subset$Sub_metering_3, col="blue")
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"),tick = TRUE)
legend("topright", lty = 1, col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ))
##plot 4: Lower right
with(subset, plot(Global_reactive_power, type = "l", xaxt = 'n', 
                  xlab = "datetime", ylab = "Global_reactive_power"))
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"),tick = TRUE)
dev.off()