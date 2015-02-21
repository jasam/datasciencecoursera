
# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Generate tidy data for performance
tidyData <-aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
colnames(tidyData)[1] = "Year"
colnames(tidyData)[2] = "Emissions"

# Open PNG file
png(filename = "plot1.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

# Generate plot
plot(tidyData$Year, tidyData$Emissions, type="l", col="blue", xlab = "Years", ylab="Emissions(Tons)")
title(main = "Emissions from all sources")

# off PNG device
dev.off()