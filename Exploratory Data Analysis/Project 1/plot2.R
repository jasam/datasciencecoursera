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
png(filename = "plot2.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")

# Generate plot
plot(tidyData$DateTime, tidyData$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# off PNG device
dev.off()