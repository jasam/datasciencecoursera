NEI <- readRDS("summarySCC_PM25.rds")

# subset data to obtain Baltimore data
baltimoreData <- subset(NEI, fips == "24510")

# Generate tidy data for performance
tidyData <-aggregate(baltimoreData$Emissions, by=list(baltimoreData$year), FUN=sum)

colnames(tidyData)[1] = "Year"
colnames(tidyData)[2] = "Emissions"

# Open PNG file
png(filename = "plot2.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

# Generate plot
plot(tidyData$Year, tidyData$Emissions, type="l", col="blue", xlab = "Years", ylab="Emissions(Tons)")
title(main = "Total emissions from PM2.5 in the Baltimore City")

# off PNG device
dev.off()