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

##step 4: plot the linegraph into a png-file
png(file = "plot2.png")
with(subset, plot(Global_active_power, type = "l",xaxt='n', xlab="", ylab = "Global Active Power (kilowatts)"))
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"),tick = TRUE)
dev.off()