# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Generating tidyData 
CRS <-SCC[grep("Coal",SCC$Short.Name),]
mergeData <- merge(NEI,CRS,by = "SCC")
tidyData <-aggregate(mergeData$Emissions, by=list(mergeData$year), FUN=sum)

# Renaming cols on tidyData
colnames(tidyData)[1] = "Year"
colnames(tidyData)[2] = "Emissions"

# Open PNG file
png(filename = "plot4.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

# Generate plot
plot(tidyData$Year, tidyData$Emissions, type="l", col="blue", xlab = "Years", ylab="Emissions(Tons)")
title(main = "Emissions from coal combustion-related sources (US)")
# off PNG device
dev.off()