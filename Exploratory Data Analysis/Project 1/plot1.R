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

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
# Open PNG file
png(filename = "plot1.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

# Generate histogram
hist(tidyData$Global_active_power, 
     col    = "red", 
     main   = "Global Active Power", 
     xlab   = "Global Active Power (kilowatts)",
     breaks = 12, ylim = c(0, 1200))

# off PNG device
dev.off()