# Assumes the data file is in the parent folder to the working directory
library(plyr)
library(lubridate)

# Load data (common)
cols <- c(rep("character",2),rep("numeric",7))
electricity <- read.csv(file.path("..", "household_power_consumption.txt"), colClasses = cols, sep = ";", na.strings = "?")
electricity <- electricity[(function(d) d == "1/2/2007" | d == "2/2/2007")(electricity$Date),]
electricity <- mutate(electricity, DateTime = dmy(Date) + hms(Time))

# Plot data
png("plot2.png")
plot(electricity$DateTime, electricity$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(electricity$DateTime, electricity$Global_active_power)
dev.off()