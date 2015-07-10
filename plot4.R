# Assumes the data file is in the parent folder to the working directory
library(plyr)
library(lubridate)

# Load data (common)
cols <- c(rep("character",2),rep("numeric",7))
electricity <- read.csv(file.path("..", "household_power_consumption.txt"), colClasses = cols, sep = ";", na.strings = "?")
electricity <- electricity[(function(d) d == "1/2/2007" | d == "2/2/2007")(electricity$Date),]
electricity <- mutate(electricity, DateTime = dmy(Date) + hms(Time))

# Plot data
# Anti-aliasing doesn't work on Windows, producing harder lines than the lecturer's Mac
png("plot4.png")
# Could set mar - but can't match the original 504x504 with a 480x480 no matter what
par(mfcol = c(2,2))

# Top Left
plot(electricity$DateTime, electricity$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(electricity$DateTime, electricity$Global_active_power)

# Bottom Left
plot(electricity$DateTime, electricity$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("Black", "Red", "Blue"), bty="n")
lines(electricity$DateTime, electricity$Sub_metering_1)
lines(electricity$DateTime, electricity$Sub_metering_2, col="Red")
lines(electricity$DateTime, electricity$Sub_metering_3, col="Blue")

# Top Right
plot(electricity$DateTime, electricity$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(electricity$DateTime, electricity$Voltage)

# Bottom Right
plot(electricity$DateTime, electricity$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(electricity$DateTime, electricity$Global_reactive_power)

dev.off()