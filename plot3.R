# Assumes the data file is in the parent folder to the working directory
library(plyr)
library(lubridate)

# Load data (common)
cols <- c(rep("character",2),rep("numeric",7))
electricity <- read.csv(file.path("..", "household_power_consumption.txt"), colClasses = cols, sep = ";", na.strings = "?")
electricity <- electricity[(function(d) d == "1/2/2007" | d == "2/2/2007")(electricity$Date),]
electricity <- mutate(electricity, DateTime = dmy(Date) + hms(Time))

# Plot data
png("plot3.png")
plot(electricity$DateTime, electricity$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("Black", "Red", "Blue"))
lines(electricity$DateTime, electricity$Sub_metering_1)
lines(electricity$DateTime, electricity$Sub_metering_2, col="Red")
lines(electricity$DateTime, electricity$Sub_metering_3, col="Blue")
dev.off()