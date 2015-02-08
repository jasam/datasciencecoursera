# Load all data
# Note that in this dataset missing values are coded as ?.
# note: before set working directory, where data file resides
data = read.table("household_power_consumption.txt",
                  header     = TRUE,
                  sep        = ";",
                  colClasses = c("character", "character", rep("numeric",7)),
                  na         = "?")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# logical filter
subSetData = data$Date == "1/2/2007" | data$Date == "2/2/2007"

# Tidy data, only selected dates for performance
tidyData = data[subSetData,]

# Join two columns
temp = paste(tidyData$Date, tidyData$Time)

# add new column with date concat with date
tidyData$DateTime = strptime(temp, "%d/%m/%Y %H:%M:%S")

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
# Open PNG file
png(filename = "plot4.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
par(mfrow = c(2, 2))

# Generate plot
## Top-left
plot(tidyData$DateTime, tidyData$Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power")
## Top-right
plot(tidyData$DateTime, tidyData$Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")
## Bottom-left
plot(tidyData$DateTime, tidyData$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(tidyData$DateTime, tidyData$Sub_metering_2, col = "red")
lines(tidyData$DateTime, tidyData$Sub_metering_3, col = "blue")
# Remove the border of legend here.
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## Bottom-right
plot(tidyData$DateTime, tidyData$Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", ylab = colnames(tidyData)[4])

# off PNG device
dev.off()